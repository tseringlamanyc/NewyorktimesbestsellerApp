//
//  BestSellerViewController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence
import Speech

class BestSellerViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private var bestSellerView = BestSellerView()
    
    private var dataPersistence: DataPersistence<Book>
    
    private var userPreference: UserPreference
    
    init(dataPersistence: DataPersistence<Book>,userPreference: UserPreference) {
        self.dataPersistence = dataPersistence
        self.userPreference = userPreference
        super.init(nibName: nil, bundle: nil)
        self.userPreference.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init couldnt be implemented")
    }
    
    let audioEngine = AVAudioEngine() // mic is recieving audio
    
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer() // transcribing, actual recognition
    
    let request = SFSpeechAudioBufferRecognitionRequest() // This allocates speech as the user speaks in real-time and controls the buffering
    
    var recognitionTask: SFSpeechRecognitionTask? // This will be used to manage, cancel, or stop the current recognition task.
    
    var isRecording = false
    
    override func loadView() {
        view = bestSellerView
    }
    
    var nowBook = "Advice How-To and Miscellaneous" {
        didSet {
            getBooks(category: nowBook)
        }
    }
    
    var sections = [String]() {
        didSet {
            bestSellerView.pickerView.reloadAllComponents()
            getIndex()
        }
    }
    
    private var allCategories = [Categories]() {
        didSet {
            sections = allCategories.map {$0.listName}.sorted()
        }
    }
    
    private var allBooks = [Book]() {
        didSet {
            DispatchQueue.main.async {
                self.bestSellerView.bestSellerCV.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        bestSellerView.bestSellerCV.gemini.circleRotationAnimation().radius(450).rotateDirection(.anticlockwise).itemRotationEnabled(false)
        bestSellerView.bestSellerCV.dataSource = self
        bestSellerView.bestSellerCV.delegate = self
        bestSellerView.bestSellerCV.register(BestSellerCell.self, forCellWithReuseIdentifier: "bestCell")
        bestSellerView.pickerView.dataSource = self
        bestSellerView.pickerView.delegate = self
        getCategories()
        getIndex()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mic.circle"), style: .plain, target: self, action: #selector(speechButton(sender:)))
    }
    
    private func getCategories() {
        CategoryAPI.getCategory { [weak self] (result) in
            switch result {
            case .failure(_):
                print("Couldnt get categories")
            case .success(let data):
                DispatchQueue.main.async {
                    self?.allCategories = data
                }
            }
        }
    }
    
    private func getIndex() {
        if let sectionName = userPreference.getSectionName() {
            if let index = sections.firstIndex(of: sectionName) {
                bestSellerView.pickerView.selectRow(index, inComponent: 0, animated: true)
                nowBook = sectionName
                print(sectionName)
            }
        }
    }
    
    private func getSpeech() {
        let node = audioEngine.inputNode  // nodes to process bits of audio, singleton of incoming audio
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        
        // for error checking
        do {
            try audioEngine.start()
            print("im listening")
        } catch {
            return print("\(error)")
        }
        guard let myRecognizer = SFSpeechRecognizer() else { // recognizer for locale
            return // not supported
        }
        if !myRecognizer.isAvailable {
            // recognizer not avaliable
            return print("not available")
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { [weak self] (result, error) in
            if result != nil {
                if let result = result {
                    // This is where the recognition happens
                    let userString = result.bestTranscription.formattedString
                    // This string value will show all of the words that have been said and recognized so far
                    self?.navigationItem.title = userString
                    self?.nowBook = userString
                    if let index = self?.sections.firstIndex(of: userString) {
                        self?.bestSellerView.pickerView.selectRow(index, inComponent: 0, animated: true)
                    }
                } else if let error = error {
                    print(error)
                }
            }
        })
    }
    
    
    private func getBooks(category: String) {
        NYTAPIClient.getBooks(for: nowBook) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("couldnt load books")
            case .success(let books):
                self?.allBooks = books
            }
        }
    }
    
    @objc
    private func speechButton(sender: UIBarButtonItem) {
        print("button pressed")
        if isRecording {
            request.endAudio()
            audioEngine.stop()
            let node = audioEngine.inputNode
            node.removeTap(onBus: 0)
            recognitionTask?.cancel()
            isRecording = false
            print("ended")
        } else {
            self.getSpeech()
            isRecording = true
            print("started")
        }
    }
}

extension BestSellerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bestCell", for: indexPath) as? BestSellerCell else {
            fatalError()
        }
        cell.updateCell(book: allBooks[indexPath.row])
        cell.backgroundColor = .systemGray4
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bestSellerView.bestSellerCV.animateVisibleCells()
        bestSellerView.bestSellerCV.alpha = 1
    }
}

extension BestSellerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds.size
        let itemwidth: CGFloat = maxSize.width * 0.47
        let itemHeight: CGFloat = maxSize.height * 0.37
        return CGSize(width: itemwidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aBook = allBooks[indexPath.row]
        let detailVC = DetailViewController(dataPersistence, books: aBook)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension BestSellerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sectionName = sections[row]
        print(sectionName)
        nowBook = sectionName
    }
    
}
extension BestSellerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row]
    }
}

extension BestSellerViewController: UserPreferenceDelegate {
    func didIndexChange(_ userPreference: UserPreference, index: Int) {
        getIndex()
    }
    
    func didChangeNewsSection(_ userPreference: UserPreference, sectionName: String) {
        nowBook = sectionName
    }
}

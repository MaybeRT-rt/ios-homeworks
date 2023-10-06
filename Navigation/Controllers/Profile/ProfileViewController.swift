//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 06.04.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    let viewModelProfile: ProfileViewModel
    private var audioTrackURLs: [URL] = []
    
    var user: User?
    
    private lazy var profileTableView: UITableView = {
        
        let profileTV = UITableView.init(frame: .zero, style: .grouped)
        profileTV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileTV
    }()
    
    private enum CellReuseID: String {
        case base = "PostTableViewCell_ReuseID"
        case photos = "PhotoTableViewCell_ReuseID"
        case music = "TrackTableViewCell_ReuseID"
        case headerID = "profileHeaderView"
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModelProfile = viewModel
        super.init(nibName: nil, bundle: nil)
        // audioTrackURLs = viewModel.musicViewModel.audioTracks
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgraund()
        addedSubview()
        setupContrain()
        tuneTableView()
        bindViewModel()
    }
    
    private func changeBackgraund() {
#if DEBUG
        view.backgroundColor = .systemGray
        profileTableView.backgroundColor = .systemGray
#else
        view.backgroundColor = .systemBackground
#endif
    }
    
    private func addedSubview() {
        view.addSubview(profileTableView)
    }
    
    func setupContrain() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func tuneTableView() {
        profileTableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: CellReuseID.headerID.rawValue)
        profileTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseID.photos.rawValue)
        profileTableView.register(MyMusicCell.self, forCellReuseIdentifier: CellReuseID.music.rawValue)
        profileTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        //profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 1000
        
    }
    
    private func bindViewModel() {
        viewModelProfile.reloadData = { [weak self] in
            self?.profileTableView.reloadData()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelProfile.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelProfile.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: PhotosTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell_ReuseID", for: indexPath)) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.music.rawValue, for: indexPath) as! MyMusicCell
            return cell
        case 2:
            let cell: PostsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell_ReuseID", for: indexPath)) as! PostsTableViewCell
            cell.selectionStyle = .none
            guard let model = viewModelProfile.post(at: indexPath.row) else { return UITableViewCell() }
            cell.update(model)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let profileHeaderView = ProfileHeaderView()
            if let user = viewModelProfile.user {
                profileHeaderView.nameLabel.text = user.fullName
                profileHeaderView.photoImageView.image = user.avatar
                profileHeaderView.myLabel.text = user.status
            }
            return profileHeaderView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let cell = tableView.cellForRow(at: indexPath) as? PhotosTableViewCell, cell.reuseIdentifier == "PhotoTableViewCell_ReuseID" {
                let galleryViewController = PhotosViewController()
                
                navigationController?.pushViewController(galleryViewController, animated: true)
            }
        case 1:
            if let cell = tableView.cellForRow(at: indexPath) as? MyMusicCell, cell.reuseIdentifier == "TrackTableViewCell_ReuseID" {
                let musicPlayerViewController = MusicPlayerViewController()
                navigationController?.pushViewController(musicPlayerViewController, animated: true)
            }
        default:
            break
        }
    }
}

extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

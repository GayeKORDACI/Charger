//
//  ReservationTableViewCell.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 17.07.2022.
//

import UIKit

class ReservationTableViewCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var acDcImage: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var deleteReservationButton: UIButton!
    
    
    @IBOutlet weak var reservationTimeDetailView: UIView!
    @IBOutlet weak var reservationDateLabel: UILabel!
    @IBOutlet weak var notificationTimeImage: UIImageView!
    @IBOutlet weak var notificationTimeLabel: UILabel!
    
    @IBOutlet weak var socketDetailView: UIView!
    @IBOutlet weak var socketNumberLabel: UILabel!
    @IBOutlet weak var socketTypeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        containerView.setCorners(10)
        containerView.backgroundColor = .charcoalGray.withAlphaComponent(0.66)
        
        reservationTimeDetailView.backgroundColor = .charcoalGray
        reservationTimeDetailView.setCorners(3)
        socketDetailView.backgroundColor = .charcoalGray
        socketDetailView.setCorners(3)
    }
    
    func setData(_ data: ReservationAPIModel?) {
        
        if(data?.station?.sockets?.first?.chargeType == "AC")
        {
            acDcImage.image = UIImage(named: "ac")
        }
        else if (data?.station?.sockets?.first?.chargeType == "DC")
        {
            acDcImage.image = UIImage(named: "dc")
        }
        else{
            acDcImage.image = UIImage(named: "acdc")
        }
        
        deleteReservationButton.setImage(UIImage(named: "trashcan")?.withTintColor(.grayscale), for: .normal)
        deleteReservationButton.tintColor = .grayscale
        deleteReservationButton.setTitle("", for: .normal)
        deleteReservationButton.isHidden = data?.hasPassed ?? true
        
        
        stationNameLabel.text = "\((data?.stationName ?? "")) ,  \((data?.station?.geoLocation?.province ?? ""))"
        stationNameLabel.textColor = .white
        stationNameLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        
        reservationDateLabel.text = "\((data?.date ?? "")) , \((data?.time ?? ""))"
        reservationDateLabel.textColor = .white
        reservationDateLabel.font = UIFont.systemFont(ofSize: 16.0)
        
        notificationTimeLabel.text = "\((data?.station?.sockets?.first?.power ?? 0)) \((data?.station?.sockets?.first?.powerUnit ?? ""))"
        notificationTimeLabel.textColor = .white
        notificationTimeLabel.font = UIFont.systemFont(ofSize: 16.0)
        
        socketNumberLabel.text = "\("socket_number".localized) :  \((data?.station?.sockets?.first?.socketNumber ?? 0))"
        socketNumberLabel.textColor = .grayscale
        socketNumberLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        socketTypeLabel.text = "\(data?.station?.sockets?.first?.chargeType ?? "") - \((data?.station?.sockets?.first?.socketType ?? ""))"
        socketTypeLabel.textColor = .grayscale
        socketTypeLabel.font = UIFont.systemFont(ofSize: 14.0)
        
    }
    
}

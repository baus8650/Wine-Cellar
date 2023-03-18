////
////  TasteDetailsViewController.swift
////  Wine Cellar
////
////  Created by Tim Bausch on 11/4/22.
////
//
//import PureLayout
//import UIKit
//
//class TasteDetailsViewController: UIViewController {
//    
//    let wine: Wine
//    let wineViewModel: WineViewModel!
//    let segmentedControlFont: [NSAttributedString.Key: Any] = [
//        NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 12) as Any,
//        NSAttributedString.Key.foregroundColor: UIColor(named: "WineColorAccent") as Any
//    ]
//    
//    var bodyDescriptorText: String?
//    var sweetnessDescriptorText: String?
//    var alcoholDescriptorText: String?
//    var acidityDescriptorText: String?
//    var tanninDescriptorText: String?
//    
//    // MARK: - Views
//    
//    private lazy var saveButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(systemItem: .save, menu: UIMenu(title: "Save Options", children: [
//            UIAction(title: "Save and return to cellar", image: UIImage(systemName: "arrow.left.circle")?.withTintColor(UIColor(named: "WineColorAccent")!), handler: { [weak self] _ in
//                guard let self else { return }
//                self.returnPressed()
//            }),
//            UIAction(title: "Save and continue", image: UIImage(systemName: "arrow.right.circle")?.withTintColor(UIColor(named: "WineColorAccent")!), handler: { [weak self] _ in
//                guard let self else { return }
//                self.continuePressed()
//            }),
//        ]))
//        return button
//    }()
//    
//    private lazy var bodyLabel: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.text = "Body"
//        label.font = UIFont(name: "Avenir Next Bold", size: 24)
//        label.textColor = UIColor(named: "WineColorAccent")
//        return label
//    }()
//    
//    private lazy var bodyDescriptor: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.font = UIFont(name: "Avenir Next Medium", size: 16)
//        label.textColor = UIColor(named: "WineColorAccent")
//        label.text = bodyDescriptorText ?? "No Response"
//        return label
//    }()
//    
//    private lazy var bodySlider: UISlider = {
//        let slider = UISlider(forAutoLayout: ())
//        slider.tintColor = UIColor(named: "WineColorAccent")
//        slider.minimumValue = 0.0
//        slider.maximumValue = Float(Constants.WineBody.allCases.last!.rawValue)
//        slider.isContinuous = true
//        slider.tag = 0
//        slider.thumbTintColor = UIColor(named: "NavigationElements")
//        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
//        return slider
//    }()
//    
//    private lazy var bodyStack: UIStackView = {
//        let stackView = UIStackView(forAutoLayout: ())
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        let views = [bodyLabel, bodyDescriptor, bodySlider]
//        let _ = views.map {
//            stackView.addArrangedSubview($0)
//        }
//        return stackView
//    }()
//    
//    private lazy var sweetnessLabel: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.text = "Sweetness"
//        label.font = UIFont(name: "Avenir Next Bold", size: 24)
//        label.textColor = UIColor(named: "WineColorAccent")
//        return label
//    }()
//    
//    private lazy var sweetnessDescriptor: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.font = UIFont(name: "Avenir Next Medium", size: 16)
//        label.textColor = UIColor(named: "WineColorAccent")
//        label.text = sweetnessDescriptorText ?? "No Response"
//        return label
//    }()
//    
//    private lazy var sweetnessSlider: UISlider = {
//        let slider = UISlider(forAutoLayout: ())
//        slider.tintColor = UIColor(named: "WineColorAccent")
//        slider.minimumValue = 0.0
//        slider.maximumValue = Float(Constants.Sweetness.allCases.last!.rawValue)
//        slider.isContinuous = true
//        slider.tag = 1
//        slider.thumbTintColor = UIColor(named: "NavigationElements")
//        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
//        return slider
//    }()
//
//    private lazy var sweetnessStack: UIStackView = {
//        let stackView = UIStackView(forAutoLayout: ())
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        let views = [sweetnessLabel, sweetnessDescriptor, sweetnessSlider]
//        let _ = views.map {
//            stackView.addArrangedSubview($0)
//        }
//        return stackView
//    }()
//    
//    private lazy var alcoholLabel: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.text = "Alcohol"
//        label.font = UIFont(name: "Avenir Next Bold", size: 24)
//        label.textColor = UIColor(named: "WineColorAccent")
//        return label
//    }()
//
//    private lazy var alcoholDescriptor: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.font = UIFont(name: "Avenir Next Medium", size: 16)
//        label.textColor = UIColor(named: "WineColorAccent")
//        label.text = alcoholDescriptorText ?? "No Response"
//        return label
//    }()
//    
//    private lazy var alcoholSlider: UISlider = {
//        let slider = UISlider(forAutoLayout: ())
//        slider.tintColor = UIColor(named: "WineColorAccent")
//        slider.minimumValue = 0.0
//        slider.maximumValue = Float(Constants.AlcoholLevel.allCases.last!.rawValue)
//        slider.isContinuous = true
//        slider.tag = 2
//        slider.thumbTintColor = UIColor(named: "NavigationElements")
//        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
//        return slider
//    }()
//    
//    private lazy var alcoholStack: UIStackView = {
//        let stackView = UIStackView(forAutoLayout: ())
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        let views = [alcoholLabel, alcoholDescriptor, alcoholSlider]
//        let _ = views.map {
//            stackView.addArrangedSubview($0)
//        }
//        return stackView
//    }()
//    
//    private lazy var acidityLabel: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.text = "Acidity"
//        label.font = UIFont(name: "Avenir Next Bold", size: 24)
//        label.textColor = UIColor(named: "WineColorAccent")
//        return label
//    }()
//    
//    private lazy var acidityDescriptor: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.font = UIFont(name: "Avenir Next Medium", size: 16)
//        label.textColor = UIColor(named: "WineColorAccent")
//        label.text = acidityDescriptorText ?? "No Response"
//        return label
//    }()
//    
//    private lazy var aciditySlider: UISlider = {
//        let slider = UISlider(forAutoLayout: ())
//        slider.tintColor = UIColor(named: "WineColorAccent")
//        slider.minimumValue = 0.0
//        slider.maximumValue = Float(Constants.AcidityLevel.allCases.last!.rawValue)
//        slider.isContinuous = true
//        slider.tag = 3
//        slider.thumbTintColor = UIColor(named: "NavigationElements")
//        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
//        return slider
//    }()
//    
//    private lazy var acidityStack: UIStackView = {
//        let stackView = UIStackView(forAutoLayout: ())
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        let views = [acidityLabel, acidityDescriptor, aciditySlider]
//        let _ = views.map {
//            stackView.addArrangedSubview($0)
//        }
//        return stackView
//    }()
//    
//    private lazy var tanninLabel: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.text = "Tannins"
//        label.font = UIFont(name: "Avenir Next Bold", size: 24)
//        label.textColor = UIColor(named: "WineColorAccent")
//        return label
//    }()
//    
//    private lazy var tanninDescriptor: UILabel = {
//        let label = UILabel(forAutoLayout: ())
//        label.font = UIFont(name: "Avenir Next Medium", size: 16)
//        label.textColor = UIColor(named: "WineColorAccent")
//        label.text = tanninDescriptorText ?? "No Response"
//        return label
//    }()
//    
//    private lazy var tanninSlider: UISlider = {
//        let slider = UISlider(forAutoLayout: ())
//        slider.tintColor = UIColor(named: "WineColorAccent")
//        slider.minimumValue = 0.0
//        slider.maximumValue = Float(Constants.TanninLevel.allCases.last!.rawValue)
//        slider.isContinuous = true
//        slider.tag = 4
//        slider.thumbTintColor = UIColor(named: "NavigationElements")
//        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
//        return slider
//    }()
//    
//    private lazy var tanninStack: UIStackView = {
//        let stackView = UIStackView(forAutoLayout: ())
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        let views = [tanninLabel, tanninDescriptor, tanninSlider]
//        let _ = views.map {
//            stackView.addArrangedSubview($0)
//        }
//        return stackView
//    }()
//    
//    private lazy var cancelButton: UIButton = {
//        let button = UIButton(forAutoLayout: ())
//        button.setTitleColor(.systemRed, for: .normal)
//        button.setTitle("Cancel", for: .normal)
//        button.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var tasteStack: UIStackView = {
//        let stackView = UIStackView(forAutoLayout: ())
//        stackView.axis = .vertical
//        stackView.spacing = 24
//        let views = [bodyStack, sweetnessStack, alcoholStack, acidityStack, tanninStack, cancelButton]
//        let _ = views.map {
//            stackView.addArrangedSubview($0)
//        }
//        return stackView
//    }()
//    
//    init(wine: Wine, wineViewModel: WineViewModel) {
//        self.wine = wine
//        self.wineViewModel = wineViewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
//        navigationItem.rightBarButtonItem = saveButton
//        setUpSubviews()
//    }
//    
//    private func setUpSubviews() {
//        view.addSubview(mainStack)
//        mainStack.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)
//    }
//    
//    @objc
//    private func sliderDidChange(_ sender: UISlider) {
//        let roundedStepValue = round(sender.value / 1) * 1
//        sender.value = roundedStepValue
//        switch sender.tag {
//        case 0:
//            switch sender.value {
//            case 1:
//                bodyDescriptor.text = Constants.WineBody.light.description
//            case 2:
//                bodyDescriptor.text = Constants.WineBody.medium.description
//            case 3:
//                bodyDescriptor.text = Constants.WineBody.full.description
//            default:
//                bodyDescriptor.text = "No Response"
//            }
//        case 1:
//            switch sender.value {
//            case 1:
//                sweetnessDescriptor.text = Constants.Sweetness.boneDry.description
//            case 2:
//                sweetnessDescriptor.text = Constants.Sweetness.dry.description
//            case 3:
//                sweetnessDescriptor.text = Constants.Sweetness.semiSweet.description
//            case 4:
//                sweetnessDescriptor.text = Constants.Sweetness.sweet.description
//            case 5:
//                sweetnessDescriptor.text = Constants.Sweetness.verySweet.description
//            default:
//                bodyDescriptor.text = "No Response"
//            }
//        case 2:
//            switch sender.value {
//            case 1:
//                alcoholDescriptor.text = Constants.AlcoholLevel.extremelyLow.description
//            case 2:
//                alcoholDescriptor.text = Constants.AlcoholLevel.low.description
//            case 3:
//                alcoholDescriptor.text = Constants.AlcoholLevel.neutral.description
//            case 4:
//                alcoholDescriptor.text = Constants.AlcoholLevel.high.description
//            case 5:
//                alcoholDescriptor.text = Constants.AlcoholLevel.extremelyHigh.description
//            default:
//                bodyDescriptor.text = "No Response"
//            }
//        case 3:
//            switch sender.value {
//            case 1:
//                acidityDescriptor.text = Constants.AcidityLevel.extremelyLow.description
//            case 2:
//                acidityDescriptor.text = Constants.AcidityLevel.low.description
//            case 3:
//                acidityDescriptor.text = Constants.AcidityLevel.neutral.description
//            case 4:
//                acidityDescriptor.text = Constants.AcidityLevel.high.description
//            case 5:
//                acidityDescriptor.text = Constants.AcidityLevel.extremelyHigh.description
//            default:
//                bodyDescriptor.text = "No Response"
//            }
//        case 4:
//            switch sender.value {
//            case 1:
//                tanninDescriptor.text = Constants.TanninLevel.extremelyLow.description
//            case 2:
//                tanninDescriptor.text = Constants.TanninLevel.low.description
//            case 3:
//                tanninDescriptor.text = Constants.TanninLevel.neutral.description
//            case 4:
//                tanninDescriptor.text = Constants.TanninLevel.high.description
//            case 5:
//                tanninDescriptor.text = Constants.TanninLevel.extremelyHigh.description
//            default:
//                bodyDescriptor.text = "No Response"
//            }
//        default:
//            print("Slider couldn't be found")
//        }
//    }
//    
//    @objc
//    func returnPressed() {
//        wineViewModel.saveTasteDetails(body: Int16(bodySlider.value), sweetness: Int16(sweetnessSlider.value), alcohol: Int16(alcoholSlider.value), acidityLevel: Int16(aciditySlider.value), tanninLevel: Int16(tanninSlider.value), wine: wine)
//        navigationController?.popToRootViewController(animated: true)
//    }
//    
//    @objc
//    func continuePressed() {
//        
//    }
//    
//    @objc
//    func cancelPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}

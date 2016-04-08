//
//  CustomView.swift
//
//  Code generated using QuartzCode 1.39.13 on 3/31/16.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class CustomView: UIView {
	
	var updateLayerValueForCompletedAnimation : Bool = false
	var animationAdded : Bool = false
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var layers : Dictionary<String, AnyObject> = [:]
	
	
	
	//MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayers()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupProperties()
		setupLayers()
	}
	
	var moveAnimProgress: CGFloat = 0{
		didSet{
			if(!self.animationAdded){
				removeAllAnimations()
				addMoveAnimation()
				self.animationAdded = true
				layer.speed = 0
				layer.timeOffset = 0
			}
			else{
				let totalDuration : CGFloat = 1
				let offset = moveAnimProgress * totalDuration
				layer.timeOffset = CFTimeInterval(offset)
			}
		}
	}
	
	override var frame: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	override var bounds: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	func setupProperties(){
		
	}
	
	func setupLayers(){
		let Retangle = CAShapeLayer()
		self.layer.addSublayer(Retangle)
		layers["Retangle"] = Retangle
		
		resetLayerPropertiesForLayerIdentifiers(nil)
		setupLayerFrames()
	}
	
	func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("Retangle"){
			let Retangle = layers["Retangle"] as! CAShapeLayer
			Retangle.fillColor   = UIColor(red:0.922, green: 0.922, blue:0.922, alpha:1).CGColor
			Retangle.strokeColor = UIColor(red:0.329, green: 0.329, blue:0.329, alpha:1).CGColor
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let Retangle : CAShapeLayer = layers["Retangle"] as? CAShapeLayer{
			Retangle.frame = CGRectMake(0.181 * Retangle.superlayer!.bounds.width, 0.121 * Retangle.superlayer!.bounds.height, 0.164 * Retangle.superlayer!.bounds.width, 0.164 * Retangle.superlayer!.bounds.height)
			Retangle.path  = RetanglePathWithBounds((layers["Retangle"] as! CAShapeLayer).bounds).CGPath;
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addMoveAnimation(){
		addMoveAnimationCompletionBlock(nil)
	}
	
	func addMoveAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
		addMoveAnimationTotalDuration(1, completionBlock:completionBlock)
	}
	
	func addMoveAnimationTotalDuration(totalDuration: CFTimeInterval, completionBlock: ((finished: Bool) -> Void)?){
		if completionBlock != nil{
			let completionAnim = CABasicAnimation(keyPath:"completionAnim")
			completionAnim.duration = totalDuration
			completionAnim.delegate = self
			completionAnim.setValue("Move", forKey:"animId")
			completionAnim.setValue(false, forKey:"needEndAnim")
			layer.addAnimation(completionAnim, forKey:"Move")
			if let anim = layer.animationForKey("Move"){
				completionBlocks[anim] = completionBlock
			}
		}
		
		self.layer.speed = 1
		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		let Retangle = layers["Retangle"] as! CAShapeLayer
		
		////Retangle animation
		let RetanglePositionAnim      = CAKeyframeAnimation(keyPath:"position")
		RetanglePositionAnim.values   = [NSValue(CGPoint: CGPointMake(0.263 * Retangle.superlayer!.bounds.width, 0.203 * Retangle.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.767 * Retangle.superlayer!.bounds.width, 0.797 * Retangle.superlayer!.bounds.height))]
		RetanglePositionAnim.keyTimes = [0, 1]
		RetanglePositionAnim.duration = totalDuration
		
		let RetangleMoveAnim : CAAnimationGroup = QCMethod.groupAnimations([RetanglePositionAnim], fillMode:fillMode)
		Retangle.addAnimation(RetangleMoveAnim, forKey:"RetangleMoveAnim")
	}
	
	//MARK: - Animation Cleanup
	
	override func animationDidStop(anim: CAAnimation, finished flag: Bool){
		if let completionBlock = completionBlocks[anim]{
			completionBlocks.removeValueForKey(anim)
			if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
				updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
				removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
			}
			completionBlock(flag)
		}
	}
	
	func updateLayerValuesForAnimationId(identifier: String){
		if identifier == "Move"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["Retangle"] as! CALayer).animationForKey("RetangleMoveAnim"), theLayer:(layers["Retangle"] as! CALayer))
		}
	}
	
	func removeAnimationsForAnimationId(identifier: String){
		if identifier == "Move"{
			(layers["Retangle"] as! CALayer).removeAnimationForKey("RetangleMoveAnim")
		}
		self.layer.speed = 1
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
		self.layer.speed = 1
	}
	
	//MARK: - Bezier Path
	
	func RetanglePathWithBounds(bound: CGRect) -> UIBezierPath{
		let RetanglePath = UIBezierPath(rect:bound)
		return RetanglePath;
	}
	
	
}

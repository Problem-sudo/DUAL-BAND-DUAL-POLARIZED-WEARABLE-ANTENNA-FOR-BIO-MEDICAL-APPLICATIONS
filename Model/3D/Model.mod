'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 0 fmax = 8
'# created = '[VERSION]2019.0|28.0.2|20180920[/VERSION]


'@ use template: demo_1.cfg

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
End With
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' optimize mesh settings for planar structures
With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy"
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")
'----------------------------------------------------------------------------

'@ new component: component1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Component.New "component1"

'@ define cylinder: component1:ground

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "ground" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "GR" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "PT" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ switch working plane

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Plot.DrawWorkplane "false"

'@ define material: Folder1/demo1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material 
     .Reset 
     .Name "demo1"
     .Folder "Folder1"
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "1.2"
     .Mu "1"
     .Sigma "0"
     .TanD "0.02"
     .TanDFreq "0.0"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "0", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define cylinder: component1:substrate

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "substrate" 
     .Component "component1" 
     .Material "Folder1/demo1" 
     .OuterRadius "GR" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "PT", "PT+SH" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:patch

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "patch" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "PR" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "PT+SH", "PT+SH+PT" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:ground_cut

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "ground_cut" 
     .Component "component1" 
     .Material "Vacuum" 
     .OuterRadius "O_r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "0", "PT" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ boolean subtract shapes: component1:ground, component1:ground_cut

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:ground_cut"

'@ define cylinder: component1:inner_pin

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "inner_pin" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "i_r" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-3*SH", "2*PT+SH" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define material: PTFE (lossy)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "PTFE (lossy)"
     .Folder ""
     .FrqType "all"
     .Type "Normal"
     .SetMaterialUnit "GHz", "mm"
     .Epsilon "2.1"
     .Mu "1.0"
     .Kappa "0.0"
     .TanD "0.0002"
     .TanDFreq "10.0"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .KappaM "0.0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstKappa"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "General 1st"
     .DispersiveFittingSchemeMu "General 1st"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .Rho "2200.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.2"
     .HeatCapacity "1.0"
     .SetActiveMaterial "all"
     .MechanicsType "Isotropic"
     .YoungsModulus "0.5"
     .PoissonsRatio "0.4"
     .ThermalExpansionRate "140"
     .Colour "0.94", "0.82", "0.76"
     .Wireframe "False"
     .Transparency "0"
     .Create
End With

'@ define cylinder: component1:teflon

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "teflon" 
     .Component "component1" 
     .Material "PTFE (lossy)" 
     .OuterRadius "O_r-0.1" 
     .InnerRadius "i_r" 
     .Axis "z" 
     .Zrange "-3*SH", "0" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:outer_cover

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "outer_cover" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "O_r" 
     .InnerRadius "O_r-0.1" 
     .Axis "z" 
     .Zrange "-3*SH", "0" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:sorting_pin_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "sorting_pin_1" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "sr" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "2*PT+SH" 
     .Xcenter "0" 
     .Ycenter "s" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:sorting_pin_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "sorting_pin_2" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "sr" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "2*PT+SH" 
     .Xcenter "0" 
     .Ycenter "-s" 
     .Segments "0" 
     .Create 
End With

'@ boolean add shapes: component1:ground, component1:outer_cover

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:ground", "component1:outer_cover"

'@ boolean add shapes: component1:inner_pin, component1:patch

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:inner_pin", "component1:patch"

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:teflon", "1"

'@ define port: 1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "True" 
     .ClipPickedPortToBound "False" 
     .Xrange "-1.5", "1.5" 
     .Yrange "-1.5", "1.5" 
     .Zrange "-3", "-3" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create 
End With

'@ modify port: 1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "-3*SH" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "True" 
     .ClipPickedPortToBound "False" 
     .Xrange "-1.5", "1.5" 
     .Yrange "-1.5", "1.5" 
     .Zrange "-3", "-3" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Shield "none" 
     .WaveguideMonitor "False" 
     .Modify 
End With

'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "1", "3"

'@ define time domain solver parameters

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set PBA version

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Discretizer.PBAVersion "2018092019"

'@ set mesh properties (Hexahedral)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "3" 
     .Set "StepsPerWaveFar", "3" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "3" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "6" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "False"
     .UsePecEdgeModel "True" 
     .GapDetection "False" 
     .FPBAGapTolerance "1e-3" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2018092019" 
End With

'@ define brick: component1:slot1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "slot1" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "misl", "mast" 
     .Yrange "-t", "t" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:slot1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:slot1"

'@ define brick: component1:SLOT2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "SLOT2" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "-misl", "-mast" 
     .Yrange "-t", "t" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:SLOT2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:SLOT2"

'@ define brick: component1:slot3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "slot3" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "-t", "t" 
     .Yrange "misl", "mast" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:slot3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:slot3"

'@ define brick: component1:slot4

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "slot4" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "-t", "t" 
     .Yrange "-misl", "-mast" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:slot4

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:slot4"

'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "0", "20"

'@ define monitor: e-field (f=2.4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.4)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.4" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=2.4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.4)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.4" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.4)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.4" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ define cylinder: component1:MICROSTRIP

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "MICROSTRIP" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "MICROO" 
     .InnerRadius "MICROIN" 
     .Axis "z" 
     .Zrange "PT+SH", "PT+SH+PT" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define brick: component1:MICROSTRIPL1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MICROSTRIPL1" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "SLMIN", "MICROO" 
     .Yrange "-T2", "+T2" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MICROSTRIPL1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ define brick: component1:MICROSTRIPL1_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MICROSTRIPL1_1" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "SLMIN", "MICROO" 
     .Yrange "-T2", "+T2" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MICROSTRIPL1_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: translate component1:MICROSTRIPL1_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_1" 
     .Vector "0", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ define brick: component1:MICROSTRIPL1_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MICROSTRIPL1_2" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "SLMIN", "MICROO" 
     .Yrange "-T2", "+T2" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MICROSTRIPL1_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_2" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: translate component1:MICROSTRIPL1_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_2" 
     .Vector "0", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "2" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ define brick: component1:MICROSTRIPL1_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MICROSTRIPL1_3" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "SLMIN", "MICROO" 
     .Yrange "-T2", "+T2" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MICROSTRIPL1_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_3" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: translate component1:MICROSTRIPL1_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_3" 
     .Vector "0", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "3" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: rotate component1:MICROSTRIPL1_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ define brick: component1:MICROSTRIPL1_2_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MICROSTRIPL1_2_1" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "SLMIN", "MICROO" 
     .Yrange "-T2", "+T2" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MICROSTRIPL1_2_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_2_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: translate component1:MICROSTRIPL1_2_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_2_1" 
     .Vector "0", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "2" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: rotate component1:MICROSTRIPL1_2_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_2_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "180" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ delete shape: component1:MICROSTRIPL1_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Delete "component1:MICROSTRIPL1_2"

'@ transform: rotate component1:MICROSTRIPL1_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_3" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "270" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ delete shape: component1:MICROSTRIP

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Delete "component1:MICROSTRIP"

'@ define brick: component1:MSLKD

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MSLKD" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "MICROIN", "MICROO" 
     .Yrange "-T3", "T4" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ define brick: component1:MSLKD_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MSLKD_1" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "MICROIN", "MICROO" 
     .Yrange "-T3", "T4" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MSLKD_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MSLKD_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ define brick: component1:MSLKD_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "MSLKD_2" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "MICROIN", "MICROO" 
     .Yrange "-T3", "T4" 
     .Zrange "SH+PT", "SH+PT+PT" 
     .Create
End With

'@ transform: rotate component1:MSLKD_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MSLKD_2" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "180" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:MSLKD

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MSLKD" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "270" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:MICROSTRIPL1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "-35" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:MICROSTRIPL1_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "-35" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:MICROSTRIPL1_2_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_2_1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "-35" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ transform: rotate component1:MICROSTRIPL1_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "component1:MICROSTRIPL1_3" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "-35" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Rotate" 
End With

'@ set mesh properties (Hexahedral)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "3" 
     .Set "StepsPerWaveFar", "3" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "2" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "6" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .GapDetection "True" 
     .FPBAGapTolerance "1e-3" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2018092019" 
End With

'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "0", "8"

'@ define monitor: e-field (f=2.33)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.33)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.33" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=2.33)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.33)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.33" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.33)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.33)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.33" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=2.4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.4)"

'@ delete monitor: h-field (f=2.4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=2.4)"

'@ delete monitor: farfield (f=2.4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=2.4)"

'@ farfield plot options

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define monitor: e-field (f=7)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=7)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "7.1" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: e-field (f=7)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=7)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "7.1" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=2.33)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.33)"

'@ delete monitor: h-field (f=2.33)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=2.33)"

'@ delete monitor: farfield (f=2.33)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=2.33)"

'@ delete monitor: e-field (f=7)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=7)"

'@ define monitor: e-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=7.11)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "7.11" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=7.11)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "7.11" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=7.11)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "7.11" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=7.11)"

'@ delete monitor: h-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=7.11)"

'@ delete monitor: farfield (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=7.11)"

'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "0", "15"

'@ define monitor: e-field (f=12.1)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=12.1)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "12.1" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=12.1)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=12.1)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "12.1" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=12.1)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=12.1)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "12.1" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ set mesh properties (Hexahedral)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "6" 
     .Set "StepsPerWaveFar", "6" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "5" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "6" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .GapDetection "True" 
     .FPBAGapTolerance "1e-3" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2018092019" 
End With

'@ boolean add shapes: component1:MICROSTRIPL1, component1:MSLKD

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:MICROSTRIPL1", "component1:MSLKD"

'@ boolean add shapes: component1:MICROSTRIPL1_1, component1:MSLKD_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:MICROSTRIPL1_1", "component1:MSLKD_1"

'@ boolean add shapes: component1:MICROSTRIPL1_2_1, component1:MSLKD_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:MICROSTRIPL1_2_1", "component1:MSLKD_2"

'@ boolean add shapes: component1:MICROSTRIPL1_3, component1:MSLKD_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:MICROSTRIPL1_3", "component1:MSLKD_3"

'@ boolean add shapes: component1:inner_pin, component1:MICROSTRIPL1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:inner_pin", "component1:MICROSTRIPL1"

'@ boolean add shapes: component1:inner_pin, component1:MICROSTRIPL1_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:inner_pin", "component1:MICROSTRIPL1_1"

'@ boolean add shapes: component1:inner_pin, component1:MICROSTRIPL1_2_1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:inner_pin", "component1:MICROSTRIPL1_2_1"

'@ boolean add shapes: component1:inner_pin, component1:MICROSTRIPL1_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:inner_pin", "component1:MICROSTRIPL1_3"

'@ delete monitor: e-field (f=12.1)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=12.1)"

'@ delete monitor: h-field (f=12.1)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=12.1)"

'@ delete monitor: farfield (f=12.1)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=12.1)"

'@ define monitor: e-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=7.11)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "7.11" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=7.11)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "7.11" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=7.11)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "7.11" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ set mesh properties (Hexahedral)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "4" 
     .Set "StepsPerWaveFar", "4" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "4" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "6" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .GapDetection "True" 
     .FPBAGapTolerance "1e-3" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2018092019" 
End With

'@ define brick: component1:L_shaped

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "L_shaped" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "misl", "2*t+misl" 
     .Yrange "t", "-L_shaped_length" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:L_shaped

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:L_shaped"

'@ define brick: component1:L_shaped_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "L_shaped_2" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "-misl", "-2*t-misl" 
     .Yrange "-t", "L_shaped_length" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:L_shaped_2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:L_shaped_2"

'@ define brick: component1:L_shaped_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "L_shaped_3" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "t", "-L_shaped_length" 
     .Yrange "-misl", "-misl-2*t" 
     .Zrange "0", "PT" 
     .Create
End With

'@ change material: component1:L_shaped_3 to: Vacuum

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.ChangeMaterial "component1:L_shaped_3", "Vacuum"

'@ delete shape: component1:L_shaped_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Delete "component1:L_shaped_3"

'@ define brick: component1:L_shaped_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "L_shaped_3" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "t", "-L_shaped_length" 
     .Yrange "-misl", "-misl-2*t" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:L_shaped_3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:L_shaped_3"

'@ define brick: component1:L_shaped_4

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "L_shaped_4" 
     .Component "component1" 
     .Material "Vacuum" 
     .Xrange "-t", "L_shaped_length" 
     .Yrange "misl", "misl+2*t" 
     .Zrange "0", "PT" 
     .Create
End With

'@ boolean subtract shapes: component1:ground, component1:L_shaped_4

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground", "component1:L_shaped_4"

'@ set mesh properties (Hexahedral)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "3" 
     .Set "StepsPerWaveFar", "3" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "3" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "6" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .GapDetection "True" 
     .FPBAGapTolerance "1e-3" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2018092019" 
End With

'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "0", "8"

'@ define monitor: e-field (f=4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=4)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "4" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=5.68)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "5.68" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: h-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=7.11)"

'@ delete monitor: e-field (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=7.11)"

'@ delete monitor: farfield (f=7.11)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=7.11)"

'@ delete monitor: e-field (f=4)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=4)"

'@ farfield plot options

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With FarfieldPlot 
     .Plottype "2D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.616)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.616" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=5.68)"

'@ delete monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=5.68)"

'@ delete monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=5.68)"

'@ define monitor: e-field (f=4.24)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=4.24)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "4.24" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=4.24)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=4.24)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "4.24" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=4.24)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=4.24)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "4.24" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.616)"

'@ delete monitor: h-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=2.616)"

'@ delete monitor: farfield (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=2.616)"

'@ define monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=5.68)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "5.68" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=4.24)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=4.24)"

'@ delete monitor: farfield (f=4.24)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=4.24)"

'@ delete monitor: h-field (f=4.24)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=4.24)"

'@ define monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.616)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.616" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=5.68)"

'@ delete monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=5.68)"

'@ delete monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=5.68)"

'@ switch working plane

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Plot.DrawWorkplane "false"

'@ switch bounding box

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Plot.DrawBox "False"

'@ define monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ delete monitor: h-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=2.616)"

'@ delete monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.616)"

'@ delete monitor: farfield (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=2.616)"

'@ delete monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=5.68)"

'@ define monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=5.68)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "5.68" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ define monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ delete monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=5.68)"

'@ delete monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=5.68)"

'@ delete monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=5.68)"

'@ delete monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.616)"

'@ define monitor: e-field (f=2.161)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.161)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.161" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=2.161)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.161)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.161" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.161)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.161)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.161" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ farfield plot options

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete monitor: e-field (f=2.161)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.161)"

'@ delete monitor: farfield (f=2.161)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=2.161)"

'@ delete monitor: h-field (f=2.161)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=2.161)"

'@ define monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=5.68)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "5.68" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=5.68)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "5.68" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ farfield plot options

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete monitor: e-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=5.68)"

'@ delete monitor: h-field (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "h-field (f=5.68)"

'@ delete monitor: farfield (f=5.68)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "farfield (f=5.68)"

'@ define monitor: e-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define monitor: h-field (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.616)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.616" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.616)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.616)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.616" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-3", "1.07" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With 


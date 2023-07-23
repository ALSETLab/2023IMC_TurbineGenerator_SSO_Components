within TurbineGeneratorSSO.Examples;
model SHAF25_component_scalable_linear
  extends Modelica.Icons.Example;
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=555000000, fn=60);

  Components.Shafts.Shaft_Scalable_v2_heqk
                                      shaft(
    N=5,
    H={0.124,0.232,1.155,1.192,0.855},
    K={21.8,48.4,75.6,62.3,1.98})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Interfaces.RealInput small_torque
    annotation (Placement(transformation(extent={{-160,-20},{-120,20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.RealExpression speedOut[shaft.N](y[:]=shaft.inertia[:].w);
  //Modelica.Blocks.Sources.RealExpression angleOut[shaft.N](y[:] = shaft.springdamper[:].phi_rel);
  Modelica.Blocks.Interfaces.RealOutput small_speed[shaft.N];
  //Modelica.Blocks.Interfaces.RealOutput small_angle[shaft.N];
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
    annotation (Placement(transformation(extent={{114,-10},{134,10}})));
equation
  connect(shaft.flange_a, torque1.flange)
    annotation (Line(points={{19.6,0},{-20,0}},color={0,0,0}));
    for i in 1:shaft.N loop
      connect(speedOut[i].y, small_speed[i]);
      //connect(angleOut[i].y, small_angle[i]);
      //small_speed[i] = shaft.springdamper[i].w_rel;
      //small_angle[i] = shaft.springdamper[i].phi_rel;
    end for;
  connect(shaft.flange_b, flange_b1)
    annotation (Line(points={{40.4,0},{124,0}}, color={0,0,0}));
  connect(torque1.tau, small_torque)
    annotation (Line(points={{-42,0},{-140,0}}, color={0,0,127}));
    annotation (Line(points={{-42,0},{-140,0}},
                                              color={0,0,127}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}})),
    experiment(
      StopTime=0,
      Interval=0.04,
      __Dymola_Algorithm="Dassl"));
end SHAF25_component_scalable_linear;

within TurbineGeneratorSSO.Components.Interfaces;
model T2PInterface
  "Interface between OpenIPSL generators and detailed turbine models from other libraries"
  import Modelica.Constants.pi;
  outer OpenIPSL.Electrical.SystemBase SysData(S_b=960000000, fn=30) "Must add this line in all models";
  parameter Integer Np=2;
  parameter OpenIPSL.Types.ApparentPower M_b "Machine base power";
  parameter Real ratio=2 "Transmission ratio (flange_a.phi/flange_b.phi)";
  parameter Real efficiency=1 "Generator efficiency";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft "Left flange of shaft" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput PMECH annotation (Placement(transformation(extent={{100,40},{120,60}}), iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealInput SPEED annotation (Placement(transformation(extent={{120,-70},{80,-30}}), iconTransformation(extent={{100,-60},{80,-40}})));

  Real w_m;

equation
  SPEED = der(shaft.phi)/(2*SysData.fn*pi);
  w_m = 2*SysData.fn*pi*(1+SPEED)*(Np/ratio);
  PMECH = ((w_m*shaft.tau)/(M_b))*(Np/ratio)*efficiency;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
  Rectangle(
    extent={{-100,100},{100,-100}},
    lineColor={28,108,200},
    fillColor={255,255,255},
    fillPattern=FillPattern.Solid)}),                Diagram(coordinateSystem(preserveAspectRatio=false)));
end T2PInterface;

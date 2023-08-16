within TurbineGeneratorSSO.Components.Shafts;
model Shaft_Scalable_v2 "Scalable torsional shaft model"
  extends TurbineGeneratorSSO.BaseModels.Shafts.baseShaft;

  import SIunits = Modelica.Units.SI;

  outer
    OpenIPSL.Electrical.SystemBase SysData( S_b = 960000000, fn = 30);

  //parameter Real Sb = 100e6 "base power";
  //parameter Real f = 50 "rated frequency";
  parameter Real wo = 2*Modelica.Constants.pi*SysData.fn "rated angular frequency";
  parameter Real p = 2 "number of poles";

  parameter Integer N = 5 "Number of masses";

  //parameter SIunits.Inertia H[N] = {0.124, 0.232,  1.155, 1.192, 0.855} "Vector of moment of inertia values in p.u.";
  parameter SIunits.Inertia H[N] = {0.176, 1.427, 1.428, 1.428, 0.869} "Vector of moment of inertia values in p.u.";
  parameter SIunits.Inertia J[N] = H.*(SysData.S_b/wo^2);
  parameter SIunits.RotationalSpringConstant K[N-1] = {17.78, 27.66, 31.31, 37.25} "p.u. torque/rad";
  parameter SIunits.RotationalSpringConstant C[N-1] = K.*p^2*(SysData.S_b/(4*wo));
  parameter SIunits.RotationalDampingConstant D[N-1] = fill(Modelica.Constants.small, N-1) "Vector of damping constant values in Nms/rad";
  Modelica.Mechanics.Rotational.Components.Inertia inertia[N](J=J, each stateSelect=StateSelect.always, each phi(fixed=true,
        start=1.5707963267949));
  Modelica.Mechanics.Rotational.Components.SpringDamper springdamper[N-1](c=C, d=D);
  Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngle[N];

equation
  connect(inertia[1].flange_a, flange_a);
  for i in 1:(N-1) loop
    connect(inertia[i].flange_b, springdamper[i].flange_a);
    connect(springdamper[i].flange_b, inertia[i+1].flange_a);
    connect(relAngle[i].flange_b, inertia[i].flange_a);
    connect(relAngle[i].flange_a, inertia[i].flange_b);
  end for;
  connect(flange_b, inertia[N].flange_b);
  connect(relAngle[N].flange_b, inertia[N].flange_a);
  connect(relAngle[N].flange_a, inertia[N].flange_b);
  annotation ();
end Shaft_Scalable_v2;

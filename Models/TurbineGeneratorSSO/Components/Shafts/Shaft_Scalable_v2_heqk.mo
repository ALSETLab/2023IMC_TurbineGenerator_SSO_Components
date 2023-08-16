within TurbineGeneratorSSO.Components.Shafts;
model Shaft_Scalable_v2_heqk "Scalable torsional shaft model (for use when # of inertias is equal to # of spring constants)."
  extends TurbineGeneratorSSO.BaseModels.Shafts.baseShaft;

  import SIunits = Modelica.Units.SI;

  outer
    OpenIPSL.Electrical.SystemBase SysData;

  //parameter Real Sb = 100e6 "base power";
  //parameter Real f = 50 "rated frequency";
  parameter Real wo = 2*Modelica.Constants.pi*SysData.fn "rated angular frequency";
  parameter Real p = 2 "number of poles";

  parameter Integer N = 4 "Number of masses";

  //parameter SIunits.Inertia H[N] = {0.124, 0.232,  1.155, 1.192, 0.855} "Vector of moment of inertia values in p.u.";
  parameter SIunits.Inertia H[N] = {0.124, 0.232,  1.155, 1.192} "Vector of moment of inertia values in p.u.";
  parameter SIunits.Inertia J[N] = H.*(SysData.S_b/wo^2);
  parameter SIunits.RotationalSpringConstant K[N] = {21.8, 48.4, 75.6, 62.3} "p.u. torque/rad";
  parameter SIunits.RotationalSpringConstant C[N] = K.*p^2*(SysData.S_b/(4*wo));
  parameter SIunits.RotationalDampingConstant D[N] = fill(Modelica.Constants.small, N) "Vector of damping constant values in Nms/rad";
  Modelica.Mechanics.Rotational.Components.Inertia inertia[N](J=J);
  Modelica.Mechanics.Rotational.Components.SpringDamper springdamper[N](c=C, d=D,
      each stateSelect=StateSelect.always);

equation
  connect(inertia[1].flange_a, flange_a);
  for i in 1:(N-1) loop
    connect(inertia[i].flange_b, springdamper[i].flange_a);
    connect(springdamper[i].flange_b, inertia[i+1].flange_a);
  end for;
  connect(inertia[N].flange_b, springdamper[N].flange_a);
  connect(flange_b, springdamper[N].flange_b);
  annotation ();
end Shaft_Scalable_v2_heqk;

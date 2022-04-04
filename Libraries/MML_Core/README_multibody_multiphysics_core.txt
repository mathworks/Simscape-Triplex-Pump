Simscape Multibody Multiphysics Library - Core

Open project Multibody_Multiphysics_Core.prj to get started

This file contains example models showing how to extend Simscape Multibody models
by adding physical effects spanning multiple physical domains modeled in Simscape. 

Connecting the models using Simscape Physical Signals ensures a lossless transfer 
of power between physical networks. This submission contains a library that contains 
general interface blocks (rotational, translational), and example models showing 
how to use them to model multidomain physical systems.

You need to ensure that your use of these interfaces is physically valid.  Connecting
a 3D mechanical model to a 1D physical systems requires that you follow a few basic
rules:

1. Never add inertia directly to the node on the Simscape side of the interface.
  
   All masses in Simscape models live in an implicit inertial reference frame. A Simscape mechanical 
   circuit interfaced to a Simscape Multibody machine in general moves in an accelerated frame. A simulation 
   with such a circuit does not include the pseudoforces acting on the Simscape mass and inertia elements 
   as experienced in such a noninertial frame and thus violates Newton's second law of mechanics.

2. If you must model inertia in the Simscape network, connect it to the interface element 
   via a spring and damper connected in parallel.  Be aware that a Simscape circuit does not model 
   the motion of such bodies along or about axes orthogonal to the coupled primitive axis chosen 
   in the interfaced Joint.

3. Quantities sensed in Simscape (like translation at a node) may be offset from comparable quantities
   measured in Simscape Multibody.  This is because the initial position of the Simscape Multibody joint,
   which is determined during the assembly process, is not automatically conveyed to the Simscape network.
   You must either use MATLAB variables to synchronize the setting of the initial position or feed
   the position from Simscape Multibody to the Simscape network.  The examples in this submission
   show how to do that.

Copyright 2013-2022 The MathWorks, Inc.

#########  Release History  #########  
v 4.1 (R2021a)	May 2021    Removed hardstops from single acting pump examples
                            Added example single acting pump, motor driven

v 4.1 (R2021a)	Mar 2021    Updated for R2021a 
                            Added library blocks that use foundation library elements
                            Added/Updated examples to use new blocks

v 4.0 (R2020b)	Sep 2020    Updated for R2020b 
      (R2020a)
      (R2019b)

v 4.0 (R2020a)	Mar  2020   Updated for R2020a
      (R2019b)

v 4.0 (R2019b)	Sep  2019   Updated for R2019b
                            Converted to MATLAB Project with core content as Reference Project

v 3.0 (R2019a)	Mar  2019   Updated for R2019a
                            Joint limits within Simscape Multibody added (see sm_ssci_hinge_hardstop.slx)
                            Physical Signal blocks updated for unit propagation.

v 2.7 (R2018b)	Sep  2018   Updated for R2018b

v 2.6 (R2018a)	Mar  2018   Updated for R2018a

v 2.5 (R2017b)	Sept 2017   Added block Hydraulic Cylinder SA PS to library which models
                            a single-acting hydraulic cylinder using a physical signal
                            interface.  
                             
                            Added sm_ssci_02_cylinder_sa_pump which models a single 
                            piston pump using the Hydraulic SA PS block.                          

v 2.4 (R2017b)	Sept 2017   Updated for R2017b.

v 2.3 (R2017a)	July 2017   Fixed mistake in library (Interfaces/Translational Simscape Multibody).
                            Changed checkbox from torque to force.
                            Added example sm_ssci_01_slider_crank.slx                            

v 2.2 (R2017a)	May  2017   Initial release (version number set to match File Exchange)
                            Includes general 3D-1D interface blocks as well as abstract multiphysics
                            blocks connecting hydraulic, electrical, and mechanical effects to
                            multibody systems.  5 basic examples and one CAD workflow example.


# Structure_Analysis_direct_Stiffness_method
An analysis of a 2-D frame by Indirect Stiffness Method. 
The ISM is based on the principles of matrix structural analysis.

- Define the structure: Identify the elements (beams and columns), nodes (points of connection), and their connectivity.
- Define geometry and material properties: Define the dimensions and properties of each element (length, cross-sectional area, modulus of elasticity, etc.).
- Define boundary conditions: Identify the fixed supports, pinned supports, and rollers that restrict the motion of the structure.
- Define loads: Determine the external loads acting on the structure (forces, moments, etc.).
- Form transformation matrix: Create a transformation matrix to convert the element stiffness matrix from local to global coordinates.
- Create the element stiffness matrix: Formulate the stiffness matrix for each element in local coordinates.
- Form the joint load matrix: Calculate the forces acting on each node due to the external loads.
- Assemble the global stiffness matrix: Combine the element stiffness matrices into a global stiffness matrix using the connectivity information.
- Apply boundary conditions: Remove the rows and columns corresponding to the fixed and restrained degrees of freedom from the global stiffness matrix and the joint load matrix.
- Solve for displacements and reactions: Solve the system of equations to obtain the nodal displacements and reaction forces.
- Calculate member end forces: Calculate the internal forces (axial, shear, and bending) in each element based on the nodal displacements and the element stiffness matrix.

By following these steps, the Direct Stiffness Method can be used to analyze and design 2-D frames for a variety of structural engineering applications such as bridges, buildings, and aircraft.

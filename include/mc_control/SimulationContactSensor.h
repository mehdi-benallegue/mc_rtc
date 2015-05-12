#ifndef _H_SIMULATIONCONTACTSENSOR_H_
#define _H_SIMULATIONCONTACTSENSOR_H_

#include <mc_control/ContactSensor.h>

#include <mc_rbdyn/surface_hull.h>
#include <mc_rbdyn/stance.h>

namespace mc_control
{

struct SimulationContactPair
{
public:
  SimulationContactPair(const std::shared_ptr<mc_rbdyn::Surface> & robotSurface, const std::shared_ptr<mc_rbdyn::Surface> & envSurface);

  double update(const mc_rbdyn::Robot & robot, const mc_rbdyn::Robot & env);
public:
  std::shared_ptr<mc_rbdyn::Surface> robotSurface;
  std::shared_ptr<mc_rbdyn::Surface> envSurface;
  sch::S_Object * robotSch;
  sch::S_Object * envSch;
  sch::CD_Pair pair;
private:
  void updateSCH(sch::S_Object * obj, const mc_rbdyn::Robot & robot, const std::shared_ptr<mc_rbdyn::Surface> & robotSurface);
};

struct SimulationContactSensor : public ContactSensor
{
public:
  SimulationContactSensor(const std::vector<mc_rbdyn::Stance> & stances);

  virtual std::vector<std::string> update(MCController & ctl) override;
public:
  std::vector<SimulationContactPair> surfacePairs;
};

}

#endif
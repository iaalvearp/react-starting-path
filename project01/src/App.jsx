import "./index.css";
import { FollowerCard } from "./TwitterFollowCard";

export function App() {
  return (
    <>
      <h1>Proyecto #1</h1>
      <FollowerCard
        name="Ivan Alvear"
        nickname="iaalvearp"
        followBtnText="Seguir"
      />
      <FollowerCard
        name="Miguel Ángel Durán"
        nickname="midudev"
        isFollower
        followBtnText="Seguir"
      />
    </>
  );
}

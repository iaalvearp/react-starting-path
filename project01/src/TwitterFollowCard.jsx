import { useState } from "react";

export const FollowerCard = ({
  srcAvatar,
  altAvatar,
  name,
  nickname,
  isFollower,
  //formattedNickname = nickname.startsWith("@"),
}) => {
  const srcPic = `https://unavatar.io/${nickname}`;
  const [isFollowing, changeFollowState] = useState(false);
  const classNameIsFollowing = isFollower ? "isFollowing" : "";
  const text = isFollowing ? "Siguiendo" : "Seguir";

  const afterClick = () => {
    changeFollowState(!isFollowing);
  };

  return (
    <article className="follow-card-container">
      <img
        src={srcAvatar || srcPic}
        alt={altAvatar || `avatar pic de ${name}`}
      />
      <div>
        <h3>{name}</h3>
        <div>
          <p>@{nickname}</p>
          <p className={classNameIsFollowing}>
            {isFollower ? "Te sigue" : null}
          </p>
        </div>
      </div>
      <button onClick={afterClick}>{text}</button>
    </article>
  );
};

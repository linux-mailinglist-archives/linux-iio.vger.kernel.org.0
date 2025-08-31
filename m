Return-Path: <linux-iio+bounces-23510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27126B3D149
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86263BF79B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D323BD02;
	Sun, 31 Aug 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZOJyzE2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376F2AD31;
	Sun, 31 Aug 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627534; cv=none; b=htD/fNhJNtBCAMjPbwGFE5nLdJUrAeTROOh8KoZq3aNBdfQOGyho7hN+OGiwfsiESWbhQwm3N82I/WhHnoy2LEmP4e5zJps8WsAJlfv1QbxgFJR6p42/rZazKiTL5Xn2VHXQ3gvGQHD30iIsH/bsQjWNYh+YAtRUImiRDBN7qzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627534; c=relaxed/simple;
	bh=Z1ugpXmy7mz8b7C5DBeJAh9VhGg7hZ9lOg7ZQvQv+LY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PdgbxlHYdf8T6C90yWKe9dIOR1Nm8SJeE55AsFlaNc2/J+IENm6z3Ry5l9yby+LLSG93CQ7pYHoFVxE/LBL1/U+NZLImYQ2hEjwtZYGBnjwCDb6qxp9NVziYtDuwLsfGswJN/yYVP5EHMw6Ra+lHK2ZaIq4+AbPp7SE9ujQhQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZOJyzE2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so225141a12.1;
        Sun, 31 Aug 2025 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756627531; x=1757232331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oH6/8MjSD96Gpd6MchRWuyisfBsWBUqYXvFpynszMvY=;
        b=nZOJyzE2v7yd0TX/7YnDPXXpTndyCXcM53OgXujwmKbW++BPTKhKXthQ+HEY+mF14i
         zUSLzMS+u8PKmuxk3+aZy7OrZ3dEEXgjwtdblP0nSInLo0ZTz8Fsnyk4y7+O/h5fb+u9
         glDM2OMgB+12S4RnZRqkfrahVAL7vRB5isoqkjONfKni15Qwat/N5LwXou98UWJm+VwO
         L6iL9+IK1w4ZfeLyqmn5/GLQb1D6ulzqbpauAPha6OMsvHKqpzkjqjm1O0BqtCeUPuvJ
         HknQ5biQ/LC6A/2trboS11xmjlnHmwmng3KpZmormjootlLb+HPl2nPH0MLqOQjB+p17
         Y1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756627531; x=1757232331;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oH6/8MjSD96Gpd6MchRWuyisfBsWBUqYXvFpynszMvY=;
        b=KTN7PLwXdwBWIHN+ZppCPs1pbsx6NlkvuW0qtzr82VdHY7e/ZlbsSH6ryeUM/DtgXP
         XKd+/LwtwMx+t8T+WIu6kZGXs0JMlanLHGrFRQPeK7GntF4HvmR73oX+nkowlQKV5zu4
         MXeyzED/r7pf3yJ2njWPTb8EkZBeouF/aBGaR4DLwphAaU9RFkIgKt466uQBlCWcjt1O
         aiHb7O3bGz1FLAtm2v4FYfUN1dJTbf4lW2zEQ3dtHa/vcyFyrKnEZY5fmVY0qc6H1FqA
         OrdmXp74gdzuA7WTBdlH60loTO0+z7H6WW0Mv/h48W4Uturldq/0eDcBNgUbC5bMzBHl
         vNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCWmsS5r1mrrZ9tBwUGH6CRS8NawMvo+CksoQxTNGU7b2vS5M3yAF1VnojHAM09JTEGpgaruwVn3fW@vger.kernel.org, AJvYcCVPow1ECRqpNsmI7E+XZPtnrwrTzqI7iqEaATwJQCyECGbnG6GcdStWDgr4x+y2sQIPyqH4rV4DBYSq@vger.kernel.org
X-Gm-Message-State: AOJu0YywyHZ2D4XLPSwfglg9SiR1ZTX18w801iBUJCV0kGeg2Z11Vst2
	Razuam03l2nhSKVPRV86Ahovf32zuK1pqrMIb+hCt6xksOP9rXI6wPLyfGyZiH81bfAy8mVkYhC
	fzu2q6Q0XU4iektLzwNwxycFd96v8fH7YQ9ggZ0g=
X-Gm-Gg: ASbGncuV0Iwm7zAAD5vJo4cGjMYg0XcRxrO3Iz/NvKlTE9bI1utbWvHtv9pNVwRYHNT
	cmq6J0xq8PPWEr5FZc6LSpCKW3kWerO/R/rgMYhnf3RkJ4JFask10sUPuOqKHnSuh+dAVl0EXAw
	H6vcRbmi2/Pk2ZsvhMrBy31lOnJDt01hX89HlQtd7y2DmyryJZuimL2dBDVJccwvzwdlvJtbnAL
	r7QeBVrGce87wT99/EahtwAKAAsIVE=
X-Google-Smtp-Source: AGHT+IETeTdt8DWnpMCxDaUFfJLUgy8KTW5IGNWlAOrKq+ka7w0Dlv8B3V8KOpSw4h1MpPXgEQN3OgoaRNumeRteCRw=
X-Received: by 2002:a05:6402:2711:b0:61c:5100:3063 with SMTP id
 4fb4d7f45d1cf-61d22dfd639mr4598915a12.7.1756627530711; Sun, 31 Aug 2025
 01:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sun, 31 Aug 2025 13:50:19 +0545
X-Gm-Features: Ac12FXxG-u-9NBXeaKseL5AVOyH__WjOgKXMzYu77vKX0bGQvfzi6SJ6rIUnbCc
Message-ID: <CAJE-K+Ctp7sps9yhyagxzL-SJYfyN8mPSz87ALD5XOZqYMru7Q@mail.gmail.com>
Subject: [PATCH v1 0/2] winsen,mhz19b: added compatibility and of_match for mhz19c.
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The winsen mhz19c is physically and pin-to-pin compatible with mhz19b.
The need for the compatibility stems from the discontinuance of mhz19b
as explained on winsen's website.

Sidharth Seela (2):
  Added mh-z19c to compatible enum list
  Added mhz19c to compatible list in mhz19b driver.

 .../bindings/iio/chemical/winsen,mhz19b.yaml           |  5 ++++-
 drivers/iio/chemical/mhz19b.c                          | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

--
2.39.5 (Apple Git-154)

-- 
Thanks,
Sidharth Seela


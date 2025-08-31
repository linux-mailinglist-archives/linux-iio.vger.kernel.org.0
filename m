Return-Path: <linux-iio+bounces-23512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA0B3D15A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955CE440709
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887A246782;
	Sun, 31 Aug 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7y5c4pe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022920DD48;
	Sun, 31 Aug 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627918; cv=none; b=U4v5Pk7FpPIlBWXBP9nVpTLcUwsTN979n+hqLEg5IlaGs3YJ7zwvIrFvEBNsVwcUW9V33Ya77frhD/2ksd8mMk0RyKcOnRByg6bWYTn0a+b3mTM5SQoHXnd2NdT0lOSxBcRcfG6dQdpBzBL0ZA+IRhDD4/8EralGuCrX7vu3URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627918; c=relaxed/simple;
	bh=oDGPoeLsOQZEenctq3oEfpVzBuv5PrPvnl290sTfW7g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ne44dJ9Xs/mYBtxGlGYifgKspH1wvRAYC/XKp18VStZMPOF4+lq+b3ckYQh8Pcdh1/veGrTCMr2fcBTY7wVLGvWTO+E81bLm4aRnd5sQWQAfvhbqDPeLnMJ+TTy5UAwo7oP1qzK77DZf+WMXh/MdiN/n+1oly8Nu+KNK1kVW7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7y5c4pe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso328456a12.2;
        Sun, 31 Aug 2025 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756627915; x=1757232715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3qsLy+JmHMtInU59RKvLKKlar7+2mo40YH+sJ3iJSdg=;
        b=e7y5c4peEmRUBkn0+roNIuCGCTrW0MQ9GOHAnLvbi+loIAZ7Bqp5mLW3hbY2K6GKKH
         7E1QGdHRAuhlKE08F+oL+9rb0xd934H0FhDBNJHJQDZyIv0yAYh2QCQ8jDMxkdXXKffZ
         gdYg5xLExeI9rLYmamtfLFm3JPPSfv5tQBqveptblS2tXGZcSpxrkNdRhATwa2Cq3rhz
         YXgt/rmtWH6tj+7vPvk5Jrn+QnxpAelKgc/AYzwofWTrPbRFLRmwkoYC1crvhngDbMI2
         IMU6SaVUSaWY1AGsMKVjMdg5nKO7b+VPO91OxbOWrj+iQizjKt0irwRDlVf8/Xn1J+L1
         EHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756627915; x=1757232715;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qsLy+JmHMtInU59RKvLKKlar7+2mo40YH+sJ3iJSdg=;
        b=i0D5K6OJPzKPOT0yRlUruiZi35IiEd3Ckm68b6sWqSz7h0iKiiuyZr63oZbzobqa8J
         jk3rG9V527nOK/qyu1HXMes29arcuNv373gXaF2ccmTwj2T0v8H0SjmDbmG62EgtWoQZ
         gdfz/judCqmBjCcWX7om3J9Jdoi669wdfBdKLj8k+PyIfP9+M7cN8flUfjpeYbH9K6VB
         JksZ6bIGltY1vJE11myRm3mMZBxAFD6JqaJJXAwof0rSmYkPMex5WudQMkN/zoUrsuE2
         8gnsfaqp7aKhVVoUdOgJI+X/si9rpacSOjENLLs6LA0VlOVdC/6Ib6Y32gwzFiTLr/bq
         QXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw9HXZ9uP4iBvdMsx0EMX0hf9f2shGDwZpbkg2tF/qtHJqEZL+XVH12BPO8LpHc0nLXhTuydmin2AG@vger.kernel.org, AJvYcCWR7ZxfrrPZF0lOwZLqNqw0024n/WQFHt7dMhZ3OCmRvbklN5KvKwQhZIdVZOxFK6jaEK6Gy6Ld+Lc6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cVtbnYk7D2bxIjCzvkhxPsbeRqbbfd9UvX1OVcXHnz/+n5kj
	wbjYj4yNne2zryOtl5vjyGFH3qpxBGbY9vgl13+1i72nikc6ZaW6Gt+hMlPdmm+OavODE6v9nuZ
	mAR0lb9vcZbFRBQ47lQJJ56E4h6wxxVw=
X-Gm-Gg: ASbGncsrAyguj6bZ41hgXsMFpb2ynRmdY1y0tFdPL+fHuKqGsgPtO6L294QmR0O0F3h
	Q7HMbGStoN1S9u813CPdFdCbItaoQg+zdaij8HDHpIjc73nConDQtJuA91ojY9RUP3TD573E50V
	5VTpAC11766SH+HfnbcwFtKg21YVvVn8Gb3AOCXANyXeL62LXSAlXefgi88UJxkqHe7FcaEG98t
	ooD7NRTit4qT7X/uZZ2ji+NxJXljqo=
X-Google-Smtp-Source: AGHT+IFiZXPejAbkpTHcvTZ1PSw6jS1yB3DbuP+950Wkg4KnvHL/aE/xFtVXhMENeDHldbhjoyw0K9MiG/Ky3+ZKkKk=
X-Received: by 2002:a05:6402:274c:b0:61c:30cf:885c with SMTP id
 4fb4d7f45d1cf-61d26d7ac53mr3396922a12.32.1756627915194; Sun, 31 Aug 2025
 01:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sun, 31 Aug 2025 13:56:44 +0545
X-Gm-Features: Ac12FXz4KVwcXyNzi14PlWg4NRK-zL1wGBQzK7Wy9u5y931Wz5utFFhLtLNFNYs
Message-ID: <CAJE-K+DSw5PWdxqdTMO1oXcAQs9cH04jAVeajFuBcZf==jP=Og@mail.gmail.com>
Subject: [PATCH v1 1/2] Added mh-z19c to compatible enum list
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Winsen sensor's mh-z19c and mh-z19b are pin-compatible and also share
the same UART parameters. Hence, it makes sense to add it as a
compatible in the yaml file. Also mh-z19b is discontinued.

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---
 .../devicetree/bindings/iio/chemical/winsen,mhz19b.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
index 2a6ddb33f163..e8520d9095f3 100644
--- a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
@@ -11,7 +11,10 @@ maintainers:

 properties:
   compatible:
-    const: winsen,mhz19b
+    items:
+      - enum:
+        - winsen,mhz19b
+        - winsen,mhz19c

   vin-supply:
     description: Regulator that provides power to the sensor
--
2.39.5 (Apple Git-154)


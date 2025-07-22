Return-Path: <linux-iio+bounces-21879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DCB0E25F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18CD567C0A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8EF27EC78;
	Tue, 22 Jul 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I326v3hJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F220C038;
	Tue, 22 Jul 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203979; cv=none; b=NoXQO6oZULuvPuqAmp1avVU84EYFP4XYI0ZjnZZW3xn2guiCltkV3GtH2836GjZZl7nHyQ2SQR5H4PeWIzr9VSBbn05z6J4fjPa49bM1vYrKPO+Ww29GaAWL7ut0Tg+P3PAJm8Rd1eiDBffHZ+p8RqO2mG0jF+wEp2PeCWyWRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203979; c=relaxed/simple;
	bh=+7hq+WLdRqopPF+CFD7fiq+PsdOgDtJNEsq2kRZLNgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7HYnxubJy4JkK/t5gCW3gH80h5ys4Kd6Uod3LpYS2P+gp8zURw7vuR2JM7ETKobsmwZ4tSrWCID+bz8l4eKlqNrqTiNQSTsFsoa/0zCXGpxMVk6CxFRovBez8P3dcDfGMRrqrCw94VxihMatzUohGT0SbP5/iBy46qihC5AK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I326v3hJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748feca4a61so3201652b3a.3;
        Tue, 22 Jul 2025 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753203974; x=1753808774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJQH/hF+xiHb5wpOlNLaNq0/n1MDfFBc0fOnEVl8MF0=;
        b=I326v3hJAFF7Dc+yROokrg8kintpEtwnRxGivtDjRPcTa/blHynghcEG9NdaqUIAvw
         0VFtNBxv5u2W6mjzhHSckssCVFJDM3eU/9LCM4xYBPlCoP7Es3+EAG8kHnHSP0ofm+Cu
         Z4b2/AMCR9tKynvDZL+0ITxJFJXMUM0pfOZVn3M+lWaZa00vg+cG/ZNYW7Fe3BtqPMyq
         3XsoBCex6gzoo2cv75dGFkymkpbLwfXuqrIvh4MTSiHXgXxIueegTP5+cZVCcDv7yeO2
         wRMEUnCE3ikImq9cMf6UitFjNZz+MAV9WWaLLp32qGYDAHWYUEPFFOvifZdEsUdQR3t1
         8gqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753203974; x=1753808774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJQH/hF+xiHb5wpOlNLaNq0/n1MDfFBc0fOnEVl8MF0=;
        b=D5sqMsGSGjn3/F9XRATwTyZxrcpXNWXHOJNlNzc5isbRt03jt2e7JXqZegjT9FkqRn
         0QFI2F+E3HUmBWOJAeSpWR/muU4ByjXQnBx37GrqqYV8Hj5Q8GptLEt8gpD27IRg+ISp
         1ktBiUJnk3u7v6BW2N1oozR56yVhv8DNbtAPQjdCvKu50CcyYtkNnjnlTtVopT74ZlcY
         3FjpIXq6fGK8zon35EjeUJh+p1qCP79ay6Vr/KtcaKixaUJsgiZXAClMFKuv0emOce90
         gaosVBgapDy+v9Jq/ZrJt7TPo9T5WoPydcSmq92q+9r5vrr/CRHNK7Bwh4Zv5EWKc8v3
         uLVw==
X-Forwarded-Encrypted: i=1; AJvYcCUQjpko9i+gVf06XxrRFXGTA4JTJMF07qd/ONZ1V70q0UvIsWPHy9kqJgNh4cvcIPHw4esJrdM2HGbS@vger.kernel.org, AJvYcCVOTjcR4u69PxgXPC5W/TSVCiIhKGfD5dEHnjropg1zYdXGJ1PrVLwjfnj6b6M6ZWqEjCPhu6jCfKZO@vger.kernel.org, AJvYcCVgg/7zqglA/ptFk6jxxhVhqYcvzC3KKOwuT80tfYq9PUzVvjuucYnu1lhdmnqWWaIiOw0qMzeX@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwoZvjLozfJHjtWzhHjfK35ahjWoqr+zfDqJnP9zWaQiOtBrq
	mCeCQBCIhD4DGhN1C0HzoFJloMeUMzrs6fiZTnYPrU0sv2q2I1mjx4N3JlHTkjvqKxc=
X-Gm-Gg: ASbGncuLSGoiXe394dWosM/3kS+KAr0zvm1nH+L1u4yi/SS9+r1NVwvoq6GZp/OUlrU
	ZlE15DlG7gwKa+jIdY0mGAYr1sQpZu5/18ZgeQUoYa4+dG4FOms2kV/1w3t59SLCrL4WWv8pxE4
	v57b/DdTPMcxG7UMu+j3Yy4GNjSt8LEfC85f5hjmdapYQJL43CF0c3OZRkSFEjju8jwkysFbMlt
	l04onkrvxwNABMxJ5RClsmelfQkIlFKjYfq9opVny2jlz3aT6iHn8Io5ZERrF8fC6pMFarDMK4t
	593ylhRkdmJpAOW49tNQxI/xBSQhy1VUVP7TjWHAPRo2Vmzq1fRx1zTf9U3L6ZwVGdT3KLTnle1
	j4cjNJ6p1rgUlQ0AFep/CgJUo6NaeUVY=
X-Google-Smtp-Source: AGHT+IEkw8+Vtk94z6sfnq2tvcwIOwJg956iq0XweSQItS4GP7Y0qaUNiQVwgOPzwgaUtt2BcOqzAQ==
X-Received: by 2002:a05:6a20:6a09:b0:232:6809:d41a with SMTP id adf61e73a8af0-2381244da0bmr42904835637.14.1753203974225;
        Tue, 22 Jul 2025 10:06:14 -0700 (PDT)
Received: from km-host.. ([49.207.192.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe63065sm7350732a12.15.2025.07.22.10.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:06:13 -0700 (PDT)
From: Sanjay Suthar <sanjaysuthar661996@gmail.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: ribalda@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	Sanjay Suthar <sanjaysuthar661996@gmail.com>
Subject: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML docs
Date: Tue, 22 Jul 2025 22:35:13 +0530
Message-Id: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor grammatical issues by removing duplicated "is" in two devicetree
binding documents:

- net/amlogic,meson-dwmac.yaml
- iio/dac/ti,dac7612.yaml

Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>
---
Changes since V2:
- Corrected the subject line
- link to v2 : https://lore.kernel.org/linux-iio/20250720182627.39384-1-sanjaysuthar661996@gmail.com/T/#u

 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml      | 2 +-
 Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
index 20dd1370660d..624c640be4c8 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
 description:
   The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
   guaranteed 12-bit monotonicity performance over the industrial temperature
-  range. Is is programmable through an SPI interface.
+  range. It is programmable through an SPI interface.
 
 maintainers:
   - Ricardo Ribalda Delgado <ricardo@ribalda.com>
diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 0cd78d71768c..5c91716d1f21 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -149,7 +149,7 @@ properties:
       - description:
           The first register range should be the one of the DWMAC controller
       - description:
-          The second range is is for the Amlogic specific configuration
+          The second range is for the Amlogic specific configuration
           (for example the PRG_ETHERNET register range on Meson8b and newer)
 
   interrupts:
-- 
2.34.1



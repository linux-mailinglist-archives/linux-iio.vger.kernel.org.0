Return-Path: <linux-iio+bounces-13320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97089EBE57
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 23:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1865828480C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0223A59D;
	Tue, 10 Dec 2024 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtboAx0B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413923A566;
	Tue, 10 Dec 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871090; cv=none; b=fqmypQOCtFrvbSnz8mm50QSwypXMgKl9IpvffN2FPbpKfsoioXY3Sp8FaG+JFSsVr58bxBOsQDmEMOSgQ18c40MqHHuNqfQW8XxNwICQy/L3N1sz4g+5asDGQ+RDjInQRF6jd7SsGZA2dkU/B2kGRLDpIbbNDGEu4VxamxxkxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871090; c=relaxed/simple;
	bh=n5pG/TYyBwfqRQtEQJbQZiEr58WKn9aE5efNPAZov7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sl5nmXvPySSf4BOnFGNaNgKjRJscEuW94HNTL/DdmiFoz8U4zvUUl5AVR0zRHe1XOO1G/3fbuaRM93LOiBO0vsyfo0r5KzoCyE8FNia3Tt3/keicfm5KOe44f+lipyuD4HgI4357HklSUXswfCczBDHFf11nq067PswEhtNd7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtboAx0B; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71ddcdc445dso75953a34.0;
        Tue, 10 Dec 2024 14:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733871088; x=1734475888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWRlOS/1Rlfm48UyQ1PyZDHyVL86Gb45oXxEsMJ/ync=;
        b=DtboAx0B9Zy1ML6wAeMicEKSWRJNT+JBcpsXg/DTSQHVnol3BFX94WNcys9galOQm2
         JWLyY1Oe+3N5vdY3eTThIFdG86qxCfMCrTNmpU+9pAZMooqypRWOy85GC61AvrymEuc8
         /V5k28/1LqAlcXq4Oa1RpTTQqS3/Jhe7pl9DtaKmYCVAUIn9rwXfO+OsMNsweX1Pu4N4
         z3efkUHl5mmyugFcY2TXulCIHdKCe1bk+eHCLccU/o81UyS8UMYErjhzeehV4rZVp9DX
         qGEwmNyxYCpR+EzV9FYaRGaHkus2KYP/mAVij4rPR7sLWt+1X3N043pDFO8Utt4wR0W+
         bWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733871088; x=1734475888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWRlOS/1Rlfm48UyQ1PyZDHyVL86Gb45oXxEsMJ/ync=;
        b=sljfxqQB1Lzm8XxnJRPZ+jJ2gzGYNge4FZjHzuIr1Fo/2KRGxewm7x5UqJxXaZEgLg
         jfXC92QGFLF+PjYUvmbZzljUMziTR1RbOFVd/vlm0u/0YCXB37McyjVAA95w58He/aYL
         xcmmAtIXT/uFLcWyIzgsfa7HVrLrKZk1akmUYyp436JGkSvQB00+CFgwJHkg/Ck8iPYg
         UNuj7sGfuS0fpEa44S1Irp/4IOVVE7epTyjX4WtDCpKLg64r4h0o9CA+u8PAFT+TMzj6
         1X+4pykaxdEyOq7yebwM/jvIk6HSEieayFBc1pdKpjBctr3NmR+DymDTHQ1cajTCltX3
         9paA==
X-Gm-Message-State: AOJu0Yxv2YBxbqSmaEcrXI/gBp3MHDkQ/PxgwYz3+gUbySb2lw1Btajx
	F7Pbr/kbX0q7ANIaOkwqt+bDhVHBZW51B5zyXk2vQedWNwSoBwRZIpGAkg==
X-Gm-Gg: ASbGncsr4gLmlr1wfuNVak/gEHdoPBJodlGG7jsSofhTBuvTh5JyMn6I1nE4mbz5oID
	aW8e8wJq69CN85SbDJbF8monyyGhpKITsvgYtIQxDhmwG8bP9UimAAfkJHMxdUHNwla/oOjMmDx
	WIY/GApsBmQNdGXAZApQwEmKU6LP4O6isg9UXDyDC0geCh/40rO5KZvMWUtmIBdu0EOJO7tVpdd
	sdIqAIzMmaDIz8Fakweyw/Q3kZN2/gmN7x5XHMAcEyeMIqgOPC9
X-Google-Smtp-Source: AGHT+IGEiwxPq74eA4rSCC4kG14soSRpIJQDfPDrxZrNkVAU/bFf3Ano6imm6xa4F50w7uxedzW2UA==
X-Received: by 2002:a9d:6a19:0:b0:71e:1d:5e09 with SMTP id 46e09a7af769-71e1a10e638mr238943a34.11.1733871087792;
        Tue, 10 Dec 2024 14:51:27 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2a9d525f2sm1704136eaf.4.2024.12.10.14.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:51:27 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	andre.przywara@arm.com,
	lee@kernel.org,
	wens@csie.org,
	sre@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2] power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans
Date: Tue, 10 Dec 2024 16:48:59 -0600
Message-ID: <20241210224859.58917-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210224859.58917-1-macroalpha82@gmail.com>
References: <20241210224859.58917-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Since commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators")
the drivers for AC, battery, and USB have failed to probe when the
option of CONFIG_AXP20X_ADC is enabled. This appears to be because
the existing function devm_iio_channel_get() no longer calls
iio_channel_get_sys(). Use the newly created function of
devm_iio_channel_get_sys() instead.

Fixes: e37ec3218870 ("mfd: axp20x: Allow multiple regulators")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_ac_power.c  |  4 ++--
 drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
 drivers/power/supply/axp20x_usb_power.c |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index e5733cb9e19e..07de889af16b 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -343,14 +343,14 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (axp_data->acin_adc) {
-		power->acin_v = devm_iio_channel_get(&pdev->dev, "acin_v");
+		power->acin_v = devm_iio_channel_get_sys(&pdev->dev, "acin_v");
 		if (IS_ERR(power->acin_v)) {
 			if (PTR_ERR(power->acin_v) == -ENODEV)
 				return -EPROBE_DEFER;
 			return PTR_ERR(power->acin_v);
 		}
 
-		power->acin_i = devm_iio_channel_get(&pdev->dev, "acin_i");
+		power->acin_i = devm_iio_channel_get_sys(&pdev->dev, "acin_i");
 		if (IS_ERR(power->acin_i)) {
 			if (PTR_ERR(power->acin_i) == -ENODEV)
 				return -EPROBE_DEFER;
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index fa27195f074e..152e556a4417 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -906,23 +906,23 @@ static const struct power_supply_desc axp717_batt_ps_desc = {
 static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
 				       struct axp20x_batt_ps *axp_batt)
 {
-	axp_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
+	axp_batt->batt_v = devm_iio_channel_get_sys(&pdev->dev, "batt_v");
 	if (IS_ERR(axp_batt->batt_v)) {
 		if (PTR_ERR(axp_batt->batt_v) == -ENODEV)
 			return -EPROBE_DEFER;
 		return PTR_ERR(axp_batt->batt_v);
 	}
 
-	axp_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
-							"batt_chrg_i");
+	axp_batt->batt_chrg_i = devm_iio_channel_get_sys(&pdev->dev,
+							 "batt_chrg_i");
 	if (IS_ERR(axp_batt->batt_chrg_i)) {
 		if (PTR_ERR(axp_batt->batt_chrg_i) == -ENODEV)
 			return -EPROBE_DEFER;
 		return PTR_ERR(axp_batt->batt_chrg_i);
 	}
 
-	axp_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
-							   "batt_dischrg_i");
+	axp_batt->batt_dischrg_i = devm_iio_channel_get_sys(&pdev->dev,
+							    "batt_dischrg_i");
 	if (IS_ERR(axp_batt->batt_dischrg_i)) {
 		if (PTR_ERR(axp_batt->batt_dischrg_i) == -ENODEV)
 			return -EPROBE_DEFER;
@@ -935,15 +935,15 @@ static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
 static int axp717_bat_cfg_iio_channels(struct platform_device *pdev,
 				       struct axp20x_batt_ps *axp_batt)
 {
-	axp_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
+	axp_batt->batt_v = devm_iio_channel_get_sys(&pdev->dev, "batt_v");
 	if (IS_ERR(axp_batt->batt_v)) {
 		if (PTR_ERR(axp_batt->batt_v) == -ENODEV)
 			return -EPROBE_DEFER;
 		return PTR_ERR(axp_batt->batt_v);
 	}
 
-	axp_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
-							"batt_chrg_i");
+	axp_batt->batt_chrg_i = devm_iio_channel_get_sys(&pdev->dev,
+							 "batt_chrg_i");
 	if (IS_ERR(axp_batt->batt_chrg_i)) {
 		if (PTR_ERR(axp_batt->batt_chrg_i) == -ENODEV)
 			return -EPROBE_DEFER;
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 9722912268fe..c82f05cef379 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -577,14 +577,14 @@ static int axp717_usb_power_prop_writeable(struct power_supply *psy,
 static int axp20x_configure_iio_channels(struct platform_device *pdev,
 					 struct axp20x_usb_power *power)
 {
-	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	power->vbus_v = devm_iio_channel_get_sys(&pdev->dev, "vbus_v");
 	if (IS_ERR(power->vbus_v)) {
 		if (PTR_ERR(power->vbus_v) == -ENODEV)
 			return -EPROBE_DEFER;
 		return PTR_ERR(power->vbus_v);
 	}
 
-	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
+	power->vbus_i = devm_iio_channel_get_sys(&pdev->dev, "vbus_i");
 	if (IS_ERR(power->vbus_i)) {
 		if (PTR_ERR(power->vbus_i) == -ENODEV)
 			return -EPROBE_DEFER;
@@ -597,7 +597,7 @@ static int axp20x_configure_iio_channels(struct platform_device *pdev,
 static int axp717_configure_iio_channels(struct platform_device *pdev,
 					 struct axp20x_usb_power *power)
 {
-	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	power->vbus_v = devm_iio_channel_get_sys(&pdev->dev, "vbus_v");
 	if (IS_ERR(power->vbus_v)) {
 		if (PTR_ERR(power->vbus_v) == -ENODEV)
 			return -EPROBE_DEFER;
-- 
2.43.0



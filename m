Return-Path: <linux-iio+bounces-7769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD493844D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 12:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7451C209E6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7C156F46;
	Sun, 21 Jul 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MS6qEWPr"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19493156C72;
	Sun, 21 Jul 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721556967; cv=none; b=vBDEWMdtj7v7j7bVSJ2p70ES/VbQzF5vGouVRt/YUavBAEO1qx1ACuvaE28XjSX/u8m9cavGUxRg2bMOAl8Bs1eVRpjS+EDtJFPbwCpauCfk8Fl7TJVGg5yHuNzbuvZgIURQD+aSeeF8Zdi1AnnVMXf2vbO2SFfkwTkHkJa3RjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721556967; c=relaxed/simple;
	bh=VbSZYwRv3jtpNXDiyhysm6/0+1x9p2kdZVp+aQs9vqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tA24tkPjAfexDd/2hprnlIYNSrbASndNO8EOElHnAtHCAwTTnAwfZlgDf015BmmNK2v0DUb5mXeugpDfG77z7+aF+WfMK5mdMj9Xyyin5j52XZ40mT6pExnU3+15x7I6HyL9duROKzY+XhFCI8iV2ZyRN2qDzpcmlESc9kIvhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MS6qEWPr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3C3C841805;
	Sun, 21 Jul 2024 12:15:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1VOMynD1hsG; Sun, 21 Jul 2024 12:15:58 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1721556958; bh=VbSZYwRv3jtpNXDiyhysm6/0+1x9p2kdZVp+aQs9vqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MS6qEWPrVL4eDaBDaedLGIFIxAPdpEuk8aim69gVyukw0ZY7FcC8l8SLsl64XfrJR
	 632jvmmnUd611oyAGMbPNjxr5wXgV4PzWAy82hoyYYvWhTeGZomjB1Zr5amgrBW0NR
	 ZrXO+2gH2IVO0tg047wKe044tGeXOJs/NhNcrMyBRbBhgMA/TZ+5BvVNqnDnAjFvtX
	 jXzJZY/9j4B/6uck2OBSUQ1BI/XaItgVMvNinbs+XUz3GPp/6l1q96FVjBQTdZB0vi
	 Z/sjvgDVlXVrVKglnTHF2q6HbWQxlCxxWZ2fdO1+Dn5aAM5uRSd8KPwgAQRVPGO0/Z
	 WNWFTBolFkm7w==
Date: Sun, 21 Jul 2024 15:44:30 +0530
Subject: [PATCH v3 2/3] iio: light: stk3310: add support for stk3013
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-stk3310-v3-2-98fcb6f551a1@disroot.org>
References: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
In-Reply-To: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

Add support for Sensortek's STK3013 in the driver. The part bears the
product ID 0x31.

As seen in [1], Sensortek lists STK3013 as a proximity sensor. But it
has been experimentally observed that they do have ambient light sensing
capabilities. Furthermore, [2] implements a proximity and ambient light
sensor driver for STK3x1x devices, which is also indicative of the fact
that these parts are also ambient light sensors.

[1] https://www.sensortek.com.tw/index.php/en/products/optical-sensor/
[2] https://android.googlesource.com/kernel/msm.git/+/e6dfa4641d88201e8019be19ff557e5d2cf4572f

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/iio/light/stk3310.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 48a971de6a04..ed20b6714546 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -35,6 +35,7 @@
 #define STK3310_STATE_EN_ALS			BIT(1)
 #define STK3310_STATE_STANDBY			0x00
 
+#define STK3013_CHIP_ID_VAL			0x31
 #define STK3310_CHIP_ID_VAL			0x13
 #define STK3311_CHIP_ID_VAL			0x1D
 #define STK3311A_CHIP_ID_VAL			0x15
@@ -84,6 +85,7 @@ static const struct reg_field stk3310_reg_field_flag_nf =
 				REG_FIELD(STK3310_REG_FLAG, 0, 0);
 
 static const u8 stk3310_chip_ids[] = {
+	STK3013_CHIP_ID_VAL,
 	STK3310_CHIP_ID_VAL,
 	STK3311A_CHIP_ID_VAL,
 	STK3311S34_CHIP_ID_VAL,
@@ -700,6 +702,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
 				stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
+	{ "STK3013" },
 	{ "STK3310" },
 	{ "STK3311" },
 	{ "STK3335" },
@@ -708,6 +711,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 
 static const struct acpi_device_id stk3310_acpi_id[] = {
+	{"STK3013", 0},
 	{"STK3310", 0},
 	{"STK3311", 0},
 	{}
@@ -716,6 +720,7 @@ static const struct acpi_device_id stk3310_acpi_id[] = {
 MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
 
 static const struct of_device_id stk3310_of_match[] = {
+	{ .compatible = "sensortek,stk3013", },
 	{ .compatible = "sensortek,stk3310", },
 	{ .compatible = "sensortek,stk3311", },
 	{ .compatible = "sensortek,stk3335", },

-- 
2.45.2



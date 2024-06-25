Return-Path: <linux-iio+bounces-6916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA532916EB2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B4E28B90A
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30756172786;
	Tue, 25 Jun 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lKZFGi00"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E41494D9;
	Tue, 25 Jun 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334825; cv=none; b=k7FLxLp4Y/RGoK9hRxJiIQHauoaZwm00xbjSBJWwW6lgwK39S0Fp8dTC+oJLlfsFAw4OmQvzoPbG3it6IJsfttGI4OKFon9m55+lyfJlVXyyw7ifM44GrXvmCtcSt3uLE41oDPVoYBAAA1Qyw3Ixd6H7U9r635dQfuLzdr3pq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334825; c=relaxed/simple;
	bh=7zGkmCGwedhVhDlUUqPb+kRA9524NAzODRiWSHPQgVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKqUEyEnj//j/qfi0U+RTj1fjcjDo+KXA/yazqR5HfEgtmdz7wZEvtRXR+ZJEInUDcySL7ff8fLc2/z1OXh3D9qLHfX2HPjZGPIc20ooayuBeKqhqMXLBQ7SRF+paZh60C1fKmM6yJh5t6NRPbw3PL8xiPVat9W7r8V9UTeWgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lKZFGi00; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719334357; bh=7zGkmCGwedhVhDlUUqPb+kRA9524NAzODRiWSHPQgVc=;
	h=From:To:Cc:Subject:Date;
	b=lKZFGi00vOR3gge+h8j+BPt5adPxE55XO0ejK31HCF8KVMgYyHPN3gq6cqXGgS9s1
	 kK+yMrqDXc+S73KKLziI6P/nmIY/GtFsNPIABdpPTwdQeRogl0+nzuq2DRJuWe8Ckb
	 sR03DlR/ylMIf+0vB7iGNTTYj00zPAP4ZZnvNcVlVs3fb5McfBHxZ08ayJDZ7mFDhR
	 YVHeOK9ttegmAVKnGAIDMQAzS93YfyK9FdTX8w2P9QLdt5PKk3Ix9UyM5v96YN8/v6
	 o5pOCgS2vzAhtl3/AVsjc9oR1axLaNFtOvDBiXBcFpZgSgz/+YBX1I1VwgYWEB7Om3
	 WwSKfSOnbRW7w==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 1/2] iio: light: stk3310: add support for stk3013
Date: Tue, 25 Jun 2024 22:21:05 +0530
Message-ID: <20240625165122.231182-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index e3470d6743ef..003e7c1473d7 100644
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



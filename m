Return-Path: <linux-iio+bounces-7550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A940292FD7D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2A1B21D8B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D41741D3;
	Fri, 12 Jul 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="X2cjFFn8"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224238DC7;
	Fri, 12 Jul 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797919; cv=none; b=iPFZ0wvfP43+V4Pb5ixKoQLYycbhhfKRK0/o95TkVkz8LSLOHLvtGZGc3YZBDNnHi3smAnjDXpBxRA/kO0qWHH4PCc1f6sZaR7cDC04E4laAjeqFz3yDsdgk/FYfU8mgrYl7qZYLlm/ojM9E3V3IvuqrUzC1VPU546Zw03lS+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797919; c=relaxed/simple;
	bh=HuKnqTxFRMZlKP0bBlf9blLr9jAV7BBvT/4TiHr3PDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoSnuj5M1EY0RX5gfgDEF+U2yLktBuz9xJ2O8k7HAEvZ8wVjusXcH8bypXsdc4kqYY2LhAff6Oj/CW2RzwIZAoY1/FjLVNQvHo81v+/Ro24gvE/5OaO6um0S+ilJIsfxQdHlBlJJVoaet6bO4L22ZGsbolof+E1Y6nan80C10iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=X2cjFFn8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5DC01410A8;
	Fri, 12 Jul 2024 17:25:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xy20ZnCFpo_O; Fri, 12 Jul 2024 17:25:09 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720797909; bh=HuKnqTxFRMZlKP0bBlf9blLr9jAV7BBvT/4TiHr3PDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2cjFFn8AjzWzfRRLuO3xSGZ3FKjfchHQp++AdUtXPxNLQrqrdZ/AO65RALuHzTdZ
	 qIpvCsy4L58IhbBX3HxyW4v9fiAkt+wG102DXtXbbB9xwDqZG8pyvFP7OY9iD71Pb+
	 0nQuHOGZDy4lrq51o4lZuYEwGOqp6eGTPsJWoMzvVcUgiRl/cKZ6uSD4iEn4rMhahg
	 Z95POhWI5wDGYEA65OfcBLdI7fLBewra5tdWCmfB4ohROZHsvmvQu11y1ununPOOft
	 C6V34/dFdjkQ9VN9f9udftFGlVYUVCBN8YvCrCRtYzOZeDYnl0LWAbrRQAzBYEeiaM
	 WjD9Nmqwl5C8w==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 2/3] iio: light: stk3310: add support for stk3013
Date: Fri, 12 Jul 2024 20:54:01 +0530
Message-ID: <20240712152417.97726-2-kauschluss@disroot.org>
In-Reply-To: <20240712152417.97726-1-kauschluss@disroot.org>
References: <20240712152417.97726-1-kauschluss@disroot.org>
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



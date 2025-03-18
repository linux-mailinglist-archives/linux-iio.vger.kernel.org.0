Return-Path: <linux-iio+bounces-16999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D4A6643E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 01:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F0018946C1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 00:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD078F59;
	Tue, 18 Mar 2025 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="BokOC1dJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from ci74p00im-qukt09082101.me.com (ci74p00im-qukt09082101.me.com [17.57.156.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A621348
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259109; cv=none; b=sVvQqOhNrvddSgeMMgbADyxgDHGEbfxElnOIL4dp9Rkpt0ns3eEK2SqpErcv4kQ/avUB7MoDAB/vc7DapQFDSMfsAsiNOD78Yj9SdTURjjE+tKIx1wfLq61zx4WllIHP5cIEM++D/BYp9H8duOMqiiVVkwiabyPuHyGIQjV39Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259109; c=relaxed/simple;
	bh=YF4nZrg9CbtoJ7k+jwHCsWpTpZ91uX3M+RwxLSG1GT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2GmZY4sNUY7fvWa++0KwZ1ghlKMO6/ANZuCL9GyGAcq1miAWwaS5Pib+xwYtXR4pTREWTdjVr8PQ23ztzSuXna/L7B7+Uo780WVg4XfU4Bp9HKJtA8UFNwszT8ULZEOkuPye2I2O/HrhrmmgbpVQKH1s2XF9fEws0o3HL+Qnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=BokOC1dJ; arc=none smtp.client-ip=17.57.156.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=ytIUtbebF1x4c9jt8NmxsoGzUBeZZ8D2Vbj4ZHkH7m0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=BokOC1dJ8+a78mIk7mGhLvdLvvAAG6yKIRLo7Vs2MwF6B61rAI4nO0rft13joRE+m
	 AnrpearLbx+VBkUzF8QobVYZtwQrJKol40cSXw/qoLqZD++L61rAD78eWYNXvywT6+
	 q+2R4f4ODGztfy/hOxWoeSDDTpOK/3Al+iQXunsq0duaEOJgZEM3VH6DSADrbJXs63
	 RkgWp0a2w6jrE+iHfjV9IXzPRjmeJIsOqNWykyWaJ4busW/cjwoukpYhl0Tlej+Viw
	 F+075qMBrDkUtnXmdp2qbEfOunk8GhMjDCLDd3QO3s7vUT0pBDVffmCz312oM+8/eU
	 JrpAoJhJ0QZAg==
Received: from localhost.localdomain (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082101.me.com (Postfix) with ESMTPSA id 2524256001FC;
	Tue, 18 Mar 2025 00:51:43 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	tduszyns@gmail.com,
	jic23@kernel.org,
	Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3] iio: light: bh1750: Add hardware reset support via GPIO
Date: Tue, 18 Mar 2025 01:50:45 +0100
Message-ID: <20250318005045.3189-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VAbrR5szIIzILIG5JgSPIGKzsSF_Mckg
X-Proofpoint-ORIG-GUID: VAbrR5szIIzILIG5JgSPIGKzsSF_Mckg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1030 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503180004

Some BH1750 sensors require a hardware reset before they can be
detected on the I2C bus. This patch adds support for an optional
reset GPIO that can be specified in the device tree.

The reset sequence pulls the GPIO low and then high before
initializing the sensor, which enables proper detection with
tools like i2cdetect.

Update the devicetree binding documentation to include the new
reset-gpios property with examples.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
 .../devicetree/bindings/iio/light/bh1750.yaml |  5 +++++
 drivers/iio/light/bh1750.c                    | 22 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..f7a8dcd7d2a1 100644
--- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -24,6 +24,10 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO connected to the sensor's reset line (active low)
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -39,6 +43,7 @@ examples:
       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
+        reset-gpios = <&gpio2 17 0>;
       };
     };
 
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 4b869fa9e5b1..b88ce92acbc6 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -22,12 +22,16 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 
 #define BH1750_POWER_DOWN		0x00
 #define BH1750_ONE_TIME_H_RES_MODE	0x20 /* auto-mode for BH1721 */
 #define BH1750_CHANGE_INT_TIME_H_BIT	0x40
 #define BH1750_CHANGE_INT_TIME_L_BIT	0x60
 
+/* Define the reset delay time in microseconds */
+#define BH1750_RESET_DELAY_US 10000 /* 10ms */
+
 enum {
 	BH1710,
 	BH1721,
@@ -40,6 +44,7 @@ struct bh1750_data {
 	struct mutex lock;
 	const struct bh1750_chip_info *chip_info;
 	u16 mtreg;
+	struct gpio_desc *reset_gpio;
 };
 
 struct bh1750_chip_info {
@@ -248,6 +253,23 @@ static int bh1750_probe(struct i2c_client *client)
 	data->client = client;
 	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
 
+	/* Get reset GPIO from device tree */
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+							"Failed to get reset GPIO\n");
+
+	/* Perform hardware reset if GPIO is provided */
+	if (data->reset_gpio) {
+		/* Perform reset sequence: low-high */
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+		fsleep(BH1750_RESET_DELAY_US);
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+		fsleep(BH1750_RESET_DELAY_US);
+
+		dev_dbg(&client->dev, "BH1750 reset completed via GPIO\n");
+	}
+
 	usec = data->chip_info->mtreg_to_usec * data->chip_info->mtreg_default;
 	ret = bh1750_change_int_time(data, usec);
 	if (ret < 0)
-- 
2.43.0



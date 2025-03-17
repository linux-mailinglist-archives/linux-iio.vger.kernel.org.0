Return-Path: <linux-iio+bounces-16990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27765A65BAB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6C177FA0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E51B3940;
	Mon, 17 Mar 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="lCa5PPWN"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-60-percent-5.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster2-host9-snip4-8.eps.apple.com [57.103.88.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117861B21A7
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234266; cv=none; b=mGy8JRm8he3luMA+xvZGSmt+W6SM7ci+qsHUFthDX7FH3FSxFdHjlj/sly0jcE2a/fKvd7Rx1UiP9QHcmiapPRFTn6QmoaaPMt+ezbb5LbxmkqQ9w2RgeImhkhwwI8307pERM8VRWMULa5bYuYI4SDJBF7OaJ+aHhacEEzz4uno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234266; c=relaxed/simple;
	bh=jUnv1e8c/oOHeoXEzJKomzP88F/Hmt1ihQ6n54MBayA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYuC4bmlrP6BvmPwg8fslS99NcVxsDaV8v5RPIGDf4Rk7FSqOGOfyXjznI2AdLNQdaDSJW8fVysC13KlXg6p56PrkZOZbkJJ1TJ3swaROPYEY9h3T7rHokdKnDQZK53YX8iaT7axPZfCyLnt2UyKtDNkr0RM/9xf3GTVWmhx/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=lCa5PPWN; arc=none smtp.client-ip=57.103.88.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=3lEw29JtEWPd9gCfFHLxFln8ckxLwNaX3mp20WGfxb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=lCa5PPWN2i4XL+p9I9CeA7nwA4qCYjnk0Eyxba64zERnLSJmp7mled1RTeAL81zM2
	 r2M4U6N/7VcEUvsqbAKre1JXOY1EBZEWg88vxMfzcn1bOw5e1FZEBWVDJam+QVq422
	 quM1bSxu7qCBkZ86vCdNZk0FApk7rBFqzoOX1PKPc6GQo3MFUZJoctOA7tR17HyAFV
	 kG62rEfA5blHVYo1SsSejgUtb3a4XvyBD7jApSZrsuJmKSOV/gs2b4Z1AtrfxmsD4s
	 q1TpwfA1HZxIAbBmtHdrabn5lL6cxfezEHV031pRxpXIlATrFzbphF0ROEKolhXfJ1
	 aRSYJaQ1SX/zA==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-5.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 9D36718000BC;
	Mon, 17 Mar 2025 17:57:41 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	tduszyns@gmail.com,
	jic23@kernel.org,
	Sergio Perez <sergio@pereznus.es>
Subject: [PATCH] [v2] iio: light: bh1750: Add hardware reset support via GPIO
Date: Mon, 17 Mar 2025 18:56:21 +0100
Message-ID: <20250317175621.593-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UHQ7w6T5tZ2JSVB2Y2nxBK9QJDiZP3JI
X-Proofpoint-ORIG-GUID: UHQ7w6T5tZ2JSVB2Y2nxBK9QJDiZP3JI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1030 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503170129

Some BH1750 sensors require a hardware reset before they can be
detected on the I2C bus. This patch adds support for an optional
reset GPIO that can be specified in the device tree.

The reset sequence pulls the GPIO low and then high before
initializing the sensor, which enables proper detection with
tools like i2cdetect.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
 .../devicetree/bindings/iio/light/bh1750.yaml |  7 +++++-
 drivers/iio/light/bh1750.c                    | 24 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..12c97d761aa4 100644
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
@@ -39,7 +43,8 @@ examples:
       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
+        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
       };
     };
 
-...
+...
\ No newline at end of file
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 4b869fa9e5b1..55e2be0323ef 100644
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
@@ -329,4 +351,4 @@ module_i2c_driver(bh1750_driver);
 
 MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("ROHM BH1710/BH1715/BH1721/BH1750/BH1751 als driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL v2");
\ No newline at end of file
-- 
2.47.1



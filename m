Return-Path: <linux-iio+bounces-16912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78BA63623
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5841E3ACA75
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E2192B81;
	Sun, 16 Mar 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="kue/gZy3"
X-Original-To: linux-iio@vger.kernel.org
Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C3134CF
	for <linux-iio@vger.kernel.org>; Sun, 16 Mar 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742136971; cv=none; b=UsHtA/7bXqpDHmIQVHZvCou2DvHeMr5BV0ssFyMMPE5M0aKFh4rojGbCUdm9cqShLA19NTq0XgRDrnClbmh92XjvuqsAF/6rbv2Lx8lXxHe4lDx3vw6F8PV2NolJTpMlHnzsU8i1luP0/14YHlmo9J0yguRkKmny5JcxyGwR9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742136971; c=relaxed/simple;
	bh=6brN5bVX/Mpl9mzNWJCC2gAUNXownz0Ffp7KvblpzHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABrSnZNXappUfjgNpFUIldOX8g56RAnsUUqWyLrJ/w8oUjRZ/o1YIXcol95TSoNtS9x8uRwcQhWxv01PsTmgtr/go8/Vb5pe1ftdMwCIdK+WPWzoaImrjisExSeIL2dvOov4nYV9sIamk+QEpxu911WmqsdRZMHx36YcXRCn8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=kue/gZy3; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=5gcyTzwkFwVZ0muQxXQO3bYLbBmvVEbEz8kn2Pzb9fM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=kue/gZy3gWIox8Yk5AmIADNimIwTXfjAW1JgPdn7gsxKnphS8Xovv17yw0/Ovei2q
	 5XjfzXCutyraJTQy+IeNQGkNi1odcdQz7oWdPZJUSfhxWUzdawhIaXlN6vL+2HmFZO
	 +1bHxNIu660wC7u24wCUdiLWywH/9VyI+tbGVV2ZED3KqOELHQG7TpXNEpnksEiPHF
	 OJAkQXXOegXHoncXHEGw73RSeQgpV+3WMEm3KuxErgxkrufxuKg6Ttb3UrRMvbwpCR
	 48+MR7xN/0o/u75XrCJJWHOLGIOpKbKS8N8/b7V9pHutEzRwmMKEBIUdlomJMwp1D7
	 yCAfCcogd8U0w==
Received: from localhost.localdomain (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id A65783C001F7;
	Sun, 16 Mar 2025 14:56:05 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Sergio Perez <sergio@pereznus.es>
Subject: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
Date: Sun, 16 Mar 2025 15:55:13 +0100
Message-ID: <20250316145514.627-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WEzs6WAV3If6F7jZIhtTdSO3yjFo905x
X-Proofpoint-ORIG-GUID: WEzs6WAV3If6F7jZIhtTdSO3yjFo905x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1030
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503160108

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
 .../devicetree/bindings/iio/light/bh1750.yaml |  20 +++-
 drivers/iio/light/bh1750.c                    | 113 ++++++++++++------
 2 files changed, 95 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..d53b221eb84b 100644
--- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -11,6 +11,9 @@ maintainers:
 
 description: |
   Ambient light sensor with an i2c interface.
+  
+  Some BH1750 sensors require a hardware reset before being properly detected
+  on the I2C bus. This can be done using the optional reset-gpios property.
 
 properties:
   compatible:
@@ -23,6 +26,10 @@ properties:
 
   reg:
     maxItems: 1
+    
+  reset-gpios:
+    description: GPIO connected to the sensor's reset line (active low)
+    maxItems: 1
 
 required:
   - compatible
@@ -41,5 +48,16 @@ examples:
         reg = <0x23>;
       };
     };
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@23 {
+        compatible = "rohm,bh1750";
+        reg = <0x23>;
+        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+      };
+    };
 
-...
+...
\ No newline at end of file
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 4b869fa9e5b1..53d64b70c03f 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -22,11 +22,16 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
 
-#define BH1750_POWER_DOWN		0x00
-#define BH1750_ONE_TIME_H_RES_MODE	0x20 /* auto-mode for BH1721 */
-#define BH1750_CHANGE_INT_TIME_H_BIT	0x40
-#define BH1750_CHANGE_INT_TIME_L_BIT	0x60
+#define BH1750_POWER_DOWN 0x00
+#define BH1750_ONE_TIME_H_RES_MODE 0x20 /* auto-mode for BH1721 */
+#define BH1750_CHANGE_INT_TIME_H_BIT 0x40
+#define BH1750_CHANGE_INT_TIME_L_BIT 0x60
+
+/* Define the reset delay time in microseconds */
+#define BH1750_RESET_DELAY_US 10000  /* 10ms */
 
 enum {
 	BH1710,
@@ -40,6 +45,7 @@ struct bh1750_data {
 	struct mutex lock;
 	const struct bh1750_chip_info *chip_info;
 	u16 mtreg;
+	struct gpio_desc *reset_gpio;
 };
 
 struct bh1750_chip_info {
@@ -62,11 +68,26 @@ struct bh1750_chip_info {
 };
 
 static const struct bh1750_chip_info bh1750_chip_info_tbl[] = {
-	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
-	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
-	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
+	[BH1710] = {140, 1022, 300, 400, 250000000, 2, 0x001F, 0x03E0},
+	[BH1721] = {140, 1020, 300, 400, 250000000, 2, 0x0010, 0x03E0},
+	[BH1750] = {31, 254, 69, 1740, 57500000, 1, 0x001F, 0x00E0},
 };
 
+static int bh1750_reset(struct bh1750_data *data)
+{
+	if (!data->reset_gpio)
+		return 0;  /* No GPIO configured for reset, continue */
+
+	/* Perform reset sequence: low-high */
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+	usleep_range(BH1750_RESET_DELAY_US, BH1750_RESET_DELAY_US + 1000);
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+	usleep_range(BH1750_RESET_DELAY_US, BH1750_RESET_DELAY_US + 1000);
+
+	dev_info(&data->client->dev, "BH1750 reset completed via GPIO\n");
+	return 0;
+}
+
 static int bh1750_change_int_time(struct bh1750_data *data, int usec)
 {
 	int ret;
@@ -87,13 +108,13 @@ static int bh1750_change_int_time(struct bh1750_data *data, int usec)
 
 	regval = (val & chip_info->int_time_high_mask) >> 5;
 	ret = i2c_smbus_write_byte(data->client,
-				   BH1750_CHANGE_INT_TIME_H_BIT | regval);
+							   BH1750_CHANGE_INT_TIME_H_BIT | regval);
 	if (ret < 0)
 		return ret;
 
 	regval = val & chip_info->int_time_low_mask;
 	ret = i2c_smbus_write_byte(data->client,
-				   BH1750_CHANGE_INT_TIME_L_BIT | regval);
+							   BH1750_CHANGE_INT_TIME_L_BIT | regval);
 	if (ret < 0)
 		return ret;
 
@@ -129,8 +150,8 @@ static int bh1750_read(struct bh1750_data *data, int *val)
 }
 
 static int bh1750_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+						   struct iio_chan_spec const *chan,
+						   int *val, int *val2, long mask)
 {
 	int ret, tmp;
 	struct bh1750_data *data = iio_priv(indio_dev);
@@ -165,8 +186,8 @@ static int bh1750_read_raw(struct iio_dev *indio_dev,
 }
 
 static int bh1750_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+							struct iio_chan_spec const *chan,
+							int val, int val2, long mask)
 {
 	int ret;
 	struct bh1750_data *data = iio_priv(indio_dev);
@@ -186,7 +207,7 @@ static int bh1750_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t bh1750_show_int_time_available(struct device *dev,
-		struct device_attribute *attr, char *buf)
+											  struct device_attribute *attr, char *buf)
 {
 	int i;
 	size_t len = 0;
@@ -195,7 +216,7 @@ static ssize_t bh1750_show_int_time_available(struct device *dev,
 
 	for (i = chip_info->mtreg_min; i <= chip_info->mtreg_max; i += chip_info->inc)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06d ",
-				 chip_info->mtreg_to_usec * i);
+						 chip_info->mtreg_to_usec * i);
 
 	buf[len - 1] = '\n';
 
@@ -220,13 +241,10 @@ static const struct iio_info bh1750_info = {
 };
 
 static const struct iio_chan_spec bh1750_channels[] = {
-	{
-		.type = IIO_LIGHT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE) |
-				      BIT(IIO_CHAN_INFO_INT_TIME)
-	}
-};
+	{.type = IIO_LIGHT,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+						   BIT(IIO_CHAN_INFO_SCALE) |
+						   BIT(IIO_CHAN_INFO_INT_TIME)}};
 
 static int bh1750_probe(struct i2c_client *client)
 {
@@ -236,7 +254,7 @@ static int bh1750_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
-				I2C_FUNC_SMBUS_WRITE_BYTE))
+													  I2C_FUNC_SMBUS_WRITE_BYTE))
 		return -EOPNOTSUPP;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -248,6 +266,19 @@ static int bh1750_probe(struct i2c_client *client)
 	data->client = client;
 	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio)) {
+		ret = PTR_ERR(data->reset_gpio);
+		dev_err(&client->dev, "Failed to get reset GPIO: %d\n", ret);
+		return ret;
+	}
+
+	if (data->reset_gpio) {
+		ret = bh1750_reset(data);
+		if (ret < 0)
+			return ret;
+	}
+
 	usec = data->chip_info->mtreg_to_usec * data->chip_info->mtreg_default;
 	ret = bh1750_change_int_time(data, usec);
 	if (ret < 0)
@@ -295,23 +326,31 @@ static int bh1750_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
 
 static const struct i2c_device_id bh1750_id[] = {
-	{ "bh1710", BH1710 },
-	{ "bh1715", BH1750 },
-	{ "bh1721", BH1721 },
-	{ "bh1750", BH1750 },
-	{ "bh1751", BH1750 },
-	{ }
-};
+	{"bh1710", BH1710},
+	{"bh1715", BH1750},
+	{"bh1721", BH1721},
+	{"bh1750", BH1750},
+	{"bh1751", BH1750},
+	{}};
 MODULE_DEVICE_TABLE(i2c, bh1750_id);
 
 static const struct of_device_id bh1750_of_match[] = {
-	{ .compatible = "rohm,bh1710", },
-	{ .compatible = "rohm,bh1715", },
-	{ .compatible = "rohm,bh1721", },
-	{ .compatible = "rohm,bh1750", },
-	{ .compatible = "rohm,bh1751", },
-	{ }
-};
+	{
+		.compatible = "rohm,bh1710",
+	},
+	{
+		.compatible = "rohm,bh1715",
+	},
+	{
+		.compatible = "rohm,bh1721",
+	},
+	{
+		.compatible = "rohm,bh1750",
+	},
+	{
+		.compatible = "rohm,bh1751",
+	},
+	{}};
 MODULE_DEVICE_TABLE(of, bh1750_of_match);
 
 static struct i2c_driver bh1750_driver = {
-- 
2.47.1.windows.1



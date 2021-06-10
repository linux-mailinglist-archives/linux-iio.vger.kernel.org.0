Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557E53A28DD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFJKBY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:01:24 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:32022 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJKBX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318987; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I7G05qoF5TMj7qf8zcKJM09yC2BGb1c3UFjWoEx6vcN9qEi6aoP8qk95AHjpVJyVK9
    yNd8cv4+wuY5BOQgUqx1lOZw51AVvzmx17GargE5ANYyewaW7Jzq94Jrmyb+KfNhzb77
    z8hbyVdsJriUA342LYE25Awg0h3fQTQTpLkjjtsdqT8YIwKB61KJAgoR8ENO2X10I+9d
    mB7hNLlxEf2IIYbYfphBZElm3LjL1ujHlxcar+LKbBTwHRTENO4vqf+tjOYG9BqM7jne
    SMzuruiVhfCxLaXwGU6u9R2vmWonigc0uinVbgQFrP6ZogT7NbdWbRadXmuWDcFLwE/r
    juSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318987;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=s/8S0a6AHAFtunnNacWQ6tVD7pAvYC0ejOcx8N11Img=;
    b=GNwJyMyGoAH//G39Agxbcyk4OXSWMshJI0SfEO8HmwVF0g4+JYNF6wyJxnlWVAz1zA
    vyDRYsVKrP73hI1J4Qci0M1m6hUskeiH2AFWozkk+wrCQsuJwUAusLPy+YKnsf6vOdMR
    HMNorf3OKtvzqC8ptmVLgmxIoAwMCVyfUh+KwyC2h2BhOIieJRjxLsu+HbpDHXgnnhbZ
    b+wYOr1T0XYtWFIT3p5SrdNx/RJzMYlOtv9foPGI5OExLYDmsrCcqQNWjslEIYHu2dBC
    FwkUQOnaoth2xFqWMqvb6dO1W4ZbCzBs1BRUpMiGPF+CO52Jtka95qTIw1mYlzahhmXg
    gZKw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318987;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=s/8S0a6AHAFtunnNacWQ6tVD7pAvYC0ejOcx8N11Img=;
    b=beYR1zvuSdrxhbnYOSMJi68EX8q6XZAP64fNUU4/ugc0d2W2vkBNaBTIiG+R68dO41
    WSZyZlrHgeLtf/1uv0RYE1EZfFwM5IcLjASRfagMYiM8dLPwVk9IgDPYfRhETN87RjNn
    Mu8b4x7lrZOeyLUHSBrOryCBMcbe506KhpiUCilUR4sCJ3w1I8ZXETkrv1d46Y+Ondpg
    wxbqZ9fNoBZstTbg7L6vxAq2ynnlrwVd0YCk3pv0a00r3ToN3iQr7FVY7vzRcncpwp6z
    ObfUSChK5EjqtKL1bZDqrBDwHmVFYaS1DgPY0Fi3NLA63f6f1U3lSXd/mU76EUogwejl
    dsZg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uRso4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:27 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 6/6] iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver
Date:   Thu, 10 Jun 2021 11:53:00 +0200
Message-Id: <20210610095300.3613-7-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit c1d1c4a62db5 ("iio: accel: bma180: BMA254 support") added
BMA254 support to the bma180 driver and changed some naming to BMA25x
to make it easier to add support for BMA253 and BMA255.

Unfortunately, there is quite some overlap between the bma180 driver
and the bmc150-accel driver. Back when the commit was made, the
bmc150-accel driver actually already had support for BMA255, and
adding support for BMA254 would have been as simple as adding a new
compatible to bmc150-accel.

The bmc150-accel driver is a bit better for BMA254 since it also
supports the motion trigger/interrupt functionality. Fortunately,
moving BMA254 support over to bmc150-accel is fairly simple because
the drivers have compatible device tree bindings.

Revert most of the changes for BMA254 support in bma180 and move
BMA254 over to bmc150-accel. This has the following advantages:

  - Support for motion trigger/interrupt
  - Fix incorrect scale values (BMA254 currently uses the same as
    BMA250 but actually they're different because of 10 vs 12 bits
    data size)
  - Less code than before :)

BMA250 could be potentially also moved but it's more complicated
because its chip_id conflicts with the one for BMA222 in bmc150-accel.
Perhaps there are also other register differences, I did not investigate
further yet (and I have no way to test it).

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Laurentiu Palcu <laurentiu.palcu@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Note that the similarity between bma180 and bmc150-accel has already
caused a lot of confusion in the past. See e.g. [1] where Hans
accidentally added BMA250E support to bma180 even though that was
already supported in bmc150-accel.

Having BMA250 in bma180 and BMA250E in bmc150-accel was also discussed
before in [2] but for some reason back then the conclusion was that
they are different enough to justify that.

Also note that this patch only applies cleanly on top of the
"iio: accel: bma180: Fix BMA25x bandwidth register values" patch [3]
that I sent earlier, which is not present in togreg/testing
at the moment (only in fixes-togreg).

[1]: https://lore.kernel.org/linux-iio/20170606203538.15250-1-hdegoede@redhat.com/
[2]: https://lore.kernel.org/linux-iio/alpine.DEB.2.01.1408281111250.3259@pmeerw.net/
[3]: https://lore.kernel.org/linux-iio/20210526094408.34298-2-stephan@gerhold.net/
---
 drivers/iio/accel/Kconfig             |  6 +-
 drivers/iio/accel/bma180.c            | 91 ++++-----------------------
 drivers/iio/accel/bmc150-accel-core.c |  4 +-
 drivers/iio/accel/bmc150-accel-i2c.c  |  2 +
 4 files changed, 19 insertions(+), 84 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index f68c14f02d6b..b00c228b9bdc 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -89,13 +89,13 @@ config ADXL372_I2C
 	  module will be called adxl372_i2c.
 
 config BMA180
-	tristate "Bosch BMA023/BMA1x0/BMA25x 3-Axis Accelerometer Driver"
+	tristate "Bosch BMA023/BMA1x0/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C && INPUT_BMA150=n
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build a driver for the Bosch BMA023, BMA150
-	  BMA180, SMB380, or BMA25x triaxial acceleration sensor.
+	  BMA180, SMB380, or BMA250 triaxial acceleration sensor.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma180.
@@ -143,7 +143,7 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMC150, BMI055, BMA250E, BMA222E, BMA253, BMA255, BMA280.
+	  BMC150, BMI055, BMA250E, BMA222E, BMA253, BMA254, BMA255, BMA280.
 
 	  This is a combo module with both accelerometer and magnetometer.
 	  This driver is only implementing accelerometer part, which has
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index e7c6b3096cb7..ea1a604a53bf 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -38,7 +38,6 @@ enum chip_ids {
 	BMA150,
 	BMA180,
 	BMA250,
-	BMA254,
 };
 
 struct bma180_data;
@@ -59,7 +58,6 @@ struct bma180_part_info {
 	u8 scale_reg, scale_mask;
 	u8 power_reg, power_mask, lowpower_val;
 	u8 int_enable_reg, int_enable_mask;
-	u8 int_map_reg, int_enable_dataready_int1_mask;
 	u8 softreset_reg, softreset_val;
 
 	int (*chip_config)(struct bma180_data *data);
@@ -112,7 +110,6 @@ struct bma180_part_info {
 #define BMA023_ID_REG_VAL	0x02
 #define BMA180_ID_REG_VAL	0x03
 #define BMA250_ID_REG_VAL	0x03
-#define BMA254_ID_REG_VAL	0xfa /* 250 decimal */
 
 /* Chip power modes */
 #define BMA180_LOW_POWER	0x03
@@ -134,24 +131,6 @@ struct bma180_part_info {
 #define BMA250_INT1_DATA_MASK	BIT(0)
 #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
 
-#define BMA254_RANGE_REG	0x0f
-#define BMA254_BW_REG		0x10
-#define BMA254_POWER_REG	0x11
-#define BMA254_RESET_REG	0x14
-#define BMA254_INT_ENABLE_REG	0x17
-#define BMA254_INT_MAP_REG	0x1a
-#define BMA254_INT_RESET_REG	0x21
-
-#define BMA254_RANGE_MASK	GENMASK(3, 0) /* Range of accel values */
-#define BMA254_BW_MASK		GENMASK(4, 0) /* Accel bandwidth */
-#define BMA254_BW_OFFSET	8
-#define BMA254_SUSPEND_MASK	BIT(7) /* chip will sleep */
-#define BMA254_LOWPOWER_MASK	BIT(6)
-#define BMA254_DATA_INTEN_MASK	BIT(4)
-#define BMA254_INT2_DATA_MASK	BIT(7)
-#define BMA254_INT1_DATA_MASK	BIT(0)
-#define BMA254_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
-
 struct bma180_data {
 	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
@@ -184,8 +163,8 @@ static int bma023_scale_table[] = { 2452, 4903, 9709, };
 static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
 static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
-static int bma25x_bw_table[] = { 8, 16, 31, 63, 125, 250, 500, 1000 }; /* Hz */
-static int bma25x_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
+static int bma250_bw_table[] = { 8, 16, 31, 63, 125, 250, 500, 1000 }; /* Hz */
+static int bma250_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
 	0, 0, 306458 };
 
 static int bma180_get_data_reg(struct bma180_data *data, enum bma180_chan chan)
@@ -432,7 +411,7 @@ static int bma180_chip_config(struct bma180_data *data)
 	return ret;
 }
 
-static int bma25x_chip_config(struct bma180_data *data)
+static int bma250_chip_config(struct bma180_data *data)
 {
 	int ret = bma180_chip_init(data);
 
@@ -451,8 +430,7 @@ static int bma25x_chip_config(struct bma180_data *data)
 	 * This enables dataready interrupt on the INT1 pin
 	 * FIXME: support using the INT2 pin
 	 */
-	ret = bma180_set_bits(data, data->part_info->int_map_reg,
-		data->part_info->int_enable_dataready_int1_mask, 1);
+	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT1_DATA_MASK, 1);
 	if (ret)
 		goto err;
 
@@ -489,7 +467,7 @@ static void bma180_chip_disable(struct bma180_data *data)
 	dev_err(&data->client->dev, "failed to disable the chip\n");
 }
 
-static void bma25x_chip_disable(struct bma180_data *data)
+static void bma250_chip_disable(struct bma180_data *data)
 {
 	if (bma180_set_new_data_intr_state(data, false))
 		goto err;
@@ -775,14 +753,6 @@ static const struct iio_chan_spec bma250_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-static const struct iio_chan_spec bma254_channels[] = {
-	BMA180_ACC_CHANNEL(X, 12),
-	BMA180_ACC_CHANNEL(Y, 12),
-	BMA180_ACC_CHANNEL(Z, 12),
-	BMA180_TEMP_CHANNEL,
-	IIO_CHAN_SOFT_TIMESTAMP(4),
-};
-
 static const struct bma180_part_info bma180_part_info[] = {
 	[BMA023] = {
 		.chip_id = BMA023_ID_REG_VAL,
@@ -872,10 +842,10 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.chip_id = BMA250_ID_REG_VAL,
 		.channels = bma250_channels,
 		.num_channels = ARRAY_SIZE(bma250_channels),
-		.scale_table = bma25x_scale_table,
-		.num_scales = ARRAY_SIZE(bma25x_scale_table),
-		.bw_table = bma25x_bw_table,
-		.num_bw = ARRAY_SIZE(bma25x_bw_table),
+		.scale_table = bma250_scale_table,
+		.num_scales = ARRAY_SIZE(bma250_scale_table),
+		.bw_table = bma250_bw_table,
+		.num_bw = ARRAY_SIZE(bma250_bw_table),
 		.temp_offset = 48, /* 0 LSB @ 24 degree C */
 		.int_reset_reg = BMA250_INT_RESET_REG,
 		.int_reset_mask = BMA250_INT_RESET_MASK,
@@ -891,42 +861,10 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.lowpower_val = 1,
 		.int_enable_reg = BMA250_INT_ENABLE_REG,
 		.int_enable_mask = BMA250_DATA_INTEN_MASK,
-		.int_map_reg = BMA250_INT_MAP_REG,
-		.int_enable_dataready_int1_mask = BMA250_INT1_DATA_MASK,
 		.softreset_reg = BMA250_RESET_REG,
 		.softreset_val = BMA180_RESET_VAL,
-		.chip_config = bma25x_chip_config,
-		.chip_disable = bma25x_chip_disable,
-	},
-	[BMA254] = {
-		.chip_id = BMA254_ID_REG_VAL,
-		.channels = bma254_channels,
-		.num_channels = ARRAY_SIZE(bma254_channels),
-		.scale_table = bma25x_scale_table,
-		.num_scales = ARRAY_SIZE(bma25x_scale_table),
-		.bw_table = bma25x_bw_table,
-		.num_bw = ARRAY_SIZE(bma25x_bw_table),
-		.temp_offset = 46, /* 0 LSB @ 23 degree C */
-		.int_reset_reg = BMA254_INT_RESET_REG,
-		.int_reset_mask = BMA254_INT_RESET_MASK,
-		.sleep_reg = BMA254_POWER_REG,
-		.sleep_mask = BMA254_SUSPEND_MASK,
-		.bw_reg = BMA254_BW_REG,
-		.bw_mask = BMA254_BW_MASK,
-		.bw_offset = BMA254_BW_OFFSET,
-		.scale_reg = BMA254_RANGE_REG,
-		.scale_mask = BMA254_RANGE_MASK,
-		.power_reg = BMA254_POWER_REG,
-		.power_mask = BMA254_LOWPOWER_MASK,
-		.lowpower_val = 1,
-		.int_enable_reg = BMA254_INT_ENABLE_REG,
-		.int_enable_mask = BMA254_DATA_INTEN_MASK,
-		.int_map_reg = BMA254_INT_MAP_REG,
-		.int_enable_dataready_int1_mask = BMA254_INT1_DATA_MASK,
-		.softreset_reg = BMA254_RESET_REG,
-		.softreset_val = BMA180_RESET_VAL,
-		.chip_config = bma25x_chip_config,
-		.chip_disable = bma25x_chip_disable,
+		.chip_config = bma250_chip_config,
+		.chip_disable = bma250_chip_disable,
 	},
 };
 
@@ -1166,7 +1104,6 @@ static const struct i2c_device_id bma180_ids[] = {
 	{ "bma150", BMA150 },
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
-	{ "bma254", BMA254 },
 	{ "smb380", BMA150 },
 	{ }
 };
@@ -1190,10 +1127,6 @@ static const struct of_device_id bma180_of_match[] = {
 		.compatible = "bosch,bma250",
 		.data = (void *)BMA250
 	},
-	{
-		.compatible = "bosch,bma254",
-		.data = (void *)BMA254
-	},
 	{
 		.compatible = "bosch,smb380",
 		.data = (void *)BMA150
@@ -1217,5 +1150,5 @@ module_i2c_driver(bma180_driver);
 
 MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("Bosch BMA023/BMA1x0/BMA25x triaxial acceleration sensor");
+MODULE_DESCRIPTION("Bosch BMA023/BMA1x0/BMA250 triaxial acceleration sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 21abc8d166e6..979da58fdb60 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -3,7 +3,7 @@
  * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
  *  - BMC150
  *  - BMI055
- *  - BMA253/BMA255
+ *  - BMA253/BMA254/BMA255
  *  - BMA250E
  *  - BMA222
  *  - BMA222E
@@ -1098,7 +1098,7 @@ static const struct iio_chan_spec bma280_accel_channels[] =
 
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 	{
-		.name = "BMC150/BMI055/BMA253/BMA255",
+		.name = "BMC150/BMI055/BMA253/BMA254/BMA255",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index a87306f03a4c..8f0dfe03c919 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -239,6 +239,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmi055_accel"},
 	{"bma253"},
+	{"bma254"},
 	{"bma255"},
 	{"bma250e"},
 	{"bma222"},
@@ -253,6 +254,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bmc150_accel" },
 	{ .compatible = "bosch,bmi055_accel" },
 	{ .compatible = "bosch,bma253" },
+	{ .compatible = "bosch,bma254" },
 	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma250e" },
 	{ .compatible = "bosch,bma222" },
-- 
2.31.1


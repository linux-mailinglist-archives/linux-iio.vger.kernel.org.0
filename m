Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664A33A3DD9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFKIOA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:14:00 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:35213 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFKIN7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399115; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kV56mDmVGwTp88bYTKstcEL5ZbaWEODEqO1gkio+fimlUQrum75MCBV0FHKF47zmze
    xakhfTzSlXW0D+zS8hevWE4LP4GmCgAAYnpH9hqSKvzWPpT0livufoptccvuK8krx+th
    oBrevWe+X53L8vvti1/beFg9txBf3gefo+ndjkn00qYXTcvq4LbCPJNyDBTuNUMQ+rii
    MtwhZyBhDOTK7yJ8srE9/kyZQdT8pYPV0oinkkx8bYdGnQaex7qnxohPQZsgEAxuVg14
    8R0QexfYQVjilfGRHimAcAMGM1VOBsFQ04bM+1l7V5uzvnGgqc7kxE4R5DT0PSah4mwY
    QevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399115;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5f1hdzQy5P85V8PZSDgkI5XYeVMKai3VYkUNJNnmklI=;
    b=mqkjjd0mtyUzcQ4ZMQs+lpMcmKiwwkaYADepdyTV+0HQIc9GcF6uUw0bA80SzhwRdV
    KKaJk3yn9c7jJp1lL/gJUAfXdvmh/6Q254lOfnZ2aucff8PHnAZG/y7a2nyuW13Nl16P
    o5cZm/NgsvVGXFJCYjFMFNRq4Q1jRdgzFx+htdKKaJNaVjY7GRlLsZZG+vwMP2YMVGNc
    HyiHWv24jldx0gMPcU6zkEtJoEPFTUqgrAYmpzsdOvni1qDqEeVODgh9crDekgdO4d/E
    PNI2zRTi3qJTvDZFcMuXCJTuWP3SzLdBgex5qYWjR8NZ/8cXuXIPN9HrO/Jv4vtJqV3L
    Sjsg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399115;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5f1hdzQy5P85V8PZSDgkI5XYeVMKai3VYkUNJNnmklI=;
    b=s9ZCAKmKE9QflLKrG34dC5hTqyJLDvAh46JS2L3lL+z8xeube7ii/PUAwfwlDhSWMn
    QdECOJW5gsnavf3J0Qvcnjrk1YMnv/0y2GZ9Z3xoJM4o8O9g+Zauv4eZwhaIHzdMVgwQ
    XGFpy+lmKfM90nzgg5JnXkzr0YBZ1mTRdOXaaF/mX8vvE1k3mQSNsHq2RJhSYXHYkhzg
    zK/212IlTUVUShnkvUXzE6n3fDolNuW/JsZXPMRcSmToYeq5+zShmN6tiZ1pTUCCEA8M
    oivo7yOQ/iJs2ThuFlQzLihYn1iL4YHCdkC5I1kSJx2gOYNtgGyUusTYUbPbexh4JKGK
    4LBA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bs02q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:54 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 10/10] iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver
Date:   Fri, 11 Jun 2021 10:09:03 +0200
Message-Id: <20210611080903.14384-11-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: Sort chip list in BMA180 Kconfig text
Changes in v2: Also drop BMA254 comment from file header in bma180.c

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
 drivers/iio/accel/bma180.c            | 92 ++++-----------------------
 drivers/iio/accel/bmc150-accel-core.c |  2 +-
 drivers/iio/accel/bmc150-accel-i2c.c  |  2 +
 4 files changed, 18 insertions(+), 84 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index f8dc5403397d..0e56ace61103 100644
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
+	  BMA180, BMA250 or SMB380 triaxial acceleration sensor.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma180.
@@ -143,7 +143,7 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMA222, BMA222E, BMA250E, BMA253, BMA255, BMA280, BMC150, BMI055.
+	  BMA222, BMA222E, BMA250E, BMA253, BMA254, BMA255, BMA280, BMC150, BMI055.
 
 	  Note that some of these are combo modules:
 	    - BMC150: accelerometer and magnetometer
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index e7c6b3096cb7..2edfcb4819b7 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -10,7 +10,6 @@
  * BMA023/BMA150/SMB380: 7-bit I2C slave address 0x38
  * BMA180: 7-bit I2C slave address 0x40 or 0x41
  * BMA250: 7-bit I2C slave address 0x18 or 0x19
- * BMA254: 7-bit I2C slave address 0x18 or 0x19
  */
 
 #include <linux/module.h>
@@ -38,7 +37,6 @@ enum chip_ids {
 	BMA150,
 	BMA180,
 	BMA250,
-	BMA254,
 };
 
 struct bma180_data;
@@ -59,7 +57,6 @@ struct bma180_part_info {
 	u8 scale_reg, scale_mask;
 	u8 power_reg, power_mask, lowpower_val;
 	u8 int_enable_reg, int_enable_mask;
-	u8 int_map_reg, int_enable_dataready_int1_mask;
 	u8 softreset_reg, softreset_val;
 
 	int (*chip_config)(struct bma180_data *data);
@@ -112,7 +109,6 @@ struct bma180_part_info {
 #define BMA023_ID_REG_VAL	0x02
 #define BMA180_ID_REG_VAL	0x03
 #define BMA250_ID_REG_VAL	0x03
-#define BMA254_ID_REG_VAL	0xfa /* 250 decimal */
 
 /* Chip power modes */
 #define BMA180_LOW_POWER	0x03
@@ -134,24 +130,6 @@ struct bma180_part_info {
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
@@ -184,8 +162,8 @@ static int bma023_scale_table[] = { 2452, 4903, 9709, };
 static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
 static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
-static int bma25x_bw_table[] = { 8, 16, 31, 63, 125, 250, 500, 1000 }; /* Hz */
-static int bma25x_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
+static int bma250_bw_table[] = { 8, 16, 31, 63, 125, 250, 500, 1000 }; /* Hz */
+static int bma250_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
 	0, 0, 306458 };
 
 static int bma180_get_data_reg(struct bma180_data *data, enum bma180_chan chan)
@@ -432,7 +410,7 @@ static int bma180_chip_config(struct bma180_data *data)
 	return ret;
 }
 
-static int bma25x_chip_config(struct bma180_data *data)
+static int bma250_chip_config(struct bma180_data *data)
 {
 	int ret = bma180_chip_init(data);
 
@@ -451,8 +429,7 @@ static int bma25x_chip_config(struct bma180_data *data)
 	 * This enables dataready interrupt on the INT1 pin
 	 * FIXME: support using the INT2 pin
 	 */
-	ret = bma180_set_bits(data, data->part_info->int_map_reg,
-		data->part_info->int_enable_dataready_int1_mask, 1);
+	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT1_DATA_MASK, 1);
 	if (ret)
 		goto err;
 
@@ -489,7 +466,7 @@ static void bma180_chip_disable(struct bma180_data *data)
 	dev_err(&data->client->dev, "failed to disable the chip\n");
 }
 
-static void bma25x_chip_disable(struct bma180_data *data)
+static void bma250_chip_disable(struct bma180_data *data)
 {
 	if (bma180_set_new_data_intr_state(data, false))
 		goto err;
@@ -775,14 +752,6 @@ static const struct iio_chan_spec bma250_channels[] = {
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
@@ -872,10 +841,10 @@ static const struct bma180_part_info bma180_part_info[] = {
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
@@ -891,42 +860,10 @@ static const struct bma180_part_info bma180_part_info[] = {
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
 
@@ -1166,7 +1103,6 @@ static const struct i2c_device_id bma180_ids[] = {
 	{ "bma150", BMA150 },
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
-	{ "bma254", BMA254 },
 	{ "smb380", BMA150 },
 	{ }
 };
@@ -1190,10 +1126,6 @@ static const struct of_device_id bma180_of_match[] = {
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
@@ -1217,5 +1149,5 @@ module_i2c_driver(bma180_driver);
 
 MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("Bosch BMA023/BMA1x0/BMA25x triaxial acceleration sensor");
+MODULE_DESCRIPTION("Bosch BMA023/BMA1x0/BMA250 triaxial acceleration sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3faa3de0dd4d..43aecd4bf3a4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1125,7 +1125,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
-		.name = "BMA253/BMA255/BMC150/BMI055",
+		.name = "BMA253/BMA254/BMA255/BMC150/BMI055",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 32ed07354a9a..999495f0669d 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -232,6 +232,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bma222e"},
 	{"bma250e"},
 	{"bma253"},
+	{"bma254"},
 	{"bma255"},
 	{"bma280"},
 	{"bmc150_accel"},
@@ -246,6 +247,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bma222e" },
 	{ .compatible = "bosch,bma250e" },
 	{ .compatible = "bosch,bma253" },
+	{ .compatible = "bosch,bma254" },
 	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma280" },
 	{ .compatible = "bosch,bmc150_accel" },
-- 
2.32.0


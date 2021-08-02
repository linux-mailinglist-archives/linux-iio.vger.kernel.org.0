Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05073DDCF6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhHBP5f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 11:57:35 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:9631 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhHBP5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 11:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627919827;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vjjM9KDhXDv2+5Ew09t9LRbQGsYbUdyEmKNBZzOLl0c=;
    b=M0zRSa/YDlFCV993+kpcUdu0iaSFUiCaf2m02E0zJVHEVngo2iVFDYy7kpxiuPPRQZ
    maGTgmpCeqjqleWvBeD2kVwWVByPk+ZR4DXJLhBuKQCQ6imTnj7JmwGH4L4Z0cAqr7lG
    3iGg3nUBvZP3APKrCper4revlvRb7LfwqhH4NnX5boQwSzYw72bnb9H4OFKW0IqOGPnA
    IR7DeAwVYtPscypEQHMUgWKM45koTHXTyQswASx5mrL8dukolQ9IrLr3Y70TrArQt9xb
    U2kasfJkmxMxLEuZMQ8pRPjpqFuT65OfZ02tEdLBn8vp0+eSeUsQAVyuibm2MxnZ/Cvz
    /ljg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIhr0eF6M4Q=="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.30.0 DYNA|AUTH)
    with ESMTPSA id e095f1x72Fv72RG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 Aug 2021 17:57:07 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 4/4] iio: accel: bmc150: Add support for BMC156
Date:   Mon,  2 Aug 2021 17:56:57 +0200
Message-Id: <20210802155657.102766-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802155657.102766-1-stephan@gerhold.net>
References: <20210802155657.102766-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMC156 is another accelerometer that works just fine with the bmc150-accel
driver. It's very similar to BMC150 (also a accelerometer + magnetometer
combo) but with only one accelerometer interrupt pin. It would make sense
if only INT1 was exposed but someone at Bosch decided to only have an
INT2 pin.

Try to deal with this by making use of the INT2 support introduced
in the previous commit and force using INT2 for BMC156. To detect
that we need to bring up a simplified version of the previous type IDs.

Note that unlike the type IDs removed in commit c06a6aba6835
("iio: accel: bmc150: Drop misleading/duplicate chip identifiers")
here I only add one for the special case of BMC156. Everything else
still happens by reading the CHIP_ID register since the chip type
information often is not accurate in ACPI tables.

Tested-by: Nikita Travkin <nikita@trvn.ru> # BMC156
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Wrap line in bmc150_accel_interrupts_setup() for better readability
  - Clarify reason for BOSCH_UNKNOWN with a comment
---
 drivers/iio/accel/Kconfig             |  5 +++--
 drivers/iio/accel/bmc150-accel-core.c |  9 ++++++---
 drivers/iio/accel/bmc150-accel-i2c.c  | 10 ++++++++--
 drivers/iio/accel/bmc150-accel-spi.c  | 10 +++++++++-
 drivers/iio/accel/bmc150-accel.h      | 20 +++++++++++++++++++-
 5 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 0e56ace61103..2f0c0d512ae7 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -143,10 +143,11 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMA222, BMA222E, BMA250E, BMA253, BMA254, BMA255, BMA280, BMC150, BMI055.
+	  BMA222, BMA222E, BMA250E, BMA253, BMA254, BMA255, BMA280, BMC150, BMC156
+	  BMI055.
 
 	  Note that some of these are combo modules:
-	    - BMC150: accelerometer and magnetometer
+	    - BMC150/BMC156: accelerometer and magnetometer
 	    - BMI055: accelerometer and gyroscope
 
 	  This driver is only implementing accelerometer part, which has
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 8d3dd3c2bcc2..e8693a42ad46 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -553,7 +553,8 @@ static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
 	 * Without interrupt-names, we assume the irq belongs to INT1.
 	 */
 	irq_info = bmc150_accel_interrupts_int1;
-	if (irq == of_irq_get_byname(dev->of_node, "INT2"))
+	if (data->type == BOSCH_BMC156 ||
+	    irq == of_irq_get_byname(dev->of_node, "INT2"))
 		irq_info = bmc150_accel_interrupts_int2;
 
 	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)
@@ -1174,7 +1175,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {306458, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
-		.name = "BMA253/BMA254/BMA255/BMC150/BMI055",
+		.name = "BMA253/BMA254/BMA255/BMC150/BMC156/BMI055",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
@@ -1661,7 +1662,8 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 }
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-			    const char *name, bool block_supported)
+			    enum bmc150_type type, const char *name,
+			    bool block_supported)
 {
 	const struct attribute **fifo_attrs;
 	struct bmc150_accel_data *data;
@@ -1676,6 +1678,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	dev_set_drvdata(dev, indio_dev);
 
 	data->regmap = regmap;
+	data->type = type;
 
 	if (!bmc150_apply_acpi_orientation(dev, &data->orientation)) {
 		ret = iio_read_mount_matrix(dev, &data->orientation);
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 999495f0669d..88bd8a25f142 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -176,6 +176,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 {
 	struct regmap *regmap;
 	const char *name = NULL;
+	enum bmc150_type type = BOSCH_UNKNOWN;
 	bool block_supported =
 		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
 		i2c_check_functionality(client->adapter,
@@ -188,10 +189,13 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		return PTR_ERR(regmap);
 	}
 
-	if (id)
+	if (id) {
 		name = id->name;
+		type = id->driver_data;
+	}
 
-	ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name, block_supported);
+	ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq,
+				      type, name, block_supported);
 	if (ret)
 		return ret;
 
@@ -236,6 +240,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bma255"},
 	{"bma280"},
 	{"bmc150_accel"},
+	{"bmc156_accel", BOSCH_BMC156},
 	{"bmi055_accel"},
 	{}
 };
@@ -251,6 +256,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma280" },
 	{ .compatible = "bosch,bmc150_accel" },
+	{ .compatible = "bosch,bmc156_accel" },
 	{ .compatible = "bosch,bmi055_accel" },
 	{ },
 };
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 54b8c9c8068b..191e312dc91a 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -16,6 +16,8 @@
 static int bmc150_accel_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
+	const char *name = NULL;
+	enum bmc150_type type = BOSCH_UNKNOWN;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	regmap = devm_regmap_init_spi(spi, &bmc150_regmap_conf);
@@ -24,7 +26,12 @@ static int bmc150_accel_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return bmc150_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
+	if (id) {
+		name = id->name;
+		type = id->driver_data;
+	}
+
+	return bmc150_accel_core_probe(&spi->dev, regmap, spi->irq, type, name,
 				       true);
 }
 
@@ -54,6 +61,7 @@ static const struct spi_device_id bmc150_accel_id[] = {
 	{"bma255"},
 	{"bma280"},
 	{"bmc150_accel"},
+	{"bmc156_accel", BOSCH_BMC156},
 	{"bmi055_accel"},
 	{}
 };
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 47121f070fe9..1bb5023e8ed9 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -13,6 +13,22 @@ struct i2c_client;
 struct bmc150_accel_chip_info;
 struct bmc150_accel_interrupt_info;
 
+/*
+ * We can often guess better than "UNKNOWN" based on the device IDs
+ * but unfortunately this information is not always accurate. There are some
+ * devices where ACPI firmware specifies an ID like "BMA250E" when the device
+ * actually has a BMA222E. The driver attempts to detect those by reading the
+ * chip ID from the registers but this information is not always enough either.
+ *
+ * Therefore, this enum should be only used when the chip ID detection is not
+ * enough and we can be reasonably sure that the device IDs are reliable
+ * in practice (e.g. for device tree platforms).
+ */
+enum bmc150_type {
+	BOSCH_UNKNOWN,
+	BOSCH_BMC156,
+};
+
 struct bmc150_accel_interrupt {
 	const struct bmc150_accel_interrupt_info *info;
 	atomic_t users;
@@ -62,6 +78,7 @@ struct bmc150_accel_data {
 	int ev_enable_state;
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
+	enum bmc150_type type;
 	struct i2c_client *second_device;
 	void (*resume_callback)(struct device *dev);
 	struct delayed_work resume_work;
@@ -69,7 +86,8 @@ struct bmc150_accel_data {
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-			    const char *name, bool block_supported);
+			    enum bmc150_type type, const char *name,
+			    bool block_supported);
 int bmc150_accel_core_remove(struct device *dev);
 extern const struct dev_pm_ops bmc150_accel_pm_ops;
 extern const struct regmap_config bmc150_regmap_conf;
-- 
2.32.0


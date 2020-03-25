Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E22192BEF
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCYPMW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 11:12:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48270 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbgCYPMV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Mar 2020 11:12:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 22B4D4128B;
        Wed, 25 Mar 2020 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1585149135; x=1586963536; bh=n9KPpCUHTHy6OddXI1/pvEdLgXvXj5esfBI
        INiVMeBA=; b=dCceEXvkPujvB6SbRy8OAkfNFeuKyydF4x7RYOr0wp2ZOy5uViw
        k1n/QrwMkczB2HqcmZUyM34PWQFuO2GaMI7OaHZI6G+d7IDQJT5uvGa9bvtTIdHj
        LtUot8G6CdNSJGwHjWIxVBaJMaSdFzRPSQTgw/IvdGwg5xz9luAU3VB4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EInnvtaYe3Oh; Wed, 25 Mar 2020 18:12:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 535804128C;
        Wed, 25 Mar 2020 18:12:15 +0300 (MSK)
Received: from localhost.yadro.com (10.199.1.182) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 25
 Mar 2020 18:12:15 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] iio: proximity: Add driver support for vcnl3020 proximity sensor
Date:   Wed, 25 Mar 2020 18:12:11 +0300
Message-ID: <20200325151211.19949-3-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325151211.19949-1-i.mikhaylov@yadro.com>
References: <20200325151211.19949-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.1.182]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Proximity sensor driver based on light/vcnl4000.c code.
For now supports only the single on-demand measurement.

The VCNL3020 is a fully integrated proximity sensor. Fully
integrated means that the infrared emitter is included in the
package. It has 16-bit resolution. It includes a signal
processing IC and features standard I2C communication
interface. It features an interrupt function.

Datasheet: http://www.vishay.com/docs/84150/vcnl3020.pdf
Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/Kconfig    |  10 ++
 drivers/iio/proximity/Makefile   |   1 +
 drivers/iio/proximity/vcnl3020.c | 242 +++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 drivers/iio/proximity/vcnl3020.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index d53601447da4..e781f7f4639b 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -112,6 +112,16 @@ config SRF08
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf08.
 
+config VCNL3020
+	tristate "VCNL3020 proximity sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VCNL3020
+	  proximity sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vcnl3020.
+
 config VL53L0X_I2C
 	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 0bb5f9de13d6..8245978ced30 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
+obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
 
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
new file mode 100644
index 000000000000..9da77cc10ab7
--- /dev/null
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for Vishay VCNL3020 proximity sensor on i2c bus.
+ * Based on Vishay VCNL4000 driver code.
+ *
+ * TODO: interrupts.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define VCNL_DRV_NAME		"vcnl3020"
+#define VCNL_REGMAP_NAME	"vcnl3020_regmap"
+#define VCNL3020_PROD_ID	0x21
+
+#define VCNL_COMMAND		0x80 /* Command register */
+#define VCNL_PROD_REV		0x81 /* Product ID and Revision ID */
+#define VCNL_PROXIMITY_RATE	0x82 /* Rate of Proximity Measurement */
+#define VCNL_LED_CURRENT	0x83 /* IR LED current for proximity mode */
+#define VCNL_PS_RESULT_HI	0x87 /* Proximity result register, MSB */
+#define VCNL_PS_RESULT_LO	0x88 /* Proximity result register, LSB */
+#define VCNL_PS_ICR		0x89 /* Interrupt Control Register  */
+
+#define VCNL_PS_LO_THR_HI	0x8a /* High byte of low threshold value */
+#define VCNL_PS_LO_THR_LO	0x8b /* Low byte of low threshold value */
+#define VCNL_PS_HI_THR_HI	0x8c /* High byte of high threshold value */
+#define VCNL_PS_HI_THR_LO	0x8d /* Low byte of high threshold value */
+#define VCNL_ISR		0x8e /* Interrupt Status Register */
+#define VCNL_PS_MOD_ADJ		0x8f /* Proximity Modulator Timing Adjustment */
+
+/* Bit masks for COMMAND register */
+#define VCNL_PS_RDY		BIT(5) /* proximity data ready? */
+#define VCNL_PS_OD		BIT(3) /* start on-demand proximity
+					* measurement
+					*/
+
+struct vcnl3020_data {
+	struct regmap *regmap;
+	struct i2c_client *client;
+	u8 rev;
+	struct mutex lock;
+};
+
+static int vcnl3020_init(struct vcnl3020_data *data)
+{
+	int rc;
+	unsigned int reg;
+	u32 led_current;
+
+	rc = device_property_read_u32(&data->client->dev, "led-current",
+				      &led_current);
+	if (rc) {
+		dev_err(&data->client->dev, "Couldn't get led current (%d)",
+			rc);
+		return rc;
+	}
+
+	rc = regmap_read(data->regmap, VCNL_PROD_REV, &reg);
+	if (rc < 0) {
+		dev_err(&data->client->dev,
+			"Error (%d) reading product revision", rc);
+		return rc;
+	}
+
+	if (reg == VCNL3020_PROD_ID) {
+		data->rev = reg;
+		mutex_init(&data->lock);
+	} else {
+		dev_err(&data->client->dev,
+			"Product id (%x) did not match vcnl3020 (%x)", reg,
+			VCNL3020_PROD_ID);
+		return -ENODEV;
+	}
+
+	/* set led current */
+	rc = regmap_write(data->regmap, VCNL_LED_CURRENT, led_current);
+	if (rc < 0) {
+		dev_err(&data->client->dev, "Error (%d) setting LED current",
+			rc);
+		return rc;
+	}
+
+	return 0;
+};
+
+static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
+{
+	u8 tries = 20;
+	int rc;
+	unsigned int reg;
+
+	mutex_lock(&data->lock);
+
+	rc = regmap_write(data->regmap, VCNL_COMMAND, VCNL_PS_OD);
+	if (rc < 0)
+		goto err_unlock;
+
+	/* wait for data to become ready */
+	do {
+		rc = regmap_read(data->regmap, VCNL_COMMAND, &reg);
+		if (rc < 0)
+			goto err_unlock;
+		if (reg & VCNL_PS_RDY)
+			break;
+		msleep(20); /* measurement takes up to 100 ms */
+	} while (--tries);
+
+	if (tries < 0) {
+		dev_err(&data->client->dev,
+			"vcnl3020_measure() failed, data is not ready");
+		rc = -EIO;
+		goto err_unlock;
+	}
+
+	rc = regmap_read(data->regmap, VCNL_PS_RESULT_HI, &reg);
+	if (rc < 0)
+		goto err_unlock;
+	*val = reg << 8;
+	dev_dbg(&data->client->dev, "result high byte 0x%x", rc);
+
+	rc = regmap_read(data->regmap, VCNL_PS_RESULT_LO, &reg);
+	if (rc < 0)
+		goto err_unlock;
+	*val |= reg;
+	dev_dbg(&data->client->dev, "result low byte 0x%x", rc);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return rc;
+}
+
+static const struct iio_chan_spec vcnl3020_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}
+};
+
+static int vcnl3020_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	int rc;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			rc = vcnl3020_measure_proximity(data, val);
+			if (rc)
+				return rc;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info vcnl3020_info = {
+	.read_raw = vcnl3020_read_raw,
+};
+
+static const struct regmap_config vcnl3020_regmap_config = {
+	.name		= VCNL_REGMAP_NAME,
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= VCNL_PS_MOD_ADJ,
+};
+
+static int vcnl3020_probe(struct i2c_client *client)
+{
+	struct vcnl3020_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc;
+
+	regmap = devm_regmap_init_i2c(client, &vcnl3020_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "regmap_init failed!\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->regmap = regmap;
+	data->client = client;
+
+	rc = vcnl3020_init(data);
+	if (rc)
+		return rc;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &vcnl3020_info;
+	indio_dev->channels = vcnl3020_channels;
+	indio_dev->num_channels = ARRAY_SIZE(vcnl3020_channels);
+	indio_dev->name = VCNL_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id vcnl3020_id[] = {
+	{ "vcnl3020", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, vcnl3020_id);
+
+static const struct of_device_id vcnl3020_of_match[] = {
+	{
+		.compatible = "vishay,vcnl3020",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, vcnl3020_of_match);
+
+static struct i2c_driver vcnl3020_driver = {
+	.driver = {
+		.name   = VCNL_DRV_NAME,
+		.of_match_table = vcnl3020_of_match,
+	},
+	.probe_new  = vcnl3020_probe,
+	.id_table = vcnl3020_id,
+};
+module_i2c_driver(vcnl3020_driver);
+
+MODULE_AUTHOR("Ivan Mikhaylov <i.mikhaylov@yadro.com>");
+MODULE_DESCRIPTION("Vishay VCNL3020 proximity sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.21.1


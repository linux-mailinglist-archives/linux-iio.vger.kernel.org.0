Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318BE374FCA
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhEFHKw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 03:10:52 -0400
Received: from first.geanix.com ([116.203.34.67]:43804 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhEFHKv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 May 2021 03:10:51 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 6DA35467C0C;
        Thu,  6 May 2021 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620284991; bh=wqED4axQUlyM4KkUuBGGG1pLEn7eRBbhATafGypGP8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YkcgWCrME/YdjBj9WW+gWeN0vaqJfivQd+5wTKLXoV4HKqJFOyA7NfMsEvSL9ltb3
         TCsuKqItW1dGAbM14JcdqIGeZm466zaJF0LjCIPMJPlEfBtYCrKJzgDU/FxMOWO4hi
         3G2z7Ot0FNFemO+o8FdLmLxkv4MaQhuufEgtuCwD3UIzipiqvI4cRd0ztTpFRUnl+l
         +YptzKZHoElb+GAEnzWv62+LR+D4P2AtoBxnksW0IOkbOG5JtIU9/igvrYIbqjICF3
         wkYcrDvf2We3OXZ6n7/7DuWLT+lLQBjsfiOp+svZB2W9zLFcQJ+o1LCPxc2pAdLAzG
         +yY7wOHWRX8Uw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        tomas.melin@vaisala.com
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v5 4/6] iio: accel: fxls8962af: add interrupt support
Date:   Thu,  6 May 2021 09:09:38 +0200
Message-Id: <20210506070940.312959-4-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210506070940.312959-1-sean@geanix.com>
References: <20210506070940.312959-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Preparation commit for the next that adds hw buffered sampling.
Adds the interrupt function and reads the devicetree for which
interrupt pin that is used.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes for v5:
 - using of_irq_get_byname()

 drivers/iio/accel/fxls8962af-core.c | 114 ++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 13167bae9e67..b909ba23e47c 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -15,6 +15,7 @@
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
@@ -54,6 +55,10 @@
 #define FXLS8962AF_SC3_WAKE_ODR_PREP(x)		FIELD_PREP(FXLS8962AF_SC3_WAKE_ODR_MASK, (x))
 #define FXLS8962AF_SC3_WAKE_ODR_GET(x)		FIELD_GET(FXLS8962AF_SC3_WAKE_ODR_MASK, (x))
 #define FXLS8962AF_SENS_CONFIG4			0x18
+#define FXLS8962AF_SC4_INT_PP_OD_MASK		BIT(1)
+#define FXLS8962AF_SC4_INT_PP_OD_PREP(x)	FIELD_PREP(FXLS8962AF_SC4_INT_PP_OD_MASK, (x))
+#define FXLS8962AF_SC4_INT_POL_MASK		BIT(0)
+#define FXLS8962AF_SC4_INT_POL_PREP(x)		FIELD_PREP(FXLS8962AF_SC4_INT_POL_MASK, (x))
 #define FXLS8962AF_SENS_CONFIG5			0x19
 
 #define FXLS8962AF_WAKE_IDLE_LSB		0x1b
@@ -62,6 +67,9 @@
 
 #define FXLS8962AF_INT_EN			0x20
 #define FXLS8962AF_INT_PIN_SEL			0x21
+#define FXLS8962AF_INT_PIN_SEL_MASK		GENMASK(7, 0)
+#define FXLS8962AF_INT_PIN_SEL_INT1		0x00
+#define FXLS8962AF_INT_PIN_SEL_INT2		GENMASK(7, 0)
 
 #define FXLS8962AF_OFF_X			0x22
 #define FXLS8962AF_OFF_Y			0x23
@@ -142,6 +150,11 @@ enum {
 	fxls8962af_idx_ts,
 };
 
+enum fxls8962af_int_pin {
+	FXLS8962AF_PIN_INT1,
+	FXLS8962AF_PIN_INT2,
+};
+
 static int fxls8962af_power_on(struct fxls8962af_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -504,6 +517,20 @@ static int fxls8962af_reset(struct fxls8962af_data *data)
 	return ret;
 }
 
+static irqreturn_t fxls8962af_interrupt(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
+	if (ret)
+		return IRQ_NONE;
+
+	return IRQ_NONE;
+}
+
 static void fxls8962af_regulator_disable(void *data_ptr)
 {
 	struct fxls8962af_data *data = data_ptr;
@@ -523,6 +550,87 @@ static void fxls8962af_pm_disable(void *dev_ptr)
 	fxls8962af_standby(iio_priv(indio_dev));
 }
 
+static void fxls8962af_get_irq(struct device_node *of_node,
+			       enum fxls8962af_int_pin *pin)
+{
+	int irq;
+
+	irq = of_irq_get_byname(of_node, "INT2");
+	if (irq > 0) {
+		*pin = FXLS8962AF_PIN_INT2;
+		return;
+	}
+
+	*pin = FXLS8962AF_PIN_INT1;
+}
+
+static int fxls8962af_irq_setup(struct iio_dev *indio_dev, int irq)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned long irq_type;
+	bool irq_active_high;
+	enum fxls8962af_int_pin int_pin;
+	u8 int_pin_sel;
+	int ret;
+
+	fxls8962af_get_irq(dev->of_node, &int_pin);
+	switch (int_pin) {
+	case FXLS8962AF_PIN_INT1:
+		int_pin_sel = FXLS8962AF_INT_PIN_SEL_INT1;
+		break;
+	case FXLS8962AF_PIN_INT2:
+		int_pin_sel = FXLS8962AF_INT_PIN_SEL_INT2;
+		break;
+	default:
+		dev_err(dev, "unsupported int pin selected\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_PIN_SEL,
+				 FXLS8962AF_INT_PIN_SEL_MASK, int_pin_sel);
+	if (ret)
+		return ret;
+
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+		irq_active_high = true;
+		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		irq_active_high = false;
+		break;
+	default:
+		dev_info(dev, "mode %lx unsupported\n", irq_type);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG4,
+				 FXLS8962AF_SC4_INT_POL_MASK,
+				 FXLS8962AF_SC4_INT_POL_PREP(irq_active_high));
+	if (ret)
+		return ret;
+
+	if (device_property_read_bool(dev, "drive-open-drain")) {
+		ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG4,
+					 FXLS8962AF_SC4_INT_PP_OD_MASK,
+					 FXLS8962AF_SC4_INT_PP_OD_PREP(1));
+		if (ret)
+			return ret;
+
+		irq_type |= IRQF_SHARED;
+	}
+
+	return devm_request_threaded_irq(dev,
+					 irq,
+					 NULL, fxls8962af_interrupt,
+					 irq_type | IRQF_ONESHOT,
+					 indio_dev->name, indio_dev);
+}
+
 int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	struct fxls8962af_data *data;
@@ -582,6 +690,12 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
+	if (irq) {
+		ret = fxls8962af_irq_setup(indio_dev, irq);
+		if (ret)
+			return ret;
+	}
+
 	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-- 
2.31.0


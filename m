Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE743DDCF4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhHBP5d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 11:57:33 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:10035 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhHBP5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 11:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627919826;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EU27wwecFrV7EsbZx1jhBFJBmbc5/vqkmCkJSV+r7Ck=;
    b=W4MG1mVgZcvrSPmCiIIDvHzmUUszLD0LsJhQ63lp6Zvo2xftUJ1EMa55uUJyRg1C6l
    E4++rzGoGa5LaetG4S70C04LGVf7i707mWvPAdAaZGJH9PZkm7Bqs09LC063F26d+aqc
    X7aDFFpqsWqLfaSxbDTtc0juB7kwTrmV/JVkZBNASBDEEQjh1d5bmN6+AcI8BAxqXb67
    RN9qEXLSWAT9twowLfzmdpQkgkMnt2kl/x0SjwyBnYbP882Gg7LN5xVfFrecpFRfMWAG
    qFM4e+ZzpfjYP/woKnAlKdLb53xsr6/brCuOdKBcuS5xVp1hQNZcX9xwCjGEiWaU0lYv
    6OPw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIhr0eF6M4Q=="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.30.0 DYNA|AUTH)
    with ESMTPSA id e095f1x72Fv62RF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 Aug 2021 17:57:06 +0200 (CEST)
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
Subject: [PATCH v2 3/4] iio: accel: bmc150: Make it possible to configure INT2 instead of INT1
Date:   Mon,  2 Aug 2021 17:56:56 +0200
Message-Id: <20210802155657.102766-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802155657.102766-1-stephan@gerhold.net>
References: <20210802155657.102766-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some Bosch accelerometers have two interrupt pins (INT1 and INT2).
At the moment, the driver uses only the first one, which is fine for
most situations. However, some boards might only have INT2 connected
for some reason.

Add the necessary bits and configuration to set up INT2. Then try
to detect this situation at least for device tree setups by checking
if the first interrupt (the one picked by the I2C/SPI core) is actually
named "INT2" using the interrupt-names property.

of_irq_get_byname() returns either 0 or some error code in case
the driver probed without device tree, so in all other cases we fall
back to configuring INT1 as before.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/bmc150-accel-core.c | 71 ++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 5ce384ebe6c7..8d3dd3c2bcc2 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of_irq.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
@@ -57,12 +58,18 @@
 #define BMC150_ACCEL_RESET_VAL			0xB6
 
 #define BMC150_ACCEL_REG_INT_MAP_0		0x19
-#define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE	BIT(2)
+#define BMC150_ACCEL_INT_MAP_0_BIT_INT1_SLOPE	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_MAP_1		0x1A
-#define BMC150_ACCEL_INT_MAP_1_BIT_DATA		BIT(0)
-#define BMC150_ACCEL_INT_MAP_1_BIT_FWM		BIT(1)
-#define BMC150_ACCEL_INT_MAP_1_BIT_FFULL	BIT(2)
+#define BMC150_ACCEL_INT_MAP_1_BIT_INT1_DATA	BIT(0)
+#define BMC150_ACCEL_INT_MAP_1_BIT_INT1_FWM	BIT(1)
+#define BMC150_ACCEL_INT_MAP_1_BIT_INT1_FFULL	BIT(2)
+#define BMC150_ACCEL_INT_MAP_1_BIT_INT2_FFULL	BIT(5)
+#define BMC150_ACCEL_INT_MAP_1_BIT_INT2_FWM	BIT(6)
+#define BMC150_ACCEL_INT_MAP_1_BIT_INT2_DATA	BIT(7)
+
+#define BMC150_ACCEL_REG_INT_MAP_2		0x1B
+#define BMC150_ACCEL_INT_MAP_2_BIT_INT2_SLOPE	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_RST_LATCH		0x21
 #define BMC150_ACCEL_INT_MODE_LATCH_RESET	0x80
@@ -81,6 +88,7 @@
 
 #define BMC150_ACCEL_REG_INT_OUT_CTRL		0x20
 #define BMC150_ACCEL_INT_OUT_CTRL_INT1_LVL	BIT(0)
+#define BMC150_ACCEL_INT_OUT_CTRL_INT2_LVL	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_5			0x27
 #define BMC150_ACCEL_SLOPE_DUR_MASK		0x03
@@ -476,21 +484,24 @@ static bool bmc150_apply_acpi_orientation(struct device *dev,
 }
 #endif
 
-static const struct bmc150_accel_interrupt_info {
+struct bmc150_accel_interrupt_info {
 	u8 map_reg;
 	u8 map_bitmask;
 	u8 en_reg;
 	u8 en_bitmask;
-} bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
+};
+
+static const struct bmc150_accel_interrupt_info
+bmc150_accel_interrupts_int1[BMC150_ACCEL_INTERRUPTS] = {
 	{ /* data ready interrupt */
 		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
-		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_DATA,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_INT1_DATA,
 		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
 		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_DATA_EN,
 	},
 	{  /* motion interrupt */
 		.map_reg = BMC150_ACCEL_REG_INT_MAP_0,
-		.map_bitmask = BMC150_ACCEL_INT_MAP_0_BIT_SLOPE,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_0_BIT_INT1_SLOPE,
 		.en_reg = BMC150_ACCEL_REG_INT_EN_0,
 		.en_bitmask =  BMC150_ACCEL_INT_EN_BIT_SLP_X |
 			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
@@ -498,19 +509,55 @@ static const struct bmc150_accel_interrupt_info {
 	},
 	{ /* fifo watermark interrupt */
 		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
-		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_FWM,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_INT1_FWM,
+		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
+		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_FWM_EN,
+	},
+};
+
+static const struct bmc150_accel_interrupt_info
+bmc150_accel_interrupts_int2[BMC150_ACCEL_INTERRUPTS] = {
+	{ /* data ready interrupt */
+		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_INT2_DATA,
+		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
+		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_DATA_EN,
+	},
+	{  /* motion interrupt */
+		.map_reg = BMC150_ACCEL_REG_INT_MAP_2,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_2_BIT_INT2_SLOPE,
+		.en_reg = BMC150_ACCEL_REG_INT_EN_0,
+		.en_bitmask =  BMC150_ACCEL_INT_EN_BIT_SLP_X |
+			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
+			BMC150_ACCEL_INT_EN_BIT_SLP_Z
+	},
+	{ /* fifo watermark interrupt */
+		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_INT2_FWM,
 		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
 		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_FWM_EN,
 	},
 };
 
 static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
-					  struct bmc150_accel_data *data)
+					  struct bmc150_accel_data *data, int irq)
 {
+	const struct bmc150_accel_interrupt_info *irq_info = NULL;
+	struct device *dev = regmap_get_device(data->regmap);
 	int i;
 
+	/*
+	 * For now we map all interrupts to the same output pin.
+	 * However, some boards may have just INT2 (and not INT1) connected,
+	 * so we try to detect which IRQ it is based on the interrupt-names.
+	 * Without interrupt-names, we assume the irq belongs to INT1.
+	 */
+	irq_info = bmc150_accel_interrupts_int1;
+	if (irq == of_irq_get_byname(dev->of_node, "INT2"))
+		irq_info = bmc150_accel_interrupts_int2;
+
 	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)
-		data->interrupts[i].info = &bmc150_accel_interrupts[i];
+		data->interrupts[i].info = &irq_info[i];
 }
 
 static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
@@ -1714,7 +1761,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			goto err_buffer_cleanup;
 		}
 
-		bmc150_accel_interrupts_setup(indio_dev, data);
+		bmc150_accel_interrupts_setup(indio_dev, data, irq);
 
 		ret = bmc150_accel_triggers_setup(indio_dev, data);
 		if (ret)
-- 
2.32.0


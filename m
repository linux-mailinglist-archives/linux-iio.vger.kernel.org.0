Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD619F97B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDFP6b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:58:31 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:17995 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgDFP6a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 11:58:30 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0936F240012;
        Mon,  6 Apr 2020 15:58:27 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 3/3] Input: add a rotary encoders based on counter devices
Date:   Mon,  6 Apr 2020 17:58:06 +0200
Message-Id: <20200406155806.1295169-4-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This add support for rotary encoders that use the counter subsystem to
expose an input device.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 drivers/input/misc/Kconfig                  |   9 ++
 drivers/input/misc/Makefile                 |   1 +
 drivers/input/misc/rotary_encoder_counter.c | 152 ++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/input/misc/rotary_encoder_counter.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7e2e658d551c..b91b4257e337 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -619,6 +619,15 @@ config INPUT_GPIO_ROTARY_ENCODER
 	  To compile this driver as a module, choose M here: the
 	  module will be called rotary_encoder.
 
+config INPUT_COUNTER_ROTARY_ENCODER
+       tristate "Rotary encoders connected to counter devices"
+       depends on COUNTER || COMPILE_TEST
+       help
+         Say Y here to add support for rotary encoders connected to counter devices.
+
+         To compile this driver as a module, choose M here: the
+         module will be called rotary_encoder_counter.
+
 config INPUT_RB532_BUTTON
 	tristate "Mikrotik Routerboard 532 button interface"
 	depends on MIKROTIK_RB532
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 8fd187f314bd..74bbe6d400a3 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
 obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
 obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
 obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
+obj-$(CONFIG_INPUT_COUNTER_ROTARY_ENCODER) += rotary_encoder_counter.o
 obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
 obj-$(CONFIG_INPUT_SC27XX_VIBRA)	+= sc27xx-vibra.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
diff --git a/drivers/input/misc/rotary_encoder_counter.c b/drivers/input/misc/rotary_encoder_counter.c
new file mode 100644
index 000000000000..20017308f4f3
--- /dev/null
+++ b/drivers/input/misc/rotary_encoder_counter.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A rotary encoder driver using the generic counter interface.
+ *
+ * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/counter.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+
+#define MAX_STEPS	24
+
+struct rotary_encoder {
+	struct input_dev *input;
+	u32 steps;
+	u32 axis;
+	bool relative_axis;
+	bool rollover;
+	long last_pos;
+	struct counter_device *counter;
+};
+
+static void rotary_encoder_poll(struct input_dev *input)
+{
+	struct rotary_encoder *encoder = input_get_drvdata(input);
+	long rotary_pos;
+	int ret;
+
+	ret = counter_count_get(encoder->counter, &rotary_pos);
+	if (ret)
+		return;
+
+	if (encoder->relative_axis) {
+		input_report_rel(encoder->input, encoder->axis,
+				 rotary_pos - encoder->last_pos);
+	} else {
+		if (encoder->rollover)
+			rotary_pos %= encoder->steps;
+		input_report_abs(encoder->input, encoder->axis, rotary_pos);
+	}
+
+	encoder->last_pos = rotary_pos;
+	input_sync(encoder->input);
+}
+
+static int rotary_encoder_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
+	struct rotary_encoder *encoder;
+	struct input_dev *input;
+	int qdec_mode;
+	u32 poll_interval;
+	int err;
+
+	encoder = devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERNEL);
+	if (!encoder)
+		return -ENOMEM;
+
+	encoder->rollover =
+		device_property_read_bool(dev, "rollover");
+
+	device_property_read_u32(dev, "steps", &encoder->steps);
+
+	device_property_read_u32(dev, "linux-axis", &encoder->axis);
+
+	encoder->relative_axis =
+		device_property_read_bool(dev, "relative-axis");
+
+	counter = devm_counter_get(dev);
+	if (IS_ERR(counter))
+		return PTR_ERR(counter);
+
+	if (device_property_read_u32(dev, "qdec-mode", &qdec_mode)) {
+		dev_err(dev, "Invalid or missing quadrature mode\n");
+		return -EINVAL;
+	}
+
+	err = counter_function_set(counter, qdec_mode);
+	if (err) {
+		dev_err(dev, "Failed to set quadrature mode %d\n",
+			qdec_mode);
+		return err;
+	}
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input_set_drvdata(input, encoder);
+	encoder->input = input;
+	encoder->counter = counter;
+	encoder->steps = (!encoder->steps) ? MAX_STEPS : encoder->steps;
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = dev;
+
+	if (encoder->relative_axis)
+		input_set_capability(input, EV_REL, encoder->axis);
+	else
+		input_set_abs_params(input, encoder->axis, 0,
+				     encoder->steps, 0, 1);
+
+	err = input_setup_polling(input, rotary_encoder_poll);
+	if (err)
+		return err;
+
+	if (!device_property_read_u32(dev, "poll-interval",
+				      &poll_interval))
+		input_set_poll_interval(input, poll_interval);
+
+	err = input_register_device(input);
+	if (err) {
+		dev_err(dev, "failed to register device, err=%d\n", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, encoder);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id rotary_encoder_of_match[] = {
+	{ .compatible = "rotary-encoder-counter", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
+#endif
+
+static struct platform_driver rotary_encoder_driver = {
+	.probe		= rotary_encoder_probe,
+	.driver		= {
+		.name	= "rotary-encoder-counter",
+		.of_match_table = of_match_ptr(rotary_encoder_of_match),
+	}
+};
+module_platform_driver(rotary_encoder_driver);
+
+MODULE_DESCRIPTION("Counter rotary encoder driver");
+MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.0


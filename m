Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B013052B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2020 01:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgAEAKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jan 2020 19:10:47 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42031 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgAEAKq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jan 2020 19:10:46 -0500
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 664F31C000A;
        Sun,  5 Jan 2020 00:10:43 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 5/5] input: joystick: Add ADC attached joystick driver.
Date:   Sun,  5 Jan 2020 01:16:39 +0100
Message-Id: <20200105001639.142061-5-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200105001639.142061-1-contact@artur-rojek.eu>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a driver for joystick devices connected to ADC controllers
supporting the Industrial I/O subsystem.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/input/joystick/Kconfig        |  10 ++
 drivers/input/joystick/Makefile       |   1 +
 drivers/input/joystick/adc-joystick.c | 230 ++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/input/joystick/adc-joystick.c

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 940b744639c7..efbc20ec5099 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -42,6 +42,16 @@ config JOYSTICK_A3D
 	  To compile this driver as a module, choose M here: the
 	  module will be called a3d.
 
+config JOYSTICK_ADC
+	tristate "Simple joystick connected over ADC"
+	depends on IIO
+	select IIO_BUFFER_CB
+	help
+	  Say Y here if you have a simple joystick connected over ADC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adc-joystick.
+
 config JOYSTICK_ADI
 	tristate "Logitech ADI digital joysticks and gamepads"
 	select GAMEPORT
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 8656023f6ef5..58232b3057d3 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -6,6 +6,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_JOYSTICK_A3D)		+= a3d.o
+obj-$(CONFIG_JOYSTICK_ADC)		+= adc-joystick.o
 obj-$(CONFIG_JOYSTICK_ADI)		+= adi.o
 obj-$(CONFIG_JOYSTICK_AMIGA)		+= amijoy.o
 obj-$(CONFIG_JOYSTICK_AS5011)		+= as5011.o
diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
new file mode 100644
index 000000000000..0dfc4218dafa
--- /dev/null
+++ b/drivers/input/joystick/adc-joystick.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Input driver for joysticks connected over ADC.
+ * Copyright (c) 2019-2020 Artur Rojek <contact@artur-rojek.eu>
+ */
+#include <linux/ctype.h>
+#include <linux/input.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct adc_joystick_axis {
+	u32 code;
+	s32 range[2];
+	s32 fuzz;
+	s32 flat;
+};
+
+struct adc_joystick {
+	struct input_dev *input;
+	struct iio_cb_buffer *buffer;
+	struct adc_joystick_axis *axes;
+	struct iio_channel *chans;
+	int num_chans;
+};
+
+static int adc_joystick_handle(const void *data, void *private)
+{
+	struct adc_joystick *joy = private;
+	enum iio_endian endianness;
+	int bytes, msb, val, i;
+	bool sign;
+
+	/* Assume all channels have the same storage size. */
+	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
+
+	for (i = 0; i < joy->num_chans; ++i) {
+		endianness = joy->chans[i].channel->scan_type.endianness;
+		msb = joy->chans[i].channel->scan_type.realbits - 1;
+		sign = (tolower(joy->chans[i].channel->scan_type.sign) == 's');
+
+		switch (bytes) {
+		case 1:
+			val = ((const u8 *)data)[i];
+			break;
+		case 2:
+			val = ((const u16 *)data)[i];
+			if (endianness == IIO_BE)
+				val = be16_to_cpu(val);
+			else if (endianness == IIO_LE)
+				val = le16_to_cpu(val);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		val >>= joy->chans[i].channel->scan_type.shift;
+		if (sign)
+			val = sign_extend32(val, msb);
+		else
+			val &= GENMASK(msb, 0);
+		input_report_abs(joy->input, joy->axes[i].code, val);
+	}
+
+	input_sync(joy->input);
+
+	return 0;
+}
+
+static int adc_joystick_open(struct input_dev *dev)
+{
+	struct adc_joystick *joy = input_get_drvdata(dev);
+	int ret;
+
+	ret = iio_channel_start_all_cb(joy->buffer);
+	if (ret)
+		dev_err(dev->dev.parent, "Unable to start callback buffer");
+
+	return ret;
+}
+
+static void adc_joystick_close(struct input_dev *dev)
+{
+	struct adc_joystick *joy = input_get_drvdata(dev);
+
+	iio_channel_stop_all_cb(joy->buffer);
+}
+
+static void adc_joystick_disable(void *data)
+{
+	iio_channel_release_all_cb(data);
+}
+
+static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
+{
+	struct adc_joystick_axis *axes;
+	struct fwnode_handle *child;
+	int num_axes, i = 0;
+
+	num_axes = device_get_child_node_count(dev);
+	if (!num_axes) {
+		dev_err(dev, "Unable to find child nodes");
+		return -EINVAL;
+	}
+
+	if (num_axes != joy->num_chans) {
+		dev_err(dev, "Got %d child nodes for %d channels",
+			num_axes, joy->num_chans);
+		return -EINVAL;
+	}
+
+	axes = devm_kmalloc_array(dev, num_axes, sizeof(*axes), GFP_KERNEL);
+	if (!axes)
+		return -ENOMEM;
+
+	device_for_each_child_node(dev, child) {
+		if (fwnode_property_read_u32(child, "linux,abs-code",
+					     &axes[i].code)) {
+			dev_err(dev, "linux,abs-code invalid or missing");
+			goto err;
+		}
+
+		if (fwnode_property_read_u32_array(child, "linux,abs-range",
+						   axes[i].range, 2)) {
+			dev_err(dev, "linux,abs-range invalid or missing");
+			goto err;
+		}
+
+		fwnode_property_read_u32(child, "linux,abs-fuzz",
+					 &axes[i].fuzz);
+		fwnode_property_read_u32(child, "linux,abs-flat",
+					 &axes[i].flat);
+
+		input_set_abs_params(joy->input, axes[i].code, axes[i].range[0],
+				     axes[i].range[1], axes[i].fuzz,
+				     axes[i].flat);
+		input_set_capability(joy->input, EV_ABS, axes[i].code);
+
+		++i;
+	}
+
+	joy->axes = axes;
+
+	return 0;
+
+err:
+	fwnode_handle_put(child);
+	return -EINVAL;
+}
+
+static int adc_joystick_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adc_joystick *joy;
+	struct input_dev *input;
+	int ret;
+
+	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
+	if (!joy)
+		return -ENOMEM;
+
+	joy->chans = devm_iio_channel_get_all(dev);
+	if (IS_ERR(joy->chans)) {
+		ret = PTR_ERR(joy->chans);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Unable to get IIO channels");
+		return ret;
+	}
+
+	/* Count how many channels we got. NULL terminated. */
+	while (joy->chans[joy->num_chans].indio_dev)
+		joy->num_chans++;
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "Unable to allocate input device");
+		return -ENOMEM;
+	}
+
+	joy->input = input;
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->open = adc_joystick_open;
+	input->close = adc_joystick_close;
+
+	ret = adc_joystick_set_axes(dev, joy);
+	if (ret)
+		return ret;
+
+	input_set_drvdata(input, joy);
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "Unable to register input device: %d", ret);
+		return ret;
+	}
+
+	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
+	if (IS_ERR(joy->buffer)) {
+		dev_err(dev, "Unable to allocate callback buffer");
+		return PTR_ERR(joy->buffer);
+	}
+
+	ret = devm_add_action_or_reset(dev, adc_joystick_disable, joy->buffer);
+	if (ret)
+		dev_err(dev, "Unable to add action");
+
+	return ret;
+}
+
+static const struct of_device_id adc_joystick_of_match[] = {
+	{ .compatible = "adc-joystick", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
+
+static struct platform_driver adc_joystick_driver = {
+	.driver = {
+		.name = "adc-joystick",
+		.of_match_table = of_match_ptr(adc_joystick_of_match),
+	},
+	.probe = adc_joystick_probe,
+};
+module_platform_driver(adc_joystick_driver);
+
+MODULE_DESCRIPTION("Input driver for joysticks connected over ADC");
+MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
+MODULE_LICENSE("GPL");
-- 
2.24.1


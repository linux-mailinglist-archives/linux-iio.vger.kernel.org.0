Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A482568AF5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jul 2022 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiGFOL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiGFOL4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 10:11:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA5B1EAC5;
        Wed,  6 Jul 2022 07:11:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so14447240pfv.13;
        Wed, 06 Jul 2022 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FTiter/PQ1QbI6Ree7YnYZ+Mv5A2DG1K1zlSq79Gihg=;
        b=h3TreDFn4casMYr8fPllakS9kECMtk0bK3vH/YeXV7GsRyUm61ktIZADoYMfEyCVBC
         3J68bggMBxZ8DV4ZRM85PrE0cGLcFDD0CcyJD6ympWVB1f7+N5Z4FocOp3oyzRouX6uj
         Y31HJjM1qQGJbzLlCjPir6oB13NDB8Sc1cDyZSzvkfjMsArLt4scWO+rwdrqh5tfDIjw
         0Ccu+CyXi4+nkjclHnhGNla53XVeA7ipBipECChW6D9y9NnVeLH77wZITXBWz10aFxOJ
         2vKlDmrsfrbBGbEzVyuaVYJsXQhGlFfaa/qmIluFgvBscqIUNxNInBDvHuqNRRN5EU0U
         Nfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FTiter/PQ1QbI6Ree7YnYZ+Mv5A2DG1K1zlSq79Gihg=;
        b=iVOfDx875ApMDbZa6XTWs7kQi93zxUPOASxSciGQ0lJsNe3YDq4VCmEL5eChkeEpKV
         NJ77rvR5KL8bEMdLxP/G0tk4Rpi+nWD5pfFHtQRI3THBnIbLEyevrBK3tJZ6HGoajUtF
         XjxI8KQcWHM+4Iwe0Z4OpNDjZnBJXwGSGeqXLVoesJjK9z5ooYhcNgZ0qqoam6mY6vN5
         Eg3zk+taq3XfVjR0SaFhQqiK+3dnZujd6f3C96QiWBjDJDXJ87ZC0X2a5Hs5B3okWJ7/
         pc1ZV2ERVnJQ2ampoWvk6intRubxTLDniC4gPJq3aOEeO1rysFFkfVIOD6iQVXAMSA2U
         bGow==
X-Gm-Message-State: AJIora9WxPCtW85AIUyTOmbBPIMGU7T+xtAi7tElvZgPxYQjQBNUVCNs
        YkGa/96h9iawPyXnXcpOt9YFn8kKmaI=
X-Google-Smtp-Source: AGRyM1spQjVv2229WCFjFE0geAhsrueBzYqsHbyWy+hnluRAJtRVClA2X1C8pX2Ab5LbU6YKVICnDQ==
X-Received: by 2002:a63:234f:0:b0:405:3981:be7 with SMTP id u15-20020a63234f000000b0040539810be7mr34798660pgm.15.1657116713161;
        Wed, 06 Jul 2022 07:11:53 -0700 (PDT)
Received: from localhost.localdomain (1-171-7-167.dynamic-ip.hinet.net. [1.171.7.167])
        by smtp.gmail.com with ESMTPSA id k2-20020aa79722000000b005283fa73dcesm8738427pfg.77.2022.07.06.07.11.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:11:52 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] iio: adc: Add rtq6056 support
Date:   Wed,  6 Jul 2022 22:11:42 +0800
Message-Id: <1657116702-24161-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add Richtek rtq6056 supporting.

It can be used for the system to monitor load current and power with 16-bit
resolution.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Since v5
- Fix kernel version text for ABI.

Since v4
- Add '__aligned(8)' for timestamp member in buffer_trigger_handler function.
- Declare timestamp from 'int64_t' to more unified 's64'.

Since v3
- Refine pm_runtime API calling order in 'read_channel' API.
- Fix vshunt wrong scale for divider.
- Refine the comment text.
- Use 'devm_add_action_or_reset' to decrease the code usage in probe
  function.
- Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
- minor fix for the comma.
- Use pm_ptr to replace the direct assigned pm_ops.

Since v2
- Rename file from 'rtq6056-adc' to 'rtq6056'.
- Refine the ABI, if generic already defined it, remove it and check the channel
  report unit.
- Add copyright text.
- include the correct header.
- change the property parsing name.
- To use iio_chan_spec address field.
- Refine each channel separate and shared_by_all.
- Use pm_runtime and pm_runtime_autosuspend.
- Remove the shutdown callback. From the HW suggestion, it's not recommended to
  use battery as the power supply.
- Check all scale unit (voltage->mV, current->mA, power->milliWatt).
- Use the read_avail to provide the interface for attribute value list.
- Add comma for the last element in the const integer array.
- Refine each ADC label text.
- In read_label callback, replace snprintf to sysfs_emit.

---
 .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rtq6056.c                          | 651 +++++++++++++++++++++
 4 files changed, 673 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
 create mode 100644 drivers/iio/adc/rtq6056.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
new file mode 100644
index 00000000..e89d15b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
@@ -0,0 +1,6 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_integration_time
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_integration_time
+KernelVersion:	5.20
+Contact:	cy_huang@richtek.com
+Description:
+		Each voltage conversion time in uS
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace74..caebd1a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -908,6 +908,21 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config RICHTEK_RTQ6056
+	tristate "Richtek RTQ6056 Current and Power Monitor ADC"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to enable RQT6056 ADC support.
+	  RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
+	  compatible interface, and the device provides full information for
+	  system by reading out the load current and power.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called rtq6056.
+
 config RZG2L_ADC
 	tristate "Renesas RZ/G2L ADC driver"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f..cda7580 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
 obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
+obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
new file mode 100644
index 00000000..64027b1
--- /dev/null
+++ b/drivers/iio/adc/rtq6056.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Richtek Technology Corp.
+ *
+ * ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/util_macros.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define RTQ6056_REG_CONFIG	0x00
+#define RTQ6056_REG_SHUNTVOLT	0x01
+#define RTQ6056_REG_BUSVOLT	0x02
+#define RTQ6056_REG_POWER	0x03
+#define RTQ6056_REG_CURRENT	0x04
+#define RTQ6056_REG_CALIBRATION	0x05
+#define RTQ6056_REG_MASKENABLE	0x06
+#define RTQ6056_REG_ALERTLIMIT	0x07
+#define RTQ6056_REG_MANUFACTID	0xFE
+#define RTQ6056_REG_DIEID	0xFF
+
+#define RTQ6056_VENDOR_ID	0x1214
+#define RTQ6056_DEFAULT_CONFIG	0x4127
+#define RTQ6056_CONT_ALLON	7
+
+enum {
+	RTQ6056_CH_VSHUNT = 0,
+	RTQ6056_CH_VBUS,
+	RTQ6056_CH_POWER,
+	RTQ6056_CH_CURRENT,
+	RTQ6056_MAX_CHANNEL
+};
+
+enum {
+	F_OPMODE = 0,
+	F_VSHUNTCT,
+	F_VBUSCT,
+	F_AVG,
+	F_RESET,
+	F_MAX_FIELDS
+};
+
+struct rtq6056_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_field *rm_fields[F_MAX_FIELDS];
+	u32 shunt_resistor_uohm;
+	int vshuntct_us;
+	int vbusct_us;
+	int avg_sample;
+};
+
+static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] = {
+	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
+	[F_VSHUNTCT] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 5),
+	[F_VBUSCT] = REG_FIELD(RTQ6056_REG_CONFIG, 6, 8),
+	[F_AVG]	= REG_FIELD(RTQ6056_REG_CONFIG, 9, 11),
+	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
+};
+
+static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.address = RTQ6056_REG_SHUNTVOLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.address = RTQ6056_REG_BUSVOLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_POWER,
+		.indexed = 1,
+		.channel = 2,
+		.address = RTQ6056_REG_POWER,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_CURRENT,
+		.indexed = 1,
+		.channel = 3,
+		.address = RTQ6056_REG_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL),
+};
+
+static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
+				    struct iio_chan_spec const *ch,
+				    int *val)
+{
+	struct device *dev = priv->dev;
+	unsigned int addr = ch->address;
+	unsigned int regval;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = regmap_read(priv->regmap, addr, &regval);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
+	if (ret)
+		return ret;
+
+	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
+	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
+		*val = regval;
+	else
+		*val = sign_extend32(regval, 16);
+
+
+	return IIO_VAL_INT;
+}
+
+static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
+				  int *val2)
+{
+	switch (ch->address) {
+	case RTQ6056_REG_SHUNTVOLT:
+		/* VSHUNT lsb  2.5uV */
+		*val = 2500;
+		*val2 = 1000000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_REG_BUSVOLT:
+		/* VBUS lsb 1.25mV */
+		*val = 1250;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_REG_POWER:
+		/* Power lsb 25mW */
+		*val = 25;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Conversion time in uS for channel VSHUNT and VBUS. The indices correspond
+ * with the bit value expected by the chip. And it can be found at
+ * https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+ */
+static const int rtq6056_conv_time_list[] = {
+	139, 203, 269, 525, 1037, 2061, 4109, 8205,
+};
+
+static int rtq6056_adc_set_conv_time(struct rtq6056_priv *priv,
+				     struct iio_chan_spec const *ch,
+				     int val)
+{
+	struct regmap_field *rm_field;
+	unsigned int selector;
+	int *ct, ret;
+
+	if (val > 8205 || val < 139)
+		return -EINVAL;
+
+	if (ch->address == RTQ6056_REG_SHUNTVOLT) {
+		rm_field = priv->rm_fields[F_VSHUNTCT];
+		ct = &priv->vshuntct_us;
+	} else {
+		rm_field = priv->rm_fields[F_VBUSCT];
+		ct = &priv->vbusct_us;
+	}
+
+	selector = find_closest(val, rtq6056_conv_time_list,
+				ARRAY_SIZE(rtq6056_conv_time_list));
+
+	ret = regmap_field_write(rm_field, selector);
+	if (ret)
+		return ret;
+
+	*ct = rtq6056_conv_time_list[selector];
+
+	return 0;
+}
+
+/*
+ * Available averaging rate for rtq6056. The indices correspond with the bit
+ * value expected by the chip. And it can be found at
+ * https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+ */
+static const int rtq6056_avg_sample_list[] = {
+	1, 4, 16, 64, 128, 256, 512, 1024,
+};
+
+static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
+{
+	unsigned int selector;
+	int ret;
+
+	if (val > 1024 || val < 1)
+		return -EINVAL;
+
+	selector = find_closest(val, rtq6056_avg_sample_list,
+				ARRAY_SIZE(rtq6056_avg_sample_list));
+
+	ret = regmap_field_write(priv->rm_fields[F_AVG], selector);
+	if (ret)
+		return ret;
+
+	priv->avg_sample = rtq6056_avg_sample_list[selector];
+
+	return 0;
+}
+
+static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv, int *val)
+{
+	int sample_time;
+
+	sample_time = priv->vshuntct_us + priv->vbusct_us;
+	sample_time *= priv->avg_sample;
+
+	*val = DIV_ROUND_UP(1000000, sample_time);
+
+	return IIO_VAL_INT;
+}
+
+static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return rtq6056_adc_read_channel(priv, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		return rtq6056_adc_read_scale(chan, val, val2);
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->address == RTQ6056_REG_SHUNTVOLT)
+			*val = priv->vshuntct_us;
+		else
+			*val = priv->vbusct_us;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = priv->avg_sample;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return rtq6056_adc_get_sample_freq(priv, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = rtq6056_conv_time_list;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(rtq6056_conv_time_list);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = rtq6056_avg_sample_list;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(rtq6056_avg_sample_list);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int val,
+				 int val2, long mask)
+{
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return rtq6056_adc_set_conv_time(priv, chan, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return rtq6056_adc_set_average(priv, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
+	[RTQ6056_CH_VSHUNT] = "Vshunt",
+	[RTQ6056_CH_VBUS] = "Vbus",
+	[RTQ6056_CH_POWER] = "Power",
+	[RTQ6056_CH_CURRENT] = "Current",
+};
+
+static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  char *label)
+{
+	return sysfs_emit(label, "%s\n", rtq6056_channel_labels[chan->channel]);
+}
+
+static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
+				      int resistor_uohm)
+{
+	unsigned int calib_val;
+	int ret;
+
+	if (resistor_uohm <= 0) {
+		dev_err(priv->dev, "Invalid resistor [%d]\n", resistor_uohm);
+		return -EINVAL;
+	}
+
+	/* calibration = 5120000 / (Rshunt (uOhm) * current lsb (1mA)) */
+	calib_val = 5120000 / resistor_uohm;
+	ret = regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib_val);
+	if (ret)
+		return ret;
+
+	priv->shunt_resistor_uohm = resistor_uohm;
+
+	return 0;
+}
+
+static ssize_t shunt_resistor_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct rtq6056_priv *priv = iio_priv(dev_to_iio_dev(dev));
+	int vals[2] = { priv->shunt_resistor_uohm, 1000000 };
+
+	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
+}
+
+static ssize_t shunt_resistor_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	int val, val_fract, ret;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
+	if (ret)
+		return ret;
+
+	ret = rtq6056_set_shunt_resistor(priv, val * 1000000 + val_fract);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(shunt_resistor, 0);
+
+static struct attribute *rtq6056_attributes[] = {
+	&iio_dev_attr_shunt_resistor.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group rtq6056_attribute_group = {
+	.attrs = rtq6056_attributes,
+};
+
+static const struct iio_info rtq6056_info = {
+	.attrs = &rtq6056_attribute_group,
+	.read_raw = rtq6056_adc_read_raw,
+	.read_avail = rtq6056_adc_read_avail,
+	.write_raw = rtq6056_adc_write_raw,
+	.read_label = rtq6056_adc_read_label,
+};
+
+static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	struct device *dev = priv->dev;
+	struct {
+		u16 vals[RTQ6056_MAX_CHANNEL];
+		s64 timestamp __aligned(8);
+	} data;
+	unsigned int raw;
+	int i = 0, bit, ret;
+
+	memset(&data, 0, sizeof(data));
+
+	pm_runtime_get_sync(dev);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		unsigned int addr = rtq6056_channels[bit].address;
+
+		ret = regmap_read(priv->regmap, addr, &raw);
+		if (ret)
+			goto out;
+
+		data.vals[i++] = raw;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static void rtq6056_remove(void *dev)
+{
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+}
+
+static bool rtq6056_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RTQ6056_REG_CONFIG ... RTQ6056_REG_ALERTLIMIT:
+	case RTQ6056_REG_MANUFACTID ... RTQ6056_REG_DIEID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rtq6056_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RTQ6056_REG_CONFIG:
+	case RTQ6056_REG_CALIBRATION ... RTQ6056_REG_ALERTLIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rtq6056_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = RTQ6056_REG_DIEID,
+	.readable_reg = rtq6056_is_readable_reg,
+	.writeable_reg = rtq6056_is_writeable_reg,
+};
+
+static int rtq6056_probe(struct i2c_client *i2c)
+{
+	struct iio_dev *indio_dev;
+	struct rtq6056_priv *priv;
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+	unsigned int vendor_id, shunt_resistor_uohm;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = dev;
+	priv->vshuntct_us = priv->vbusct_us = 1037;
+	priv->avg_sample = 1;
+	i2c_set_clientdata(i2c, priv);
+
+	regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init regmap\n");
+
+	priv->regmap = regmap;
+
+	ret = regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get manufacturer info\n");
+
+	if (vendor_id != RTQ6056_VENDOR_ID)
+		return dev_err_probe(dev, -ENODEV,
+				     "Invalid vendor id 0x%04x\n", vendor_id);
+
+	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
+					   rtq6056_reg_fields, F_MAX_FIELDS);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regmap field\n");
+
+	/*
+	 * By default, configure average sample as 1, bus and shunt conversion
+	 * timea as 1037 microsecond, and operating mode to all on.
+	 */
+	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable continuous sensing\n");
+
+	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, rtq6056_remove, dev);
+	if (ret)
+		return ret;
+
+	/* By default, use 2000 micro-ohm resistor */
+	shunt_resistor_uohm = 2000;
+	device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				 &shunt_resistor_uohm);
+
+	ret = rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to init shunt resistor\n");
+
+	indio_dev->name = "rtq6056";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = rtq6056_channels;
+	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
+	indio_dev->info = &rtq6056_info;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      rtq6056_buffer_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to allocate iio trigger buffer\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int rtq6056_runtime_suspend(struct device *dev)
+{
+	struct rtq6056_priv *priv = dev_get_drvdata(dev);
+
+	/* Configure to shutdown mode */
+	return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
+}
+
+static int rtq6056_runtime_resume(struct device *dev)
+{
+	struct rtq6056_priv *priv = dev_get_drvdata(dev);
+	int sample_rdy_time_us, ret;
+
+	ret = regmap_field_write(priv->rm_fields[F_OPMODE], RTQ6056_CONT_ALLON);
+	if (ret)
+		return ret;
+
+	sample_rdy_time_us = priv->vbusct_us + priv->vshuntct_us;
+	sample_rdy_time_us *= priv->avg_sample;
+
+	usleep_range(sample_rdy_time_us, sample_rdy_time_us + 100);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rtq6056_pm_ops = {
+	RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resume, NULL)
+};
+
+static const struct of_device_id rtq6056_device_match[] = {
+	{ .compatible = "richtek,rtq6056" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtq6056_device_match);
+
+static struct i2c_driver rtq6056_driver = {
+	.driver = {
+		.name = "rtq6056",
+		.of_match_table = rtq6056_device_match,
+		.pm = pm_ptr(&rtq6056_pm_ops),
+	},
+	.probe_new = rtq6056_probe,
+};
+module_i2c_driver(rtq6056_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTQ6056 Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


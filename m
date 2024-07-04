Return-Path: <linux-iio+bounces-7328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4C927C68
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C840828481C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120FC61FFE;
	Thu,  4 Jul 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2FKf7OM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1C45038;
	Thu,  4 Jul 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114938; cv=none; b=W/mNhhYlXoZPLBEgQFZMEetubI4/S10pNuUoi4XatHVeVcqfqC4OrWcKdl8LjiO8WKKKwq3Q2IIgzon4bT13VwrlvqBD7C6XSNCjUqVHar9U/G6GQvV/S+KkFwJcB7GnGQxCReHIwbb4y7q773jjhBvCF9FnFAcWXh0iRfD3j3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114938; c=relaxed/simple;
	bh=DB58UAk+ZaG4En51DaC/4yhfA8h1xsc4ysU/MOe9hp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llalACIbJsz6KK2F6PocBpQ/G4dUaCDCQ00lD0cxkSonV/kpxOlxPFYuJFWWLxIC2jZjbtls5sAz33KcwtLH4zEG7vRMp6vV15X4yvmHtIUSrg7uFHoA+Ic/4gWWl7hT3wJFmkLpugYZO2OhHq0PtFHqqgh9t+LzaZ3zK+zJpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2FKf7OM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so5745685e9.1;
        Thu, 04 Jul 2024 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114934; x=1720719734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H/cpC4QkVjr17u95nafI/MIJWj/KJjqGVGnAae1ItQ=;
        b=V2FKf7OM8u2yhl+YPrqM3L+V1YgRIqru1kPfoiEqVzH3KrjW3hMMHB3/oLWHKZZFYa
         c2Obxc1FP2z4zbJzzKxNYjUqR1uOSOx9ATxfyy+KllptBKbXdv7THLGZy50r+5G/+jfu
         1bBSDFpkol/fyitPLcdbC2GHhDDdiic6CDhtk4qE7AbTzFLJf79YFsb/31euAP/6vTcH
         1rvYB7kXtVw8RLouAjovMAih0SaKLCM5H/8PaHTiONhLUbrNZ7qRc7o4SSkU/2JGPd+e
         RI3vIkItw5IUA7/cHUEoO1dVQmj+GKBmcYMu1rkSAkztnzbJcLImD/fLCcyStjIyUiD5
         hlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114934; x=1720719734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H/cpC4QkVjr17u95nafI/MIJWj/KJjqGVGnAae1ItQ=;
        b=Klv/W9vv86Elhx5NjsQbl+ADuHJ0o70oVBX0+65icyQWrGVpEg/ZgGP0jyKhmIgdBm
         2AJo6TOreoNpM3buJLXd8sCwmrlNGAUeLWjmFY9mJNZ5sF9S/fk8/ZfljFxUoqRm/xeF
         BJKPEEqA2vqjuCK1v+OUrhesLq6p38C/VDkqcwGLxz0Htx+0IrNWxKeHmGJWHdMovwZF
         XhyL3Qj9BnZr+Xbq0xwHX9RptW/NrfpyOSvLOLBjfEW1Tfmba5nzGfGKFL1bkO89Hv8G
         mT5nN8LgndXBgS0qdFWqaP8BZNbVKpSBV68xyPdW4PSpm5ist6sJgJ6hxQ7fYtnxQboh
         fdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXArrpvLNCx6GkgnQ4EKPtuZO+W5F11eCLPaGZP3/srR2IepGpzRClKjUVq9BpjP8zbpgoUxXlK3q66O1NOgJo5Zfo6eFY/WKAta78p0DaiD5Gz2MMnS+ZUVrnlWp+1t1LWKHvOMdNh0A==
X-Gm-Message-State: AOJu0Yyoxy6Q7er38z/IX5oBVTt74M3k0ZohF8243jcoLlaYkHVV0sVd
	xARHZfwFbbjNPbN86z8JYZi5fQDmUQ97FR4kds9+hY6z9WWkHVcV
X-Google-Smtp-Source: AGHT+IGOm6NMacuJj2tpHHL3S4uxabWximYA9AniaJa6XmtliEZujdRtWknRwu0F9Vefwc4C7piY8w==
X-Received: by 2002:a05:600c:3107:b0:424:aa5a:280e with SMTP id 5b1f17b1804b1-4264b124440mr20938375e9.8.1720114933912;
        Thu, 04 Jul 2024 10:42:13 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0b24sm32173185e9.3.2024.07.04.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:42:13 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 04 Jul 2024 19:42:02 +0200
Subject: [PATCH v2 2/2] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
In-Reply-To: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.13.0

Add support for Microchip PAC1921 Power/Current monitor.

Implemented features:
* capture of bus voltage, sense voltage, current and power measurements
  in free-run integration mode
* support for both raw and triggered buffer reading
* support for overflow events
* userspace controls for voltage and current gains, measurement
  resolution, integration samples and filters enabling/disabling
* simple power management support

Limitations:
* operation mode fixed to free-run integration
* measurement resolution and filters controls are applied to both VSENSE
  and VBUS measurements

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-pac1921          |   45 +
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1921.c                          | 1038 ++++++++++++++++++++
 5 files changed, 1101 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
new file mode 100644
index 000000000000..4a32e2d4207b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
@@ -0,0 +1,45 @@
+What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		ADC measurement resolution. Can be either 11 bits or 14 bits
+		(default). The driver sets the same resolution for both VBUS and
+		VSENSE measurements even if the hardware could be configured to
+		measure VBUS and VSENSE with different resolutions.
+		This attribute affects the integration time: with 14 bits
+		resolution the integration time is increased by a factor of
+		1.9 (the driver considers a factor of 2). See Table 4-5 in
+		device datasheet for details.
+
+What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits_available
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List all possible ADC measurement resolutions: "11 14"
+
+What:		/sys/bus/iio/devices/iio:deviceX/integration_samples
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of samples taken during a full integration period. Can be
+		set to any power of 2 value from 1 (default) to 2048.
+		This attribute affects the integration time: higher the number
+		of samples, longer the integration time. See Table 4-5 in device
+		datasheet for details.
+
+What:		/sys/bus/iio/devices/iio:deviceX/integration_samples_available
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List all possible numbers of integration samples:
+		"1 2 4 8 16 32 64 128 256 512 1024 2048"
+
+What:		/sys/bus/iio/devices/iio:devices/filters_en
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Attribute to enable/disable ADC post filters. Enabled by
+		default.
+		This attribute affects the integration time: with filters
+		enabled the integration time is increased by 50%. See Table 4-5
+		in device datasheet for details.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0cbeb03847f5..a737dc00e29c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14793,6 +14793,13 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
+MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
+M:	Matteo Martelli <matteomartelli3@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
+F:	drivers/iio/adc/pac1921.c
+
 MICROCHIP PAC1934 POWER/ENERGY MONITOR DRIVER
 M:	Marius Cristea <marius.cristea@microchip.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..b56e494da970 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -991,6 +991,16 @@ config NPCM_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called npcm_adc.
 
+config PAC1921
+	tristate "Microchip Technology PAC1921 driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Microchip Technology's PAC1921
+	  High-Side Power/Current Monitor with Analog Output.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pac1921.
+
 config PAC1934
 	tristate "Microchip Technology PAC1934 driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d370e066544e..5af30eeff262 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
 obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
+obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
new file mode 100644
index 000000000000..879753466093
--- /dev/null
+++ b/drivers/iio/adc/pac1921.c
@@ -0,0 +1,1038 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for PAC1921 High-Side Power/Current Monitor
+ *
+ * Copyright (C) 2024 Matteo Martelli <matteomartelli3@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/regmap.h>
+
+/* pac1921 registers */
+#define PAC1921_REG_GAIN_CFG		0x00
+#define PAC1921_REG_INT_CFG		0x01
+#define PAC1921_REG_CONTROL		0x02
+#define PAC1921_REG_VBUS		0x10
+#define PAC1921_REG_VSENSE		0x12
+#define PAC1921_REG_OVERFLOW_STS	0x1C
+#define PAC1921_REG_VPOWER		0x1D
+
+/* pac1921 gain configuration bits */
+#define PAC1921_GAIN_I_RES		BIT(7)
+#define PAC1921_GAIN_V_RES		BIT(6)
+#define PAC1921_GAIN_DI_GAIN_SHIFT	3
+#define PAC1921_GAIN_DI_GAIN_MASK	GENMASK(5, PAC1921_GAIN_DI_GAIN_SHIFT)
+#define PAC1921_GAIN_DI_GAIN_MAX	7
+#define PAC1921_GAIN_DV_GAIN_SHIFT	0
+#define PAC1921_GAIN_DV_GAIN_MASK	GENMASK(2, PAC1921_GAIN_DV_GAIN_SHIFT)
+#define PAC1921_GAIN_DV_GAIN_MAX	5
+
+/* pac1921 integration configuration bits */
+#define PAC1921_INT_CFG_SMPL_SHIFT	4
+#define PAC1921_INT_CFG_SMPL_MASK	GENMASK(7, PAC1921_INT_CFG_SMPL_SHIFT)
+#define PAC1921_INT_CFG_SMPL_MAX	11
+#define PAC1921_INT_CFG_VSFEN		BIT(3)
+#define PAC1921_INT_CFG_VBFEN		BIT(2)
+#define PAC1921_INT_CFG_RIOV		BIT(1)
+#define PAC1921_INT_CFG_INTEN		BIT(0)
+
+/* pac1921 control bits */
+#define PAC1921_CONTROL_MXSL_SHIFT	6
+enum pac1921_mxsl {
+	PAC1921_MXSL_VPOWER_PIN = 0,
+	PAC1921_MXSL_VSENSE_FREE_RUN = 1,
+	PAC1921_MXSL_VBUS_FREE_RUN = 2,
+	PAC1921_MXSL_VPOWER_FREE_RUN = 3,
+};
+#define PAC1921_CONTROL_SLEEP		BIT(2)
+
+/* pac1921 overflow status bits */
+#define PAC1921_OVERFLOW_VSOV		BIT(2)
+#define PAC1921_OVERFLOW_VBOV		BIT(1)
+#define PAC1921_OVERFLOW_VPOV		BIT(0)
+
+/* pac1921 constants */
+#define PAC1921_MAX_VSENSE_MV		100
+#define PAC1921_MAX_VBUS_V		32
+#define PAC1921_RES_RESOLUTION		1023 /* Result registers resolution */
+
+/* pac1921 defaults */
+#define PAC1921_DEFAULT_DV_GAIN		0 /* 2^(value): 1x gain */
+#define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain */
+#define PAC1921_DEFAULT_HIGH_RES	true /* 14-bit measurement resolution */
+#define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample */
+#define PAC1921_DEFAULT_FILTERS_ENABLED true
+
+/* pac1921 tables to create iio available parameters */
+static const unsigned int pac1921_di_gains[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+static const unsigned int pac1921_dv_gains[] = { 1, 2, 4, 8, 16, 32 };
+enum pac1921_meas_resolution_idx {
+	PAC1921_MEAS_RESOLUTION_IDX_LOW = 0,
+	PAC1921_MEAS_RESOLUTION_IDX_HIGH,
+};
+static const char *const pac1921_meas_resolutions[] = { "11", "14" };
+static const char *const pac1921_integr_num_samples[] = {
+	"1",  "2",   "4",   "8",   "16",   "32",
+	"64", "128", "256", "512", "1024", "2048"
+};
+
+/* pac1921 regmap configuration */
+static const struct regmap_range pac1921_regmap_wr_ranges[] = {
+	regmap_reg_range(PAC1921_REG_GAIN_CFG, PAC1921_REG_CONTROL),
+};
+static const struct regmap_access_table pac1921_regmap_wr_table = {
+	.yes_ranges = pac1921_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pac1921_regmap_wr_ranges),
+};
+static const struct regmap_range pac1921_regmap_rd_ranges[] = {
+	regmap_reg_range(PAC1921_REG_GAIN_CFG, PAC1921_REG_CONTROL),
+	regmap_reg_range(PAC1921_REG_VBUS, PAC1921_REG_VPOWER + 1),
+};
+static const struct regmap_access_table pac1921_regmap_rd_table = {
+	.yes_ranges = pac1921_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pac1921_regmap_rd_ranges),
+};
+static const struct regmap_config pac1921_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &pac1921_regmap_rd_table,
+	.wr_table = &pac1921_regmap_wr_table,
+};
+
+enum pac1921_channels {
+	PAC1921_CHAN_VBUS = 0,
+	PAC1921_CHAN_VSENSE = 1,
+	PAC1921_CHAN_CURRENT = 2,
+	PAC1921_CHAN_POWER = 3,
+};
+#define PAC1921_NUM_MEAS_CHANS 4
+
+struct pac1921_priv {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct regulator *vdd;
+	struct iio_info iio_info;
+
+	/* Synchronize access to private members, and ensure atomicity of
+	 * consecutive regmap operations.
+	 */
+	struct mutex lock;
+
+	u32 rshunt; /* uOhm */
+	bool high_res;
+	u8 dv_gain;
+	u8 di_gain;
+	u8 n_samples;
+	bool filters_en;
+	u8 prev_ovf_flags;
+
+	bool first_integr_started;
+	bool first_integr_done;
+	unsigned long integr_start_time; /* jiffies */
+	unsigned int integr_period; /* usecs */
+
+	struct {
+		u16 chan[PAC1921_NUM_MEAS_CHANS];
+		s64 timestamp __aligned(8);
+	} scan;
+};
+
+/* The integration period depends on the configuration of number of integration
+ * samples, measurement resolution and post filters. The following array
+ * contains integration periods, in microsecs unit, based on table 4-5 from
+ * datasheet considering power integration mode, 11-Bit resolution and post
+ * filters off. Each index corresponds to a specific number of samples from 1
+ * to 2048.
+ */
+static const unsigned int pac1921_integr_periods_us[] = {
+	930,   1460,  2410,   4320,   8050,   16100,
+	32100, 64200, 128300, 257000, 513000, 1026000
+};
+
+/* Calculate and update the integration period
+ *
+ * The base integration period is retrieved from pac1921_integr_periods_us
+ * array, then doubled if 14-Bit resolution is used (even if the actual
+ * increase factor is about 1.9) and increased by 50% if post filters are
+ * enabled.
+ *
+ * Must be called with lock held.
+ */
+static int pac1921_update_integr_period(struct pac1921_priv *priv)
+{
+	if (WARN_ON_ONCE(priv->n_samples >=
+			 ARRAY_SIZE(pac1921_integr_periods_us)))
+		return -EINVAL;
+
+	priv->integr_period = pac1921_integr_periods_us[priv->n_samples];
+	if (priv->high_res)
+		priv->integr_period *= 2;
+	if (priv->filters_en)
+		priv->integr_period += priv->integr_period / 2;
+
+	return 0;
+}
+
+/* Check if first integration after configuration update has completed.
+ *
+ * Must be called with lock held.
+ */
+static bool pac1921_data_ready(struct pac1921_priv *priv)
+{
+	if (!priv->first_integr_started)
+		return false;
+
+	if (!priv->first_integr_done) {
+		unsigned long t_ready = priv->integr_start_time +
+					usecs_to_jiffies(priv->integr_period);
+		if (time_before(jiffies, t_ready))
+			/* First integration not completed: data not ready */
+			return false;
+
+		priv->first_integr_done = true;
+	}
+
+	return true;
+}
+
+/* Check if overflow occurred and if so, push the corresponding events.
+ *
+ * Must be called with lock held.
+ */
+static int pac1921_check_push_overflow(struct iio_dev *indio_dev, s64 timestamp)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	unsigned int flags;
+
+	int ret = regmap_read(priv->regmap, PAC1921_REG_OVERFLOW_STS, &flags);
+	if (ret)
+		return ret;
+
+	if (flags & PAC1921_OVERFLOW_VBOV &&
+	    !(priv->prev_ovf_flags & PAC1921_OVERFLOW_VBOV)) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				       IIO_VOLTAGE, PAC1921_CHAN_VBUS,
+				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+			       timestamp);
+	}
+	if (flags & PAC1921_OVERFLOW_VSOV &&
+	    !(priv->prev_ovf_flags & PAC1921_OVERFLOW_VSOV)) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				       IIO_VOLTAGE, PAC1921_CHAN_VSENSE,
+				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+			       timestamp);
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				       IIO_CURRENT, PAC1921_CHAN_CURRENT,
+				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+			       timestamp);
+	}
+	if (flags & PAC1921_OVERFLOW_VPOV &&
+	    !(priv->prev_ovf_flags & PAC1921_OVERFLOW_VPOV)) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				       IIO_POWER, PAC1921_CHAN_POWER,
+				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+			       timestamp);
+	}
+
+	priv->prev_ovf_flags = (u8)flags;
+
+	return 0;
+}
+
+/* Read the value from a result register
+ *
+ * Result registers contain the most recent averaged values of Vbus, Vsense and
+ * Vpower. Each value is 10 bits wide and spread across two consecutive 8 bit
+ * registers, with 6 bit LSB zero padding.
+ */
+static int pac1921_read_res(struct pac1921_priv *priv, unsigned long reg,
+			    int *val)
+{
+	u8 val_buf[2];
+
+	int ret = regmap_bulk_read(priv->regmap, (unsigned int)reg, &val_buf,
+				   sizeof(val_buf));
+	if (ret)
+		return ret;
+
+	*val = (val_buf[0] << 8 | val_buf[1]) >> 6;
+
+	return 0;
+}
+
+/* Get the Vsense LSB in nV
+ *
+ * Used to calculate scale factors for current and power measurements
+ */
+static inline int pac1921_vsense_lsb(u8 di_gain)
+{
+	int max = (PAC1921_MAX_VSENSE_MV * 1000000) >> (int)di_gain;
+
+	return DIV_ROUND_CLOSEST(max, PAC1921_RES_RESOLUTION);
+}
+
+static int pac1921_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&priv->lock);
+
+		if (!pac1921_data_ready(priv))
+			return -EBUSY;
+
+		s64 ts = iio_get_time_ns(indio_dev);
+
+		int ret = pac1921_check_push_overflow(indio_dev, ts);
+		if (ret)
+			return ret;
+
+		ret = pac1921_read_res(priv, chan->address, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case PAC1921_CHAN_VBUS: {
+			/* Vbus scale factor in mV:
+			 * max_vbus (mV) / vgain / resolution
+			 */
+			guard(mutex)(&priv->lock);
+
+			*val = PAC1921_MAX_VBUS_V * 1000;
+			*val2 = PAC1921_RES_RESOLUTION << (int)priv->dv_gain;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+		case PAC1921_CHAN_VSENSE: {
+			/* Vsense voltage scale factor in mV:
+			 * max_vsense (mV) / igain / resolution
+			 */
+			guard(mutex)(&priv->lock);
+
+			*val = PAC1921_MAX_VSENSE_MV;
+			*val2 = PAC1921_RES_RESOLUTION << (int)priv->di_gain;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+		case PAC1921_CHAN_CURRENT: {
+			/* Current scale factor in mA:
+			 * Vsense LSB (nV) / shunt (uOhm)
+			 */
+			guard(mutex)(&priv->lock);
+
+			*val = pac1921_vsense_lsb(priv->di_gain);
+			*val2 = (int)priv->rshunt;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+		case PAC1921_CHAN_POWER: {
+			/* Power scale factor in mW:
+			 * Vsense LSB (nV) * max_vbus (V) / vgain / shunt (uOhm)
+			 */
+			guard(mutex)(&priv->lock);
+
+			*val = pac1921_vsense_lsb(priv->di_gain) *
+			       (PAC1921_MAX_VBUS_V >> (int)priv->dv_gain);
+			*val2 = (int)priv->rshunt;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		switch (chan->channel) {
+		case PAC1921_CHAN_VBUS: {
+			guard(mutex)(&priv->lock);
+			*val = 1 << (int)priv->dv_gain;
+			return IIO_VAL_INT;
+		}
+		case PAC1921_CHAN_VSENSE:
+		case PAC1921_CHAN_CURRENT: {
+			guard(mutex)(&priv->lock);
+			*val = 1 << (int)priv->di_gain;
+			return IIO_VAL_INT;
+		}
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_INT_TIME: {
+		/* Integration time is read only: it depends on the number of
+		 * integration samples, measurement resolution and post filters
+		 */
+		*val2 = 1000000; /* From usecs to fractional secs */
+		guard(mutex)(&priv->lock);
+		*val = (int)priv->integr_period;
+		return IIO_VAL_FRACTIONAL;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Perform configuration update sequence: set the device into read state, then
+ * write the config register and set the device back into integration state.
+ * Also reset integration start time and mark first integration to be yet
+ * completed.
+ *
+ * Must be called with lock held.
+ */
+static int pac1921_update_cfg_reg(struct pac1921_priv *priv, unsigned int reg,
+				  unsigned int mask, unsigned int val)
+{
+	/* Enter READ state before configuration */
+	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
+				     PAC1921_INT_CFG_INTEN, 0);
+	if (ret)
+		return ret;
+
+	/* Update configuration value */
+	ret = regmap_update_bits(priv->regmap, reg, mask, val);
+	if (ret)
+		return ret;
+
+	/* Re-enable integration and reset start time */
+	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
+				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
+	if (ret)
+		return ret;
+
+	priv->integr_start_time = jiffies;
+	priv->first_integr_done = false;
+
+	return 0;
+}
+
+static inline bool pac1921_gain_param_valid(unsigned int gain, unsigned int max)
+{
+	return (gain > 0 && gain <= (1U << max) && is_power_of_2(gain));
+}
+
+static int pac1921_update_gain(struct pac1921_priv *priv,
+			       struct iio_chan_spec const *chan, int val)
+{
+	unsigned int max;
+	unsigned int mask;
+	unsigned int shift;
+	u8 *priv_val;
+
+	switch (chan->channel) {
+	case PAC1921_CHAN_VBUS:
+		max = PAC1921_GAIN_DV_GAIN_MAX;
+		mask = PAC1921_GAIN_DV_GAIN_MASK;
+		shift = PAC1921_GAIN_DV_GAIN_SHIFT;
+		priv_val = &priv->dv_gain;
+		break;
+	case PAC1921_CHAN_VSENSE:
+	case PAC1921_CHAN_CURRENT:
+		max = PAC1921_GAIN_DI_GAIN_MAX;
+		mask = PAC1921_GAIN_DI_GAIN_MASK;
+		shift = PAC1921_GAIN_DI_GAIN_SHIFT;
+		priv_val = &priv->di_gain;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	unsigned int gain_param = (unsigned int)val;
+
+	if (!pac1921_gain_param_valid(gain_param, max))
+		return -EINVAL;
+
+	u8 gain = (u8)ilog2(gain_param);
+
+	guard(mutex)(&priv->lock);
+
+	if (*priv_val == gain)
+		return 0;
+
+	int ret = pac1921_update_cfg_reg(priv, PAC1921_REG_GAIN_CFG, mask,
+					 gain << shift);
+	if (ret)
+		return ret;
+
+	*priv_val = gain;
+
+	return 0;
+}
+
+static int pac1921_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return pac1921_update_gain(priv, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1921_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		switch (chan->channel) {
+		case PAC1921_CHAN_VBUS:
+			*length = ARRAY_SIZE(pac1921_dv_gains);
+			*vals = pac1921_dv_gains;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_VSENSE:
+		case PAC1921_CHAN_CURRENT:
+			*length = ARRAY_SIZE(pac1921_di_gains);
+			*vals = pac1921_di_gains;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1921_read_label(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, char *label)
+{
+	switch (chan->channel) {
+	case PAC1921_CHAN_VBUS:
+		return sprintf(label, "vbus\n");
+	case PAC1921_CHAN_VSENSE:
+		return sprintf(label, "vsense\n");
+	case PAC1921_CHAN_CURRENT:
+		return sprintf(label, "current\n");
+	case PAC1921_CHAN_POWER:
+		return sprintf(label, "power\n");
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info pac1921_iio = {
+	.read_raw = pac1921_read_raw,
+	.write_raw = pac1921_write_raw,
+	.read_avail = pac1921_read_avail,
+	.read_label = pac1921_read_label,
+};
+
+static int pac1921_get_resolution(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	guard(mutex)(&priv->lock);
+
+	if (priv->high_res)
+		return PAC1921_MEAS_RESOLUTION_IDX_HIGH;
+
+	return PAC1921_MEAS_RESOLUTION_IDX_LOW;
+}
+
+static int pac1921_set_resolution(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int val)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	bool high_res;
+
+	switch (val) {
+	case PAC1921_MEAS_RESOLUTION_IDX_LOW:
+		high_res = false;
+		break;
+	case PAC1921_MEAS_RESOLUTION_IDX_HIGH:
+		high_res = true;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&priv->lock);
+
+	if (priv->high_res == high_res)
+		return 0;
+
+	unsigned int mask = PAC1921_GAIN_I_RES | PAC1921_GAIN_V_RES;
+	unsigned int bits = high_res ?
+			    0 : PAC1921_GAIN_I_RES | PAC1921_GAIN_V_RES;
+
+	int ret = pac1921_update_cfg_reg(priv, PAC1921_REG_GAIN_CFG,
+					 mask, bits);
+	if (ret)
+		return ret;
+
+	priv->high_res = high_res;
+
+	return pac1921_update_integr_period(priv);
+}
+
+static int pac1921_get_int_num_samples(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	guard(mutex)(&priv->lock);
+
+	return priv->n_samples;
+}
+
+static int pac1921_set_int_num_samples(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       unsigned int val)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	if (WARN_ON_ONCE(val > PAC1921_INT_CFG_SMPL_MAX))
+		return -EINVAL;
+
+	guard(mutex)(&priv->lock);
+
+	if (priv->n_samples == val)
+		return 0;
+
+	int ret = pac1921_update_cfg_reg(priv, PAC1921_REG_INT_CFG,
+					 PAC1921_INT_CFG_SMPL_MASK,
+					 val << PAC1921_INT_CFG_SMPL_SHIFT);
+	if (ret)
+		return ret;
+
+	priv->n_samples = (u8)val;
+
+	return pac1921_update_integr_period(priv);
+}
+
+static ssize_t pac1921_read_filters_enabled(struct iio_dev *indio_dev,
+					    uintptr_t private,
+					    const struct iio_chan_spec *chan,
+					    char *buf)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	bool enabled;
+
+	scoped_guard(mutex, &priv->lock) {
+		enabled = priv->filters_en;
+	}
+	return sysfs_emit(buf, "%d\n", enabled);
+}
+
+static ssize_t pac1921_write_filters_enabled(struct iio_dev *indio_dev,
+					     uintptr_t private,
+					     const struct iio_chan_spec *chan,
+					     const char *buf, size_t len)
+{
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	bool enabled;
+
+	int ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&priv->lock);
+
+	if (priv->filters_en == enabled)
+		return len;
+
+	unsigned int mask = PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN;
+	unsigned int bits = enabled ?
+			    PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN : 0;
+
+
+	ret = pac1921_update_cfg_reg(priv, PAC1921_REG_INT_CFG, mask, bits);
+	if (ret)
+		return ret;
+
+	priv->filters_en = enabled;
+
+	ret = pac1921_update_integr_period(priv);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static const struct iio_enum pac1921_resolution_enum = {
+	.items = pac1921_meas_resolutions,
+	.num_items = ARRAY_SIZE(pac1921_meas_resolutions),
+	.get = pac1921_get_resolution,
+	.set = pac1921_set_resolution,
+};
+static const struct iio_enum pac1921_int_num_samples_enum = {
+	.items = pac1921_integr_num_samples,
+	.num_items = ARRAY_SIZE(pac1921_integr_num_samples),
+	.get = pac1921_get_int_num_samples,
+	.set = pac1921_set_int_num_samples,
+};
+static const struct iio_chan_spec_ext_info pac1921_ext_info[] = {
+	IIO_ENUM("resolution_bits", IIO_SHARED_BY_ALL,
+		 &pac1921_resolution_enum),
+	IIO_ENUM_AVAILABLE("resolution_bits", IIO_SHARED_BY_ALL,
+			   &pac1921_resolution_enum),
+	IIO_ENUM("integration_samples", IIO_SHARED_BY_ALL,
+		 &pac1921_int_num_samples_enum),
+	IIO_ENUM_AVAILABLE("integration_samples", IIO_SHARED_BY_ALL,
+			   &pac1921_int_num_samples_enum),
+	{
+		.name = "filters_en",
+		.read = pac1921_read_filters_enabled,
+		.write = pac1921_write_filters_enabled,
+		.shared = IIO_SHARED_BY_ALL,
+	},
+	{},
+};
+
+static const struct iio_event_spec pac1921_overflow_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+	},
+};
+
+static const struct iio_chan_spec pac1921_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.channel = PAC1921_CHAN_VBUS,
+		.address = PAC1921_REG_VBUS,
+		.scan_index = PAC1921_CHAN_VBUS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+			.endianness = IIO_CPU
+		},
+		.indexed = 1,
+		.event_spec = pac1921_overflow_event,
+		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
+		.ext_info = pac1921_ext_info,
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.channel = PAC1921_CHAN_VSENSE,
+		.address = PAC1921_REG_VSENSE,
+		.scan_index = PAC1921_CHAN_VSENSE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+			.endianness = IIO_CPU
+		},
+		.indexed = 1,
+		.event_spec = pac1921_overflow_event,
+		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
+		.ext_info = pac1921_ext_info,
+	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.channel = PAC1921_CHAN_CURRENT,
+		.address = PAC1921_REG_VSENSE,
+		.scan_index = PAC1921_CHAN_CURRENT,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+			.endianness = IIO_CPU
+		},
+		.event_spec = pac1921_overflow_event,
+		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
+		.ext_info = pac1921_ext_info,
+	},
+	{
+		.type = IIO_POWER,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.channel = PAC1921_CHAN_POWER,
+		.address = PAC1921_REG_VPOWER,
+		.scan_index = PAC1921_CHAN_POWER,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+			.endianness = IIO_CPU
+		},
+		.event_spec = pac1921_overflow_event,
+		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
+		.ext_info = pac1921_ext_info,
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(PAC1921_NUM_MEAS_CHANS),
+};
+
+static irqreturn_t pac1921_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *idev = pf->indio_dev;
+	struct pac1921_priv *priv = iio_priv(idev);
+
+	guard(mutex)(&priv->lock);
+
+	if (!pac1921_data_ready(priv))
+		goto done;
+
+	int ret = pac1921_check_push_overflow(idev, pf->timestamp);
+	if (ret)
+		goto done;
+
+	memset(&priv->scan, 0, sizeof(priv->scan));
+
+	int bit, ch = 0;
+	for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {
+		int val;
+
+		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
+		if (ret)
+			goto done;
+
+		priv->scan.chan[ch++] = (u16)val;
+	}
+
+	iio_push_to_buffers_with_timestamp(idev, &priv->scan, pf->timestamp);
+
+done:
+	iio_trigger_notify_done(idev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int pac1921_init(struct pac1921_priv *priv)
+{
+	/* Time after power-up before ready to begin communications */
+	msleep(20);
+
+	/* Enter READ state before configuration */
+	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
+				 PAC1921_INT_CFG_INTEN, 0);
+	if (ret)
+		return ret;
+
+	/* Configure gains and measurements resolution */
+	unsigned int val = priv->di_gain << PAC1921_GAIN_DI_GAIN_SHIFT |
+			   priv->dv_gain << PAC1921_GAIN_DV_GAIN_SHIFT;
+	if (!priv->high_res)
+		val |= PAC1921_GAIN_I_RES | PAC1921_GAIN_V_RES;
+	ret = regmap_write(priv->regmap, PAC1921_REG_GAIN_CFG, val);
+	if (ret)
+		return ret;
+
+	/* Configure integration:
+	 * - num of integration samples, filters enabled/disabled
+	 * - set READ/INT pin override (RIOV) to control operation mode via
+	 *   register instead of pin
+	 */
+	val = priv->n_samples << PAC1921_INT_CFG_SMPL_SHIFT |
+	      PAC1921_INT_CFG_RIOV;
+	if (priv->filters_en)
+		val |= PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN;
+	ret = regmap_write(priv->regmap, PAC1921_REG_INT_CFG, val);
+	if (ret)
+		return ret;
+
+	/* Init control register:
+	 * - VPower free run integration mode
+	 * - OUT pin full scale range: 3V (HW detault)
+	 * - no timeout, no sleep, no sleep override, no recalc (HW defaults)
+	 */
+	val = PAC1921_MXSL_VPOWER_FREE_RUN << PAC1921_CONTROL_MXSL_SHIFT;
+	ret = regmap_write(priv->regmap, PAC1921_REG_CONTROL, val);
+	if (ret)
+		return ret;
+
+	/* Enable integration */
+	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
+				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
+	if (ret)
+		return ret;
+
+	priv->first_integr_started = true;
+	priv->integr_start_time = jiffies;
+
+	return pac1921_update_integr_period(priv);
+}
+
+static int pac1921_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	guard(mutex)(&priv->lock);
+
+	priv->first_integr_started = false;
+	priv->first_integr_done = false;
+
+	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
+				     PAC1921_INT_CFG_INTEN, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, PAC1921_REG_CONTROL,
+				 PAC1921_CONTROL_SLEEP, PAC1921_CONTROL_SLEEP);
+	if (ret)
+		return ret;
+
+	return regulator_disable(priv->vdd);
+
+}
+
+static int pac1921_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+
+	guard(mutex)(&priv->lock);
+
+	int ret = regulator_enable(priv->vdd);
+	if (ret)
+		return ret;
+
+	return pac1921_init(priv);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pac1921_pm_ops, pac1921_suspend,
+				pac1921_resume);
+
+static void pac1921_regulator_disable(void *data)
+{
+	struct pac1921_priv *priv = data;
+
+	regulator_disable(priv->vdd);
+}
+
+static int pac1921_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pac1921_priv *priv;
+
+	struct iio_dev *indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->client = client;
+	i2c_set_clientdata(client, indio_dev);
+
+	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
+	if (IS_ERR(priv->regmap))
+		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
+			      "Cannot initialize register map\n");
+
+	mutex_init(&priv->lock);
+
+	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
+	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
+	priv->high_res = PAC1921_DEFAULT_HIGH_RES;
+	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
+	priv->filters_en = PAC1921_DEFAULT_FILTERS_ENABLED;
+
+	int ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+					   &priv->rshunt);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot read shunt resistor property\n");
+	if (priv->rshunt == 0 || priv->rshunt > INT_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid shunt resistor: %u\n",
+				     priv->rshunt);
+
+	priv->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(priv->vdd))
+		return dev_err_probe(dev, (int)PTR_ERR(priv->vdd),
+				     "Cannot get vdd regulator\n");
+
+	ret = regulator_enable(priv->vdd);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot enable vdd regulator\n");
+
+	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable, priv);
+
+	ret = pac1921_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot initialize device\n");
+
+	priv->iio_info = pac1921_iio;
+
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+
+	indio_dev->name = id->name;
+	indio_dev->info = &priv->iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = pac1921_channels;
+	indio_dev->num_channels = ARRAY_SIZE(pac1921_channels);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &pac1921_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot setup IIO triggered buffer\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id pac1921_id[] = {
+	{ .name = "pac1921", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pac1921_id);
+
+static const struct of_device_id pac1921_of_match[] = {
+	{ .compatible = "microchip,pac1921" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pac1921_of_match);
+
+static struct i2c_driver pac1921_driver = {
+	.driver	 = {
+		.name = "pac1921",
+		.pm = pm_sleep_ptr(&pac1921_pm_ops),
+		.of_match_table = pac1921_of_match,
+	},
+	.probe = pac1921_probe,
+	.id_table = pac1921_id,
+};
+
+module_i2c_driver(pac1921_driver);
+
+MODULE_AUTHOR("Matteo Martelli <matteomartelli3@gmail.com>");
+MODULE_DESCRIPTION("IIO driver for PAC1921 High-Side Power/Current Monitor");
+MODULE_LICENSE("GPL");

-- 
2.45.1



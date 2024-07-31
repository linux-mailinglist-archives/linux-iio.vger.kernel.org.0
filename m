Return-Path: <linux-iio+bounces-8102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C211794314E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707E12814CE
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E81B29D6;
	Wed, 31 Jul 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rj8PlHRb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16F1B3742
	for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433693; cv=none; b=dD2HtYfjpiEpZa2IlNqfM0R32pFumc1+nKW4vc8avK9qK/SJl6L1e0dlAvD0xXzWagTbNc+RyBVw5+/2zE2hFy75rEvgIbkq304r7eFS+qgb/CjpzdBEBLr3UUjCM93mjg2Y9jU2MMd5jBDVyCqeTAxxGKXYmq7eATIPz27QRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433693; c=relaxed/simple;
	bh=KmSGIKQZSeNafXsD7q5641e2e3PYC4QxC9JqJq9CPcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2wAUTHZSpryASL+Tw0fHTGDxVvTE7kkSB9BjQkpfQl7To9GULwtzvd/5+9Il4YyTlXNWx9afJWwNCcDC1cObrv6kmfX7SUNLldCG15N3bmt1m9NppL+G2OybnD5yketa2j94Q+oKMk2EMoDMrVnPFruT/D0ICNxwtgZAk11t1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rj8PlHRb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70938328a0aso2440573a34.1
        for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722433689; x=1723038489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VjiyCfgwjK02//6GoHdg64d2wASOuLzZfqUWJQCUHI=;
        b=rj8PlHRb905u1k/Vy2zyWs4RCN5+GQ9hxyTGldHKlrzxbP7vPZooTlAz/O7rpgYdoS
         x0Q2sYMaPaEFvPglTu9ut8v7+ZT6JfLBvRooK6E1NunbK7FSYgye5XzZ7X4DxE/q6NXa
         wbH7M2/kWkTmXWtEgAGUQE+n2FgMljm0hDHXCfSUrACYycW0cuJ7Dn9QLZ3+8wypBlGP
         rNsHCYGCfEhrs2TocsMP/BAkXgnCNt68hOSIvnnfwXR9iyrAvWwQI2GQftQ9RtFeYfGL
         BTQJmnb4TdWCIkrTtk5e0YlEwx8bR5zCUGHdcfO0+Ww39Rp2vTgC9xNYsYbCQKpnR2rK
         YKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433689; x=1723038489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VjiyCfgwjK02//6GoHdg64d2wASOuLzZfqUWJQCUHI=;
        b=ws+I/W7fM+I6Wxkq687ecasUBtfXZf9B82pjLR0Bpd58dRXT+Bg+Kkrh1nFtH9dLnh
         eM6ZjC8q/GUZ/G+jMH3oNVm4TGvrjZFFfbRRV/g1S7atO6qdBD4FnbVfO+E3diMPSjC4
         lz9CrV4SS+GtNqA7bMwMHPmo5tXHn/QNhFU/W2sToZWIqNBSm24FQcrO4DKT0XC6kE5Y
         Ss9+d0+eb2kqAApa5t/OAgsHgWm3vBTwltI546vUFGH6oRx/MJl8InliNBV4seVOk7T7
         yRQrO98Jnig8Cmv/fVx730SyEhOApuMrBcnZkDsBDsYkrJjvjRNi+gGv1m3TvghyBBT3
         hlmA==
X-Gm-Message-State: AOJu0YyZ6VUFM93PzKrrMSgr9DRtRnXJS/lZleKGNY4CzH4YlH2ubi6e
	nH403KCO8HSldcblEa84M3xT+1IolAwmsyx3zpsdldpXl/xCKBj5nIih1MSxaV4=
X-Google-Smtp-Source: AGHT+IEtiQvqWZP5/6OSJH8ScvsJwmeiiFgcMu7COZ+lmQFDIO4pjwnRRIsWA8WCGAzdIri2t2WJDQ==
X-Received: by 2002:a05:6830:4708:b0:709:4065:63e6 with SMTP id 46e09a7af769-70940c156b4mr17249312a34.12.1722433689274;
        Wed, 31 Jul 2024 06:48:09 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955ccsm746209985a.11.2024.07.31.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:48:08 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 31 Jul 2024 09:48:04 -0400
Subject: [PATCH RFC 2/3] iio: adc: ad7625: add driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7625_r1-v1-2-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
In-Reply-To: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

This adds a driver for the ad762x and ad796x family of ADCs. These are
pin-compatible devices using an LVDS interface for data transfer,
capable of sampling at rates of 6 and 10 MSPS, respectively. They also
feature multiple voltage reference options based on the configuration of
the EN1/EN0 pins, which can be set in the devicetree.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  15 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7625.c | 626 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 643 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2361f92751dd..a90972e1c5c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1268,6 +1268,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+F:	drivers/iio/adc/ad7625.c
 
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..e25fb505f545 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -219,6 +219,21 @@ config AD7606_IFACE_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_spi.
 
+config AD7625
+        tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
+        select IIO_BACKEND
+        help
+          Say yes here to build support for Analog Devices:
+	  * AD7625 16-Bit, 6 MSPS PulSAR Analog-to-Digital Converter
+	  * AD7626 16-Bit, 10 MSPS PulSAR Analog-to-Digital Converter
+	  * AD7960 18-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
+	  * AD7961 16-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
+
+          The driver requires the assistance of the AXI ADC IP core to operate.
+
+          To compile this driver as a module, choose M here: the module will be
+          called ad7625.
+
 config AD7766
 	tristate "Analog Devices AD7766/AD7767 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d370e066544e..6bf429ca24ea 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
+obj-$(CONFIG_AD7625) += ad7625.o
 obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7768_1) += ad7768-1.o
 obj-$(CONFIG_AD7780) += ad7780.o
diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
new file mode 100644
index 000000000000..b74760c2fee2
--- /dev/null
+++ b/drivers/iio/adc/ad7625.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Analog Devices Inc. AD7625 ADC driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
+ *
+ * Note that this driver requires the AXI ADC IP block configured for
+ * LVDS to function. See Documentation/iio/ad7625.rst for more information.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#define AD7625_INTERNAL_REF_MV 4096
+#define AD7960_MAX_NBW_FREQ (2 * MEGA)
+
+struct ad7625_timing_spec {
+	/* Max conversion high time (t_{CNVH}). */
+	unsigned int conv_high_ns;
+	/* Max conversion to MSB delay (t_{MSB}). */
+	unsigned int conv_msb_ns;
+};
+
+struct ad7625_chip_info {
+	const char *name;
+	const unsigned int max_sample_rate_hz;
+	const struct ad7625_timing_spec *timing_spec;
+	const struct iio_chan_spec chan_spec;
+	const bool has_power_down_state;
+	const bool has_bandwidth_control;
+	const bool has_internal_vref;
+};
+
+/* AD7625_CHAN_SPEC - Define a chan spec structure for a specific chip */
+#define AD7625_CHAN_SPEC(_bits) {					\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.differential = 1,						\
+	.channel = 0,							\
+	.channel2 = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = 0,						\
+	.scan_type.sign = 's',						\
+	.scan_type.storagebits = _bits > 16 ? 32 : 16,			\
+	.scan_type.realbits = _bits,					\
+}
+
+struct ad7625_state {
+	const struct ad7625_chip_info *info;
+	struct iio_backend *back;
+	/* rate of the clock gated by the "clk_gate" PWM */
+	unsigned long ref_clk_rate_hz;
+	/* PWM burst signal for transferring acquired data to the host */
+	struct pwm_device *clk_gate_pwm;
+	/*
+	 * PWM control signal for initiating data conversion. Analog
+	 * inputs are sampled beginning on this signal's rising edge.
+	 */
+	struct pwm_device *cnv_pwm;
+	unsigned int vref_mv;
+	int sampling_freq_hz;
+	/*
+	 * Optional GPIOs for controlling device state. EN0 and EN1
+	 * determine voltage reference configuration and on/off state.
+	 * EN2 controls the device -3dB bandwidth (and by extension, max
+	 * sample rate). EN3 controls the VCM reference output. EN2 and
+	 * EN3 are only present for the AD796x devices.
+	 */
+	struct gpio_desc *en_gpios[4];
+	bool can_power_down;
+	bool can_refin;
+	bool can_ref_4v096;
+	/*
+	 * Indicate whether the bandwidth can be narrow (9MHz).
+	 * When true, device sample rate must also be < 2MSPS.
+	 */
+	bool can_narrow_bandwidth;
+	/* Indicate whether the bandwidth can be wide (28MHz). */
+	bool can_wide_bandwidth;
+	bool can_ref_5v;
+	bool can_snooze;
+	bool can_test_pattern;
+};
+
+static const struct ad7625_timing_spec ad7625_timing_spec = {
+	.conv_high_ns = 40,
+	.conv_msb_ns = 145,
+};
+
+static const struct ad7625_timing_spec ad7626_timing_spec = {
+	.conv_high_ns = 40,
+	.conv_msb_ns = 80,
+};
+
+/*
+ * conv_msb_ns is set to 0 instead of the datasheet maximum of 200ns to
+ * avoid exceeding the minimum conversion time, i.e. it is effectively
+ * modulo 200 and offset by a full period. Values greater than or equal
+ * to the period would be rejected by the PWM API.
+ */
+static const struct ad7625_timing_spec ad7960_timing_spec = {
+	.conv_high_ns = 80,
+	.conv_msb_ns = 0,
+};
+
+static const struct ad7625_chip_info ad7625_chip_info = {
+	.name = "ad7625",
+	.max_sample_rate_hz = 6 * MEGA,
+	.timing_spec = &ad7625_timing_spec,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_power_down_state = false,
+	.has_bandwidth_control = false,
+	.has_internal_vref = true,
+};
+
+static const struct ad7625_chip_info ad7626_chip_info = {
+	.name = "ad7626",
+	.max_sample_rate_hz = 10 * MEGA,
+	.timing_spec = &ad7626_timing_spec,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_power_down_state = true,
+	.has_bandwidth_control = false,
+	.has_internal_vref = true,
+};
+
+static const struct ad7625_chip_info ad7960_chip_info = {
+	.name = "ad7960",
+	.max_sample_rate_hz = 5 * MEGA,
+	.timing_spec = &ad7960_timing_spec,
+	.chan_spec = AD7625_CHAN_SPEC(18),
+	.has_power_down_state = true,
+	.has_bandwidth_control = true,
+	.has_internal_vref = false,
+};
+
+static const struct ad7625_chip_info ad7961_chip_info = {
+	.name = "ad7961",
+	.max_sample_rate_hz = 5 * MEGA,
+	.timing_spec = &ad7960_timing_spec,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_power_down_state = true,
+	.has_bandwidth_control = true,
+	.has_internal_vref = false,
+};
+
+enum ad7960_mode {
+	AD7960_MODE_POWER_DOWN,
+	AD7960_MODE_SNOOZE,
+	AD7960_MODE_NARROW_BANDWIDTH,
+	AD7960_MODE_WIDE_BANDWIDTH,
+	AD7960_MODE_TEST_PATTERN,
+};
+
+static void ad7625_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
+static int ad7625_set_sampling_freq(struct ad7625_state *st, int freq)
+{
+	u64 target;
+	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
+	int ret;
+
+	cnv_wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+
+	/*
+	 * Make sure that the CNV period doesn't exceed the datasheet
+	 * maximum
+	 */
+	cnv_wf.period_length_ns = clamp(cnv_wf.period_length_ns, 100, 10 * KILO);
+
+	/*
+	 * Use the maximum conversion time t_CNVH from the datasheet as
+	 * the duty_cycle for ref_clk, cnv, and clk_gate
+	 */
+	cnv_wf.duty_length_ns = st->info->timing_spec->conv_high_ns;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_pwm, &cnv_wf, false);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Set up the burst signal for transferring data. period and
+	 * offset should mirror the CNV signal
+	 */
+	clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
+
+	clk_gate_wf.duty_length_ns = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *
+		st->info->chan_spec.scan_type.realbits,
+		st->ref_clk_rate_hz);
+
+	/* max t_MSB from datasheet */
+	clk_gate_wf.duty_offset_ns = st->info->timing_spec->conv_msb_ns;
+
+	ret = pwm_set_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf, false);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: Add a rounding API for PWMs that can simplify this */
+	target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz, freq);
+	st->sampling_freq_hz = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz, target);
+
+	return 0;
+}
+
+static int devm_ad7625_pwm_get(struct device *dev, struct clk *ref_clk,
+				       struct ad7625_state *st)
+{
+	unsigned long ref_clk_rate_hz;
+	int ret;
+
+	st->cnv_pwm = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->cnv_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
+				     "failed to get cnv pwm\n");
+
+	ret = devm_add_action_or_reset(dev, ad7625_pwm_disable, st->cnv_pwm);
+	if (ret)
+		return ret;
+
+	st->clk_gate_pwm = devm_pwm_get(dev, "clk_gate");
+	if (IS_ERR(st->clk_gate_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->clk_gate_pwm),
+				     "failed to get clk_gate pwm\n");
+
+	ret = devm_add_action_or_reset(dev, ad7625_pwm_disable,
+				       st->clk_gate_pwm);
+	if (ret)
+		return ret;
+
+	ref_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(ref_clk))
+		return dev_err_probe(dev, PTR_ERR(ref_clk),
+				     "failed to get ref_clk");
+
+	ref_clk_rate_hz = clk_get_rate(ref_clk);
+	if (!ref_clk_rate_hz)
+		return dev_err_probe(dev, -EINVAL,
+				     "failed to get ref_clk rate");
+
+	st->ref_clk_rate_hz = ref_clk_rate_hz;
+
+	return 0;
+}
+
+static int ad7625_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7625_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->sampling_freq_hz;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = chan->scan_type.realbits - 1;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7625_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7625_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return ad7625_set_sampling_freq(st, val);
+		unreachable();
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7625_info = {
+	.read_raw = ad7625_read_raw,
+	.write_raw = ad7625_write_raw,
+};
+
+static int ad7625_parse_mode(struct device *dev, struct ad7625_state *st, int num_gpios)
+{
+	bool en_always_on[4], en_always_off[4],
+	     en_may_be_on[4], en_may_be_off[4];
+	char en_gpio_buf[4];
+	char always_on_buf[18];
+	int i;
+
+	for (i = 0; i < num_gpios; i++) {
+		snprintf(en_gpio_buf, sizeof(en_gpio_buf), "en%d", i);
+		snprintf(always_on_buf, sizeof(always_on_buf),
+			 "adi,en%d-always-on", i);
+		/* Set the device to 0b0000 (power-down mode) by default */
+		st->en_gpios[i] = devm_gpiod_get_optional(dev, en_gpio_buf,
+							  GPIOD_OUT_LOW);
+		if (IS_ERR(st->en_gpios[i]))
+			return dev_err_probe(dev, PTR_ERR(st->en_gpios[i]),
+					     "failed to get EN%d GPIO\n", i);
+
+		en_always_on[i] = device_property_present(dev, always_on_buf);
+		if (st->en_gpios[i] && en_always_on[i])
+			return dev_err_probe(dev, -EINVAL,
+				"cannot have both adi,en%d-always-on and en%d-gpios\n", i, i);
+
+		en_may_be_off[i] = !en_always_on[i];
+		en_may_be_on[i] = en_always_on[i] || st->en_gpios[i];
+		en_always_off[i] = !en_always_on[i] && !st->en_gpios[i];
+	}
+
+	/*
+	 * Power down is mode 0bXX00, but not all devices have a valid
+	 * power down state.
+	 */
+	st->can_power_down = en_may_be_off[1] && en_may_be_off[0] &&
+			     st->info->has_power_down_state;
+	/*
+	 * The REFIN pin can take a 1.2V (AD762x) or 2.048V (AD796x)
+	 * external reference when the mode is 0bXX01.
+	 */
+	st->can_refin = en_may_be_off[1] && en_may_be_on[0];
+	/* 4.096V can be applied to REF when the EN mode is 0bXX10. */
+	st->can_ref_4v096 = en_may_be_on[1] && en_may_be_off[0];
+
+	/* Avoid AD796x-specific setup if the part is an AD762x */
+	if (num_gpios == 2)
+		return 0;
+
+	/* mode 0b1100 (AD796x) is invalid */
+	if (en_always_on[3] && en_always_on[2] && en_always_off[1] && en_always_off[0])
+		return dev_err_probe(dev, -EINVAL,
+				     "EN GPIOs set to invalid mode 0b1100\n");
+	/*
+	 * 5V can be applied to the AD796x REF pin when the EN mode is
+	 * the same (0bX001 or 0bX101) as for can_refin, and REFIN is
+	 * 0V.
+	 */
+	st->can_ref_5v = st->can_refin;
+	/*
+	 * Bandwidth (AD796x) is controlled solely by EN2. If it's
+	 * specified and not hard-wired, then we can configure it to
+	 * change the bandwidth between 28MHz and 9MHz.
+	 */
+	st->can_narrow_bandwidth = en_may_be_on[2];
+	/* Wide bandwidth mode is possible if EN2 can be 0. */
+	st->can_wide_bandwidth = en_may_be_off[2];
+	/* Snooze mode (AD796x) is 0bXX11 when REFIN = 0V. */
+	st->can_snooze = en_may_be_on[1] && en_may_be_on[0];
+	/* Test pattern mode (AD796x) is 0b0100. */
+	st->can_test_pattern = en_may_be_off[3] && en_may_be_on[2] &&
+			       en_may_be_off[1] && en_may_be_off[0];
+
+	return 0;
+}
+
+/* Set EN1 and EN0 based on reference voltage source */
+static void ad7625_set_en_gpios_for_vref(struct ad7625_state *st, bool have_refin, int ref_mv)
+{
+	if (have_refin || ref_mv == 5000) {
+		gpiod_set_value_cansleep(st->en_gpios[1], 0);
+		gpiod_set_value_cansleep(st->en_gpios[0], 1);
+	} else if (ref_mv == 4096) {
+		gpiod_set_value_cansleep(st->en_gpios[1], 1);
+		gpiod_set_value_cansleep(st->en_gpios[0], 0);
+	/*
+	 * Unreachable by AD796x, since the driver will error if neither
+	 * REF nor REFIN is provided
+	 */
+	} else {
+		gpiod_set_value_cansleep(st->en_gpios[1], 1);
+		gpiod_set_value_cansleep(st->en_gpios[0], 1);
+	}
+}
+
+static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
+			   bool have_refin, int ref_mv)
+{
+	switch (mode) {
+	case AD7960_MODE_POWER_DOWN:
+		if (!st->can_power_down)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[2], 0);
+		gpiod_set_value_cansleep(st->en_gpios[1], 0);
+		gpiod_set_value_cansleep(st->en_gpios[0], 0);
+		return 0;
+
+	case AD7960_MODE_SNOOZE:
+		if (!st->can_snooze)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[1], 1);
+		gpiod_set_value_cansleep(st->en_gpios[0], 1);
+		return 0;
+
+	case AD7960_MODE_NARROW_BANDWIDTH:
+		if (!st->can_narrow_bandwidth)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[2], 1);
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+		return 0;
+
+	case AD7960_MODE_WIDE_BANDWIDTH:
+		if (!st->can_wide_bandwidth)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[2], 0);
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+		return 0;
+
+	case AD7960_MODE_TEST_PATTERN:
+		if (!st->can_test_pattern)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[3], 0);
+		gpiod_set_value_cansleep(st->en_gpios[2], 1);
+		gpiod_set_value_cansleep(st->en_gpios[1], 0);
+		gpiod_set_value_cansleep(st->en_gpios[0], 0);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7625_probe(struct platform_device *pdev)
+{
+	/*
+	 * Power-up info for the device says to bring up vio, then
+	 * vdd2, then vdd1
+	 */
+	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct ad7625_state *st;
+	struct clk *ref_clk;
+	int ret, ref_mv;
+	int default_sample_freq;
+	bool have_refin;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->info = device_get_match_data(dev);
+	if (!st->info)
+		return dev_err_probe(dev, -EINVAL, "no chip info\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+		regulator_names);
+	if (ret)
+		return ret;
+
+	if (st->info->has_bandwidth_control)
+		ret = ad7625_parse_mode(dev, st, 4);
+	else
+		ret = ad7625_parse_mode(dev, st, 2);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Determine the source of the reference voltage:
+	 * - internal reference: neither REF or REFIN is connected
+	 *   (invalid for AD796x)
+	 * - internal buffer, external reference: REF not connected,
+	 *   is REFIN connected
+	 * - external reference: REF connected, REFIN not connected
+	 */
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
+
+	ref_mv = ret == -ENODEV ? 0 : ret / 1000;
+
+	ret = devm_regulator_get_enable_optional(dev, "refin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
+
+	have_refin = ret != -ENODEV;
+
+	if (have_refin && !st->can_refin)
+		return dev_err_probe(dev, -EINVAL,
+				     "REFIN provided in unsupported mode\n");
+
+	if (!st->info->has_internal_vref && !have_refin && !ref_mv)
+		return dev_err_probe(dev, -EINVAL,
+				     "Need either REFIN or REF");
+
+	if (have_refin && ref_mv)
+		return dev_err_probe(dev, -EINVAL,
+				     "cannot have both REFIN and REF supplies\n");
+
+	st->vref_mv = ref_mv ?: AD7625_INTERNAL_REF_MV;
+
+	if (ref_mv == 4096 && !st->can_ref_4v096)
+		return dev_err_probe(dev, -EINVAL,
+				     "REF is 4.096V in unsupported mode\n");
+
+	if (ref_mv == 5000 && !st->can_ref_5v)
+		return dev_err_probe(dev, -EINVAL,
+				     "REF is 5V in unsupported mode\n");
+
+	/* Set the device mode based on detected EN configuration. */
+	if (!st->info->has_bandwidth_control) {
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+	} else {
+		/*
+		 * If neither sampling mode is available, then report an error,
+		 * since the other modes are not useful defaults.
+		 */
+		if (st->can_wide_bandwidth) {
+			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
+				have_refin, ref_mv);
+		} else if (st->can_narrow_bandwidth) {
+			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
+				have_refin, ref_mv);
+		} else {
+			return dev_err_probe(dev, -EINVAL,
+				"couldn't set device to wide or narrow bandwidth modes\n");
+		}
+
+		if (ret)
+			return dev_err_probe(dev, -EINVAL,
+					     "failed to set EN pins\n");
+	}
+
+	ret = devm_ad7625_pwm_get(dev, ref_clk, st);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL,
+				     "failed to set ref_clk_rate_hz\n");
+
+	indio_dev->channels = &st->info->chan_spec;
+	indio_dev->num_channels = 1;
+	indio_dev->name = st->info->name;
+	indio_dev->info = &ad7625_info;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get IIO backend");
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set the initial sampling frequency to the maximum, unless the
+	 * AD796x device is limited to narrow bandwidth, in which case
+	 * the sampling frequency should be limited to 2MSPS
+	 */
+	if (!st->info->has_bandwidth_control) {
+		default_sample_freq = st->info->max_sample_rate_hz;
+	} else {
+		default_sample_freq = !st->can_wide_bandwidth ? AD7960_MAX_NBW_FREQ :
+				      st->info->max_sample_rate_hz;
+	}
+
+	ret = ad7625_set_sampling_freq(st, default_sample_freq);
+	if (ret < 0)
+		dev_err_probe(dev, ret, "failed to set sampling frequency\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad7625_of_match[] = {
+	{ .compatible = "adi,ad7625", .data = &ad7625_chip_info, },
+	{ .compatible = "adi,ad7626", .data = &ad7626_chip_info, },
+	{ .compatible = "adi,ad7960", .data = &ad7960_chip_info, },
+	{ .compatible = "adi,ad7961", .data = &ad7961_chip_info, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7625_of_match);
+
+static const struct platform_device_id ad7625_device_ids[] = {
+	{ .name = "ad7625", .driver_data = (kernel_ulong_t)&ad7625_chip_info },
+	{ .name = "ad7626", .driver_data = (kernel_ulong_t)&ad7626_chip_info },
+	{ .name = "ad7960", .driver_data = (kernel_ulong_t)&ad7960_chip_info },
+	{ .name = "ad7961", .driver_data = (kernel_ulong_t)&ad7961_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ad7625_device_ids);
+
+static struct platform_driver ad7625_driver = {
+	.probe = ad7625_probe,
+	.driver = {
+		.name = "ad7625",
+		.of_match_table = ad7625_of_match,
+	},
+	.id_table = ad7625_device_ids,
+};
+module_platform_driver(ad7625_driver);
+
+MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
+MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.39.2



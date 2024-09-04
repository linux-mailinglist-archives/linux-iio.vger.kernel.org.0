Return-Path: <linux-iio+bounces-9154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACB96C743
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 21:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E9287050
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45261E5028;
	Wed,  4 Sep 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="icYjDrj9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372F1E4938
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477268; cv=none; b=hb6sC7XXexxg9hRr/eDCSpdi1i2MmBmVwROqcW/+y0Qx3lZjsTmboDN5ffafKwROM3baj9RUdGWqKihXjJEhJ9ytICRyw3F8HjCxKKq2GVuxMMP6AxbntL+LKxWYKUpIRNQBez1l4faZ8iU9yxPDF7VXwNzrnSUvfizX4i9P8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477268; c=relaxed/simple;
	bh=RZPFdcAZT0WLc/zhjApXTiW2QQSAznITFoZlM5MtEJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C02lfPGHchCW2SqNCExpDTmkwAkLrJiG/8QykTdZnbrSi/aUZQYCQnZONr1gJvb/7+RQVV9ZO/bprEZJbQbqbLH7kzmRiT5N3YqFJc3Frkcn5+soeMj2p3iwlX56fBIZRQzyVPzkET6pB0JmW7I/bqKsBnH+U2dSHJ+DtV/3VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=icYjDrj9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a812b64d1cso396413285a.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725477265; x=1726082065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=693JUJ6NLGOoTJU5fDNqW8RRAm55O7dEN2C2v+khej8=;
        b=icYjDrj9m3EFWxvDBeWbpx0r3NeKPICd3jwQWCy2GjJ9aD7nBRF6z7m3DxbjwjCeLz
         Z8H5ITHYneUGb5sXw9GejbPKCorqxvKSyvzjq769szZi7oP4KRVmm/AQfbohJi44jcZt
         F3lphw9UyIIPS7O49TmoGagw68ik8A3NTeOrjiN4h3UVxY9DOKrH2Hfobd2UVhnBKk+I
         5YrBYTJjGpWtMozPrgbZRTLkQs29KV8BXfjVLaLRRkVC8BRQHP1uW1eUExcUkoSpuMa5
         dx1KA4IWCF/PCa2rF0vtYb4cCWnJBItValSI8G/EOy2md6jzVdZfENbiIOVM5Ch3KKUk
         A3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477265; x=1726082065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=693JUJ6NLGOoTJU5fDNqW8RRAm55O7dEN2C2v+khej8=;
        b=Dw3SXw5b8njZCFiJeIM9iAnuZmstGYMjCWEPaTEgbrq0o7vSNcS537qxq8gz8yospk
         v7KI8I0xr72N/UV47enpeOdNCVtwCxROxMBVOlMCS4rA7lVFQ2af6vj+pSpGc1Kvpbu8
         fbGAz6uK5CciAIRSE3BwZSfSPIL/Z5ibg/df52wCEXWPBFxJkoNc/hHbWVylKCV1cV1O
         bFxY/tmQzWljGUKK0JlbDbRBh8o41ZntXooblTwvNdzcMiNczjPPvSVYJ96bP0BoJKjN
         ocTDoABrlKQ8UD1CokkQwN5Y2a/6nhoozCliL39HmtzmyUtXQTLkCv3giZtrNU6FBgfP
         jJfQ==
X-Gm-Message-State: AOJu0YzjbGZOBHoT2c9L6zJnOiv0rOaZoBtlTIodzBkYIp0+vx10eWAi
	N9a+/iL0zHqxZc40wwSZ+Z/Wc9GHArLB95WU51KG+i2go2bZvQTIwtS42sC4E4Q=
X-Google-Smtp-Source: AGHT+IHKKBfiIlsmQmrFNe8FrZ0n6g43ydKXIeADoXsQnPUp2l5OneLgEs3ajo0DWv9F7eRtd8ohYA==
X-Received: by 2002:a05:620a:3909:b0:7a7:faf4:9aab with SMTP id af79cd13be357-7a804186b9amr2471746685a.4.1725477264527;
        Wed, 04 Sep 2024 12:14:24 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f026caesm8861085a.135.2024.09.04.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:14:24 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 04 Sep 2024 15:14:19 -0400
Subject: [PATCH v4 2/3] iio: adc: ad7625: add driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
In-Reply-To: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
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

Add a driver for the AD762x and AD796x family of ADCs. These are
pin-compatible devices using an LVDS interface for data transfer,
capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
(AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
reference options based on the configuration of the EN1/EN0 pins, which
can be set in the devicetree.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  16 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7625.c | 684 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 702 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77557e85220e..7f77a1c1110b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,6 +1279,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+F:	drivers/iio/adc/ad7625.c
 
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..2e743c95e900 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -219,6 +219,22 @@ config AD7606_IFACE_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_spi.
 
+config AD7625
+	tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
+	depends on PWM
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices:
+	  * AD7625 16-Bit, 6 MSPS PulSAR Analog-to-Digital Converter
+	  * AD7626 16-Bit, 10 MSPS PulSAR Analog-to-Digital Converter
+	  * AD7960 18-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
+	  * AD7961 16-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
+
+	  The driver requires the assistance of the AXI ADC IP core to operate.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7625.
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
index 000000000000..5faada8d510f
--- /dev/null
+++ b/drivers/iio/adc/ad7625.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Analog Devices Inc. AD7625 ADC driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
+ *
+ * Note that this driver requires the AXI ADC IP block configured for
+ * LVDS to function. See Documentation/iio/ad7625.rst for more
+ * information.
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
+	.scan_type.storagebits = (_bits) > 16 ? 32 : 16,		\
+	.scan_type.realbits = (_bits),					\
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
+	/*
+	 * Waveforms containing the last-requested and rounded
+	 * properties for the clk_gate and cnv PWMs
+	 */
+	struct pwm_waveform clk_gate_wf;
+	struct pwm_waveform cnv_wf;
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
+	/* Indicate whether there is a REFIN supply connected */
+	bool have_refin;
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
+static int ad7625_set_sampling_freq(struct ad7625_state *st, int freq)
+{
+	u64 target;
+	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
+	int ret;
+
+	target = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+	cnv_wf.period_length_ns = clamp(target, 100, 10 * KILO);
+
+	/*
+	 * Use the maximum conversion time t_CNVH from the datasheet as
+	 * the duty_cycle for ref_clk, cnv, and clk_gate
+	 */
+	cnv_wf.duty_length_ns = st->info->timing_spec->conv_high_ns;
+
+	ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
+	if (ret)
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
+	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
+	if (ret)
+		return ret;
+
+	st->cnv_wf = cnv_wf;
+	st->clk_gate_wf = clk_gate_wf;
+
+	/* TODO: Add a rounding API for PWMs that can simplify this */
+	target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz, freq);
+	st->sampling_freq_hz = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz,
+						     target);
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
+static int ad7625_parse_mode(struct device *dev, struct ad7625_state *st,
+			     int num_gpios)
+{
+	bool en_always_on[4], en_always_off[4];
+	bool en_may_be_on[4], en_may_be_off[4];
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
+		en_always_on[i] = device_property_read_bool(dev, always_on_buf);
+		if (st->en_gpios[i] && en_always_on[i])
+			return dev_err_probe(dev, -EINVAL,
+				"cannot have adi,en%d-always-on and en%d-gpios\n", i, i);
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
+	if (en_always_on[3] && en_always_on[2] &&
+	    en_always_off[1] && en_always_off[0])
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
+static void ad7625_set_en_gpios_for_vref(struct ad7625_state *st,
+					 bool have_refin, int ref_mv)
+{
+	if (have_refin || ref_mv == 5000) {
+		gpiod_set_value_cansleep(st->en_gpios[1], 0);
+		gpiod_set_value_cansleep(st->en_gpios[0], 1);
+	} else if (ref_mv == 4096) {
+		gpiod_set_value_cansleep(st->en_gpios[1], 1);
+		gpiod_set_value_cansleep(st->en_gpios[0], 0);
+	} else {
+		/*
+		 * Unreachable by AD796x, since the driver will error if
+		 * neither REF nor REFIN is provided
+		 */
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
+
+		return 0;
+
+	case AD7960_MODE_SNOOZE:
+		if (!st->can_snooze)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[1], 1);
+		gpiod_set_value_cansleep(st->en_gpios[0], 1);
+
+		return 0;
+
+	case AD7960_MODE_NARROW_BANDWIDTH:
+		if (!st->can_narrow_bandwidth)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[2], 1);
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+
+		return 0;
+
+	case AD7960_MODE_WIDE_BANDWIDTH:
+		if (!st->can_wide_bandwidth)
+			return -EINVAL;
+
+		gpiod_set_value_cansleep(st->en_gpios[2], 0);
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+
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
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7625_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7625_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_pwm, &st->cnv_wf, false);
+	if (ret)
+		return ret;
+
+	ret = pwm_set_waveform_might_sleep(st->clk_gate_pwm,
+					   &st->clk_gate_wf, false);
+	if (ret) {
+		/* Disable cnv PWM if clk_gate setup failed */
+		pwm_disable(st->cnv_pwm);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad7625_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7625_state *st = iio_priv(indio_dev);
+
+	pwm_disable(st->cnv_pwm);
+	pwm_disable(st->clk_gate_pwm);
+
+	return 0;
+}
+
+static const struct iio_info ad7625_info = {
+	.read_raw = ad7625_read_raw,
+	.write_raw = ad7625_write_raw,
+};
+
+static const struct iio_buffer_setup_ops ad7625_buffer_setup_ops = {
+	.preenable = &ad7625_buffer_preenable,
+	.postdisable = &ad7625_buffer_postdisable,
+};
+
+static int devm_ad7625_pwm_get(struct device *dev, struct clk *ref_clk,
+			       struct ad7625_state *st)
+{
+	unsigned long ref_clk_rate_hz;
+
+	st->cnv_pwm = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->cnv_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
+				     "failed to get cnv pwm\n");
+
+	/* Preemptively disable the PWM in case it was enabled at boot */
+	pwm_disable(st->cnv_pwm);
+
+	st->clk_gate_pwm = devm_pwm_get(dev, "clk_gate");
+	if (IS_ERR(st->clk_gate_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->clk_gate_pwm),
+				     "failed to get clk_gate pwm\n");
+
+	/* Preemptively disable the PWM in case it was enabled at boot */
+	pwm_disable(st->clk_gate_pwm);
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
+/*
+ * There are three required input voltages for each device, plus two
+ * conditionally-optional (depending on part) REF and REFIN voltages
+ * where their validity depends upon the EN pin configuration.
+ *
+ * Power-up info for the device says to bring up vio, then vdd2, then
+ * vdd1, so list them in that order in the regulator_names array.
+ *
+ * The reference voltage source is determined like so:
+ * - internal reference: neither REF or REFIN is connected (invalid for
+ *   AD796x)
+ * - internal buffer, external reference: REF not connected, REFIN
+ *   connected
+ * - external reference: REF connected, REFIN not connected
+ */
+static int devm_ad7625_regulator_setup(struct device *dev,
+				       struct ad7625_state *st)
+{
+	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
+	int ret, ref_mv;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return ret;
+
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
+	st->have_refin = ret != -ENODEV;
+
+	if (st->have_refin && !st->can_refin)
+		return dev_err_probe(dev, -EINVAL,
+				     "REFIN provided in unsupported mode\n");
+
+	if (!st->info->has_internal_vref && !st->have_refin && !ref_mv)
+		return dev_err_probe(dev, -EINVAL,
+				     "Need either REFIN or REF");
+
+	if (st->have_refin && ref_mv)
+		return dev_err_probe(dev, -EINVAL,
+				     "cannot have both REFIN and REF supplies\n");
+
+	if (ref_mv == 4096 && !st->can_ref_4v096)
+		return dev_err_probe(dev, -EINVAL,
+				     "REF is 4.096V in unsupported mode\n");
+
+	if (ref_mv == 5000 && !st->can_ref_5v)
+		return dev_err_probe(dev, -EINVAL,
+				     "REF is 5V in unsupported mode\n");
+
+	st->vref_mv = ref_mv ?: AD7625_INTERNAL_REF_MV;
+
+	return 0;
+}
+
+static int ad7625_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct ad7625_state *st;
+	struct clk *ref_clk;
+	int ret;
+	int default_sample_freq;
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
+	if (device_property_read_bool(dev, "adi,no-dco"))
+		return dev_err_probe(dev, -EINVAL,
+				     "self-clocked mode not supported\n");
+
+	if (st->info->has_bandwidth_control)
+		ret = ad7625_parse_mode(dev, st, 4);
+	else
+		ret = ad7625_parse_mode(dev, st, 2);
+
+	if (ret)
+		return ret;
+
+	ret = devm_ad7625_regulator_setup(dev, st);
+	if (ret)
+		return ret;
+
+	/* Set the device mode based on detected EN configuration. */
+	if (!st->info->has_bandwidth_control) {
+		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
+	} else {
+		/*
+		 * If neither sampling mode is available, then report an error,
+		 * since the other modes are not useful defaults.
+		 */
+		if (st->can_wide_bandwidth) {
+			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
+					      st->have_refin, st->vref_mv);
+		} else if (st->can_narrow_bandwidth) {
+			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
+					      st->have_refin, st->vref_mv);
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
+		return ret;
+
+	indio_dev->channels = &st->info->chan_spec;
+	indio_dev->num_channels = 1;
+	indio_dev->name = st->info->name;
+	indio_dev->info = &ad7625_info;
+	indio_dev->setup_ops = &ad7625_buffer_setup_ops;
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
+	 * AD796x device is limited to narrow bandwidth by EN2 == 1, in
+	 * which case the sampling frequency should be limited to 2MSPS
+	 */
+	default_sample_freq = st->info->max_sample_rate_hz;
+	if (st->info->has_bandwidth_control && !st->can_wide_bandwidth)
+		default_sample_freq = AD7960_MAX_NBW_FREQ;
+
+	ret = ad7625_set_sampling_freq(st, default_sample_freq);
+	if (ret)
+		dev_err_probe(dev, ret,
+			      "failed to set valid sampling frequency\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad7625_of_match[] = {
+	{ .compatible = "adi,ad7625", .data = &ad7625_chip_info },
+	{ .compatible = "adi,ad7626", .data = &ad7626_chip_info },
+	{ .compatible = "adi,ad7960", .data = &ad7960_chip_info },
+	{ .compatible = "adi,ad7961", .data = &ad7961_chip_info },
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



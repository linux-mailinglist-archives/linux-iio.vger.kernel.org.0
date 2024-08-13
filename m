Return-Path: <linux-iio+bounces-8454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99F950B65
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D4EB25EFE
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36B1A2C20;
	Tue, 13 Aug 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ta9sJWcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8E1A2C08
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570011; cv=none; b=Sw5x+zjYwk3JSFva6dpqqwpobj6IU/Q2Hzmxen3xWDh9IB29ypMAibGArLsMEd76i8hHKO8q55k96pvXmrG8p7gc/9MTwPHcRwdlz9hF9htX6PJj83oppv7V12dukhHGz6h9jYWRh3ZbP40wFEf1zQIYkMhuSCGzyaxcCKqSSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570011; c=relaxed/simple;
	bh=yHqh/AzNueb3uH4Vg4c9kJPYwN0LT6JGzvxFHXzHfwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJAwgbxDM1Pfb9/Evt0XlXlrRDKmATAUCbYDIzU6mJe2pOa6hzF25P5cZhOW0QZmsRaJLUu2MIaPCzNoiClUP4mmsy4TGZeO6ZMFEYSvIkyz+Ya0epAH5ohaRx1thEnv5hXFtOZSZD+eh+v39L/0i51er4VTDs6YMvb6DCLEL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ta9sJWcM; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-268daf61e8bso2354780fac.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723570009; x=1724174809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWy2ZeVI8MzpvKTVpOaj0dXdPJmemROzYst4zRXQgnQ=;
        b=Ta9sJWcMOAMzDaA5zQWH0LChS+WJZtQisUX2CXnn1HlGP3RwKVVD66ozXwvZYcJhF7
         jHEfYuLfBVyfOAFQKuQqSSN4vJDM7HvLZyZ8Nq7dnsq4MndIHQKS3LXDbB1EG0gWsFun
         RIBq99+SZGsU32/1g5Lrko+zqPMwlBQaTBrNZVmwGMbzL3jAl42cKjjxR9MDU8nSwMAH
         g5C1uYDX3p9jD6tTdqbwFNDrrWDvGdXPJTTMsltP9sZIPuH7AhmXFztyoCpEWS1HiNK/
         dTb1k6AAWOP7EQivLymdJ+hMaVrzv1Ia1ECnc1muWSQj08vILhl48dDpuXZmxv+IkaM3
         qhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570009; x=1724174809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWy2ZeVI8MzpvKTVpOaj0dXdPJmemROzYst4zRXQgnQ=;
        b=LL72iNZh0cELR50UKGsytE9ctOJpItg+5jG6QB3fEg462dTwYtupriyfT8zcrdmGoY
         wgQTe+0VIhPLbA/Za3YmKp6piaaMxawn1WXsUh5+eEn3nLqtMo2/q8VySw/cwdR6P0ce
         D2x2+13D2O4DDr31ynpTx3itajuRKScsowh2xx1ixUmHUfKCjj+phWEiPL8tJce9SGce
         830KwWbJOLkKiEzY9Kj+hm5HIses5MMyFtH36n5qelbBIbYIVUSv5biGGZTizPMbxeaj
         Tw6LLZrPyuHNJic2vQ7ggH6neVIxgKvaEmI6YhMk2iR53R23+iPycOT9xm2VQFcf/HpB
         pLvw==
X-Forwarded-Encrypted: i=1; AJvYcCWpxLtXHa6f7SkevRWUkAtQJznrjLC6v08EpS6g9ovK0mjb0+XQ8qxvKillVOQ2zWi0QjKokm+gXwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpwlmGj3jcehdY5i6rkoqpyH1Fa9FLDafic7NNw7Aa/wSlGnY
	7f5szKIEs5w7r3EFNH9Fzfd90ZRyR0de1i0x2uALRLJjAdDNUNkPSii7Q79vUOM=
X-Google-Smtp-Source: AGHT+IEwWLNj0bC/p+sTJkFZWe1k28ivX0q4PHwW0iol57Zla6LvOdi9+jpwEgpF2yLqu1S1F+NBtQ==
X-Received: by 2002:a05:6871:8788:b0:25e:e6d:5247 with SMTP id 586e51a60fabf-26fe5a416e1mr419063fac.14.1723570008697;
        Tue, 13 Aug 2024 10:26:48 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c7203f908sm2462915fac.11.2024.08.13.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:26:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: ad4695: implement triggered buffer
Date: Tue, 13 Aug 2024 12:26:40 -0500
Message-ID: <20240813-iio-adc-ad4695-buffered-read-v2-1-9bb19fc1924b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
References: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This implements buffered reads for the ad4695 driver using the typical
triggered buffer implementation, including adding a soft timestamp
channel.

The chip has 4 different modes for doing conversions. The driver is
using the advanced sequencer mode since that is the only mode that
allows individual configuration of all aspects each channel (e.g.
bipolar config currently and oversampling to be added in the future).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 007ecb951bc3..b8547914f00f 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -11,6 +11,7 @@
  * Copyright 2024 BayLibre, SAS
  */
 
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/compiler.h>
@@ -18,7 +19,10 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -61,6 +65,7 @@
 #define AD4695_REG_GPIO_CTRL				0x0026
 #define AD4695_REG_GP_MODE				0x0027
 #define AD4695_REG_TEMP_CTRL				0x0029
+#define   AD4695_REG_TEMP_CTRL_TEMP_EN			  BIT(0)
 #define AD4695_REG_CONFIG_IN(n)				(0x0030 | (n))
 #define   AD4695_REG_CONFIG_IN_MODE			  BIT(6)
 #define   AD4695_REG_CONFIG_IN_PAIR			  GENMASK(5, 4)
@@ -84,9 +89,13 @@
 #define AD4695_T_WAKEUP_HW_MS		3
 #define AD4695_T_WAKEUP_SW_MS		3
 #define AD4695_T_REFBUF_MS		100
+#define AD4695_T_REGCONFIG_NS		20
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
+/* Max number of voltage input channels. */
 #define AD4695_MAX_CHANNELS		16
+/* Max size of 1 raw sample in bytes. */
+#define AD4695_MAX_CHANNEL_SIZE		2
 
 enum ad4695_in_pair {
 	AD4695_IN_PAIR_REFGND,
@@ -97,6 +106,7 @@ enum ad4695_in_pair {
 struct ad4695_chip_info {
 	const char *name;
 	int max_sample_rate;
+	u32 t_acq_ns;
 	u8 num_voltage_inputs;
 };
 
@@ -112,15 +122,21 @@ struct ad4695_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
-	struct iio_chan_spec iio_chan[AD4695_MAX_CHANNELS + 1];
+	/* voltages channels plus temperature and timestamp */
+	struct iio_chan_spec iio_chan[AD4695_MAX_CHANNELS + 2];
 	struct ad4695_channel_config channels_cfg[AD4695_MAX_CHANNELS];
 	const struct ad4695_chip_info *chip_info;
 	/* Reference voltage. */
 	unsigned int vref_mv;
 	/* Common mode input pin voltage. */
 	unsigned int com_mv;
+	/* 1 per voltage and temperature chan plus 1 xfer to trigger 1st CNV */
+	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS + 2];
+	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u16 raw_data __aligned(IIO_DMA_MINALIGN);
+	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
+		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;
 	u8 cnv_cmd2;
@@ -193,6 +209,9 @@ static const struct iio_chan_spec ad4695_temp_channel_template = {
 	},
 };
 
+static const struct iio_chan_spec ad4695_soft_timestamp_channel_template =
+	IIO_CHAN_SOFT_TIMESTAMP(0);
+
 static const char * const ad4695_power_supplies[] = {
 	"avdd", "vio"
 };
@@ -200,24 +219,28 @@ static const char * const ad4695_power_supplies[] = {
 static const struct ad4695_chip_info ad4695_chip_info = {
 	.name = "ad4695",
 	.max_sample_rate = 500 * KILO,
+	.t_acq_ns = 1715,
 	.num_voltage_inputs = 16,
 };
 
 static const struct ad4695_chip_info ad4696_chip_info = {
 	.name = "ad4696",
 	.max_sample_rate = 1 * MEGA,
+	.t_acq_ns = 715,
 	.num_voltage_inputs = 16,
 };
 
 static const struct ad4695_chip_info ad4697_chip_info = {
 	.name = "ad4697",
 	.max_sample_rate = 500 * KILO,
+	.t_acq_ns = 1715,
 	.num_voltage_inputs = 8,
 };
 
 static const struct ad4695_chip_info ad4698_chip_info = {
 	.name = "ad4698",
 	.max_sample_rate = 1 * MEGA,
+	.t_acq_ns = 715,
 	.num_voltage_inputs = 8,
 };
 
@@ -254,6 +277,61 @@ static int ad4695_set_single_cycle_mode(struct ad4695_state *st,
 			       AD4695_REG_SETUP_SPI_CYC_CTRL);
 }
 
+/**
+ * ad4695_enter_advanced_sequencer_mode - Put the ADC in advanced sequencer mode
+ * @st: The driver state
+ * @n: The number of slots to use - must be >= 2, <= 128
+ *
+ * As per the datasheet, to enable advanced sequencer, we need to set
+ * STD_SEQ_EN=0, NUM_SLOTS_AS=n-1 and CYC_CTRL=0 (Table 15). Setting SPI_MODE=1
+ * triggers the first conversion using the channel in AS_SLOT0.
+ *
+ * Return: 0 on success, a negative error code on failure
+ */
+static int ad4695_enter_advanced_sequencer_mode(struct ad4695_state *st, u32 n)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4695_REG_SEQ_CTRL,
+		AD4695_REG_SEQ_CTRL_STD_SEQ_EN |
+		AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS,
+		FIELD_PREP(AD4695_REG_SEQ_CTRL_STD_SEQ_EN, 0) |
+		FIELD_PREP(AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS, n - 1));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD4695_REG_SETUP,
+		AD4695_REG_SETUP_SPI_MODE | AD4695_REG_SETUP_SPI_CYC_CTRL,
+		FIELD_PREP(AD4695_REG_SETUP_SPI_MODE, 1) |
+		FIELD_PREP(AD4695_REG_SETUP_SPI_CYC_CTRL, 0));
+}
+
+/**
+ * ad4695_exit_conversion_mode - Exit conversion mode
+ * @st: The AD4695 state
+ *
+ * Sends SPI command to exit conversion mode.
+ *
+ * Return: 0 on success, a negative error code on failure
+ */
+static int ad4695_exit_conversion_mode(struct ad4695_state *st)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = &st->cnv_cmd2,
+		.len = 1,
+		.delay.value = AD4695_T_REGCONFIG_NS,
+		.delay.unit = SPI_DELAY_UNIT_NSECS,
+	};
+
+	/*
+	 * Technically, could do a 5-bit transfer, but shifting to start of
+	 * 8 bits instead for better SPI controller support.
+	 */
+	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
 static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)
 {
 	u8 val;
@@ -296,6 +374,161 @@ static int ad4695_write_chn_cfg(struct ad4695_state *st,
 				  mask, val);
 }
 
+static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	struct spi_transfer *xfer;
+	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
+	u32 bit, num_xfer, num_slots;
+	u32 temp_en = 0;
+	int ret;
+
+	/*
+	 * We are using the advanced sequencer since it is the only way to read
+	 * multiple channels that allows individual configuration of each
+	 * voltage input channel. Slot 0 in the advanced sequencer is used to
+	 * account for the gap between trigger polls - we don't read data from
+	 * this slot. Each enabled voltage channel is assigned a slot starting
+	 * with slot 1.
+	 */
+	num_slots = 1;
+
+	memset(st->buf_read_xfer, 0, sizeof(st->buf_read_xfer));
+
+	/* First xfer is only to trigger conversion of slot 1, so no rx. */
+	xfer = &st->buf_read_xfer[0];
+	xfer->cs_change = 1;
+	xfer->delay.value = st->chip_info->t_acq_ns;
+	xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
+	xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
+	xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	num_xfer = 1;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		xfer = &st->buf_read_xfer[num_xfer];
+		xfer->bits_per_word = 16;
+		xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
+		xfer->len = 2;
+		xfer->cs_change = 1;
+		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
+		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+		if (bit == temp_chan_bit) {
+			temp_en = 1;
+		} else {
+			ret = regmap_write(st->regmap,
+				AD4695_REG_AS_SLOT(num_slots),
+				FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
+			if (ret)
+				return ret;
+
+			num_slots++;
+		}
+
+		num_xfer++;
+	}
+
+	/*
+	 * The advanced sequencer requires that at least 2 slots are enabled.
+	 * Since slot 0 is always used for other purposes, we need only 1
+	 * enabled voltage channel to meet this requirement. If the temperature
+	 * channel is the only enabled channel, we need to add one more slot
+	 * in the sequence but not read from it.
+	 */
+	if (num_slots < 2) {
+		/* move last xfer so we can insert one more xfer before it */
+		st->buf_read_xfer[num_xfer] = *xfer;
+		num_xfer++;
+
+		/* modify 2nd to last xfer for extra slot */
+		memset(xfer, 0, sizeof(*xfer));
+		xfer->cs_change = 1;
+		xfer->delay.value = st->chip_info->t_acq_ns;
+		xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
+		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer++;
+
+		/* and add the extra slot in the sequencer */
+		ret = regmap_write(st->regmap,
+				   AD4695_REG_AS_SLOT(num_slots),
+				   FIELD_PREP(AD4695_REG_AS_SLOT_INX, 0));
+		if (ret)
+			return ret;
+
+		num_slots++;
+	}
+
+	/*
+	 * Don't keep CS asserted after last xfer. Also triggers conversion of
+	 * slot 0.
+	 */
+	xfer->cs_change = 0;
+
+	/*
+	 * Temperature channel isn't included in the sequence, but rather
+	 * controlled by setting a bit in the TEMP_CTRL register.
+	 */
+
+	ret = regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
+		AD4695_REG_TEMP_CTRL_TEMP_EN,
+		FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN, temp_en));
+	if (ret)
+		return ret;
+
+	spi_message_init_with_transfers(&st->buf_read_msg, st->buf_read_xfer,
+					num_xfer);
+
+	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
+	if (ret)
+		return ret;
+
+	/* This triggers conversion of slot 0. */
+	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
+	if (ret)
+		spi_unoptimize_message(&st->buf_read_msg);
+
+	return ret;
+}
+
+static int ad4695_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4695_exit_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	spi_unoptimize_message(&st->buf_read_msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4695_buffer_setup_ops = {
+	.preenable = ad4695_buffer_preenable,
+	.postdisable = ad4695_buffer_postdisable,
+};
+
+static irqreturn_t ad4695_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4695_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = spi_sync(st->spi, &st->buf_read_msg);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->buf, pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * ad4695_read_one_sample - Read a single sample using single-cycle mode
  * @st: The AD4695 state
@@ -527,6 +760,10 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 	/* Temperature channel must be next scan index after voltage channels. */
 	st->iio_chan[i] = ad4695_temp_channel_template;
 	st->iio_chan[i].scan_index = i;
+	i++;
+
+	st->iio_chan[i] = ad4695_soft_timestamp_channel_template;
+	st->iio_chan[i].scan_index = i;
 
 	return 0;
 }
@@ -695,7 +932,14 @@ static int ad4695_probe(struct spi_device *spi)
 	indio_dev->info = &ad4695_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->iio_chan;
-	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 1;
+	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 2;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad4695_trigger_handler,
+					      &ad4695_buffer_setup_ops);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.43.0



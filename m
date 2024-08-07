Return-Path: <linux-iio+bounces-8318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA194B0CE
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 22:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DC41C20A98
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6808145A0A;
	Wed,  7 Aug 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zHrPIA9O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829E13F42D
	for <linux-iio@vger.kernel.org>; Wed,  7 Aug 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060939; cv=none; b=pRI4KaJpiRxLMvD6QzAaqbdz0HmdBRicybWAfb2uXwkyTBO9Q4uCTpgzEBGiH7K4X18aHHmVawMuzhvyBPfKVrduwyzN1nO/iLv1aNclSbmo1YJluu+KG0z3Pusr0aefcw+in9E4MrYvKf3qaJ5k10pzoRfdrtU5a74yAXjipPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060939; c=relaxed/simple;
	bh=Zj0d9gJzJH8NR7GZsT4N/D7RLDLQk30lzFYYG1toUv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHYqMNW7qMj6aJxlhKGF29dPn4okH2L0wXE6VCwVRVUIJbdYW/wfuUPeV17HqsaZxsuxCeE7dMqeEL8gPJJQm4VPrY7oaeYRCulhbAVlYYoj0ohViqyJlwlnA291f32lIBMv+mqW+DzGLfVjGipHK00DVCN5tALy6JUbvBhjAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zHrPIA9O; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7092dd03223so68053a34.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Aug 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723060937; x=1723665737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh9Di04Q6X1QnLXM0dyhJm7bWzho7wJu5BICWBfLDlU=;
        b=zHrPIA9Onlg1iqpGUADR1V3iORwvdkCfzteFPOJzMnKBknsrQPW/6C9DCkYIWY4HVi
         SIFGlFoXT3l2/If8dg/AIMoXPa4ylXwGCM25hRMF5YXlU1SFNHL906WERhipSBYSSDj8
         DPuNMBzuNHBohbPfDw6GkYQXroySxEDwzg4L4Jx0T1RJbgtTLrCc1SZdhmX1y00wI1Mg
         FS51dX842XBs2OENxPf9Y8mXOXfQl9fxv0bWdsVDivVKTt56d/5ZQw7yBTig2rhE3gBB
         18Vs7D3L7SS5PF1A+KHWkdCWbh/W/0YOcFCyEif0yJHL6iVK83mIsXpFbJKOr1wQgqa5
         Ni2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060937; x=1723665737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh9Di04Q6X1QnLXM0dyhJm7bWzho7wJu5BICWBfLDlU=;
        b=fTfUXLSOdJsU6q8xa9I3x7kIxxaEBpildvdpGA4JqwL/eWMEG/AapAsf84mqaHqoVx
         HL+H8S0v+DpmSXRUwbgUdnxctyuCYmvhm5/yumwKR0jquY/tBZkB5ajJ4EzJUhf14SsL
         yKJ3eZ41EjqhH77n2nqCJsNxntfzdYFN/C3XbA5IYSy8B7QNuqFC8oCd4JuX3ysItcMf
         E0OIa/qCtsb5GmcZ7TWPq+w/+IFCBJfPxSaOEkytmr6MX06e02R39AQLja2Wm1DSL5HJ
         k7H+WNO3YVaxdlWGV5b99rYqV26s5Qa8zV6Ey9NqfwtAp3xfCxWE8W8Mw9k3PR05H/G/
         xiZA==
X-Forwarded-Encrypted: i=1; AJvYcCXkujhkLiqhq1kLtJkE7OqLup8SY/WD1/qog0/hIgB/jCk+aySfg+861t6Is/IgoQ/xAuKCFkkZzLNXFDy7joDbTpRNq9c+C7PD
X-Gm-Message-State: AOJu0YwLr2bgKH1BBhtPIsB30XglvEnjYIizrF9NNZlJOC9Ee27FSSzb
	acF2telG1rD7zXZB6FoMTxdbO2pTrsaSS47u+3bAWTBn48r02luh87+ULDWBkZQ=
X-Google-Smtp-Source: AGHT+IGH185FZV5017mKVEb2haN0kAu/yY9SJUY3aq32lZacVosvwx3+Qgo9srcPI0xFzKhYywun1A==
X-Received: by 2002:a05:6830:6e91:b0:703:6341:5171 with SMTP id 46e09a7af769-709b3217843mr22325092a34.15.1723060936747;
        Wed, 07 Aug 2024 13:02:16 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31eaf7b6sm4951003a34.24.2024.08.07.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:02:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
Date: Wed,  7 Aug 2024 15:02:10 -0500
Message-ID: <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
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
 drivers/iio/adc/ad4695.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 230 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 007ecb951bc3..a3bd5be36134 100644
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
@@ -80,13 +85,18 @@
 #define AD4695_CMD_VOLTAGE_CHAN(n)	(0x10 | (n))
 
 /* timing specs */
+#define AD4695_T_CNVL_NS		80
 #define AD4695_T_CONVERT_NS		415
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
@@ -254,6 +273,62 @@ static int ad4695_set_single_cycle_mode(struct ad4695_state *st,
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
+	u32 mask, val;
+	int ret;
+
+	mask = AD4695_REG_SEQ_CTRL_STD_SEQ_EN;
+	val = FIELD_PREP(AD4695_REG_SEQ_CTRL_STD_SEQ_EN, 0);
+
+	mask |= AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS;
+	val |= FIELD_PREP(AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS, n - 1);
+
+	ret = regmap_update_bits(st->regmap, AD4695_REG_SEQ_CTRL, mask, val);
+	if (ret)
+		return ret;
+
+	mask = AD4695_REG_SETUP_SPI_MODE;
+	val = FIELD_PREP(AD4695_REG_SETUP_SPI_MODE, 1);
+
+	mask |= AD4695_REG_SETUP_SPI_CYC_CTRL;
+	val |= FIELD_PREP(AD4695_REG_SETUP_SPI_CYC_CTRL, 0);
+
+	return regmap_update_bits(st->regmap, AD4695_REG_SETUP, mask, val);
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
+	struct spi_transfer xfer = { };
+
+	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
+	xfer.tx_buf = &st->cnv_cmd2;
+	xfer.len = 1;
+	xfer.delay.value = AD4695_T_REGCONFIG_NS;
+	xfer.delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
 static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)
 {
 	u8 val;
@@ -296,6 +371,147 @@ static int ad4695_write_chn_cfg(struct ad4695_state *st,
 				  mask, val);
 }
 
+static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	struct spi_transfer *xfer;
+	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
+	bool temp_chan_en = false;
+	u32 reg, mask, val, bit, num_xfer, num_slots;
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
+	xfer->delay.value = AD4695_T_CNVL_NS;
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
+			temp_chan_en = true;
+		} else {
+			reg = AD4695_REG_AS_SLOT(num_slots);
+			val = FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit);
+
+			ret = regmap_write(st->regmap, reg, val);
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
+	 * Don't keep CS asserted after last xfer. Also triggers conversion of
+	 * slot 0.
+	 */
+	xfer->cs_change = 0;
+
+	/**
+	 * The advanced sequencer requires that at least 2 slots are enabled.
+	 * Since slot 0 is always used for other purposes, we need only 1
+	 * enabled voltage channel to meet this requirement. This error will
+	 * only happen if only the temperature channel is enabled.
+	 */
+	if (num_slots < 2) {
+		dev_err_ratelimited(&indio_dev->dev,
+			"Buffered read requires at least 1 voltage channel enabled\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Temperature channel isn't included in the sequence, but rather
+	 * controlled by setting a bit in the TEMP_CTRL register.
+	 */
+
+	reg = AD4695_REG_TEMP_CTRL;
+	mask = AD4695_REG_TEMP_CTRL_TEMP_EN;
+	val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
+
+	ret = regmap_update_bits(st->regmap, reg, mask, val);
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
+	if (ret) {
+		spi_unoptimize_message(&st->buf_read_msg);
+		return ret;
+	}
+
+	return 0;
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
@@ -527,6 +743,10 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 	/* Temperature channel must be next scan index after voltage channels. */
 	st->iio_chan[i] = ad4695_temp_channel_template;
 	st->iio_chan[i].scan_index = i;
+	i++;
+
+	st->iio_chan[i] = ad4695_soft_timestamp_channel_template;
+	st->iio_chan[i].scan_index = i;
 
 	return 0;
 }
@@ -695,7 +915,14 @@ static int ad4695_probe(struct spi_device *spi)
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



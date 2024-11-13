Return-Path: <linux-iio+bounces-12226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82049C7D2C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6828B1F22E2B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912D2071EF;
	Wed, 13 Nov 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iu2415SD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6F15AAC1
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531188; cv=none; b=WXO/5nk2oTTP8x6r+13poXA2TjmQ0JsN4P2BhU+c4AdgQPHFtXyH3FFSgrZUhXdzP/dnp68u74zZg6RkcJ0Cvil4Ze33wi1SA9MoU1Ez8SEsT2jHcaSn2RUty/Wcs58Rc3siW7dz9ncI/pMj3+y8IS+1gls/26e05anlB7TyT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531188; c=relaxed/simple;
	bh=inYPjYm6sWO4oCa64YYvhao2qecb1g1DwZ4g5dtN9AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcRvGtQG/erveEXEILR5J5imYikcPAidcAELy6Y242uhOPGXBzVMmf4LXe0u2Tu+vMduPFx5kKo99rgTzYjfDckIPaoiYaeAmX4yO6TXvmesUWqGCeAfbcunEfQIHte+FFWprvNhRqZ88rPZRZYfZ9zBKU7qy4ngtz+qU6v/JVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iu2415SD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so50339806d6.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531185; x=1732135985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1IRlM14Re6YTgXmGb4nIZwdTV5d6qwkRvdoFKXb/hE=;
        b=Iu2415SDL+VxfrSFLsO6yfi8X0BDcsHlkHqkqZ08ImD2j4FLsVL0o2j7DHFtHcURAC
         yhrLz4cnf6mxLqacyFz11SNJB4AiwXPcbup/iIH7lRAvPAIvsaZflUuK6VOZ+AGP1F0c
         oV6kVdPgvj7ZVhUCXJ43I9vAtMf/NlDY6dF+cbH+5v7cmGkTusRjUtxbbVFCO5QeVyWb
         hh3DqK11mmclmZt3K0WlTs3WbRRl8q6W978J35msBllASFY6Uh7oGttYC1iXnrdNZHHm
         TJ9cGN/2GV0Fhkp+4ikdWNKF2w1J7kiav7l3UPFJJtFF2mq0FI7MssAaVvl4TAwVyS8J
         MZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531185; x=1732135985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1IRlM14Re6YTgXmGb4nIZwdTV5d6qwkRvdoFKXb/hE=;
        b=QJjdB/brTnOVVVgjN/eiCjX86Ra8XUUgKJLEC1Yov4UINePVI7YcYU9bF35J+YEuYY
         Y/TcMH+kK1zF11HjlxRWHghlaLaLcBwwGFvjjoggN1cOwwUcYez5l5Gch7Jn6W1ZoIao
         aNlBFsb4T3cFd4aCrIgZyUJW9lfETRCElS5a3q6xM32Rcd9M+gc6NjuTiUadv9ItatkY
         4hb08SxDtwItDwDmTesSO0Pkm6SH75KhI/Da0inkdcxNxmwsA4bllyx1lrQnPiPD9OoY
         n9SNiddGTGPjaRjwFJksrtB2rMEpJ9QzYiZHcuKlcWtbKJXdZ7/Byn1+0bIGRygXo9Nk
         ExIw==
X-Forwarded-Encrypted: i=1; AJvYcCUq8s32Qyd4SsXMekuztMW2NH1mx1/ahn7QdV33JkW+vZZpavPCHMfeSDrPE3bOCtQ9MEIW6suRLRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVFZs47eW7+seJCyXqVKcGQdr7Ym7TF5ufzPSQMR28URijxWu
	BVRXTxAzzK3Vj4f9kWQ8G4Rcqgmr4Z5rKFjtPrhZvubkwmk6JfTJyXg6EAFDwD/Tlcpjyf3PlKc
	O
X-Google-Smtp-Source: AGHT+IF67ezHsmerGAYtKOJ6aXjMLI5v44DpR71gf0fhQIS/DNRdN3lY67eE0w9zQq/Qb/LryneyOg==
X-Received: by 2002:a05:6214:3290:b0:6d1:86b2:5569 with SMTP id 6a1803df08f44-6d39e112ac1mr294129606d6.16.1731531185555;
        Wed, 13 Nov 2024 12:53:05 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2f5sm88829336d6.2.2024.11.13.12.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:53:04 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 13 Nov 2024 15:52:58 -0500
Subject: [PATCH v2 1/3] iio: adc: ad4695: fix buffered read, single sample
 timings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tgamblin-ad4695_improvements-v2-1-b6bb7c758fc4@baylibre.com>
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Modify ad4695_buffer_preenable() by adding an extra SPI transfer after
each data read to help ensure that the timing requirement between the
last SCLK rising edge and the next CNV rising edge is met. This requires
a restructure of the buf_read_xfer array in ad4695_state. Also define
AD4695_T_SCK_CNV_DELAY_NS to use for each added transfer. Without this
change it is possible for the data to become corrupted on sequential
buffered reads due to the device not properly exiting conversion mode.

Similarly, make adjustments to ad4695_read_one_sample() so that timings
are respected, and clean up the function slightly in the process.

Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 100 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 595ec4158e73..0146aed9069f 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -91,6 +91,7 @@
 #define AD4695_T_WAKEUP_SW_MS		3
 #define AD4695_T_REFBUF_MS		100
 #define AD4695_T_REGCONFIG_NS		20
+#define AD4695_T_SCK_CNV_DELAY_NS	80
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
@@ -132,8 +133,13 @@ struct ad4695_state {
 	unsigned int vref_mv;
 	/* Common mode input pin voltage. */
 	unsigned int com_mv;
-	/* 1 per voltage and temperature chan plus 1 xfer to trigger 1st CNV */
-	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS + 2];
+	/*
+	 * 2 per voltage and temperature chan plus 1 xfer to trigger 1st
+	 * CNV. Excluding the trigger xfer, every 2nd xfer only serves
+	 * to control CS and add a delay between the last SCLK and next
+	 * CNV rising edges.
+	 */
+	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
 	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
@@ -423,7 +429,7 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
 	u32 bit, num_xfer, num_slots;
 	u32 temp_en = 0;
-	int ret;
+	int ret, rx_buf_offset = 0;
 
 	/*
 	 * We are using the advanced sequencer since it is the only way to read
@@ -449,11 +455,9 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 	iio_for_each_active_channel(indio_dev, bit) {
 		xfer = &st->buf_read_xfer[num_xfer];
 		xfer->bits_per_word = 16;
-		xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
+		xfer->rx_buf = &st->buf[rx_buf_offset];
 		xfer->len = 2;
-		xfer->cs_change = 1;
-		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
-		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		rx_buf_offset += xfer->len;
 
 		if (bit == temp_chan_bit) {
 			temp_en = 1;
@@ -468,21 +472,44 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 		}
 
 		num_xfer++;
+
+		/*
+		 * We need to add a blank xfer in data reads, to meet the timing
+		 * requirement of a minimum delay between the last SCLK rising
+		 * edge and the CS deassert.
+		 */
+		xfer = &st->buf_read_xfer[num_xfer];
+		xfer->delay.value = AD4695_T_SCK_CNV_DELAY_NS;
+		xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer->cs_change = 1;
+		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
+		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+		num_xfer++;
 	}
 
 	/*
 	 * The advanced sequencer requires that at least 2 slots are enabled.
 	 * Since slot 0 is always used for other purposes, we need only 1
-	 * enabled voltage channel to meet this requirement. If the temperature
-	 * channel is the only enabled channel, we need to add one more slot
-	 * in the sequence but not read from it.
+	 * enabled voltage channel to meet this requirement.  If the temperature
+	 * channel is the only enabled channel, we need to add one more slot in
+	 * the sequence but not read from it. This is because the temperature
+	 * sensor is sampled at the end of the channel sequence in advanced
+	 * sequencer mode (see datasheet page 38).
+	 *
+	 * From the iio_for_each_active_channel() block above, we now have an
+	 * xfer with data followed by a blank xfer to allow us to meet the
+	 * timing spec, so move both of those up before adding an extra to
+	 * handle the temperature-only case.
 	 */
 	if (num_slots < 2) {
-		/* move last xfer so we can insert one more xfer before it */
-		st->buf_read_xfer[num_xfer] = *xfer;
+		/* Move last two xfers */
+		st->buf_read_xfer[num_xfer] = st->buf_read_xfer[num_xfer - 1];
+		st->buf_read_xfer[num_xfer - 1] = st->buf_read_xfer[num_xfer - 2];
 		num_xfer++;
 
-		/* modify 2nd to last xfer for extra slot */
+		/* Modify inserted xfer for extra slot. */
+		xfer = &st->buf_read_xfer[num_xfer - 3];
 		memset(xfer, 0, sizeof(*xfer));
 		xfer->cs_change = 1;
 		xfer->delay.value = st->chip_info->t_acq_ns;
@@ -499,6 +526,12 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 			return ret;
 
 		num_slots++;
+
+		/*
+		 * We still want to point at the last xfer when finished, so
+		 * update the pointer.
+		 */
+		xfer = &st->buf_read_xfer[num_xfer - 1];
 	}
 
 	/*
@@ -583,8 +616,20 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
  */
 static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 {
-	struct spi_transfer xfer[2] = { };
-	int ret, i = 0;
+	struct spi_transfer xfers[2] = {
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.bits_per_word = 16,
+			.tx_buf = &st->cnv_cmd,
+			.len = 2,
+		},
+		{
+			/* Required delay between last SCLK and CNV/CS */
+			.delay.value = AD4695_T_SCK_CNV_DELAY_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+		}
+	};
+	int ret;
 
 	ret = ad4695_set_single_cycle_mode(st, address);
 	if (ret)
@@ -592,29 +637,22 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 
 	/*
 	 * Setting the first channel to the temperature channel isn't supported
-	 * in single-cycle mode, so we have to do an extra xfer to read the
-	 * temperature.
+	 * in single-cycle mode, so we have to do an extra conversion to read
+	 * the temperature.
 	 */
 	if (address == AD4695_CMD_TEMP_CHAN) {
-		/* We aren't reading, so we can make this a short xfer. */
-		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
-		xfer[0].tx_buf = &st->cnv_cmd2;
-		xfer[0].len = 1;
-		xfer[0].cs_change = 1;
-		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
-		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
-
-		i = 1;
+		st->cnv_cmd = AD4695_CMD_TEMP_CHAN << 11;
+
+		ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+		if (ret)
+			return ret;
 	}
 
 	/* Then read the result and exit conversion mode. */
 	st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
-	xfer[i].bits_per_word = 16;
-	xfer[i].tx_buf = &st->cnv_cmd;
-	xfer[i].rx_buf = &st->raw_data;
-	xfer[i].len = 2;
+	xfers[0].rx_buf = &st->raw_data;
 
-	return spi_sync_transfer(st->spi, xfer, i + 1);
+	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static int ad4695_read_raw(struct iio_dev *indio_dev,

-- 
2.39.5



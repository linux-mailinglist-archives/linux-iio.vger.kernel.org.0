Return-Path: <linux-iio+bounces-4948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00868C2E2A
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 02:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17DD1C21566
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2481DFF2;
	Sat, 11 May 2024 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JXcOWyD8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B51BC2F
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388607; cv=none; b=nWJiTjuml+d2mhiy4M5HMiPcmG8hhZ0sHksuzbrQZL5p/tMOVVeGHMf48rpeheMHAGKpE0ikUeRovf8Nn3pt5UDnzB9/Q5mwjHxtMh2chcJTKZIKOXgWMT5evmenbAU4HtEPw+y/GmnL0zS3Ngcu7Erw6w7d/Gk02H3ON0yKulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388607; c=relaxed/simple;
	bh=qfovg8GPkCrYv+M58MvC1AwOylMJYvN79Ny2UrHzdtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbuCdC/oO3+8EWsBT4k22YVsquuuaUMKKIQxMhVsHE17c/oesyiDmreJOHcIgEKdQEICh12DIx1+L4TjNxg80WeE8ETmiBbbeXUSsL7RUd0Wlvfdc3VGkGomHZbcsgHCe/xpp5IuDDnvLaTwTOzqEzVDIeit/k//Fi4CvMoW1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JXcOWyD8; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so1774232eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388604; x=1715993404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sef0yxj3M0McfXOWyYuZh5QNVIS4E8ybwIxSMPcOtQk=;
        b=JXcOWyD8VBvKnYW77q19opIK1vz4yClDsHyCvB/utsUPEdO5Mr3R39PJR0/oEAbYcl
         kRviy2Kc2QENOgs/R/0n8vfpVSKhaazqNdkght3zIY+CDWkj99Mj1NNanFdfDdHAPqVC
         FX4K8EJPdTWfYltaAHNSPWg4LysuT7tfgPNhhlv+6MhHXSn199YjNx0wkqmTD1nUOqdv
         o7xXLsZJXsMqrWd4Fia5EPtoMEtxhptNowK7IofVxdaAIuMzZLEOzAw6aLkzs2pz8Sq5
         KApBEZVm6pufbasNL/la4BRiH6YW9OQsKeYQYvpLtt8GGMqaGm8VXFZUd6pg22pMJViR
         fQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388604; x=1715993404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sef0yxj3M0McfXOWyYuZh5QNVIS4E8ybwIxSMPcOtQk=;
        b=B4N9kQGoyi1eZ3RB/JHHjsBIkaGTbmfbb46Jpksqp5GTz3WbBPlzjXOgWY86K1R5lH
         L6Jtau84iEvURkw/3CFUcguHrhDQNM/uAyUw8YZwOlyXH6Wbtgei2MjnAvz9UBrHnuIM
         XkHW9JrnQvoRyZ2CuHOhjH+JcH1+qHCWb1UmSx7xAJbXoAyeNaQTX+nmcD/RYxTOKS6z
         7QmlHpBJtpb8owUIUwcXgb1ZRKMzQXpAm0QCUhsWH4sNxCuUBiJNm/G3vltXiBj6GE5B
         Fy7KNGhJ92b3X1YtaYyyEypYYoPYT+TG8L+txYS3k2ERvqzDYfDkIBFnZ4ZF5PQHRt1s
         BQDg==
X-Forwarded-Encrypted: i=1; AJvYcCVab5RHEjrGbqKic6/swNafeT0OObHvRaxwY6BaUD0ebOwMTKmvxxl2s8EayNjmqAxF1DevyGwsyKWVn0J3vdkonPP0IgRZlCDc
X-Gm-Message-State: AOJu0YwUvxVzyrMx6XDuG9OYvMRskog9hgWeZqRnArFzET8kNeLdLTIr
	0TDGN9eTb64WsVQP/qBlGiczYyzKFLlxBG3d8aowB/+H/HoyxvWbqTSFjR3jUDo=
X-Google-Smtp-Source: AGHT+IFISSd56LKo6PC65Rb6v16dDvY0nToNpJBuoPHdhJJv2V9+3eeHEwn6BehsohvwaWKdMXJowQ==
X-Received: by 2002:a4a:8c21:0:b0:5b1:b8a4:bce4 with SMTP id 006d021491bc7-5b281a1b6a7mr4188517eaf.8.1715388604085;
        Fri, 10 May 2024 17:50:04 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:50:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v2 8/8] iio: adc: ad7944: add support for SPI offload
Date: Fri, 10 May 2024 19:44:31 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-8-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds support for SPI offload to the ad7944 driver. This allows
reading data at the max sample rate of 2.5 MSPS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

In the previous version, there was a new separate driver for the PWM
trigger and DMA hardware buffer. This was deemed too complex so they
are moved into the ad7944 driver.

It has also been reworked to accommodate for the changes described in
the other patches.

RFC: This isn't very polished yet, just FYI. A few things to sort out:

Rather than making the buffer either triggered buffer or hardware buffer,
I'm considering allowing both, e.g. buffer0 will always be the triggered
buffer and buffer1 will will be the hardware buffer if connected to a SPI
controller with offload support, otherwise buffer1 is absent. But since
multiple buffers haven't been used much so far, more investigation is
needed to see how that would work in practice. If we do that though, then
we would always have the sampling_frequency attribute though even though
it only applies to one buffer.
---
 drivers/iio/adc/ad7944.c | 147 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4602ab5ed2a6..6724d6c92778 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -21,6 +22,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -65,6 +67,8 @@ struct ad7944_adc {
 	bool always_turbo;
 	/* Reference voltage (millivolts). */
 	unsigned int ref_mv;
+	/* Clock that triggers SPI offload. */
+	struct clk *trigger_clk;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -123,6 +127,7 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
 			.scan_type.endianness = IIO_CPU,		\
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
 					| BIT(IIO_CHAN_INFO_SCALE),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		},							\
 		IIO_CHAN_SOFT_TIMESTAMP(1),				\
 	},								\
@@ -134,18 +139,12 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
-static void ad7944_unoptimize_msg(void *msg)
-{
-	spi_unoptimize_message(msg);
-}
-
-static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
-					 const struct iio_chan_spec *chan)
+static void ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+					  const struct iio_chan_spec *chan)
 {
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -174,21 +173,14 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 	xfers[2].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
-
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
 }
 
-static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
-				      const struct iio_chan_spec *chan)
+static void ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+				       const struct iio_chan_spec *chan)
 {
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -208,12 +200,6 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
-
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
 }
 
 static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -345,6 +331,30 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!adc->trigger_clk)
+			return -EOPNOTSUPP;
+
+		*val = clk_get_rate(adc->trigger_clk);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7944_write_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int val, int val2, long info)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!adc->trigger_clk)
+			return -EOPNOTSUPP;
+
+		return clk_set_rate(adc->trigger_clk, val);
 	default:
 		return -EINVAL;
 	}
@@ -352,6 +362,28 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7944_iio_info = {
 	.read_raw = &ad7944_read_raw,
+	.write_raw = &ad7944_write_raw,
+};
+
+static int ad7944_offload_ex_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	return spi_offload_hw_trigger_enable(adc->spi, 0);
+}
+
+static int ad7944_offload_ex_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	spi_offload_hw_trigger_disable(adc->spi, 0);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7944_offload_ex_buffer_setup_ops = {
+	.postenable = &ad7944_offload_ex_buffer_postenable,
+	.predisable = &ad7944_offload_ex_buffer_predisable,
 };
 
 static irqreturn_t ad7944_trigger_handler(int irq, void *p)
@@ -471,6 +503,18 @@ static void ad7944_ref_disable(void *ref)
 	regulator_disable(ref);
 }
 
+static void ad7944_offload_unprepare(void *p)
+{
+	struct ad7944_adc *adc = p;
+
+	spi_offload_unprepare(adc->spi, 0, &adc->msg);
+}
+
+static void ad7944_unoptimize_msg(void *msg)
+{
+	spi_unoptimize_message(msg);
+}
+
 static int ad7944_probe(struct spi_device *spi)
 {
 	const struct ad7944_chip_info *chip_info;
@@ -603,16 +647,10 @@ static int ad7944_probe(struct spi_device *spi)
 
 	switch (adc->spi_mode) {
 	case AD7944_SPI_MODE_DEFAULT:
-		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
-		if (ret)
-			return ret;
-
+		ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
 		break;
 	case AD7944_SPI_MODE_SINGLE:
-		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
-		if (ret)
-			return ret;
-
+		ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
 		break;
 	case AD7944_SPI_MODE_CHAIN:
 		ret = device_property_read_u32(dev, "#daisy-chained-devices",
@@ -649,11 +687,48 @@ static int ad7944_probe(struct spi_device *spi)
 		indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad7944_trigger_handler, NULL);
-	if (ret)
-		return ret;
+	if (device_property_present(dev, "spi-offloads")) {
+		/* TODO: make this a parameter to ad7944_3wire_cs_mode_init_msg() */
+		/* FIXME: wrong index for 4-wire mode */
+		adc->xfers[2].rx_buf = NULL;
+		adc->xfers[2].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+		ret = spi_offload_prepare(adc->spi, 0, &adc->msg);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to prepare offload\n");
+
+		ret = devm_add_action_or_reset(dev, ad7944_offload_unprepare, adc);
+		if (ret)
+			return ret;
+
+		adc->trigger_clk = devm_clk_get_enabled(dev, "trigger");
+		if (IS_ERR(adc->trigger_clk))
+			return dev_err_probe(dev, PTR_ERR(adc->trigger_clk),
+					     "failed to get trigger clk\n");
+
+		ret = devm_iio_dmaengine_buffer_setup(dev, indio_dev, "rx");
+		if (ret)
+			return ret;
+
+		indio_dev->setup_ops = &ad7944_offload_ex_buffer_setup_ops;
+		/* offload can't have soft timestamp */
+		indio_dev->num_channels--;
+	} else {
+		ret = spi_optimize_message(adc->spi, &adc->msg);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad7944_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.43.2



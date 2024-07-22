Return-Path: <linux-iio+bounces-7811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41D939634
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D6D1F21EB2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2712F37C;
	Mon, 22 Jul 2024 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KwXQMUiT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDE4CB2B
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685698; cv=none; b=G+MwZaUEeeGoO/vzXLHYwqTrSu5YsgoXs2fixvIl2fjh1ZU4CIlIpa7XBc4XeLy6NVgSofHxizs4TdiXBcnDX70cn9cV0spl2qpXM1diybFYAyPpuiscjX8ARS9X+ZFM3hkHTgpzJ8u5I6LBmkDe9eeWfEWTPjYxjZAFnNrJsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685698; c=relaxed/simple;
	bh=wLwtAkIBM4hq/kR6Mmx+dPtGfZzSSBSwcvcMoP+c4hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxHw01wxF2N3bbQ1wkQfjpP/DxdaGK3r3LsN50X4PVQ8Z1R+ESpdkgWaUbMo5YGQoLlJe8rrT8tqk7Zc2ngn52VLyWX7ncZo0fRukBIdHpLJI0glh6D+dM+DiLiZzsas2SO6oLtef+5OkQ3S8LR0wrB2PJZP0quh496AxGECDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KwXQMUiT; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-704466b19c4so2251935a34.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685694; x=1722290494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhPgWBgcgXIA+u+ClJPVILjR7vSD2cCOFhbPqeE2xbQ=;
        b=KwXQMUiTtm5zOKk7tW2xHx1Gl/lne+8fBJsfiSG3ccUbsqMrz8QsIhrQGK5sYbHFz4
         hWEeIPLMr/veXavhXXw2N4re2PmZjpMxDqKq+iRa+Jcu/LeGoNM0ecH6Eiw9sk1l01en
         CRa3/kUdncvsC8PXaWXDiriYo8+geX0pQpQnLcGiBYh04ruoUezi2qeTJpJWMBl/grzQ
         Kf78qZIRkyhNaZH766N3ClXt9AF3UJqtWgg9NeJirK4UAmNsT6QgCMbSjGAHwzvX6Kqb
         UDq7NiI6jHgqWMZaLhcL8YSvAvShVFCggeL9jq3TVpVw7CojK+JcEzQ8uRFVgiHrhMOf
         X+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685694; x=1722290494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhPgWBgcgXIA+u+ClJPVILjR7vSD2cCOFhbPqeE2xbQ=;
        b=QR8lYoQSqm+9ojVj8juEJ1Bt3/PfZTW2RFo4ByPJYDk7luilvfkIt8+cfL8vwF34US
         M1c27G0yTdWjMQ8Vlv9xWpJYYrpTv9zylijgjfkMqFfe+1N3HM/3qmNl9fHdHFaoowJu
         FPY/GCPdHEzbOeEjZ4Mxh0hRbiOG8G3//7VHDwz59pRgX4RDyk+//gh02Q/AQAZkdX5e
         WeG22xFLXjeciSv1zafu3agUd4ek60BisDJgCs4HC+DwNdpDGT6zrLBjr6gc6zFSCMlL
         hJadcZu8LX5BOBcmqYxX1wcopitpPhW+djUaolk2ll/UkliPFuVx84e9zWSPgZyGZVG4
         EK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOpqgmUSFREFVE1xix38Ju/YxfVstTna9NG61LEI3GAQb7ktusJuF4b9D61hXwCqJgny4oeQsMkKBjLNe851AhDtQluryS1k5H
X-Gm-Message-State: AOJu0YzCW5ixZPeKsrj/C4qtG0hkFejy3pkWBOf5pbzSMf7NV/fNlGqe
	F4yQy+T0tGLdXYrG2sWz58Apu6l6Sv4/j+OQ8uZRqD5GGGZGmOB736kJAqVTjOg=
X-Google-Smtp-Source: AGHT+IHXDgeNbeZYlN1uzwQdl3tCZ2beK6K+VycJjOQkxwH827CZ/P//PGWZ3iQGkscdaaE2b16UQA==
X-Received: by 2002:a05:6830:6a16:b0:703:6ca6:27 with SMTP id 46e09a7af769-708fdb34f44mr13425465a34.16.1721685694085;
        Mon, 22 Jul 2024 15:01:34 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:33 -0700 (PDT)
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
Subject: [PATCH RFC v3 9/9] iio: adc: ad7944: add support for SPI offload
Date: Mon, 22 Jul 2024 16:57:16 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-9-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This adds support for SPI offload to the ad7944 driver. This allows
reading data at the max sample rate of 2.5 MSPS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Note: in v2 we discussed if we should make the SPI offload use buffer1
instead of buffer0 as to not break userspace. I'm still on the fence
about if we should do that or not. Mainly because many userspace tools
aren't aware of multiple buffers yet, so would make it harder to
use the driver. And technically, the way it is implemented right now
is not going to change anything for existing users since they won't
be using the offload feature. So the argument could be made that this
isn't really breaking userspace after all.

v3 changes:
* Finished TODOs.
* Adapted to changes in other patches.

v2 changes:

In the previous version, there was a new separate driver for the PWM
trigger and DMA hardware buffer. This was deemed too complex so they
are moved into the ad7944 driver.

It has also been reworked to accommodate for the changes described in
the other patches.
---
 drivers/iio/adc/ad7944.c | 173 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 166 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 0f36138a7144..43674ff439d2 100644
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
 
@@ -54,6 +56,8 @@ struct ad7944_adc {
 	enum ad7944_spi_mode spi_mode;
 	struct spi_transfer xfers[3];
 	struct spi_message msg;
+	struct spi_transfer offload_xfers[3];
+	struct spi_message offload_msg;
 	void *chain_mode_buf;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
@@ -65,6 +69,8 @@ struct ad7944_adc {
 	bool always_turbo;
 	/* Reference voltage (millivolts). */
 	unsigned int ref_mv;
+	/* Clock that triggers SPI offload. */
+	struct clk *trigger_clk;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -81,6 +87,8 @@ struct ad7944_adc {
 
 /* quite time before CNV rising edge */
 #define T_QUIET_NS	20
+/* minimum CNV high time to trigger conversion */
+#define T_CNVH_NS	20
 
 static const struct ad7944_timing_spec ad7944_timing_spec = {
 	.conv_ns = 420,
@@ -123,6 +131,7 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
 			.scan_type.endianness = IIO_CPU,		\
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
 					| BIT(IIO_CHAN_INFO_SCALE),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		},							\
 		IIO_CHAN_SOFT_TIMESTAMP(1),				\
 	},								\
@@ -236,6 +245,54 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
+static void ad7944_offload_unprepare(void *p)
+{
+	struct ad7944_adc *adc = p;
+
+	spi_offload_unprepare(adc->spi, NULL, &adc->offload_msg);
+}
+
+/*
+ * Unlike ad7944_3wire_cs_mode_init_msg(), this creates a message that reads
+ * during the conversion phase instead of the acquisition phase when reading
+ * a sample from the ADC. This is needed to be able to read at the maximum
+ * sample rate. It requires the SPI controller to have offload support and a
+ * high enough SCLK rate to read the sample during the conversion phase.
+ */
+static int ad7944_3wire_cs_mode_init_offload_msg(struct device *dev,
+						 struct ad7944_adc *adc,
+						 const struct iio_chan_spec *chan)
+{
+	struct spi_transfer *xfers = adc->offload_xfers;
+	int ret;
+
+	/*
+	 * CS is tied to CNV and we need a low to high transition to start the
+	 * conversion, so place CNV low for t_QUIET to prepare for this.
+	 */
+	xfers[0].delay.value = T_QUIET_NS;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/* CNV has to be high for a minimum time to trigger conversion. */
+	xfers[1].cs_off = 1;
+	xfers[1].delay.value = T_CNVH_NS;
+	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/* Then we can read the previous sample during the conversion phase */
+	xfers[2].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->offload_msg, xfers,
+					ARRAY_SIZE(adc->offload_xfers));
+
+	ret = spi_offload_prepare(adc->spi, NULL, &adc->offload_msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to prepare offload\n");
+
+	return devm_add_action_or_reset(dev, ad7944_offload_unprepare, adc);
+}
+
 /**
  * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
@@ -323,6 +380,30 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
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
@@ -330,6 +411,48 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7944_iio_info = {
 	.read_raw = &ad7944_read_raw,
+	.write_raw = &ad7944_write_raw,
+};
+
+static int ad7944_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	gpiod_set_value_cansleep(adc->turbo, 1);
+
+	ret = clk_prepare_enable(adc->trigger_clk);
+	if (ret)
+		goto err_turbo_off;
+
+	ret = spi_offload_hw_trigger_mode_enable(adc->spi, NULL);
+	if (ret)
+		goto err_clk_off;
+
+	return 0;
+
+err_clk_off:
+	clk_disable_unprepare(adc->trigger_clk);
+err_turbo_off:
+	gpiod_set_value_cansleep(adc->turbo, 0);
+
+	return ret;
+}
+
+static int ad7944_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	spi_offload_hw_trigger_mode_disable(adc->spi, NULL);
+	clk_disable_unprepare(adc->trigger_clk);
+	gpiod_set_value_cansleep(adc->turbo, 0);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7944_offload_buffer_setup_ops = {
+	.postenable = &ad7944_offload_buffer_postenable,
+	.predisable = &ad7944_offload_buffer_predisable,
 };
 
 static irqreturn_t ad7944_trigger_handler(int irq, void *p)
@@ -444,6 +567,11 @@ static const char * const ad7944_power_supplies[] = {
 	"avdd",	"dvdd",	"bvdd", "vio"
 };
 
+static void ad7944_put_clk_trigger(void *p)
+{
+	clk_put(p);
+}
+
 static int ad7944_probe(struct spi_device *spi)
 {
 	const struct ad7944_chip_info *chip_info;
@@ -554,13 +682,11 @@ static int ad7944_probe(struct spi_device *spi)
 		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
 		if (ret)
 			return ret;
-
 		break;
 	case AD7944_SPI_MODE_SINGLE:
 		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
 		if (ret)
 			return ret;
-
 		break;
 	case AD7944_SPI_MODE_CHAIN:
 		ret = device_property_read_u32(dev, "#daisy-chained-devices",
@@ -597,11 +723,43 @@ static int ad7944_probe(struct spi_device *spi)
 		indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad7944_trigger_handler, NULL);
-	if (ret)
-		return ret;
+	if (device_property_present(dev, "spi-offloads")) {
+		if (adc->spi_mode != AD7944_SPI_MODE_SINGLE)
+			return dev_err_probe(dev, -EINVAL,
+					     "offload only supported in single mode\n");
+
+		ret = ad7944_3wire_cs_mode_init_offload_msg(dev, adc,
+							    &chip_info->channels[0]);
+		if (ret)
+			return ret;
+
+		adc->trigger_clk = spi_offload_hw_trigger_get_clk(spi, NULL);
+		if (IS_ERR(adc->trigger_clk))
+			return dev_err_probe(dev, PTR_ERR(adc->trigger_clk),
+					     "failed to get trigger clk\n");
+
+		ret = devm_add_action_or_reset(dev, ad7944_put_clk_trigger,
+					       adc->trigger_clk);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev,
+			spi_offload_rx_stream_get_dma_chan(spi, NULL),
+			IIO_BUFFER_DIRECTION_IN);
+		if (ret)
+			return ret;
+
+		indio_dev->setup_ops = &ad7944_offload_buffer_setup_ops;
+		/* offload can't have soft timestamp */
+		indio_dev->num_channels--;
+	} else {
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad7944_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -636,3 +794,4 @@ module_spi_driver(ad7944_driver);
 MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD7944 PulSAR ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);

-- 
2.43.0



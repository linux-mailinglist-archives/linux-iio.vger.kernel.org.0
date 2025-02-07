Return-Path: <linux-iio+bounces-15148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CF0A2CDDB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE81699AB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55D1E0DCA;
	Fri,  7 Feb 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="blKpFvjl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F91DFE11
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959002; cv=none; b=ip1AIlIdvANau4wFQcCd6oLdasf8cJ61an7CdIL7FKBra2oMAXX/+U1doL/8JrJ4smTYzD2Lm3AntKj5YlCytddoCViPEbuedqS4/rdng7tRkhMiiCtXu6YF+CQoDUHwn9vwTT8fQvC2I0XU4C/QvYiZUrvip1piVA5C/qipllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959002; c=relaxed/simple;
	bh=tLizlzLwgQHZVLFutxZhfY3pv9A8Teg53pGXyak+xGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDnfGflH2645ZaD6HV65/ILq6W9fDXT3j7CXA1W+7y9fKAT8YTXK8B0tL/PhHvQ1G6KErCy6hcmuXJGCKm0PzLxZ2VycjrkB5DtH8dIGIMtMySOf7QyuRkvE4M0BKm8y1bFDw11w0ozS+WEYph6AyJkRtBofpjmHthVCO5LRILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=blKpFvjl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e565708beso1503174a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958999; x=1739563799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swdhvOmsaXx4i7dmA/GM5tND4Q4MNmxeKJptvQs4OEQ=;
        b=blKpFvjlXVQfTdNiVN/EcYi85K3CD3hu5RZT7Jh8K91uLtHQ+b+7/Y2HV4JLY45T2i
         47FhrDIOesVrVsgth7RyE6GiyEOtt0pOMnqqsDDT0tO6RFYpmhsbkVIwiPB4oxUGCP3j
         AM0s+BP/SKHMlkj9wifyeT4OsKjz/7PusTPmy3OQL3hQhMB10TdyCNOgUz9cFXADl39M
         jHtfjIAsj7rtTKnFMmJaQr5Dgz2Tq7+7ZP+xD2FhsHgfEtBorlrLKBEPBlUfL6cYPBzC
         3TqGiNhL7YGxEoebQnAn0iFSoHYKX5FWgkVfjTCD2fQhwIynbCk2hQHZ/8zFzAFj491c
         3dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958999; x=1739563799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swdhvOmsaXx4i7dmA/GM5tND4Q4MNmxeKJptvQs4OEQ=;
        b=H9ZmvWyz8UTC2rcNBtbkMkc180bQfN8oJPhOB8YS2Nd9vcnAVJHd5hGs3zeQqLUnhv
         GaZLdIcAcTU+2E01uoz1wSjlgi81+JrgBWoRYlcihzn42JytU1O8YvOsaXpnb/X2gQrs
         5xgilJc0aUSYESN1voVW3QFpXzPCcU/oZjaogNsFKpaBPld2UCovz1SHl+19yAiKkaJZ
         vtlGXtgic2SGipm+r09evn96bYlSVih4S4QU9LJLqC0PVPW5/j3CD7vGWAac9CyMcqw6
         nA19DZQs1Kpe2Im8QUD3zzuWmnZoSGOcJ7SeDb14jho2U/bTv6SxH9HMq7TWDnhEMkzB
         RS5w==
X-Forwarded-Encrypted: i=1; AJvYcCU447wgw0+bVusQe8zpdPADB30KVsFU4hSb2ufnsiWPW+h21+e/+sUcLeiU9EZudcI71hFbwGkciFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRkre3mNnTsn0jtOmsj7QuAbn1k+E44Ue9PN5FMtGqIF+DSzZ
	w6MbfoyBMZ7eUeRvovb9uyNFuu+WTG0TBHccbV9uWoA63AHdtFOJYIGNTQY88Hw=
X-Gm-Gg: ASbGncvh5HfuYw5bQy9eZVcpmxksVcPVj3Gt4bETti5CUhmE7BcLLsnyKPi+G2NlvZH
	k2GBAyXmHsESVDllOpEa8OPr4gCJkouUmj2JoZ9KEF7uTfC0XJO+AW9EiAOszldV+1RcKoFh0kE
	GJzk6e4UzoncV/FChHenziQQaXNxMKTPSHn3G8sS9LTsAT2x/gp/23z1zC5LCMp9NzsolLVXEB3
	dpL5S1XoYqhEm/r6St4EfKI71yFXVkanlPOpdR3iB3q0vDZVUrYlj56dnJCn6K6Oh4nykrgy/w8
	dFl1Kk6eCGRhJ4rTcJbkL0pJuDOCUhHi/YtLJVcpGoqFw6Y=
X-Google-Smtp-Source: AGHT+IH91tufyShH1cB+QwfqnbPdhPjOBiatDQJckt758pCIvv3nuGpnBSZuIupBhL5FP+01Xc2JEQ==
X-Received: by 2002:a05:6830:6c10:b0:71d:eee3:fd26 with SMTP id 46e09a7af769-726b87b7814mr3104475a34.4.1738958998924;
        Fri, 07 Feb 2025 12:09:58 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:14 -0600
Subject: [PATCH v8 17/17] iio: dac: ad5791: Add offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-17-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

From: Axel Haslam <ahaslam@baylibre.com>

Add SPI offload support to stream TX buffers using DMA.
This allows loading samples to the DAC with a rate of 1 MSPS.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes:
* Removed extra space character.
* Added write_raw_get_fmt callback to avoid having to check val2.
* Don't allow sampling frequency of 0 Hz.

v6 changes: new patch in v6
---
 drivers/iio/dac/Kconfig  |   3 +
 drivers/iio/dac/ad5791.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 5690a37267d86ea3ec805adfa32e13c052864061..4811ea973125a0dea1f8a9cdee1e0c045bc21981 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -296,6 +296,9 @@ config AD5770R
 config AD5791
 	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
 	depends on SPI
+	select SPI_OFFLOAD
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	help
 	  Say yes here to build support for Analog Devices AD5760, AD5780,
 	  AD5781, AD5790, AD5791 High Resolution Voltage Output Digital to
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 4f28f49071c244bfcd21c7553aa3e39e9751490a..07848be3f8d5654418ebbac7b33c14fd1014a2c8 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -15,9 +15,12 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/dac/ad5791.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -64,11 +67,13 @@
  * struct ad5791_chip_info - chip specific information
  * @name:		name of the dac chip
  * @channel:		channel specification
+ * @channel_offload:	channel specification for offload
  * @get_lin_comp:	function pointer to the device specific function
  */
 struct ad5791_chip_info {
 	const char *name;
 	const struct iio_chan_spec channel;
+	const struct iio_chan_spec channel_offload;
 	int (*get_lin_comp)(unsigned int span);
 };
 
@@ -81,6 +86,11 @@ struct ad5791_chip_info {
  * @gpio_clear:		clear gpio
  * @gpio_ldac:		load dac gpio
  * @chip_info:		chip model specific constants
+ * @offload_msg:	spi message used for offload
+ * @offload_xfer:	spi transfer used for offload
+ * @offload:		offload device
+ * @offload_trigger:	offload trigger
+ * @offload_trigger_hz:	offload sample rate
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
  * @ctrl:		control register cache
@@ -96,6 +106,11 @@ struct ad5791_state {
 	struct gpio_desc		*gpio_clear;
 	struct gpio_desc		*gpio_ldac;
 	const struct ad5791_chip_info	*chip_info;
+	struct spi_message		offload_msg;
+	struct spi_transfer		offload_xfer;
+	struct spi_offload		*offload;
+	struct spi_offload_trigger	*offload_trigger;
+	unsigned int			offload_trigger_hz;
 	unsigned short			vref_mv;
 	unsigned int			vref_neg_mv;
 	unsigned			ctrl;
@@ -232,6 +247,25 @@ static int ad5780_get_lin_comp(unsigned int span)
 		return AD5780_LINCOMP_10_20;
 }
 
+static int ad5791_set_sample_freq(struct ad5791_state *st, int val)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = val,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
 static int ad5791_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -259,6 +293,9 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		do_div(val64, st->vref_mv);
 		*val = -val64;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -299,6 +336,24 @@ static const struct ad5791_chip_info _name##_chip_info = {		\
 			},						\
 			.ext_info = ad5791_ext_info,			\
 	},								\
+	.channel_offload = {						\
+			.type = IIO_VOLTAGE,				\
+			.output = 1,					\
+			.indexed = 1,					\
+			.address = AD5791_ADDR_DAC0,			\
+			.channel = 0,					\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),		\
+			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = (bits),			\
+				.storagebits = 32,			\
+				.shift = (_shift),			\
+			},						\
+			.ext_info = ad5791_ext_info,			\
+	},								\
 }
 
 AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
@@ -322,14 +377,106 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 
 		return ad5791_spi_write(st, chan->address, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 1)
+			return -EINVAL;
+		return ad5791_set_sample_freq(st, val);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad5791_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int ad5791_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = st->offload_trigger_hz,
+		},
+	};
+
+	if (st->pwr_down)
+		return -EINVAL;
+
+	return spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+}
+
+static int ad5791_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad5791_buffer_setup_ops = {
+	.preenable = &ad5791_buffer_preenable,
+	.postdisable = &ad5791_buffer_postdisable,
+};
+
+static int ad5791_offload_setup(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = st->spi;
+	struct dma_chan *tx_dma;
+	int ret;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(&spi->dev,
+		st->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	ret = ad5791_set_sample_freq(st, 1 * MEGA);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to init sample rate\n");
+
+	tx_dma = devm_spi_offload_tx_stream_request_dma_chan(&spi->dev,
+							     st->offload);
+	if (IS_ERR(tx_dma))
+		return dev_err_probe(&spi->dev, PTR_ERR(tx_dma),
+				     "failed to get offload TX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(&spi->dev,
+		indio_dev, tx_dma, IIO_BUFFER_DIRECTION_OUT);
+	if (ret)
+		return ret;
+
+	st->offload_xfer.len = 4;
+	st->offload_xfer.bits_per_word = 24;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_TX_STREAM;
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(&spi->dev, st->spi, &st->offload_msg);
+}
+
 static const struct iio_info ad5791_info = {
 	.read_raw = &ad5791_read_raw,
 	.write_raw = &ad5791_write_raw,
+	.write_raw_get_fmt = &ad5791_write_raw_get_fmt,
+};
+
+static const struct spi_offload_config ad5791_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_TX_STREAM_DMA,
 };
 
 static int ad5791_probe(struct spi_device *spi)
@@ -416,6 +563,21 @@ static int ad5791_probe(struct spi_device *spi)
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 	indio_dev->name = st->chip_info->name;
+
+	st->offload = devm_spi_offload_get(&spi->dev, spi, &ad5791_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to get offload\n");
+
+	if (ret != -ENODEV) {
+		indio_dev->channels = &st->chip_info->channel_offload;
+		indio_dev->setup_ops = &ad5791_buffer_setup_ops;
+		ret = ad5791_offload_setup(indio_dev);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "fail to setup offload\n");
+	}
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
@@ -452,3 +614,4 @@ module_spi_driver(ad5791_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0



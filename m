Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F903C696C
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 06:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhGMEhn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 00:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhGMEh1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 00:37:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80EC0613DD;
        Mon, 12 Jul 2021 21:34:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h18so9751280qve.1;
        Mon, 12 Jul 2021 21:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPst0AOe1AQCYOq/F7geIJMMQOaSZ1mUrw6X55zyTro=;
        b=RjSLFtYOAR6jqXxMDMCwJOkqjpQ2WD26wahtuiA8QAb8QalANJQjOE2uqIRQ2DG5bI
         NDyUx+qfI/GZ9lgank/IMKkrt68JL+9Pk7yV/VbxbgVdxLT64KN5m5C3d1iq776dsKmv
         Ha6Yaq5npuqeW7MJqwnRJ/EGlu34YGkQvCpPggUln9P6KIgF60rUu/bEsYKn+ga62zsC
         B137oUx2TWgNDtO9LIewmKOteh25RMHtlcl6kBOYuc+aG7w5RAvxkpSDt6eMWExjRbEx
         KzGfHmEQik452fIZnZtNLacy4T6z9g+uSggAlBolFt68E59r7djFvwRYbU7Ipd15d3R6
         ebQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPst0AOe1AQCYOq/F7geIJMMQOaSZ1mUrw6X55zyTro=;
        b=gn6kPYfEfU4E+x+zPbRkLwFxZFfgdX4w02kUiC5HysgXcRfuosW8mmDi/MYTfkj97q
         lpCKP2I19ktawGcrTnq4S6bxk+YCESi3zESFCmYVKkGRXP/GNu8OjdwJ+TICiXrGCOCN
         yHTPGUCffHkqH8g81Cr+5R0an3+UrJmKkYHbItzuyMxzjmrLttKWGhTq0AdqQEfMePzp
         +ImXUZrMDwkKY3h/6b87TvVgfYyFECVKEyfa8RE8E34s1ZkXxp4qA2sISuruuddo5Mzm
         /8sz6XAxEYSZkLYwgXXiV5xL7TjgYlo+QIQm5BLG3C/vjXxbYSaWCl+/ycNn//mzAGmo
         a8tQ==
X-Gm-Message-State: AOAM533v7NOAsEt1P/cwe48i8xTnJZoAesRGl9xPtzgORq5/Fye7O99J
        eJnVCIlgvOY4vwbdxToCLt0=
X-Google-Smtp-Source: ABdhPJziAkj5OokxK1f1pbkRgjq3RkEjWcUQsrYYhMZxFVybSuzi/uadGT95l4MIAHM2+QS19Dy6Mw==
X-Received: by 2002:a05:6214:172:: with SMTP id y18mr2795217qvs.14.1626150876721;
        Mon, 12 Jul 2021 21:34:36 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x16sm7311455qkn.130.2021.07.12.21.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 21:34:36 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 2/4] iio: adc: ad7949: fix spi messages on non 14-bit controllers
Date:   Tue, 13 Jul 2021 00:34:23 -0400
Message-Id: <20210713043425.3321230-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210713043425.3321230-1-liambeguin@gmail.com>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

This driver supports devices with 14-bit and 16-bit sample sizes.
This is not always handled properly by spi controllers and can fail. To
work around this limitation, pad samples to 16-bit and split the sample
into two 8-bit messages in the event that only 8-bit messages are
supported by the controller.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/adc/ad7949.c | 68 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 0b549b8bd7a9..65f78751225b 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -12,6 +12,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/bitfield.h>
+#include <asm/unaligned.h>
 
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
 
@@ -67,6 +68,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
+ * @bits_per_word: number of bits per SPI word
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
  * @buffer: buffer to send / receive data to / from device
@@ -77,6 +79,7 @@ struct ad7949_adc_chip {
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	u8 resolution;
+	u8 bits_per_word;
 	u16 cfg;
 	unsigned int current_channel;
 	u16 buffer ____cacheline_aligned;
@@ -86,19 +89,37 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 				u16 mask)
 {
 	int ret;
-	int bits_per_word = ad7949_adc->resolution;
-	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
+	u8 buf8[2];
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
 			.tx_buf = &ad7949_adc->buffer,
 			.len = 2,
-			.bits_per_word = bits_per_word,
+			.bits_per_word = ad7949_adc->bits_per_word,
 		},
 	};
 
+	ad7949_adc->buffer = 0;
 	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
-	ad7949_adc->buffer = ad7949_adc->cfg << shift;
+
+	switch (ad7949_adc->bits_per_word) {
+	case 16:
+		ad7949_adc->buffer = ad7949_adc->cfg << 2;
+		break;
+	case 14:
+		ad7949_adc->buffer = ad7949_adc->cfg;
+		break;
+	case 8:
+		/* Pack 14-bit value into 2 bytes, MSB first */
+		buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
+		buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg) << 2;
+		memcpy(&ad7949_adc->buffer, buf8, 2);
+		break;
+	default:
+		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
+		return -EINVAL;
+	}
+
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -115,14 +136,13 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 {
 	int ret;
 	int i;
-	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
+	u8 buf8[2];
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
 			.rx_buf = &ad7949_adc->buffer,
 			.len = 2,
-			.bits_per_word = bits_per_word,
+			.bits_per_word = ad7949_adc->bits_per_word,
 		},
 	};
 
@@ -157,7 +177,26 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
 	ad7949_adc->current_channel = channel;
 
-	*val = ad7949_adc->buffer & mask;
+	switch (ad7949_adc->bits_per_word) {
+	case 16:
+		*val = ad7949_adc->buffer;
+		/* Shift-out padding bits */
+		*val >>= 16 - ad7949_adc->resolution;
+		break;
+	case 14:
+		*val = ad7949_adc->buffer & GENMASK(13, 0);
+		break;
+	case 8:
+		memcpy(buf8, &ad7949_adc->buffer, 2);
+		/* Convert byte array to u16, MSB first */
+		*val = get_unaligned_be16(buf8);
+		/* Shift-out padding bits */
+		*val >>= 16 - ad7949_adc->resolution;
+		break;
+	default:
+		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -265,6 +304,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 
 static int ad7949_spi_probe(struct spi_device *spi)
 {
+	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
@@ -291,6 +331,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	indio_dev->num_channels = spec->num_channels;
 	ad7949_adc->resolution = spec->resolution;
 
+	/* Set SPI bits per word */
+	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
+		ad7949_adc->bits_per_word = ad7949_adc->resolution;
+	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
+		ad7949_adc->bits_per_word = 16;
+	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
+		ad7949_adc->bits_per_word = 8;
+	} else {
+		dev_err(dev, "unable to find common BPW with spi controller\n");
+		return -EINVAL;
+	}
+
 	ad7949_adc->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(ad7949_adc->vref)) {
 		dev_err(dev, "fail to request regulator\n");
-- 
2.30.1.489.g328c10930387


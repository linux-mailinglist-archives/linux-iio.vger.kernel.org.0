Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89693C1C4C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 01:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhGHX70 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 19:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGHX7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 19:59:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BCC06175F;
        Thu,  8 Jul 2021 16:56:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id h18so3740389qve.1;
        Thu, 08 Jul 2021 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVsr3u5FZn5oLxXXzVZW3/8XKOH6zH3bJ++kgSeTyYQ=;
        b=pXSsX+XPbegDrtVIajxirPkiVDa0MvH+zzrRHNd660DaazOD+cVT3uI/A88iGT+IX6
         F8PevzYhspGEbTralVbdLbr5ZfA9+wQNBqqmX8QMmCQiSHI1f+LEhcK2xGp5p7JaT/Hk
         sRbBAkjlsXN5E16uOsRo8s1CpnJrh7vgl+cu6D+0MxUVca9Trd+qYNaLbyvVszXXmGUs
         0B8gFt6/GuAaaiQnCkW+SOkCpwcHG9QsZQWjhI7n/mhpVf8k4rsu48I2eXArUqV6mxnA
         B5jSbknYBv3NdOuAkMQnerzObwsTX6O5BNtcFc89hNsb8/u+TXBdl4gD/b/6uv+/LsMN
         UFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVsr3u5FZn5oLxXXzVZW3/8XKOH6zH3bJ++kgSeTyYQ=;
        b=EUv8MNTO2psMY4r+jUi9JQ7ThLlmoBX+cf6AWyWZFRfTE92oG3UH+pKHLZB/G4GJ7/
         z4C98aKTMOSIFGbgqfVliAlyzaoo3Og9htHxHFHpStOECpcl8ZxZB5rZwmqnnNybWHIC
         3y+KLWb7Rl9Nk6taHcF2hXurF1Gtb6MRnwTp6i4GwSTJEkoSjbSm/SM5HbW2zo5ptnI4
         grQ8Tz0VRq2Kr/RYqffAFpSrW5ecljUekHDQTAQe4KdAxqsNqnI5EK0bLe1YMMhEKFsG
         pIPk0AV41tm+0xzb00klgK82sDeC4cM8bcDVDZTWeWNvRo0kf2z0kg1+hrPX98bhtwz1
         btpw==
X-Gm-Message-State: AOAM5323tztfuAJr9sZ1yi6verXJ3ARdBi7eTXfxtJokiAqiD+W5ovC0
        HWd1Rm7FReh5CFMXdBvNYBI=
X-Google-Smtp-Source: ABdhPJwfKCU4mN3MALPp0QRLbpeEYj4vQ8hz08OoQtY11vnX5sSvkDftOmp9E4i37trAtI5R2tP79w==
X-Received: by 2002:a0c:e9d0:: with SMTP id q16mr32692475qvo.53.1625788595296;
        Thu, 08 Jul 2021 16:56:35 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m68sm1733234qkc.109.2021.07.08.16.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 16:56:34 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 2/4] iio: adc: ad7949: fix spi messages on non 14-bit controllers
Date:   Thu,  8 Jul 2021 19:56:16 -0400
Message-Id: <20210708235618.1541335-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210708235618.1541335-1-liambeguin@gmail.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 67 ++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 93aacf4f680b..bbc6b56330a3 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/bitfield.h>
 
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
 #define AD7949_CFG_REG_SIZE_BITS	14
@@ -57,6 +58,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
+ * @bits_per_word: number of bits per SPI word
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
  * @buffer: buffer to send / receive data to / from device
@@ -67,28 +69,59 @@ struct ad7949_adc_chip {
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	u8 resolution;
+	u8 bits_per_word;
 	u16 cfg;
 	unsigned int current_channel;
-	u16 buffer ____cacheline_aligned;
+	union {
+		__be16 buffer;
+		u8 buf8[2];
+	} ____cacheline_aligned;
 };
 
+static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
+{
+	u32 adc_mask = SPI_BPW_MASK(ad7949_adc->resolution);
+	u32 bpw = adc_mask & ad7949_adc->spi->controller->bits_per_word_mask;
+
+	if (bpw == adc_mask)
+		ad7949_adc->bits_per_word = ad7949_adc->resolution;
+	else if (bpw == SPI_BPW_MASK(16))
+		ad7949_adc->bits_per_word = 16;
+	else
+		ad7949_adc->bits_per_word = 8;
+}
+
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 				u16 mask)
 {
 	int ret;
-	int bits_per_word = ad7949_adc->resolution;
-	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
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
+		ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
+		ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
+		ad7949_adc->buf8[1] = ad7949_adc->buf8[1] << 2;
+		break;
+	}
+
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -105,14 +138,12 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 {
 	int ret;
 	int i;
-	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
 			.rx_buf = &ad7949_adc->buffer,
 			.len = 2,
-			.bits_per_word = bits_per_word,
+			.bits_per_word = ad7949_adc->bits_per_word,
 		},
 	};
 
@@ -147,7 +178,24 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
 	ad7949_adc->current_channel = channel;
 
-	*val = ad7949_adc->buffer & mask;
+	switch (ad7949_adc->bits_per_word) {
+	case 16:
+		*val = ad7949_adc->buffer;
+		/* Shift-out padding bits */
+		if (ad7949_adc->resolution == 14)
+			*val = *val >> 2;
+		break;
+	case 14:
+		*val = ad7949_adc->buffer & GENMASK(13, 0);
+		break;
+	case 8:
+		/* Convert byte array to u16, MSB first */
+		*val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
+		/* Shift-out padding bits */
+		if (ad7949_adc->resolution == 14)
+			*val = *val >> 2;
+		break;
+	}
 
 	return 0;
 }
@@ -280,6 +328,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
 	indio_dev->num_channels = spec->num_channels;
 	ad7949_adc->resolution = spec->resolution;
+	ad7949_set_bits_per_word(ad7949_adc);
 
 	ad7949_adc->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(ad7949_adc->vref)) {
-- 
2.30.1.489.g328c10930387


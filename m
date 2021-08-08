Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17A93E37DB
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 03:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhHHB5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhHHB5v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 21:57:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3160C061760;
        Sat,  7 Aug 2021 18:57:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dk2so7188934qvb.3;
        Sat, 07 Aug 2021 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A37saODTcesuUxyXgpe8ielCQCcU0J71Gt99ymfG4a4=;
        b=bTvSdeRS2GvrOKEmvzNae0msWjCDDoQcG4I+V3WfQAFksXc1RJHhjiqHDV0Nbp/0QO
         NIFCI6U9ryZZYTVhDH6UD1E73VUjo4phsuG4pcux8RldxHvXrqclEKMfqrf2Nn5JJ8AP
         CCqpHkegBWxKglqULkJzk+5SRK2sPeES9IMsuB6Tsgny5UF7AtD0lupcFfk7ywhYpsih
         QhwxT7aNZZm8cygBDw/G8NZhbfVFF4FCmvbc47EFf+c+dPytT1iuhT8Ez8keUxH1slZW
         pt9Ngch1F8Z5HM+KetG6ybeMevCoDEDLUH/eUHFeuAkQkeBNJIUt0/lt9xbLgQeVlCfc
         sxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A37saODTcesuUxyXgpe8ielCQCcU0J71Gt99ymfG4a4=;
        b=G2TY5lUCgr6XgG3kn2Qh/4mOOw2PZWmRL/HtaDrwom9iK/noTVw2870zgeAbfOeOLs
         mxpcmEmStkuKtttGgLcjLj60ufvxarl4OqyNiOM0nnbgU4nN/Ih/AWnAJtq5b19CPsLt
         d5leA+NYsBNTWf3KSZqxD8Ehqe/gFCDyvMbWjm5uSVbtYN0h9YOfFbaaTuAQ5sadh3WQ
         ue/rQqj42SlKFDuBb0NB6DrzX1Zc2SxlCWtcLrZTueBR/3DLg/1K8fKFYipUVLvv4w4X
         mXe2wEp4H9VXjlVQUQkBTHKCOja9OHr8p3h+fAD9O7snTciHlwTzAb8m+QYlQUthItD2
         sHcw==
X-Gm-Message-State: AOAM5322PQHNbQKDL3juJ0J3FFji7a7XJDlTmkEoJ86H37UyjPZdHka/
        vY5On+i0hsELN2efbCJrTcI03qMIsdWgLA==
X-Google-Smtp-Source: ABdhPJz7mwF2WHZhrow+CCmSBsNNPPt+sw8vzuy7tBaFkc71vtlVOqE+VD9VnItqoF7JS/siSO3gFw==
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr18252583qvp.12.1628387852144;
        Sat, 07 Aug 2021 18:57:32 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id k24sm1569612qki.11.2021.08.07.18.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 18:57:31 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 2/5] iio: adc: ad7949: fix spi messages on non 14-bit controllers
Date:   Sat,  7 Aug 2021 21:56:56 -0400
Message-Id: <20210808015659.2955443-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210808015659.2955443-1-liambeguin@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 75 +++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 937241ee2a22..3f94ae639a44 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -14,7 +14,6 @@
 #include <linux/bitfield.h>
 
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
-#define AD7949_CFG_REG_SIZE_BITS	14
 
 /* CFG: Configuration Update */
 #define AD7949_CFG_BIT_OVERWRITE	BIT(13)
@@ -68,9 +67,11 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
+ * @bits_per_word: number of bits per SPI word
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
  * @buffer: buffer to send / receive data to / from device
+ * @buf8b: be16 buffer to exchange data with the device in 8-bit transfers
  */
 struct ad7949_adc_chip {
 	struct mutex lock;
@@ -78,28 +79,46 @@ struct ad7949_adc_chip {
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	u8 resolution;
+	u8 bits_per_word;
 	u16 cfg;
 	unsigned int current_channel;
 	u16 buffer ____cacheline_aligned;
+	__be16 buf8b;
 };
 
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 				u16 mask)
 {
 	int ret;
-	int bits_per_word = ad7949_adc->resolution;
-	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
-			.tx_buf = &ad7949_adc->buffer,
 			.len = 2,
-			.bits_per_word = bits_per_word,
+			.bits_per_word = ad7949_adc->bits_per_word,
 		},
 	};
 
 	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
-	ad7949_adc->buffer = ad7949_adc->cfg << shift;
+
+	switch (ad7949_adc->bits_per_word) {
+	case 16:
+		tx[0].tx_buf = &ad7949_adc->buffer;
+		ad7949_adc->buffer = ad7949_adc->cfg << 2;
+		break;
+	case 14:
+		tx[0].tx_buf = &ad7949_adc->buffer;
+		ad7949_adc->buffer = ad7949_adc->cfg;
+		break;
+	case 8:
+		/* Here, type is big endian as it must be sent in two transfers */
+		tx[0].tx_buf = &ad7949_adc->buf8b;
+		ad7949_adc->buf8b = cpu_to_be16(ad7949_adc->cfg << 2);
+		break;
+	default:
+		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
+		return -EINVAL;
+	}
+
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -116,17 +135,19 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 {
 	int ret;
 	int i;
-	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
-			.rx_buf = &ad7949_adc->buffer,
 			.len = 2,
-			.bits_per_word = bits_per_word,
+			.bits_per_word = ad7949_adc->bits_per_word,
 		},
 	};
 
+	if (ad7949_adc->bits_per_word == 8)
+		tx[0].rx_buf = &ad7949_adc->buf8b;
+	else
+		tx[0].rx_buf = &ad7949_adc->buffer;
+
 	/*
 	 * 1: write CFG for sample N and read old data (sample N-2)
 	 * 2: if CFG was not changed since sample N-1 then we'll get good data
@@ -144,7 +165,6 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	}
 
 	/* 3: write something and read actual data */
-	ad7949_adc->buffer = 0;
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 	if (ret)
@@ -158,7 +178,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
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
+		/* Here, type is big endian as data was sent in two transfers */
+		*val = be16_to_cpu(ad7949_adc->buf8b);
+		/* Shift-out padding bits */
+		*val >>= 16 - ad7949_adc->resolution;
+		break;
+	default:
+		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -266,6 +304,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 
 static int ad7949_spi_probe(struct spi_device *spi)
 {
+	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
@@ -292,6 +331,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
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
2.32.0.452.g940fe202adcb


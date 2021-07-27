Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEFD3D83F7
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 01:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhG0X31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 19:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhG0X3Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 19:29:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569CC061764;
        Tue, 27 Jul 2021 16:29:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t68so471236qkf.8;
        Tue, 27 Jul 2021 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXrlAfidCULyhP2C11Xrjur7fmsiuYHq0Us9S4wnzkQ=;
        b=gIzyt668qkm1C+SQ12wfGDyG9bhQPELGz27s398YHVcbPusIriEZ7He1V76wkVB0kI
         lrTNSNHCkBNKcaQSR66wGYA2/TACwIv+njZJntg9BcMANkzikPaQFIVe9znH/kn5de7a
         eGLDjLp8FW89y9CEQOIrplgJH0xBCkVfoxV1o/tKPBFHkzAMe6t0wcYQqCl+L8Icvn4t
         CzpsF9d7AAwfQQLg+mimXQdlwxovUu6WnX4P01MR7Bxmd4HvlgHTxqIXZ5WfwqX8GTgr
         v+v2rOGVni5lmuUrjyOgGQXfPTKN3w/8hDLEsbis/OTYFcWdsUoJDMXJ97b7f8wmLfh2
         Wyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXrlAfidCULyhP2C11Xrjur7fmsiuYHq0Us9S4wnzkQ=;
        b=UXRNjU8qw9JZlIciRhSJFH1teIItsxeSaq5gRvZwG4tVLkOZaKIMMnFSi/1p11m1KW
         7xCOwrOqozsUcsXARmtRBUDTa5kNhEjedaPBaTVSRSuDCbQRuLThzGJsjYKSzP8mJnM0
         xYZTsJsphUPllEwNm/5wgDisv9s5100BEH8EaFt72y1bX779wVDBfhosz0Fw1en7eby/
         HQVmYuYZMy+ifIJQJ6R26kev5KyA63WktOuuptQC2w4Z6Kl2kImPXlp5IVqqdlp3hf1j
         /9tJB4n0cT6CCuPGziQq7hgkLL3Ud1tM+ihCwcjEMnlr8yGBntGaPplf3FKP7c/57zRw
         BY0A==
X-Gm-Message-State: AOAM531YTBd3OmgCPjpTkYr8BYMPX4kUeljMG9FAVU/VCNu4DDvZlgYJ
        Q4cRwH6fEoD0io2BhD4eocc=
X-Google-Smtp-Source: ABdhPJyzpYemZkEjJj0ZWcsM0ooRGuVjQq5r3foqRQ0j9iwfbH9uAKjAYpDPVk/SjlsdBvp/dZj88Q==
X-Received: by 2002:a05:620a:4d5:: with SMTP id 21mr24466871qks.397.1627428563312;
        Tue, 27 Jul 2021 16:29:23 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p188sm2380514qka.114.2021.07.27.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:29:22 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 2/5] iio: adc: ad7949: fix spi messages on non 14-bit controllers
Date:   Tue, 27 Jul 2021 19:29:03 -0400
Message-Id: <20210727232906.980769-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210727232906.980769-1-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 62 ++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 0b549b8bd7a9..f1702c54c8be 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -67,6 +67,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
+ * @bits_per_word: number of bits per SPI word
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
  * @buffer: buffer to send / receive data to / from device
@@ -77,6 +78,7 @@ struct ad7949_adc_chip {
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	u8 resolution;
+	u8 bits_per_word;
 	u16 cfg;
 	unsigned int current_channel;
 	u16 buffer ____cacheline_aligned;
@@ -86,19 +88,34 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
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
+		/* Here, type is big endian as it must be sent in two transfers */
+		ad7949_adc->buffer = (u16)cpu_to_be16(ad7949_adc->cfg << 2);
+		break;
+	default:
+		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
+		return -EINVAL;
+	}
+
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -115,14 +132,12 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
 
@@ -157,7 +172,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
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
+		*val = be16_to_cpu(ad7949_adc->buffer);
+		/* Shift-out padding bits */
+		*val >>= 16 - ad7949_adc->resolution;
+		break;
+	default:
+		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -265,6 +298,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 
 static int ad7949_spi_probe(struct spi_device *spi)
 {
+	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
@@ -291,6 +325,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
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


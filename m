Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00A3C2724
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGIQB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhGIQBy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 12:01:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68894C0613DD;
        Fri,  9 Jul 2021 08:59:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s4so9725076qkm.13;
        Fri, 09 Jul 2021 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVzaufTKjI7vFE0WAp9ETvQcf722VGc26MQp2yQzB7M=;
        b=QNblqPWByV8M/v0AKo0T6pJJ59EF6N8LN0xEUrMT7ahzm2W0M0bZtRtpC5JbyjnURT
         rJMPAvUJMc4lnsYVm5TranAhS3DN06zE9QBqLlkVRb65gDOj1RmwM91jLlvYeDUMmXlr
         UUmFje7vi+GyrOx38qu+VivsBDrLtOMqaIkNmWYZa9ZhKaCwG0xRw80mkeWs2SLYRSCl
         u2sZW6rmaUy2OVDoLncDYdyqoM+/p9zkmIrIhGN08d12GZSAsWgMQ/oc0UBCH2BF+ADM
         5RuPd47lr4dZXA0sqV/r3v0jfWGj8WVjiVfHvKIkCbV9/EypDxcfV+0v5mMftZvabDTD
         zhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVzaufTKjI7vFE0WAp9ETvQcf722VGc26MQp2yQzB7M=;
        b=h19+m9fKaQyRtiDC29/ANZBwX5KJ82lnGXYseRQU7q5yk1ZchSdA4FIO4IIgO5kzfD
         1yih+0Mq5y2TSOa369OekIJrzinm8txfkUaH+FGCzoQxSC6n56cAveOlfL881fRInVSD
         ZkyQ7V+NfGu9L/r8ZARnDCfTIKplHHl6KhTCfIZ1LiS7wJCDSiiYz025iML4WixlTpd0
         PTq2jAw8LsQEsp2gVA82SgY83vI5h+Blc3USUa603gQ0R6xQcUxYwX3Ouf87+SqR3Uv4
         /VD9/FPYPVYpHTEK34sqeP1D3QE60eAv0o7MAO9/umMAueJICv0cMl6CzBViLr5c1O7F
         /jjA==
X-Gm-Message-State: AOAM532SxAmhusFfSePL3BDdtQkKZAaftyftsYVQCAe6MOAX6e6S+eyN
        a0G2uRE6qA6KuWqzeIz57wk=
X-Google-Smtp-Source: ABdhPJxIHLKuMZ4Jq1bbpghyvw/CUGGsf7U6/boIIOdiKSwRr3hN1U1JYfWcBhtjuEBm2EJ+ABTLSA==
X-Received: by 2002:a05:620a:e09:: with SMTP id y9mr37864332qkm.359.1625846349604;
        Fri, 09 Jul 2021 08:59:09 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm2606071qkm.66.2021.07.09.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:59:09 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 2/4] iio: adc: ad7949: fix spi messages on non 14-bit controllers
Date:   Fri,  9 Jul 2021 11:58:54 -0400
Message-Id: <20210709155856.1732245-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210709155856.1732245-1-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 69 ++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 93aacf4f680b..770112ac820f 100644
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
@@ -67,28 +69,60 @@ struct ad7949_adc_chip {
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
+	default:
+		/* Pack 14-bit value into 2 bytes, MSB first */
+		ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
+		ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
+		ad7949_adc->buf8[1] = ad7949_adc->buf8[1] << 2;
+		break;
+	}
+
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
@@ -105,14 +139,12 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
 
@@ -147,7 +179,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
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
+	default:
+		/* Convert byte array to u16, MSB first */
+		*val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
+		/* Shift-out padding bits */
+		if (ad7949_adc->resolution == 14)
+			*val = *val >> 2;
+		break;
+	}
 
 	return 0;
 }
@@ -280,6 +330,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
 	indio_dev->num_channels = spec->num_channels;
 	ad7949_adc->resolution = spec->resolution;
+	ad7949_set_bits_per_word(ad7949_adc);
 
 	ad7949_adc->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(ad7949_adc->vref)) {
-- 
2.30.1.489.g328c10930387


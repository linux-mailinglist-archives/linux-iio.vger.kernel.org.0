Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448F17A9F1F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjIUUSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjIUURi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:17:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB15AE01
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:29:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so529866466b.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317351; x=1695922151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC6Tj/wZ71OdWmHfRNe2x49Rd8CoFCC05cRR7nhn858=;
        b=fPov4pJEJR8vmoluOACwouZ/+kXHmDY/kV7Bk2BRvONEOnWSPR1HmDD26NE5S7wzpM
         zykLKW/uuPmvb1CKSa22N3sdEN+5z9qXOLG1TtpGnfjt85+i4TXLOTJOxCSx6HNK8Oir
         TLrZnWSnr9VQibaK8jhNJJVii/RJL72Njcha8gqWfZrLQoegOdtrjxDG87ATCv/CVRTq
         DvXbOgFWvr2xUkaOWHbfdzs6ebTBKMhsXoNIaYFPcKf+CAzMVd7IgHLGE/0O+61KSlsN
         mm3klhrRqwgkKTumKKTgPtAa2D+2ot4D35YkddpKZ1awU6dnB7M/Y8K4+fooJFPZ8otN
         FNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317351; x=1695922151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC6Tj/wZ71OdWmHfRNe2x49Rd8CoFCC05cRR7nhn858=;
        b=u6Oyy8Vft5vkYQqLGchweNeDWwWd4fgFc/OIFgO+rvmL9yfHNQaA41FuWCIl6F0cbI
         4tWoUSvcv+3OSLMWp+0Z7z1EQaQ4eywLvkT9/OZJ5NCT5NwwrHjvQX3nMrKsFYg49IiG
         T6qU3Z3wW2bg1At6qD2oleSpAYCLXzhEbTmsWRckbWNaSeQaJnz+B2uxvjJ3KSiKOc3m
         7AgSjF/7oZ+TQ/DCU/OFYHS6YFybsHreiIqHmqrdt8490qETz3MKwkm5LogCopVC9YOp
         1fFs+RiOjHeEORZSbig9mLmfLFThdtFhFItIfxoxtpfQn2/OC4H1cKzky1mHHHVsV+AM
         K6BA==
X-Gm-Message-State: AOJu0Yyjc/s5PaXLC2SGpW/ANsEAbFjktixg6koB53/ZW/T8neW4JBAh
        eAziJCeUjzHul3DuJ4t0RkTfVwaT/opOAz3I5tAM4+QZ
X-Google-Smtp-Source: AGHT+IEeRgrsoxDfX29qrjpP91FiFRBv3vO2R0yidMQo5d2X1FKFBQlgvaBLgvFag4zdxsrc6bIIrA==
X-Received: by 2002:a05:600c:3789:b0:3fb:c075:b308 with SMTP id o9-20020a05600c378900b003fbc075b308mr4598503wmr.12.1695307457067;
        Thu, 21 Sep 2023 07:44:17 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:16 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 05/19] staging: iio: resolver: ad2s1210: fix probe
Date:   Thu, 21 Sep 2023 09:43:46 -0500
Message-Id: <20230921144400.62380-6-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This fixes a number of issues in the ad2s1210_probe() function:
- Move call to ad2s1210_setup_gpios() after `st->sdev = spi;`. This
  fixes use of this pointer before it is initialized.
- Check return value on ad2s1210_initial().
- Move devm_iio_device_register() to the end to avoid race of
  registering before fully initialized.
- Remove call to spi_setup(). Note: MODE_3 was incorrect, it should be
  MODE_1 but we can let the device tree select this.
- Change default value for fclkin. This is an external oscillator, not
  the SPI bus clock. (Will use device tree to get the correct value
  in a future patch. For now, using the eval board value.)
- Remove spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0bdd5a30d45d..9c7f76114360 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -3,6 +3,7 @@
  * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
+ * Copyright (C) 2023 BayLibre, SAS
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
@@ -657,12 +658,8 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
@@ -671,22 +668,25 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_clocks(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad2s1210_setup_gpios(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad2s1210_initial(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	st->fclkin = spi->max_speed_hz;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
-	ad2s1210_initial(st);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad2s1210_of_match[] = {
-- 
2.34.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51F87A9896
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIURu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjIURuC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 13:50:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA14E5D6
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:17:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso149279966b.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316637; x=1695921437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xPn0fJb1G79vmQneRtFHd9riwOuPrJO1tNQT+KG0zw=;
        b=BkrbnlXdBSC0/UrV1PzKcsex/2qDLgaNrdRmn/jNw+EtcnBRKaM5uScfs6O8G4YRrU
         6D7ATLM1JbG30RtmDsnkqWHgNjHAyN7z63vGA9j3uLOlfbHic5P8jbDcsCDPARzQpLWL
         Aad73ds+1pplHPr5fIQkSdGT0Tx+XgD9oJTFq+0IklMlsHRBQmxbgFvliIM3yl2lHAZO
         qud6Igi5PVeou4jons9fB8bzB8RLiqDZk0MKJJGaMIxpBvnQjn/jY6uD54X9LyScDQHV
         ncJqlrooebv9K/VaHkbcDlay6bwpa7Xwp+RkH+DIatjDxzW3oXXCzGBZ/7yL/j7NdgVs
         VaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316637; x=1695921437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xPn0fJb1G79vmQneRtFHd9riwOuPrJO1tNQT+KG0zw=;
        b=R5FiJew7IclNsybkbDitxa7zcuQ0JgbV8wdAXq/Cu1dEjD31vMVvXadpUPqBbjEKCF
         aZKryjuqsfCwwsPeulwm5qK/BeD8He3sQbovk41Gl4aPASSeYpBka3UPVIqBvgTjo09z
         lUwWE2/Kkx25h81z+XCgVrZAPJF5EFoKQRk6+GhFIb+oMS7Zaerk3AA7O0ysilCXXv7r
         OUuM1Li3jSMZfX7a4Rq0rXgtz3PzcGJUtF6JxMuGL8yU3UgB6h8ycUnJQN1CZj67jiY4
         NJGMSlQ3llibcGXcj/tScFuKtUjWiTczt+miFyXt6U/LG44Fn78PpH3Q+vhy6tTwE2VY
         OyOw==
X-Gm-Message-State: AOJu0YylUgdHc61yxHCb1kdyQzxARBcp+nAMRggi+hoqC9DpXicCQ03r
        +J4z+H9VyFvL5EGRUcc2kASH59ILFtpiDHmNRvQaQ023
X-Google-Smtp-Source: AGHT+IHCsgQf5YDU2b8qhjf3hqvfyriFBctb7CQVc25Wz8iRM3Vsev+NwoaLu/6Clxbuw75eKXqg8g==
X-Received: by 2002:a5d:608d:0:b0:321:4b47:d1c0 with SMTP id w13-20020a5d608d000000b003214b47d1c0mr4847398wrt.71.1695306158083;
        Thu, 21 Sep 2023 07:22:38 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:37 -0700 (PDT)
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
Subject: [v2 07/19] staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
Date:   Thu, 21 Sep 2023 09:19:35 -0500
Message-Id: <20230921141947.57784-10-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

This adds an implementation of IIO_CHAN_INFO_SCALE to the ad2s1210
resolver driver. This allows userspace to get the scale factor for the
raw values.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 107 ++++++++++++++++--------
 1 file changed, 72 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 985b8fecd65a..95d43b241a75 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -458,56 +458,91 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
+static const int ad2s1210_velocity_scale[] = {
+	17089132, /* 8.192MHz / (2*pi * 2500 / 2^15) */
+	42722830, /* 8.192MHz / (2*pi * 1000 / 2^15) */
+	85445659, /* 8.192MHz / (2*pi * 500 / 2^15) */
+	341782638, /* 8.192MHz / (2*pi * 125 / 2^15) */
+};
+
 static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val,
 			     int *val2,
-			     long m)
+			     long mask)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	mutex_lock(&st->lock);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
-	/* delay (6 * tck + 20) nano seconds */
-	udelay(1);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
+		/* delay (6 * tck + 20) nano seconds */
+		udelay(1);
+
+		switch (chan->type) {
+		case IIO_ANGL:
+			ad2s1210_set_mode(MOD_POS, st);
+			break;
+		case IIO_ANGL_VEL:
+			ad2s1210_set_mode(MOD_VEL, st);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		if (ret < 0)
+			goto error_info_raw;
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0)
+			goto error_info_raw;
+
+		switch (chan->type) {
+		case IIO_ANGL:
+			*val = be16_to_cpup((__be16 *)st->rx);
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_ANGL_VEL:
+			*val = (s16)be16_to_cpup((__be16 *)st->rx);
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 
-	switch (chan->type) {
-	case IIO_ANGL:
-		ad2s1210_set_mode(MOD_POS, st);
-		break;
-	case IIO_ANGL_VEL:
-		ad2s1210_set_mode(MOD_VEL, st);
-		break;
-	default:
-		ret = -EINVAL;
+error_info_raw:
+		gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
+		/* delay (2 * tck + 20) nano seconds */
+		udelay(1);
+		mutex_unlock(&st->lock);
 		break;
-	}
-	if (ret < 0)
-		goto error_ret;
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0)
-		goto error_ret;
 
-	switch (chan->type) {
-	case IIO_ANGL:
-		*val = be16_to_cpup((__be16 *)st->rx);
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_ANGL_VEL:
-		*val = (s16)be16_to_cpup((__be16 *)st->rx);
-		ret = IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL:
+			/* approx 0.3 arc min converted to radians */
+			*val = 0;
+			*val2 = 95874;
+			ret = IIO_VAL_INT_PLUS_NANO;
+			break;
+		case IIO_ANGL_VEL:
+			*val = st->fclkin;
+			*val2 = ad2s1210_velocity_scale[st->resolution];
+			ret = IIO_VAL_FRACTIONAL;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 		break;
+
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
-error_ret:
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -549,12 +584,14 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 	}
 };
 
-- 
2.34.1


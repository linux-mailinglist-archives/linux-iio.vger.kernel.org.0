Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0C7B38C5
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjI2R0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjI2RZ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:25:56 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E31B7
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:53 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57babef76deso5274130eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008353; x=1696613153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mVPfJvq9odcQF/rUfj3o/6NyMJOAJ6+IQlyYMebtjw=;
        b=gSv16dBX8P/ZsC7lNkev8mTFmIzBYdjV2+cIC1qQuR/Kzz9xMY5dqmOtvX1fKuxgES
         DMG+CuptnuOCrvdsyGJWBA7eIvHB7YTZAB4CnxZ2XJF08a352MfxQpsp0jqVOq5HTVzt
         jk4qanpJE/1wglGCIWTu8Wl485W5WpbUY594/g/0Ji6xMN2DjDU0TpFkJJKRtWf698rV
         k6l7zdqT/f/NsnS7seNJ9b9xPA+OyFwdO5fQzJC1LteezW3WQfBLuD73cFxpo2cKb99c
         n+WeAvRYIqa8ddmnI3l2mGPTrX7ArSG5sD6u2CtsovwRZLvdkglmHNx6ozm2GGwaJYwj
         RfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008353; x=1696613153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mVPfJvq9odcQF/rUfj3o/6NyMJOAJ6+IQlyYMebtjw=;
        b=fwWBrVtKG+tytmwTDSIH96z6hgJFsUKzE4JWcVgk2nvTZmmxOZJTpCAmzZBCgj5DRe
         4ld4E08fOUB3Pq/lvoaN6To2hQ67AoPMr36mSFqUfqiw3QOEAqEfdy/cKdHOndI02Pzq
         ON5x1tsIuLXPV9kOXoxy03+mI7Q1MiF4vHoUivySr6thp20Rc81Dpm9TQQPRqz5de2k0
         3uVDVefsOsO9WLOQI2GIM5YBzQeP46Za0/CLsI2S8VZuL/grxFNJOnr3L/ZXFFsl8+/t
         p3NO2Y1BSwKJzc4XRmucxlib7J+sAq9DVFouXmt9XeACwNKhrTUEZbV6dRRSJklTuCbO
         NKxg==
X-Gm-Message-State: AOJu0YyI4rcqMan2d2fEni9X/iJB0gvCg0eNZwcH6lhh5KEPPh7BAmZi
        c/AwPbhpohQfG188QgUMADZZ26TAF7U20SGjZ7QY8w==
X-Google-Smtp-Source: AGHT+IGYCuERA7WzD2qHaKxxWRtK4iNVH6r1bESs4G+AGKirbGiiIRExnVEUMypzycdoX+A2Kfy1xg==
X-Received: by 2002:a4a:9d14:0:b0:57b:8c6b:c99b with SMTP id w20-20020a4a9d14000000b0057b8c6bc99bmr4828635ooj.9.1696008353269;
        Fri, 29 Sep 2023 10:25:53 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:52 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 07/27] staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
Date:   Fri, 29 Sep 2023 12:23:12 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-7-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This removes the special handling for resolutions lower than 16 bits.
This will allow us to use a fixed scale independent of the resolution.

A new sample field is added to store the raw data instead of reusing
the config mode rx buffer so that we don't have to do a cast or worry
about unaligned access.

Also, for the record, according to the datasheet, the logic for the
special handling based on hysteresis that was removed was incorrect.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Added __be16 sample field to state struct and use instead of rx buffer.

 drivers/staging/iio/resolver/ad2s1210.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 832f86bf15e5..f9774dff2df4 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -95,7 +95,11 @@ struct ad2s1210_state {
 	bool hysteresis;
 	u8 resolution;
 	enum ad2s1210_mode mode;
-	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
+	/** For reading raw sample value via SPI. */
+	__be16 sample __aligned(IIO_DMA_MINALIGN);
+	/** SPI transmit buffer. */
+	u8 rx[2];
+	/** SPI receive buffer. */
 	u8 tx[2];
 };
 
@@ -464,10 +468,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     long m)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
-	u16 negative;
 	int ret = 0;
-	u16 pos;
-	s16 vel;
 
 	mutex_lock(&st->lock);
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
@@ -487,26 +488,17 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	}
 	if (ret < 0)
 		goto error_ret;
-	ret = spi_read(st->sdev, st->rx, 2);
+	ret = spi_read(st->sdev, &st->sample, 2);
 	if (ret < 0)
 		goto error_ret;
 
 	switch (chan->type) {
 	case IIO_ANGL:
-		pos = be16_to_cpup((__be16 *)st->rx);
-		if (st->hysteresis)
-			pos >>= 16 - st->resolution;
-		*val = pos;
+		*val = be16_to_cpu(st->sample);
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_ANGL_VEL:
-		vel = be16_to_cpup((__be16 *)st->rx);
-		vel >>= 16 - st->resolution;
-		if (vel & 0x8000) {
-			negative = (0xffff >> st->resolution) << st->resolution;
-			vel |= negative;
-		}
-		*val = vel;
+		*val = (s16)be16_to_cpu(st->sample);
 		ret = IIO_VAL_INT;
 		break;
 	default:

-- 
2.42.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CC6EA879
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 12:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjDUKmG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDUKmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 06:42:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6162DA5F0
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 03:42:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso44826075e9.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682073720; x=1684665720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Lud2bmV2Dni/HQ7LD8dzY1T7ghtMyeOGVVq6vz/KY4=;
        b=tGrpluEyBAL+tKGdC8h9q2vZiZG0p6utHNQyjpOyR2anTmwu1WfD/UckRVHYfxdoJq
         P2cOBlafdR2Q2clqrJ3GH7BaxsDsQ4Y0g+Tcqc03ZdQhLFr2D7hUs2R85/9Ys1Ufez6+
         teKLz1ILIAW4v0TE3x+gk9tZlcqa7NyMsyJjw8++a1JPfQTbAXRIyEXqpxpOCgW18wZ6
         q87Ql7IMwrpBkTptIQ196ldv/8h9vjwsPAsJ3TwJcb6o1weaa2ZIqXJ1qj+vuwq41Js5
         UhLbq51nEhro4w7KxmUQW5DwTV78/MhrFwX54SjB4dj7Bo+rfvf51lsxKAROZAKfewCj
         f6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682073720; x=1684665720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lud2bmV2Dni/HQ7LD8dzY1T7ghtMyeOGVVq6vz/KY4=;
        b=eyYkGMKF/iTpPLVnlSiaNhqmX/DgyohlB0AP4y/PD23Z2W2dZdK4ZtTzoAOGYnCwLS
         vukV+7fdy22RsE/xPZeYShy4ZaBhTGT74hck/gyWyJVsVrUYBUZeob8xFQuI1moi0MCP
         n2vcm39mMQji9oboYQwFxY8y3l9TzGMc9xbj/GvDzfWdPqH4sB7+paTyhSjYr4YQbCnM
         XogIfHNNcgmd61blobycqH/yBHw/7RuLw0RP6ACRH71Z1t+D6NjmjkuLEZ4KsejIuhdB
         gO0ERU5jCoypkivf8qblJfhC1qEIpk3kwI87I/4Ly5Hje2BwrTGjlixIwItR4YkfuDff
         YLug==
X-Gm-Message-State: AAQBX9fVHUeEDlWQt5208WKep1ZGnSNJNTBdGSlxsjYO2y0gdE549P+2
        GnxkMTtodamCjgDP/Mdl532NGg==
X-Google-Smtp-Source: AKy350bznL3GobRNm+vZ+J+z0NJYOZaKI8retP0kCANmsk/cd8wh0xmZXckN8Di3uX26NjL8hy/h9w==
X-Received: by 2002:a5d:594c:0:b0:2e5:8874:d883 with SMTP id e12-20020a5d594c000000b002e58874d883mr7219791wri.8.1682073719821;
        Fri, 21 Apr 2023 03:41:59 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003f17eded97bsm7920120wms.19.2023.04.21.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 03:41:59 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:41:56 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: palmas: fix off by one bugs
Message-ID: <14fee94a-7db7-4371-b7d6-e94d86b9561e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Valid values for "adc_chan" are zero to (PALMAS_ADC_CH_MAX - 1).
Smatch detects some buffer overflows caused by this:
drivers/iio/adc/palmas_gpadc.c:721 palmas_gpadc_read_event_value() error: buffer overflow 'adc->thresholds' 16 <= 16
drivers/iio/adc/palmas_gpadc.c:758 palmas_gpadc_write_event_value() error: buffer overflow 'adc->thresholds' 16 <= 16

The effect of this bug in other functions is more complicated but
obviously we should fix all of them.

Fixes: a99544c6c883 ("iio: adc: palmas: add support for iio threshold events")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 drivers/iio/adc/palmas_gpadc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index c1c439215aeb..7dfc9c927a23 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -547,7 +547,7 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	int adc_chan = chan->channel;
 	int ret = 0;
 
-	if (adc_chan > PALMAS_ADC_CH_MAX)
+	if (adc_chan >= PALMAS_ADC_CH_MAX)
 		return -EINVAL;
 
 	mutex_lock(&adc->lock);
@@ -595,7 +595,7 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
 	int adc_chan = chan->channel;
 	int ret = 0;
 
-	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
 	mutex_lock(&adc->lock);
@@ -684,7 +684,7 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
 	int adc_chan = chan->channel;
 	int ret;
 
-	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
 	mutex_lock(&adc->lock);
@@ -710,7 +710,7 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
 	int adc_chan = chan->channel;
 	int ret;
 
-	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
 	mutex_lock(&adc->lock);
@@ -744,7 +744,7 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
 	int old;
 	int ret;
 
-	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
 	mutex_lock(&adc->lock);
-- 
2.39.2


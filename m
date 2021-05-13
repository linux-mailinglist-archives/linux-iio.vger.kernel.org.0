Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF2037F77E
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhEMMKA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhEMMJR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFCEC061761
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so30681347edn.7
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYfwt0+BPoPpQia/fg8ETgJym9nebkYzxG2me6iZXys=;
        b=akAB22KnxxmRLi7sNZWOmYFGksvK4Box/xAKQoVwEKqVEl3YoHISkwbj41FLsXWvtk
         olpX+WNiH9kUG7gNnhH5kDsulv1F/CjvNGmbQiF5iMZNX7wMspmZblouYH3mIkbkXn9X
         s9Kh6flgP/6QQa4AxdOY+xXz5MNIlw+YQkXlAu0lWZLrJTHQuzpGzYqVAIDYFw0qpiC3
         iLdLQHuYm5u+VbIBFyGma8cigT6+VkHFU/I3ZTWsHj2vNS9won7Um1fGSJqQaqTTfS4t
         1ktzGjGNJS8M0mitYt+P2uVtRKGwUmDBDYbsBd+3ToVhyMIGuOhXPETYdWIPaNTGo0Jq
         /42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYfwt0+BPoPpQia/fg8ETgJym9nebkYzxG2me6iZXys=;
        b=GfXPvoUtbR6QjDOLijBVjsrLepY4EX5bn5Tq1vc0CkhM3w/3L8fWOC07/91BSqHijM
         8Ie/wFRd4xOtwj7+aLmcL8dLUR7uL/PYKpC1itDP7Ncwvm/ppkNmY2RtH4LpvN3QT841
         ENu+laP22Qlie3ZAA929zKWE5hHWkv4YTZjN4HTjk+qtZ1BmeTtxiWvAVzQZAP2mCG9+
         19mNYBnv7Brx0rmXoDuou7C4kkxQV61Vk/Ya2G3QsPzGZGDi2T5OAtNGZiLxEqXJYAvH
         XYKOvUsSMy7UB82FzJ46t+ZdyZ6FrE3VJhqRirR9BEHJUnRELSxXZG3ENfr5BFqMgtYD
         VSxg==
X-Gm-Message-State: AOAM533xpie/UoZ5MbBOp/821ndfslsxusGMWOdIRiatxJD/wcLDYYz0
        JJvcq+rowMLPd+iuHAX2o3IVTnAXdaZYiA==
X-Google-Smtp-Source: ABdhPJwXR1I2grq5Jyf58tasXTwwGos+wYn6QCiiUr+IQjNRyDuX1o2SbpQzjKdsXxau/wBHRJLfOw==
X-Received: by 2002:a05:6402:3548:: with SMTP id f8mr49327140edd.251.1620907683002;
        Thu, 13 May 2021 05:08:03 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:02 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 04/12] iio: adc: ad7192: handle regulator voltage error first
Date:   Thu, 13 May 2021 15:07:44 +0300
Message-Id: <20210513120752.90074-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change fixes a corner-case, where for a zero regulator value, the
driver would exit early, initializing the driver only partially.
The driver would be in an unknown state.

This change reworks the code to check regulator_voltage() return value
for negative (error) first, and return early. This is the more common
idiom.

Also, this change is removing the 'voltage_uv' variable and using the 'ret'
value directly. The only place where 'voltage_uv' is being used is to
compute the internal reference voltage, and the type of this variable is
'int' (same are for 'ret'). Using only 'ret' avoids having to assign it on
the error path.

Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d3be67aa0522..1141cc13a124 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -912,7 +912,7 @@ static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
-	int ret, voltage_uv = 0;
+	int ret;
 
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ?\n");
@@ -949,15 +949,12 @@ static int ad7192_probe(struct spi_device *spi)
 		goto error_disable_avdd;
 	}
 
-	voltage_uv = regulator_get_voltage(st->avdd);
-
-	if (voltage_uv > 0) {
-		st->int_vref_mv = voltage_uv / 1000;
-	} else {
-		ret = voltage_uv;
+	ret = regulator_get_voltage(st->avdd);
+	if (ret < 0) {
 		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
 		goto error_disable_avdd;
 	}
+	st->int_vref_mv = ret / 1000;
 
 	spi_set_drvdata(spi, indio_dev);
 	st->chip_info = of_device_get_match_data(&spi->dev);
-- 
2.31.1


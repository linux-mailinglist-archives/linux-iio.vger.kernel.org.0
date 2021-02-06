Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC2311E07
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 15:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBFOxo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBFOxk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2021 09:53:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2516C061756
        for <linux-iio@vger.kernel.org>; Sat,  6 Feb 2021 06:53:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jj19so17661393ejc.4
        for <linux-iio@vger.kernel.org>; Sat, 06 Feb 2021 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gL6PkGPiUJyt8E86+SvXApLkntk98PwCWqJQs00szfo=;
        b=I3NCx/8l1dhB7c0bLOPVvgSA3a44ygplOUTBrf+ncLjfpT5uLW4fGYxqUu0DajllYy
         5BXzbTeUD6GaYr4+vRrTh5Ks7j0JluVggzJsjaHJFJ35i3PcmqPcDmCxN7Trz3zf2ubI
         +tK7jksvHHY5NmCCqX6JYBv//9oSV69GunvRgLo7FgoShjUFACE2UBOIg80QpGL7a9Vf
         SJ3FhoGD05zFiRUramMxGbnVMVXWjVtoZoG22urbuDHgYrY+UWfViWcMyABqpOU/Z6w7
         N0sik1A1oHtDJ+IitOyR2AD9S1O1jpfzCeSDQJHjcnddW6uaxaLItkkSTCZraqd+et35
         Ej7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gL6PkGPiUJyt8E86+SvXApLkntk98PwCWqJQs00szfo=;
        b=iQXegYbflvS8h3PdSmlceZ9yPI0iqQicaWuqKQKexiu3aF4/0QLcYENC0AKAJoYkyo
         j3u3Bnz9FXsoRaujB3U2nUDVVSGTMFSw4kcGOcsDl6qek5QCEiLT0CwbfUg8JUJE2LD/
         it5BslRLUGmONJaofFIMGAc3r+YC1pRjJeNb90ZFluEzpsS46ZoVelsRg/JPNEfMWr/f
         1mYFcac97jBhQufMae8pBV9eUISO/BL3a+xXwIHV2Sxg1bDpBV7WGhQFYJcOiXvZ/1N4
         qO3flsQhYcUJEfHuEEIFOPfA7v0T/JOoTy5dP/FS77FPJkpWGgLEEQ6+6QDVjORZlO1c
         XuWA==
X-Gm-Message-State: AOAM5306+C9JawhHo1hu+U3MlVZn059FlvK9j7pLuuZKoZs2/qnCBy+s
        gp1FaiOzaMw7+liAJVNI9o4=
X-Google-Smtp-Source: ABdhPJxs1HZ3hANE9vpbHOgv5g/8NAML2IPRNiO6DF305HT5TMhKMW76sFXz0q7YpPMrFW7gX0PphA==
X-Received: by 2002:a17:906:a147:: with SMTP id bu7mr9184909ejb.305.1612623179758;
        Sat, 06 Feb 2021 06:52:59 -0800 (PST)
Received: from ubuntu (62-46-102-85.adsl.highway.telekom.at. [62.46.102.85])
        by smtp.gmail.com with ESMTPSA id lc11sm134558ejc.95.2021.02.06.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 06:52:59 -0800 (PST)
Date:   Sat, 6 Feb 2021 15:52:58 +0100
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] iio: ad7949: fix wrong ADC result due to incorrect bit
 mask
Message-ID: <20210206145258.GA603024@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes a wrong bit mask used for the ADC's result, which was caused by an
improper usage of the GENMASK() macro. The bits higher than ADC's 
resolution are undefined and if not masked out correctly, a wrong result 
can be given. The GENMASK() macro indexing is zero based, so the mask has 
to go from [resolution - 1 , 0].

Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>

---
 drivers/iio/adc/ad7949.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5d597e5050f6..1b4b3203e428 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	int ret;
 	int i;
 	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution, 0);
+	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
-- 
2.25.1


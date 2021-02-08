Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20731352D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 15:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBHO37 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 09:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhBHO1s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 09:27:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BE2C0617A9
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 06:27:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so17401040wry.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6PZoUHzaiK538MtkpiToyHFFo/rxX3hgqAsFX27xofw=;
        b=U5ziOzZ8pzNl0U2MMLDVYxOTdQO5kDfc5xOmsd1wj6J0dWcsZHpfttS2WfgOegbNZQ
         j8j/Sq2WNbfpISlhICh2cutIT7EMRyqYD52OuJ6XT0GOVl6nDm6Ryx3CEpCEJCRePxvk
         fUNrTCsUtVWAClJMpUVDKfcAEjmcUbF/bdhr4ZFl4gUoYlNjByT8mplz21cmAJcvc/Dh
         6NbeUxN2g4+xadW2jUyf3JFuXz1ei+IGoMIL020XlO1/ZXnqPpwrWinpaJEopPYVqkof
         JO0hSkMTT1rSi1tLR6HLhqNH2X80j+OOmJQaMpAf4iXqOzJKXar2QQP715bZPzVxmHNv
         23ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6PZoUHzaiK538MtkpiToyHFFo/rxX3hgqAsFX27xofw=;
        b=UpEshPD3L63Jefs5SXR2zbVhE9r4U4ib7L+g0aW9oAdvRMtRidSZ7hit22o2tdSSEf
         2spTC7+N1d11sgrdIR/J6nSiGdUNro6B29p0jXNecUGToF53OE5dTgawxGsLq8xW5nIN
         R8/xOhOj2Aacz4G1q1hbOdBgm46mZsyP1NndGfg3aLWzXQFE4iLkbRS0mPDVOOqsOtjg
         hNMRSEFZT582zLOVf220Vk6imKVorB8CO/G0AjbPN+oOV1lSzNRDjbms0pJVRt1FOlDL
         TZHKRggRpAW0oDV+GZafJSMwk+EhybzYTZpFPaUvKHG5vTbPzLK6STyKSVsza/BtHk9B
         q+Zg==
X-Gm-Message-State: AOAM531AZDDnh4xtxo3IiMewwVqsr6xwM4AZ1F+/Uyxb19fPs3sBymdz
        lHDC/43wXwwOUghm+NbjmVye/Luc9x/k5Nb0
X-Google-Smtp-Source: ABdhPJxwz8+dWLR0W3AA62qXMOf8XHceGrxzuRxagMLhIHQ9UgtVsrmGsz/oieAZTHaZEjOc07u+xg==
X-Received: by 2002:a5d:6685:: with SMTP id l5mr19939948wru.176.1612794426844;
        Mon, 08 Feb 2021 06:27:06 -0800 (PST)
Received: from ubuntu ([212.183.24.90])
        by smtp.gmail.com with ESMTPSA id i7sm30074527wru.49.2021.02.08.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:27:06 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:27:05 +0100
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect bit
 mask
Message-ID: <20210208142705.GA51260@ubuntu>
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

Fixes: 7f40e0614317f ("iio:adc:ad7949: Add AD7949 ADC driver family")

Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>

---

The issue was found in combination of an AD7682 ADC with an ARM based 
iMX7-CPU. The SPI line was analyzed with a logic analyzer and a 
discrepancy between applied voltage level and the ADC reported value 
in user space was observed. Digging into the driver code revealed an 
improper mask used for the ADC-result.


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


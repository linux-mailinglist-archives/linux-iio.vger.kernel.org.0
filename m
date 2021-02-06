Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941BB311C13
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 09:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBFIG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 03:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFIG4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2021 03:06:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270FC06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Feb 2021 00:06:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g10so10385500wrx.1
        for <linux-iio@vger.kernel.org>; Sat, 06 Feb 2021 00:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jRWw4dofwNA6Z69Fwl5xp5mvH8K3EsO+6Hwgz0NfOgY=;
        b=QeyujqWcpGGWNutFAwDAuXqhzCYBTcXhoQxrNXqMQRSnNHjCGj9z+C8yz66JgbD16j
         1KIQ3NQbLs0YDn6K+Iuk+hxFxAQaYNzFjP4SCs2GvpR8PZXt9ADTCni5JoXuZFwbfHJu
         pU2n0UgvDfk6dNax7zHr9fzzyvE3n58aY/n1NWVOBZWJtBDBdkumZMjGgxCH2aiMparw
         ol7FrerjOI/vtLRF+kiideS0SepbDt9t59iozbn8baK3co3TiN1eFVOX1DW8vkZbNes/
         9/XUvPxPKXnO9H2xVQTtA4HXsrFTQS2tLjXu2YWhytL5atNjqKapWSXRosPpuxr/wljt
         3VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jRWw4dofwNA6Z69Fwl5xp5mvH8K3EsO+6Hwgz0NfOgY=;
        b=g6gmu4XtPRJFc4h55scsuX9ZaKT1v3GM0OyLZv+I1nBid5/s6Fpw9sjBd4F9oxxT2t
         S5K6IHGpcUYozGHPFlCIpycI7iXAfIWlx53cgLglnJjS9VKxmhRamGBqGJVIc6zXP5Vs
         R6RhbH+EL6QUIeV2VLtq+zhOHuBobhlX7yIARmx8uRWwjkF7HvP8YWaSShKLgmZUcHgp
         UTihszFfwLftd53MBtoG6z/oic206yddLOupBzeSmGka2MfnkxPm+PFTgkXwzIJrCT7R
         vASj/37oFffUEPVxPsJU8yqC7XZlJhsrlOk5r5SFuYqXqGOz9AFfkc3sbG0Nd/poXxoE
         PYCQ==
X-Gm-Message-State: AOAM531+Hht4kz0glSMMEqMLTPd6IUNC81MrjJIkS2miAGX05Gh+5yYB
        L0zRQm0MjCkB6KwuZjAbkhQsjtVbJLZg4d5B
X-Google-Smtp-Source: ABdhPJxvZnxhmHPepbjOqDII1k7RKxOhoyUx0nY9Tt1Dr1RxuzUaFRebVoysO/ord3gU7eIFcIx8dQ==
X-Received: by 2002:adf:f183:: with SMTP id h3mr9348361wro.30.1612598771242;
        Sat, 06 Feb 2021 00:06:11 -0800 (PST)
Received: from ubuntu (62-46-102-85.adsl.highway.telekom.at. [62.46.102.85])
        by smtp.gmail.com with ESMTPSA id e11sm15067588wrx.14.2021.02.06.00.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 00:06:10 -0800 (PST)
Date:   Sat, 6 Feb 2021 09:06:10 +0100
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] drivers: fixes wrong ADC result due to incorrect bit mask of
 ad7949 driver
Message-ID: <20210206080610.GA596506@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes a wrong bit mask used for the ADC's result, which was caused by an
improper usage of the GENMASK macro. The bits higher than ADC's 
resolution are undefined and if not masked out correctly, a wrong result 
can be given. The GENMASK macro indexing is zero based, so the mask has 
to go from [resolution -1 , 0].

Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>


---
 drivers/iio/adc/ad7949.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5d597e5050f6..a5b4858cb6dc 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	int ret;
 	int i;
 	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution, 0);
+	int mask = GENMASK((ad7949_adc->resolution-1), 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
-- 
2.25.1


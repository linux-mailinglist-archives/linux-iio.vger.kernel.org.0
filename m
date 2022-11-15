Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989F629A01
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKONXf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 08:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKONXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 08:23:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A119AE74
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 05:23:32 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so7238319lfc.8
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjy2+mpCjTP8mfHF1OGdgEun8TSro32Otc7xp3Fdvvs=;
        b=SmwV9CavWzAy5Xmpu8rbzU1RZqIJydT/n2irp88TN3z08Rpnl2sogkyE/0tfmepVae
         mFC8myPhZBFP/+teKFyk9lsRPqxC4AnTQZTjFzBPzFXyNwJxWoAicRGBfrYtvC9dqU9h
         /dDDqs+LXSxzuXgegsArT7EDlYQlCdJN6y31I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjy2+mpCjTP8mfHF1OGdgEun8TSro32Otc7xp3Fdvvs=;
        b=PfU1ARd+hO6HWTlunTXp3p+0H95zzBwxJN5zerfTiryprmmrgQwyDj40oJadMLXH48
         EfcT6dHzv9pWxPYXd5odoG3kKRptu3msgICcD17QOQ62MyY6bqB+UaJueCIMve63veIv
         Spnf+kcCyb+hnq6QX0ucK7f3AHMnUIIZ4YFuhnwe2resui3wMiS+98jkEgU/xE+/yr6l
         zHUSnJL428aLFwLQL4EkH2NYmByhiFREL8fokGOukp4+dYs2XvIU/H8IKrVEvVs6SXfh
         dVvMUhLZ8aDSMO9OxauebjaMCzZmclLDj2mMJcglxMQaOBkVG6wCNNmfN0L6TLZfaT9x
         bpDw==
X-Gm-Message-State: ANoB5pkD8ZY6uaz9zs4jpKF8bXqGV3o7f6dpWSO2uJOGKZSTRei8SHik
        92vU3e6tLCxC7PnuXScVLvMkmg==
X-Google-Smtp-Source: AA0mqf6L4zd00qolmGlqgN2jBZzZdMW8HcAHcCkOPudaYHSzC4peIVdNVXlDz6k1iKyXbEDWeKmNJg==
X-Received: by 2002:ac2:48b4:0:b0:497:ca2:4e74 with SMTP id u20-20020ac248b4000000b004970ca24e74mr5918104lfg.488.1668518610588;
        Tue, 15 Nov 2022 05:23:30 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s13-20020a05651c048d00b0026fc79fd67dsm2503482ljc.74.2022.11.15.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:23:29 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Javier Arteaga <javier@emutex.com>,
        "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc128s052: add proper .data members in adc128_of_match table
Date:   Tue, 15 Nov 2022 14:23:23 +0100
Message-Id: <20221115132324.1078169-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Prior to commit bd5d54e4d49d ("iio: adc128s052: add ACPI _HID
AANT1280"), the driver unconditionally used spi_get_device_id() to get
the index into the adc128_config array.

However, with that commit, OF-based boards now incorrectly treat all
supported sensors as if they are an adc128s052, because all the .data
members of the adc128_of_match table are implicitly 0. Our board,
which has an adc122s021, thus exposes 8 channels whereas it really
only has two.

Fixes: bd5d54e4d49d ("iio: adc128s052: add ACPI _HID AANT1280")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

I think the driver could be simplified somewhat by having just one
single adc_channels[] array with the 8 entries, unconditionally use
that as ->channels, with ->num_channels being taken from the match
data instead of having this indirection through the auxiliary config
array.

But this patch is properly more suited for -stable.

 drivers/iio/adc/ti-adc128s052.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 622fd384983c..b3d5b9b7255b 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -181,13 +181,13 @@ static int adc128_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adc128_of_match[] = {
-	{ .compatible = "ti,adc128s052", },
-	{ .compatible = "ti,adc122s021", },
-	{ .compatible = "ti,adc122s051", },
-	{ .compatible = "ti,adc122s101", },
-	{ .compatible = "ti,adc124s021", },
-	{ .compatible = "ti,adc124s051", },
-	{ .compatible = "ti,adc124s101", },
+	{ .compatible = "ti,adc128s052", .data = (void*)0L, },
+	{ .compatible = "ti,adc122s021", .data = (void*)1L, },
+	{ .compatible = "ti,adc122s051", .data = (void*)1L, },
+	{ .compatible = "ti,adc122s101", .data = (void*)1L, },
+	{ .compatible = "ti,adc124s021", .data = (void*)2L, },
+	{ .compatible = "ti,adc124s051", .data = (void*)2L, },
+	{ .compatible = "ti,adc124s101", .data = (void*)2L, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
-- 
2.37.2


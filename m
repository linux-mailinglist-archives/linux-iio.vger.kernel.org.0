Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3270B1DAC33
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgETHcF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETHcE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:32:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A84AC061A0E;
        Wed, 20 May 2020 00:32:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v4so1831063qte.3;
        Wed, 20 May 2020 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=ewnxfr7Zn2WCDka8Z1ZE4YnqNTreQv7/AaL61dcWtTgXc0GQNWySm2h/5BWSX0NCDQ
         F/HlvM4RsnlmK8ZPdAcCBhfEXfHIe9+TqoC2/9jgUGDF8i9kOtM4ev3CKnjnRJczlhzE
         Z+xY2vv5qT8zjb58RDX67BzpS2gjUftTuiIte9hQ858DIO/6jo+0EzoPccCdRO2eMQie
         mKHvn/NkR6x/yb0gltHkZ6yV+6j9Z52+w6TeCYBjY7qettgo3iAMGvNM2FtDyipmUWYC
         1g2sjxsTvaoejVwZbEfQFXzwS4aI3FsKeyRRRiyBFljuuFwd/BLFQHR7VJS7eQ+sZ7El
         RN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=JZMzoqPw4j7fydET1ec09E08wHqKPqD2UBANqrbCvY33IdyFpXR512Od5fXPQ0LdH0
         34PL7W5m3MlK/eMiKarDkNrYGEUf2btxhNK9sU74fCR8/082PxJZaY77IhLMSVAoYuE0
         GBV8mx9CKqDFVFYj9oZmAzovjaVFq+lzwxHLBDLtibOZRxB8yyW2qOWa3IhLnKEqw7hX
         z7fi7EmB2bOOayPhfe4pozL/7xLfb8oVR6JgzpwumEWq6p6HUxQk+w0t/6cVnKe3zPY+
         LXRqgpgxNZIuuJ/XOLN2dMDsaCTTvzmaeyNa7nu5j4SeSEepiiBUA5/sPGlx91r8WlX9
         JtaA==
X-Gm-Message-State: AOAM531W9hXtn9ihEBjBTnGxf8K9MOaWG4ydmHo/cWwLT1RsiF2Nbewe
        bZDRq2DwkSZhqEjRL55qaMHWaVg0MF221g==
X-Google-Smtp-Source: ABdhPJw9RgHGLym+SQy81PxjQu8pnjhS+XinnafLQ/jGNlE19vEZoYzTm25HtL17j/xjVfRoApim0w==
X-Received: by 2002:ac8:1381:: with SMTP id h1mr3746316qtj.98.1589959922061;
        Wed, 20 May 2020 00:32:02 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w9sm1702540qtn.29.2020.05.20.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 00:32:01 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 3/4] iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
Date:   Wed, 20 May 2020 09:31:15 +0200
Message-Id: <20200520073125.30808-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minor comment style edits.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3c881541ae72..fd368455cd7b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -385,9 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
 		return ret;
 	}
 	/*
-	 * According to the datasheet the power supply rise time i 200us
+	 * According to the datasheet the power supply rise time is 200us
 	 * and the minimum wait time before mode setting is 100us, in
-	 * total 300 us. Add some margin and say minimum 500us here.
+	 * total 300us. Add some margin and say minimum 500us here.
 	 */
 	usleep_range(500, 1000);
 	return 0;
-- 
2.17.1


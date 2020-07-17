Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E007224126
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGQQ4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgGQQ4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BAC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so15951263wmi.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pd6ShoPrm0jZpbjskrRfnA1hCGWtl3SFnepd2S/QNM=;
        b=VGtCMRlRyKO1bci+KeMExFH/2APwqhMYP6S3B9+EOf6gpg1qNARu0VHR3LvT61Neyg
         nm3rd+el8yz8XmTP2+zYHKNdshyA6ue/Nj/FWIZzGGJX8oqDJOz+Ct5Ou1DzYG54qFDH
         V3B7uywTdM+fb7kdwwIBORo/PJ0J8/kF+HGGc4mzFysjY89jf0bkZPJrq+15EKzqE7Yw
         LmZadfjDmnuJ4YH7zpONh4thewCq9vVBYbQ7vvaAJN/1cPTt5xt+0JbtOkStyaj3FdAG
         Y0yTXp9azBD9EZhNwWD5+SxbEosCZnQPQm0L27uCb61jiO13Y9ZD9xrZFWxUU1MyYrkU
         8PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pd6ShoPrm0jZpbjskrRfnA1hCGWtl3SFnepd2S/QNM=;
        b=Y6mFdJD7Jp2kH6890WjXMDLOA5TC4vr4q2NaqEYyHL57qCQhn0f2TjyTTGLI31zR+O
         yGH0CXWuXyD2kwOzrARA8QzHLFYQNvHg4mAHJ5o25LybwU4IjmMbtvz25ZIexFFMcfYD
         vbZUVO84EjDXGzxZ11ZE7I/cym3oAiJ1QImnpR330Jvv93lZnEY5AY3d0IHDGFtO9Xz8
         HeKHgZK4b6mAq7CDesdCPawiUad7RVvRSlYdmpXYytCZTvZr4TNSNoyDu2lZuZ2NAp3b
         M9o0uzkVsizibvAILDH4eiE4Bq3oNdLPjKAvCQBtlFf+fvGuMiOrzvESZJR4ExH6fAUt
         KwXw==
X-Gm-Message-State: AOAM5336bIwYhPFavXh3JlwbBtkoki3cGDRsZZrK7klBA2CTR7MMwps6
        xkwxiQS6tvcCgJoLWhuHUZaRFQ==
X-Google-Smtp-Source: ABdhPJzMIXHm3ytdzPTg/jzS+f+DoP3PtJaIUny4rj64gipaY/71JD/hoOkN+ChIiten42HePer0ZA==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr9952267wma.24.1595004960384;
        Fri, 17 Jul 2020 09:56:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:55:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        J Keerthy <j-keerthy@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>,
        Amit Kucheria <amit.kucheria@canonical.com>
Subject: [PATCH 02/30] iio: adc: twl4030-madc: Remove set but unused variables 'len'
Date:   Fri, 17 Jul 2020 17:55:10 +0100
Message-Id: <20200717165538.3275050-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/twl4030-madc.c: In function ‘twl4030_madc_threaded_irq_handler’:
 drivers/iio/adc/twl4030-madc.c:475:9: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
 475 | int i, len, ret;
 | ^~~

Cc: Sebastian Reichel <sre@kernel.org>
Cc: J Keerthy <j-keerthy@ti.com>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: Amit Kucheria <amit.kucheria@canonical.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/twl4030-madc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 472b08f37feae..826d8295e9b3c 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -472,7 +472,7 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 	struct twl4030_madc_data *madc = _madc;
 	const struct twl4030_madc_conversion_method *method;
 	u8 isr_val, imr_val;
-	int i, len, ret;
+	int i, ret;
 	struct twl4030_madc_request *r;
 
 	mutex_lock(&madc->lock);
@@ -504,8 +504,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 			continue;
 		method = &twl4030_conversion_methods[r->method];
 		/* Read results */
-		len = twl4030_madc_read_channels(madc, method->rbase,
-						 r->channels, r->rbuf, r->raw);
+		twl4030_madc_read_channels(madc, method->rbase,
+					   r->channels, r->rbuf, r->raw);
 		/* Free request */
 		r->result_pending = false;
 		r->active = false;
@@ -525,8 +525,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 			continue;
 		method = &twl4030_conversion_methods[r->method];
 		/* Read results */
-		len = twl4030_madc_read_channels(madc, method->rbase,
-						 r->channels, r->rbuf, r->raw);
+		twl4030_madc_read_channels(madc, method->rbase,
+					   r->channels, r->rbuf, r->raw);
 		/* Free request */
 		r->result_pending = false;
 		r->active = false;
-- 
2.25.1


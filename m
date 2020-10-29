Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31B129E5BB
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 09:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgJ2IDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 04:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ2IBA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 04:01:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE9C0613CF;
        Thu, 29 Oct 2020 00:51:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z24so1674123pgk.3;
        Thu, 29 Oct 2020 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkDkKRB7/2lcKBzKiX53t3HQfs1gEjtZFJmelsymB+Q=;
        b=mpFTCQ8LPy72Xr802aGpI0eZ1f4K1YI2SgfPo8aEX/BbTYD+f6SZcEIZqkDRepyWtK
         dn68KDDehULYSdvQ3IvItCo9eVahGo289q2Q3b9HwMwjxjtNcbTJytK/JJRj9vmrr8k6
         MkGf3iICdyq89omI0M7yLNpMikdW7aFOu3Hy0rDQVFI3kjmEnjAb/ucznbDci6gWkcjn
         8WnY/UkQn2/7hlFutW8Obf1O2nlkFCWrRSFlRtuwDfU81wKHghVCjmNffJye2DQRdPG7
         z037c4CQnb7zHHAmNoDmoQjzD1RW95BAtUhHo5zeqznAQt6CKSZL/ma6XoL7OuN/ddZr
         NPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkDkKRB7/2lcKBzKiX53t3HQfs1gEjtZFJmelsymB+Q=;
        b=HjjynqSqqrg+Ue38w4LdnrkiH8Km3mPV7Q9qJ4Chbaqi5DkjBbygH9knNmc+ofhJwD
         zOQ8clcOKs9b62ZHFSx19YjUrH+10TMKLlgosduySHi7lBw1yebU6ouc4gnj3Mpai++u
         gog3by6YwTNdoEzULbDzlEKujh0b2OnyTUCRW3hpBeUTap0Ocuga3hPdGS4jsh+GZ32E
         IqVLc/O8Y2Pc63BXdgTj+h9tZrnLsk6Ko7AGt74Y4TeQJSa0rqu7Iihzh6c8KKuH4rCM
         JmsYA5WbmhWSllwat5icLcUWnu0KpARHlNOISnabASrxzaOcQU3dXo3ATJfPpxc3Od+z
         cb5Q==
X-Gm-Message-State: AOAM532OPhpV8pC1iPUamdNG9l9ziA9PiJeXgFKUYUflrp8g7yRoDtmg
        2CMWN9ub08f89Wzvh1D++mA=
X-Google-Smtp-Source: ABdhPJy/PkqMcOc3J3zmNBHNCBpJIycRVZTFxoe8llsW01AjZ7H2QUwe++y/A8kRxb4bNFnzRFzreA==
X-Received: by 2002:a62:c181:0:b029:152:6ba8:a011 with SMTP id i123-20020a62c1810000b02901526ba8a011mr3171136pfg.2.1603957864450;
        Thu, 29 Oct 2020 00:51:04 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id r19sm1738735pjo.23.2020.10.29.00.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:51:04 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/15] iio: adc: palmas_gpadc: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:04 +0800
Message-Id: <20201029074910.227859-9-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/adc/palmas_gpadc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 889b88768b63..76bafa5a4bf3 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -643,7 +643,6 @@ static int palmas_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 {
 	int adc_period, conv;
@@ -812,7 +811,6 @@ static int palmas_gpadc_resume(struct device *dev)
 
 	return 0;
 };
-#endif
 
 static const struct dev_pm_ops palmas_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
-- 
2.28.0


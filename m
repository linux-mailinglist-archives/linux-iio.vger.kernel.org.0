Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4621E653A
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404029AbgE1PA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404093AbgE1PAy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 11:00:54 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57FDC08C5C6;
        Thu, 28 May 2020 08:00:54 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r16so4232320qvm.6;
        Thu, 28 May 2020 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=R6CmW4t3PZoxMLhXXqF21mgPrCitlcN57Qw20bjS4rukcgaIGsUOPADPd2HdiSg7zE
         7vfVSXbaltKMMXByDjXdsC2aE9Gv3Ine54sSQIj2ME9sI3c5UeyQbb9QBnxQZEqA45IQ
         DnRyLCe9/Kl/EptavKDVgIT3gVNCU/lFyzdWRAHAqJ1V64rgKepxyYCWP2loOhxoGJWM
         uQo/+mAmwqGNMQ+EDjEKYvn9EazOkRXwacoqmsbnar36JCZfd0bAuEnC024QcOpHMwun
         ssnIT9RlnHCqzUBEBZ1VbJmYF4CTrhm4saPaYicEVwHEGbl2YXsKOClODlCTShpqt94G
         vmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=NsrxdPfRtiFB5zYDfIlSbFYw9MsdYP2nHn7f7/8rfZl5WC262/ikL+H5X6rnK+97oh
         n65rswwP1odZao59T2RFikG7+DqiNDfLGoTIQIf0SVGYH5BCcw+SUxW4FZfdFJlBzKM1
         Znbalt/lOg0BMNT8ITCHpnBlIN8sw1HF9RQhcsoVI6r+qcTZWrLRO3ZoyQ/f3snA3cSD
         ribML2RekKDVxobCL4iT9/iZldE9jxCZBMZGIeNLFXEbYiOZCBYev+jf/HarysvdypdH
         tgbrZD1BfKvSC1b9TR1p3aiRtGcu9SzRYPzW5v6Gxqv6x1mt83Oz07mWIGtdXDEydT5w
         Ewug==
X-Gm-Message-State: AOAM532SyXu0ox3o9/NrGXEpo99FhNjlBSBjmuV2lU4eCWrf1vUqVAYe
        T5zvX5uIjcXCG8NjMf984tVpissexY0=
X-Google-Smtp-Source: ABdhPJzPhG0IW+LCYGZjfDhJfB+0UePFmkjOgyoL1ECG5lrH1SYq47IbzNf/+U6rG7orJiuQfArK4w==
X-Received: by 2002:a0c:ba22:: with SMTP id w34mr3246638qvf.129.1590678052974;
        Thu, 28 May 2020 08:00:52 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id l188sm4938778qke.127.2020.05.28.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:00:41 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v7 4/5] iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
Date:   Thu, 28 May 2020 17:00:17 +0200
Message-Id: <20200528150018.11953-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
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


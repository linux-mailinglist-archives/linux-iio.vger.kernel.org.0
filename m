Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26D31DB9A4
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETQfI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 12:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgETQfI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 12:35:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E41C061A0E;
        Wed, 20 May 2020 09:35:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f189so4189251qkd.5;
        Wed, 20 May 2020 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=i/NqEwfSn6fny5bwdxssM+Tj1jdR5N7IBdteCHjKjC/cx2IzKd2f8sGIPabD1oIiYp
         Ub32TAdMo7Eb003px2GOSSOK/42DvkP04s2F+2Hv4JBYH+3fEO3putFlHqU8KGgD8pcO
         2IhTb0OVamoawZLXJKIBQV/vcYccljzTmVHEXPYrrks8z24FPWAIwGOzmttnN27Agwf1
         EVQUkYAjsmbhQSzSW5owi4KG3MbJZ+ziN8KnYIHP4029XuDQ8tCl7pTVGAHtDRdA5iuy
         wAtZA6rvLfoxwAXSW4TeKJDs2O2C7vTRvtEMU4qiKtD9YBrJygF4OkNMQm3ypW2wtoXe
         jg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=nXnF3XgUMlkIFRYfi6WoOH6t5yTYbDA12mMGdZJUSIAwx2Ty7GcIVr17IBeOBXUTHA
         Olw/mSIYXgCZlNy3sephnOx4PXxPoWFDRQ/k2ndNVvumcILIDSomgvcTKqd7LBLxDkAv
         APM6unVNE/OXmQOWlnye1Tbpk2BeBzkA9FuYl7a7CEKKzKRsBEAG+Nk7BFqFxZRBS1Y3
         mvbrHtDakj011yRe3Hb8/6h1Pe4I3H3tVFthTv8X247wpN/uDG6YkukJ0+Suh/f46DTA
         VpY94TY7+YQPFV3o/5gdIxITIjffzk7jQ99ktrvVQYKtlK61xwzomu/yGNGkwGW+J8sl
         Fy+g==
X-Gm-Message-State: AOAM533s+X0ZcDiFwf1271kaTzE/Iov2NXFG9FZgKDfITYCiiZYKFwYs
        AlyT/A6/XkakBUqvpdc9ShA+5ERiZolddg==
X-Google-Smtp-Source: ABdhPJwRnGZRJIwG0Sp+0NdyDkVdX/R0Q6oPPIkz8JETiXQXbMpPcOx1in9Yli7akkKArDW242u2Iw==
X-Received: by 2002:a37:943:: with SMTP id 64mr5435261qkj.14.1589992506670;
        Wed, 20 May 2020 09:35:06 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id q59sm2803261qtd.73.2020.05.20.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:35:06 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
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
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH v5 3/4] iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
Date:   Wed, 20 May 2020 18:34:08 +0200
Message-Id: <20200520163417.27805-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2997122C2D0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 12:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXKJL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 06:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 06:09:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80BC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 03:09:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so7440929wmj.5
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xR13IpDqUnZcCIcGpXhWFb4rVJJI2zSLHRakfdYQn94=;
        b=joY58As0QtQkDkV87o+x7XXNQzXrifiLZ4U+u4OVMGF8UpQ6gn840pNC6AF3rwywJy
         bq2pQl25eRaHU34gdeVygXVf0CQ9/zdFnpIy3vJddf98giHrF6s6sT8L2agjTO716pk5
         Ie6T70MkBxY7h3IGQxIKh85AjyuWnD5nrbX7x61baS/e1bB5uVbANw81fIm34FR42KXL
         0K98Yn63oajRMSwD2JMGjtVDIimWzBo5WV+6k1F7sqidr62A/spGudeWKCKCqBmil/bM
         HGpauYh5riGhM5QuUouUTujCDdBr9GCuYICV6HxxdM3/y3lO6djwNJptJ2nNxQlt0aZS
         n6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xR13IpDqUnZcCIcGpXhWFb4rVJJI2zSLHRakfdYQn94=;
        b=XbQYI5CHYyPbKJN0bceWt5e1r257JmpW/M9Dn0PqiMedY3S+sLmqbh7Y8NvGSpzgMn
         A97YtzOpRe6M4XR97OMGKDWcaRrOLtChwqNX5Zp8kACM8Z6ssT7u4QiXvlGfJ1NczXEF
         KeIFvCNt+njYqy5X6PTGWnXGkdy7MKKvhsykArPRhwn0mrQW1Yyml3nkDMVfaqcDoMOz
         RonqDRVicxXidsNyPcx2V7vtdDepiahHfb2QeKxuenUVmEKqgoy25rYmbQsoEvW3CKMt
         JMv1OYFQX2r8Fqd4EyBIBwWgEd6H44vyp1tjTj64SsfNqzFROtD0eZtWkxaFxAXSe39e
         4gXQ==
X-Gm-Message-State: AOAM532TvgFIdMH7wvwkYvJVaG3T2aBtQnY/XGcGaKN2ytvQY/xrDQkA
        /cs8nAlfzlLrJO5Jgy0rBo41zEvTSlI=
X-Google-Smtp-Source: ABdhPJyrrCrOrk8B7qnuYbG+LL/W/bEAQf9PDvcg2KH4xKXQHDlm7VDXh1Z3jCVc4mzFf8ss66lgig==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr8026817wmj.20.1595585349009;
        Fri, 24 Jul 2020 03:09:09 -0700 (PDT)
Received: from fbenedet-HP (77-57-208-91.dclient.hispeed.ch. [77.57.208.91])
        by smtp.gmail.com with ESMTPSA id l81sm3732338wmf.4.2020.07.24.03.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:09:08 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:09:07 +0200
From:   Fabrizio Benedetti <fabrizio.benedetti.82@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH] staging: fbtft: fb_agm1264k-fl.c: Replaced udelay by
 usleep_range
Message-ID: <20200724100907.GA8977@fbenedet-HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch replace udelay with usleep_range
according to the Documentation/timers/timers-howto.txt .
The usleep_range have a range that is >= of udelay.

Signed-off-by: Fabrizio Benedetti <fabrizio.benedetti.82@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..4a67a660bb17 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20, 25);
 	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
-- 
2.17.1


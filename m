Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E728728300E
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 07:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJEFYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 01:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEFYX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 01:24:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C32CC0613CE;
        Sun,  4 Oct 2020 22:24:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so4824388pjb.2;
        Sun, 04 Oct 2020 22:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BNYjHkQnOMekLYDlnrC4+qnb1F1o0CegnvK1HRf+M3E=;
        b=bVhw6HJaIcRnGYg13Gwvf/nRUPEDAzphy5SgMUlQn0owx2LFY/gCCAH8tInL5h6Bm8
         9tPOvz/tin7psVeAEAqG1LZlZ7qaWKqRQsG0e5ySKJIyhJ8nwPcRy4VwtN9PAeVI1Owm
         BPlCOjl8TqDwEFd6fzfq6aVntVri/YLG4Q43yWXYImE/pWNUNVpLhls2O2qjscsa3Rs+
         hLa6BhVhheFTuL26yibuUqP6dCR3mWEPq5bc3nRwltRI2aIPHWhSXC97782P/ZKigFsg
         yCuyi/qW9cH/0FrZK5ySm5BUtnrobkrGpNlkD8RUpBytQnvYHFfPPDN3mgQsj0D1HO31
         BAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BNYjHkQnOMekLYDlnrC4+qnb1F1o0CegnvK1HRf+M3E=;
        b=Uj/2BRDdOsg2xsWDLup+CdO+AsKc1001LhYeCTImB/C/InNtBS19pzoCP4YbqjGnn+
         XnG5x3IomDf4KU+xXFUS/g8cNuaYuS8MBn8dOQZMw0LprQRTxtBL/2Zqvc8AObfyOQpd
         Le2ukZ6MrstxriVI+/GBUQZXzcm7yW/LGCdhSyoHnoKjoF61+kfpFXO8RyPPZ78JZVu/
         W33josjzQUXvuXhj6kPFx/Kpg3m8G349wJAUFBpNOxURTopVvmGrzVKMTVEXj7rNUp+X
         gl1oOs35mEfkr2WvrW/NeCMgwlxcOGxbYmrq7xY+DsCqSftByElFkbhaiIdY11WCIL20
         DVOQ==
X-Gm-Message-State: AOAM531Clxaff/073D8C7KIeCnp050DQoUwe0Oy6pMYzQ5eX0+OcfKi9
        C6PTS9XNZNK3+/74xmRDbzY=
X-Google-Smtp-Source: ABdhPJya5lgMUpviFhKpyV4jVKOyVJKf+Zu6q1nCYOlSz1S7dX9sswceSqRH3HhXDhrwTa6/Os/LKg==
X-Received: by 2002:a17:90b:797:: with SMTP id l23mr14809114pjz.176.1601875463037;
        Sun, 04 Oct 2020 22:24:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id t12sm9228351pgk.32.2020.10.04.22.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 22:24:22 -0700 (PDT)
Date:   Sun, 4 Oct 2020 22:24:20 -0700
From:   dmitry.torokhov@gmail.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201005052420.GA3262631@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The order in which 'users' counter is decremented vs calling drivers'
close() method is implementation specific, and we should not rely on
it. Let's introduce driver private flag and use it to signal ISR
to exit when device is being closed.

This has a side-effect of fixing issue of accessing inut->users
outside of input->mutex protection.

Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/exynos_adc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22131a677445..7eb2a5df6e98 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -135,6 +135,8 @@ struct exynos_adc {
 	u32			value;
 	unsigned int            version;
 
+	bool			ts_enabled;
+
 	bool			read_ts;
 	u32			ts_x;
 	u32			ts_y;
@@ -633,7 +635,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 	bool pressed;
 	int ret;
 
-	while (info->input->users) {
+	while (info->ts_enabled) {
 		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
 		if (ret == -ETIMEDOUT)
 			break;
@@ -712,6 +714,8 @@ static int exynos_adc_ts_open(struct input_dev *dev)
 {
 	struct exynos_adc *info = input_get_drvdata(dev);
 
+	info->ts_enabled = true;
+	mb();
 	enable_irq(info->tsirq);
 
 	return 0;
@@ -721,6 +725,8 @@ static void exynos_adc_ts_close(struct input_dev *dev)
 {
 	struct exynos_adc *info = input_get_drvdata(dev);
 
+	info->ts_enabled = false;
+	mb();
 	disable_irq(info->tsirq);
 }
 
-- 
2.28.0.806.g8561365e88-goog


-- 
Dmitry

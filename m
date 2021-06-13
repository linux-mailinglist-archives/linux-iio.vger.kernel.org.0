Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1F3A5AF8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 01:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhFMXdj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhFMXdj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jun 2021 19:33:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18130C061574;
        Sun, 13 Jun 2021 16:31:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so11750238wmd.5;
        Sun, 13 Jun 2021 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A94ggZZVekVyfiLLJhAqStHmusqip9YekwJs7J8LgkU=;
        b=Xfr5ZoAyqJioQJl5CeeMz2kGh/MsOu3Q4cseiVi20lQYdyFtoXVyYevDTYxqCEYeXv
         4yOIL8b8jPhcmEr8yWtbLASgmkJAN2f2FuJa1B7GxHNrtZ3JyCt7+3SPOL+J+Vpj0Ecj
         mxlsGRn4w2iZ28uIsJc4zgf9ympfJB/3be641qYN1oN2RyjzMkNKYDhbJ6qaMVPDURk6
         GOSGylUQ16fVFksZdJfnF/fHPiSOVeL0C9VUCsnU/Ds6MCx3dcaOZz8KllDbTsSoMfaB
         beKACiJDej5eGl4H/h1YK6huIKa24PMM+5FQP6X4YeTaQGp/8/6VbNhK70dNWOF2wNY6
         2Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A94ggZZVekVyfiLLJhAqStHmusqip9YekwJs7J8LgkU=;
        b=Y1NHlLcHJQPNDMX+HvAZ84pMxD6F9EXDbmDfty1AUA6pfGOKhWXXMqb9dMTk28uGjw
         3ye9ssxskCDGh/rCRa9bFuT6NQ8DfSykyd2jOKxJfrVlepLfjrtuTpuW4bCM14ZYHITf
         J9mADYxA+lLOcPTVezMNOYXofNsBGuSdorlm5+B2zpFRdIMHJsC8DA9ns4s/zlOK1Osn
         hUjf7Aic5lZ4IpCBpYtL5f2h9MO00YnXGW49R9ImNlvLEvnsrdqW0r2xaiFooJk8SFsK
         Mts+5jLwFz3v1xHLf8TSaLBTtBNGqFNvgxhLIWcjJ5IhGvbYQtXQyMNqGEnXPWqMugtf
         hxVw==
X-Gm-Message-State: AOAM533VyUQEk9WBBiu3xsqC/RRtpi5AbvxEgfQOHuGLnoFceVVv5I3o
        aoPyzl8uGsDSacve7I/d4LQ=
X-Google-Smtp-Source: ABdhPJxRGjtZEA5J417sB1J5RxCBCv+XogssRMXQ5g429+EebyNE0coFm6XBwVptoIOwlyq/3vzFjA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr13388987wmc.71.1623627080772;
        Sun, 13 Jun 2021 16:31:20 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:20 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-iio@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iio: ep93xx: Prepare clock before using it
Date:   Mon, 14 Jun 2021 01:30:35 +0200
Message-Id: <20210613233041.128961-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-adc
CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc5-... #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
[<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
[<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a2150>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
[<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
[<c01d8698>] (clk_core_enable_lock) from [<c0266560>] (ep93xx_adc_probe+0xe4/0x1a0)
[<c0266560>] (ep93xx_adc_probe) from [<c02126e0>] (platform_probe+0x34/0x80)
[<c02126e0>] (platform_probe) from [<c0210bf8>] (really_probe+0xe8/0x394)
[<c0210bf8>] (really_probe) from [<c0211464>] (device_driver_attach+0x5c/0x64)
[<c0211464>] (device_driver_attach) from [<c02114e8>] (__driver_attach+0x7c/0xec)
[<c02114e8>] (__driver_attach) from [<c020f1b4>] (bus_for_each_dev+0x78/0xc4)
[<c020f1b4>] (bus_for_each_dev) from [<c0211570>] (driver_attach+0x18/0x24)
[<c0211570>] (driver_attach) from [<c020fab4>] (bus_add_driver+0x140/0x1cc)
[<c020fab4>] (bus_add_driver) from [<c0211c44>] (driver_register+0x74/0x114)
[<c0211c44>] (driver_register) from [<c02134f8>] (__platform_driver_register+0x18/0x24)
[<c02134f8>] (__platform_driver_register) from [<c0470148>] (ep93xx_adc_driver_init+0x10/0x1c)
[<c0470148>] (ep93xx_adc_driver_init) from [<c045ce88>] (do_one_initcall+0x7c/0x1a4)
[<c045ce88>] (do_one_initcall) from [<c045d184>] (kernel_init_freeable+0x17c/0x1fc)
[<c045d184>] (kernel_init_freeable) from [<c03a64d0>] (kernel_init+0x8/0xf8)
[<c03a64d0>] (kernel_init) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
...
ep93xx-adc ep93xx-adc: Cannot enable clock
ep93xx-adc: probe of ep93xx-adc failed with error -108

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/iio/adc/ep93xx_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index c08ab3c6dfaf..5c85257b814c 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -207,7 +207,7 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
 		 */
 	}
 
-	ret = clk_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot enable clock\n");
 		return ret;
@@ -215,7 +215,7 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(iiodev);
 	if (ret)
-		clk_disable(priv->clk);
+		clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
@@ -226,7 +226,7 @@ static int ep93xx_adc_remove(struct platform_device *pdev)
 	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
 
 	iio_device_unregister(iiodev);
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
-- 
2.32.0


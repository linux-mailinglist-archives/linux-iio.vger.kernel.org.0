Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C51A36AE
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgDIPNV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 11:13:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34357 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgDIPNV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 11:13:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so3949266plm.1;
        Thu, 09 Apr 2020 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=fYqxUumxT5IzKeIsySYYf5NiqkbT2qgSW4iAGSCPZ4g=;
        b=rvc0yXxQy3G1YiA0/Xr7RCrEc6LsM2BXuOhbuxRmxTI+wzZc1BWHnqcqXa3X72Lggx
         WpJl5+O0yKPT6Tirm9M6UaeLbUieydgczPF2FZILZVEtSvjGsID2q91ro06z4KSsWMmR
         u/YEJT8BeaSiHYKyTV1bCrXrRV2PiJrW5IfI1SLJIOWfJJBngG2cNsNsr6208uebp7cg
         bCul0LHHCTBheRtie6NbiAxcKWbjoWbdRMFOutUb0su5/gHnNSFzOlmrs1W6w51bY695
         haZBhJp462H8xJsUP47t0DKibw1OP0Ltx2Atp/bFJTCerQ0aLpMJR0Zsd3JiRZqkoiMu
         /MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fYqxUumxT5IzKeIsySYYf5NiqkbT2qgSW4iAGSCPZ4g=;
        b=PRKAwtqKQ6C8yHCqwHnj/Nmm1IHkoC2DMi8eYrlooAsboQvxpwDy3DlKtYbHP75FX9
         i3Q/tu9QKD9SmmKDrdG8J7PcAPXt2No59Y4qJ+YpAy9nYkrtgluHiP+ms71gQX6uEgz0
         MOeSphRfkUFXHMCH1uwq+FGOmGEe36LMSSfr1xnAUGgkf9/m5tfUH5CPi5Nfa6t+EASZ
         8jLL5Vtl7LX/dli9cTBq4FIsl7HhVWngzudF5/e3BvuA9ByyZxMAPMhSSEq23iAf0FPP
         MSqo8oJbPgldNMaaC9lofAhfJ21NgE5hsCQfX0o0SEdoYLXMIyftH7WYipneQldcrTVJ
         +M+A==
X-Gm-Message-State: AGi0PuY4ckvm1yM8F125+8Dy0Qke67NrNt75Tb5ZDJzR6FKvIxW8aU82
        tPWrR5UkdVL7neveV0zLG/g=
X-Google-Smtp-Source: APiQypJ6VV4LiEyx2Jinl8UZcVxArfUGPqIR57YAK51gm6nZJ9wc5ZfS5Eba0FQgb+j2Tp2ZyVtzCQ==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr100328plb.64.1586445200764;
        Thu, 09 Apr 2020 08:13:20 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:700:a20f:d50:b01b:c4e4:35ad])
        by smtp.gmail.com with ESMTPSA id mm18sm2456969pjb.39.2020.04.09.08.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:13:20 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aishwarya R <aishwaryarj100@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: fsl-imx25-gcq: Use devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 20:43:05 +0530
Message-Id: <20200409151306.308-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the helper function that wraps the calls to
platform_get_resource() and devm_ioremap_resource()
together.

Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index fa71489195c6..b0a4dc88ba9b 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -294,7 +294,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 	struct mx25_gcq_priv *priv;
 	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	void __iomem *mem;
 	int ret;
 	int i;
@@ -305,8 +304,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 
 	priv = iio_priv(indio_dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mem = devm_ioremap_resource(dev, res);
+	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFB3D58DE
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhGZLLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 07:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhGZLLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 07:11:17 -0400
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A734C061757;
        Mon, 26 Jul 2021 04:51:46 -0700 (PDT)
Received: from iva4-9a39f5a0636f.qloud-c.yandex.net (iva4-9a39f5a0636f.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:3daa:0:640:9a39:f5a0])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 9890950E23AE;
        Mon, 26 Jul 2021 14:51:43 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva4-9a39f5a0636f.qloud-c.yandex.net (mxback/Yandex) with ESMTP id M7dYU4Qwd2-phIarCt7;
        Mon, 26 Jul 2021 14:51:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627300303;
        bh=DnF8MQlLLy2Du8pOQ2CgiJUliFzPhAEWk31Y4mdc5fE=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=RIR/EJZJXAzMfWyImXv/Xc1TkNumL/rqezFPESs02HJFWXw+6cGP1Gs4++SDtL8Iz
         vgRET/RPSqCHyhnr+IdYFRO0WvgEeRTxnNyf8X+iuEI+HcJdTVIPSFlvFLIZpZoCkn
         cxhrCuuY1N5MH04IftjB3CfoeHJ/5eb7xgqRy3oQ=
Authentication-Results: iva4-9a39f5a0636f.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PIKatQa27D-pg2Sp7KC;
        Mon, 26 Jul 2021 14:51:42 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] iio: ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 14:50:45 +0300
Message-Id: <20210726115058.23729-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726115058.23729-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-adc
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
...
clk_core_enable
clk_core_enable_lock
ep93xx_adc_probe
...
ep93xx-adc ep93xx-adc: Cannot enable clock
ep93xx-adc: probe of ep93xx-adc failed with error -108

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.26.2


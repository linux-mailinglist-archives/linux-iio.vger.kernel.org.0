Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC73D5AF5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhGZNZo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZNZo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 09:25:44 -0400
X-Greylist: delayed 285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jul 2021 07:06:12 PDT
Received: from forward103p.mail.yandex.net (forward103p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8CDC061757
        for <linux-iio@vger.kernel.org>; Mon, 26 Jul 2021 07:06:12 -0700 (PDT)
Received: from myt5-1892386aa303.qloud-c.yandex.net (myt5-1892386aa303.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4323:0:640:1892:386a])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 11F9D18C2778;
        Mon, 26 Jul 2021 17:01:22 +0300 (MSK)
Received: from myt3-07a4bd8655f2.qloud-c.yandex.net (myt3-07a4bd8655f2.qloud-c.yandex.net [2a02:6b8:c12:693:0:640:7a4:bd86])
        by myt5-1892386aa303.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 9yNTtrPB3e-1LI823aw;
        Mon, 26 Jul 2021 17:01:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627308081;
        bh=NuHz/YWacClslgKb232VJAShP0Ke4RBK+HwgJRwIaVk=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=KunjZqRejlkS/p8khjjymZuyU63i6nncL5uX5v17UA3TMWqT+WyNpURBpYX+6roZW
         CqcoXVBeIT67D+n5C9h1x8d8A9yM8BAlLAUnn0PBBEZIjxi9HOeE7+IOJdVpjulsmr
         lgZtZuRKI0Zu/K+wvHAORUNsSiC+L43ZQCL9R1PA=
Authentication-Results: myt5-1892386aa303.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt3-07a4bd8655f2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id olJ9yWy468-1K2iqfGp;
        Mon, 26 Jul 2021 17:01:20 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/8] iio: ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 16:59:49 +0300
Message-Id: <20210726140001.24820-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726140001.24820-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
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
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
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

base-commit: 64376a981a0e2e57c46efa63197c2ebb7dab35df
-- 
2.26.2


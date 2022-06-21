Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6641B553B81
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354308AbiFUUW7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354313AbiFUUW7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA352AA
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FD86182F
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9086BC3411C;
        Tue, 21 Jun 2022 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842973;
        bh=hI8/aEZ8n/BgKYfuEImgmOFroAF6FKeZhyhqgBeqE/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmNaUZ1t9MQoVucruDtGkB0yRu3emke9OX9v/2X2QCsGXIzrUmnH4ZwPmbu85PBW5
         ibdcWaHB/MaDIceiX+QIk50nAxCT3eX/ZYTTEiBn0zvjmrteWi7nzz90sPcH8tQhlH
         NPwIxKv9Kpu6W7Zl/tChKGK/+RtQtdUAyrq0QzhNgI+ly/uvnFS1nGr9O+EUps5SSF
         yu/Fsd63VnS7UWpXeoRDIjBDKAXrLw3GZiCehEWlvpemncd5/szQw+qI13Val6vMJW
         LblFjhibF7dN/F9joqnuIeplHPxNQyzgP0zpdZbBHnHQFgjw3eDcirthNLet77A1RE
         41lwx+X1oRazg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 35/36] iio: magnetometer: ak8974: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 21 Jun 2022 21:27:18 +0100
Message-Id: <20220621202719.13644-36-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621202719.13644-1-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using these new macros allows the compiler to remove the unused dev_pm_ops
structure and related functions if !CONFIG_PM without the need to mark
the functions __maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8974.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index e54feacfb980..c89a91db0690 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -985,7 +985,7 @@ static int ak8974_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static int __maybe_unused ak8974_runtime_suspend(struct device *dev)
+static int ak8974_runtime_suspend(struct device *dev)
 {
 	struct ak8974 *ak8974 =
 		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
@@ -996,7 +996,7 @@ static int __maybe_unused ak8974_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ak8974_runtime_resume(struct device *dev)
+static int ak8974_runtime_resume(struct device *dev)
 {
 	struct ak8974 *ak8974 =
 		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
@@ -1024,12 +1024,8 @@ static int __maybe_unused ak8974_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops ak8974_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(ak8974_runtime_suspend,
-			   ak8974_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ak8974_dev_pm_ops, ak8974_runtime_suspend,
+				 ak8974_runtime_resume, NULL);
 
 static const struct i2c_device_id ak8974_id[] = {
 	{"ami305", 0 },
@@ -1050,7 +1046,7 @@ MODULE_DEVICE_TABLE(of, ak8974_of_match);
 static struct i2c_driver ak8974_driver = {
 	.driver	 = {
 		.name	= "ak8974",
-		.pm = &ak8974_dev_pm_ops,
+		.pm = pm_ptr(&ak8974_dev_pm_ops),
 		.of_match_table = ak8974_of_match,
 	},
 	.probe	  = ak8974_probe,
-- 
2.36.1


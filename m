Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55CB553B73
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354277AbiFUUVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54C1CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 577C0B81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F871C341C5;
        Tue, 21 Jun 2022 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842871;
        bh=+3MfJvxPOfIpSBb1x+TBN4ba3dXoJ1Gf7lmS0DxkCg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUjivMIpRoeGx9L503BgW7zNE1/4a0nkbZp9VRLpKZ5EqIQifJMIS2R6CMJ5bSQDy
         NdRO4P6o1pWnQ7aYjLaO5zlOlVWPAaB+RRVCQGD1Qn+W56bMTvK+VNRnVr1aobEigJ
         KMmF9SLdmp1K292tr0VsHGOLeC36ifSzY3ZtLD6AclIV8PY2MnY1XFbh9jrQ0G9Ne7
         P9tkU98MRj3fjCBMM5m9nRx1A3Uw8HgFRG/g3aY5PXGlKbFvr3aLbk2AYouTQfrqtn
         UAd31hSeYqGMujWyfP4A3F+GgtTbLN84cdE7wqvdg3rX/HbjSn+5+d/Mki0E2oDgJ9
         IjXbhlcQBsDJg==
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
Subject: [PATCH 23/36] iio: light: cm3605: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:06 +0100
Message-Id: <20220621202719.13644-24-jic23@kernel.org>
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

Using these newer macros allows the compiler to remove the unused
structure and functions when !CONFIG_PM_SLEEP + removes the need to
mark pm functions __maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cm3605.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 50d34a98839c..c721b69d5095 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -278,7 +278,7 @@ static int cm3605_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused cm3605_pm_suspend(struct device *dev)
+static int cm3605_pm_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
@@ -289,7 +289,7 @@ static int __maybe_unused cm3605_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cm3605_pm_resume(struct device *dev)
+static int cm3605_pm_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
@@ -302,11 +302,8 @@ static int __maybe_unused cm3605_pm_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops cm3605_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cm3605_pm_suspend,
-				cm3605_pm_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(cm3605_dev_pm_ops, cm3605_pm_suspend,
+				cm3605_pm_resume);
 
 static const struct of_device_id cm3605_of_match[] = {
 	{.compatible = "capella,cm3605"},
@@ -318,7 +315,7 @@ static struct platform_driver cm3605_driver = {
 	.driver = {
 		.name = "cm3605",
 		.of_match_table = cm3605_of_match,
-		.pm = &cm3605_dev_pm_ops,
+		.pm = pm_sleep_ptr(&cm3605_dev_pm_ops),
 	},
 	.probe = cm3605_probe,
 	.remove = cm3605_remove,
-- 
2.36.1


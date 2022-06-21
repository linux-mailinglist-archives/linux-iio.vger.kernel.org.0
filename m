Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F24553B74
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354279AbiFUUVX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUVX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0BD1CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA3D2B81B24
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9024BC3411C;
        Tue, 21 Jun 2022 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842879;
        bh=P3EhNBqqUGGNk++I8lphjCVAqNPW/abwsn/04zhMlfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTOZA9b0q48rRnxp9CyHYGKS5hjPa3pd829167BS9FVi1cUU+0ODS9Q9gOw1ao3dC
         cFAbNYI7rQz4iYQgeAPG+QwpdB1tTzr0zIswkdy0vHlzF1AxyESXgBuMKfcd1KTnSp
         TG3Vnzvn7C+mjYOZYvtgWYcrHmRN05H9BiqF8erUG2BMQf9ITcilS5BYqy7Fy7l1LG
         v4riPUFl3RfslSZN5mYiNsfebKuGrK8j48ArgP0InD48rFLz8sWihdFdsAhDLWfs8J
         mMS1t7QbckVcrWkQKvl+M1/wLcB1D1FsWJKPkII+ea4bcqnUQYBe/8KkGT2nvZR0d5
         GWV9BwL6/Iwtg==
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
Subject: [PATCH 24/36] iio: proximity: cros_ec_mkbp: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:07 +0100
Message-Id: <20220621202719.13644-25-jic23@kernel.org>
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 8213b0081713..571ea1812246 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -184,7 +184,7 @@ static const struct iio_info cros_ec_mkbp_proximity_info = {
 	.write_event_config = cros_ec_mkbp_proximity_write_event_config,
 };
 
-static __maybe_unused int cros_ec_mkbp_proximity_resume(struct device *dev)
+static int cros_ec_mkbp_proximity_resume(struct device *dev)
 {
 	struct cros_ec_mkbp_proximity_data *data = dev_get_drvdata(dev);
 	struct cros_ec_device *ec = data->ec;
@@ -201,8 +201,8 @@ static __maybe_unused int cros_ec_mkbp_proximity_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cros_ec_mkbp_proximity_pm_ops, NULL,
-			 cros_ec_mkbp_proximity_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_mkbp_proximity_pm_ops, NULL,
+				cros_ec_mkbp_proximity_resume);
 
 static int cros_ec_mkbp_proximity_probe(struct platform_device *pdev)
 {
@@ -260,7 +260,7 @@ static struct platform_driver cros_ec_mkbp_proximity_driver = {
 	.driver = {
 		.name = "cros-ec-mkbp-proximity",
 		.of_match_table = cros_ec_mkbp_proximity_of_match,
-		.pm = &cros_ec_mkbp_proximity_pm_ops,
+		.pm = pm_sleep_ptr(&cros_ec_mkbp_proximity_pm_ops),
 	},
 	.probe = cros_ec_mkbp_proximity_probe,
 	.remove = cros_ec_mkbp_proximity_remove,
-- 
2.36.1


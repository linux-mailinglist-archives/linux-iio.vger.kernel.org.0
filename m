Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC99553B7D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354304AbiFUUWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354306AbiFUUWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE2F2613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3219A6181B
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4C3C3411C;
        Tue, 21 Jun 2022 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842938;
        bh=eDSa5XRmRtAbQwRlcco6kCxP436UXxhfOsvBV70Btts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHN9LWCR1mJIJ6boV4qSh2ZhMYZXQ7Y2oDt9GdO3L4Ty+P5jqfdoy32CeXa4Xi9YF
         Qb6G/UDdOG2MfDYkmCy/y98BdsBmlaMd+Jd3TG159MIZbJyRom4pK8Zyvvv4blvZsZ
         xslIi5un72O/gFEO8420SlEOPMZXm5/MdQZmQSpsVXwPSuHIQzoc2ZqsNs+2g5Rn7S
         QPxjJMF3TbSZnybNdThdS0qKxRcXBDdvaJs8oPI0IPLOeXPcNltUer6s0jRyzSVYDd
         Y9iZu1+x2fjE/Ie4p3AOOUeQD39dciF757KwqEmi1sy5wfEk8v5L+MGRNgoTcz2NGZ
         XxR2w5mwfD/Fg==
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
Subject: [PATCH 31/36] iio: light: tsl2591: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
Date:   Tue, 21 Jun 2022 21:27:14 +0100
Message-Id: <20220621202719.13644-32-jic23@kernel.org>
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

Using these new macros allows removal of unused pm_ops structure and
functions if !CONFIG_PM without the need to mark the functions
__maybe_unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joe Sandom <joe.g.sandom@gmail.com>
---
 drivers/iio/light/tsl2591.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 39e68d0c9d6a..e485a556e6da 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1019,7 +1019,7 @@ static const struct iio_info tsl2591_info_no_irq = {
 	.read_avail = tsl2591_read_available,
 };
 
-static int __maybe_unused tsl2591_suspend(struct device *dev)
+static int tsl2591_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2591_chip *chip = iio_priv(indio_dev);
@@ -1032,7 +1032,7 @@ static int __maybe_unused tsl2591_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused tsl2591_resume(struct device *dev)
+static int tsl2591_resume(struct device *dev)
 {
 	int power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -1049,10 +1049,8 @@ static int __maybe_unused tsl2591_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops tsl2591_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tsl2591_suspend, tsl2591_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(tsl2591_pm_ops, tsl2591_suspend,
+				 tsl2591_resume, NULL);
 
 static irqreturn_t tsl2591_event_handler(int irq, void *private)
 {
@@ -1213,7 +1211,7 @@ MODULE_DEVICE_TABLE(of, tsl2591_of_match);
 static struct i2c_driver tsl2591_driver = {
 	.driver = {
 		.name = "tsl2591",
-		.pm = &tsl2591_pm_ops,
+		.pm = pm_ptr(&tsl2591_pm_ops),
 		.of_match_table = tsl2591_of_match,
 	},
 	.probe_new = tsl2591_probe
-- 
2.36.1


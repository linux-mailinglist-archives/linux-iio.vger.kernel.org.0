Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8113553B7E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354307AbiFUUWa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354306AbiFUUW3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D92613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B8A61830
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA0C341C4;
        Tue, 21 Jun 2022 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842947;
        bh=Leby3RQp5/W7wO9DRLmW+m06zCVbu4XKWtNpbfXEqi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQhVUWG3DADZx3KVpRwrkxl3qazNgIS+jEYUN9sFFbDCOFbaZormaI1SSB8lUhqi6
         Vy8Xyj6hBEN4rXy+frKdeYfyFF2N+9dEgNF2heYOvztv1UDebr9xAqcWjivMcHkoe2
         QueCICEdgjWhehpjAXByr0UWR29TU9H6Lry3MgvSe86J2T0GpRyGeRV9cKKFGnk6VM
         7enJEKok3+fzFR33ZcSRy1CYbDXABRw2WyZtmbiGfuU3nkFagf0q3Ncs9jGrh3/PLg
         VyWl0Gbs34HmZz8HrV676Ah13MDOu9e6nfv2Cms25IBenT86z0dtHZcpSm4NMjWuQX
         0QQr8IluWU2Jg==
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
Subject: [PATCH 32/36] iio: light: vcnl4000: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 21 Jun 2022 21:27:15 +0100
Message-Id: <20220621202719.13644-33-jic23@kernel.org>
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
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 947a41b86173..3db4e26731bb 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1130,7 +1130,7 @@ static int vcnl4000_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused vcnl4000_runtime_suspend(struct device *dev)
+static int vcnl4000_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct vcnl4000_data *data = iio_priv(indio_dev);
@@ -1138,7 +1138,7 @@ static int __maybe_unused vcnl4000_runtime_suspend(struct device *dev)
 	return data->chip_spec->set_power_state(data, false);
 }
 
-static int __maybe_unused vcnl4000_runtime_resume(struct device *dev)
+static int vcnl4000_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct vcnl4000_data *data = iio_priv(indio_dev);
@@ -1146,17 +1146,13 @@ static int __maybe_unused vcnl4000_runtime_resume(struct device *dev)
 	return data->chip_spec->set_power_state(data, true);
 }
 
-static const struct dev_pm_ops vcnl4000_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(vcnl4000_runtime_suspend,
-			   vcnl4000_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(vcnl4000_pm_ops, vcnl4000_runtime_suspend,
+				 vcnl4000_runtime_resume, NULL);
 
 static struct i2c_driver vcnl4000_driver = {
 	.driver = {
 		.name   = VCNL4000_DRV_NAME,
-		.pm	= &vcnl4000_pm_ops,
+		.pm	= pm_ptr(&vcnl4000_pm_ops),
 		.of_match_table = vcnl_4000_of_match,
 	},
 	.probe  = vcnl4000_probe,
-- 
2.36.1


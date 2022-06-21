Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5284F553B61
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353829AbiFUUTb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUTa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:19:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A81CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C594B81809
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F46C3411C;
        Tue, 21 Jun 2022 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842767;
        bh=2VOKrsbJJyFWIQ+Jx64qLLEpnySDWXWZeeq6TPRQzXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u71zx0eEJzwq5BO14M0v49eH203ytIOxl5P4X9JN1bwlVrbO2YScLOeFPhlchWwXx
         YZs5wkFoIpJj+ISdMZNLie7vylE6WzFtdF3wMNjBOJ3Riaz1h4dgttbi0yeY/rcdtw
         r6ERqQssL7m8/FCkJA8lYaqrHVYp6ahmR4/maF9R3isFNx0ngtUfaO9GbpxmTyERX8
         Nl47zidaqbU4g6mqFbj+tbQLqwsDFBwEaSG6eCfEX94xn5y0OS5q5s+zZE8MElmVwl
         /KzQvGkoDKUB9yU9tYEK62eJ+ahfPcjGxp5lrF55v+UGE7K/oeNphl/R+fM+zMrqaq
         SEImKaAmv/a2Q==
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
Subject: [PATCH 10/36] iio: chemical: scd4x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:53 +0100
Message-Id: <20220621202719.13644-11-jic23@kernel.org>
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
Cc: Roan van Dijk <roan@protonic.nl>
---
 drivers/iio/chemical/scd4x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 37143b5526ee..54066532ea45 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -551,7 +551,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 	},
 };
 
-static int __maybe_unused scd4x_suspend(struct device *dev)
+static int scd4x_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct scd4x_state *state  = iio_priv(indio_dev);
@@ -564,7 +564,7 @@ static int __maybe_unused scd4x_suspend(struct device *dev)
 	return regulator_disable(state->vdd);
 }
 
-static int __maybe_unused scd4x_resume(struct device *dev)
+static int scd4x_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct scd4x_state *state = iio_priv(indio_dev);
@@ -577,7 +577,7 @@ static int __maybe_unused scd4x_resume(struct device *dev)
 	return scd4x_send_command(state, CMD_START_MEAS);
 }
 
-static __maybe_unused SIMPLE_DEV_PM_OPS(scd4x_pm_ops, scd4x_suspend, scd4x_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(scd4x_pm_ops, scd4x_suspend, scd4x_resume);
 
 static void scd4x_stop_meas(void *state)
 {
@@ -688,7 +688,7 @@ static struct i2c_driver scd4x_i2c_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = scd4x_dt_ids,
-		.pm = &scd4x_pm_ops
+		.pm = pm_sleep_ptr(&scd4x_pm_ops),
 	},
 	.probe = scd4x_probe,
 };
-- 
2.36.1


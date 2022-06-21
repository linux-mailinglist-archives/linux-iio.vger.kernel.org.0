Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC00553B70
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354268AbiFUUU7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbiFUUU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FBD1CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DBF4B81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4093AC341C4;
        Tue, 21 Jun 2022 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842856;
        bh=mFglGnZ2qq7YIYl4qcrkS1N+FnCS3345zhcCklI+Hbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mw31zysJolog4j4T23X3EnBy5D1Wa60sb40Va3CvpPQDww6qAuqbOo3iAHBRVQoL0
         QxiOApUX+aY9VmmxRMKU+iJZlT+zzvCJx9Wz30h6nwDrahmoPUqB+Z9USEE9GsajCH
         zUxh6WclT9MnaiSe6t65KG5KGLZ+v3jkrzJC6f3byW26n9yj8LN9dCJAH/6QXP45XS
         veQJpxN0987hoNveskfbX+9nh9Kcwu1h/w/yadsXANfQvUCZ4RVMqime0diY+L4H97
         KrYBSXePrcsV5RCUi43w7N5zaTWoukE2259HF/6jcigKCQpAzEUlujslgvJCs7dPmM
         qOdXIKKUpd1EA==
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
Subject: [PATCH 21/36] iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:04 +0100
Message-Id: <20220621202719.13644-22-jic23@kernel.org>
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
Cc: Christian Eggers <ceggers@arri.de>
---
 drivers/iio/light/as73211.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 3ba2378df3dd..2307fc531752 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -755,21 +755,22 @@ static int as73211_probe(struct i2c_client *client)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-static int __maybe_unused as73211_suspend(struct device *dev)
+static int as73211_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 
 	return as73211_power(indio_dev, false);
 }
 
-static int __maybe_unused as73211_resume(struct device *dev)
+static int as73211_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 
 	return as73211_power(indio_dev, true);
 }
 
-static SIMPLE_DEV_PM_OPS(as73211_pm_ops, as73211_suspend, as73211_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(as73211_pm_ops, as73211_suspend,
+				as73211_resume);
 
 static const struct of_device_id as73211_of_match[] = {
 	{ .compatible = "ams,as73211" },
@@ -787,7 +788,7 @@ static struct i2c_driver as73211_driver = {
 	.driver = {
 		.name           = AS73211_DRV_NAME,
 		.of_match_table = as73211_of_match,
-		.pm             = &as73211_pm_ops,
+		.pm             = pm_sleep_ptr(&as73211_pm_ops),
 	},
 	.probe_new  = as73211_probe,
 	.id_table   = as73211_id,
-- 
2.36.1


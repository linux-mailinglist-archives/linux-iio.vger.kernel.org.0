Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5647553B6A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354135AbiFUUUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUUS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E991CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D515B81B01
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A270FC3411C;
        Tue, 21 Jun 2022 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842815;
        bh=gx3OXToTwHZJAkZhPcHr+o4hZMO/s0EU8/pBJa5XMyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+SQf+m2zjw9BXH+FWN+KJX6Mi5LZep9RyESpU4Zw4U3r3Q5lNKaezgUAbtVXF4VJ
         Em9lycJAo09rgQYL40bsKBEmbliwVkjYd25z/y/dtLyq4Undx/uxxKjbpGjpJj07BW
         e1Km+b3ISQa7XQjKodsE+ClPlcPqcIDKQOf1uDDdRrp0t0OfzCfWRWqA5Nh1vHN773
         6H7DRLSGnbCSU7/Z83WU39Il8Wpy6BgYIXNtLGqs32sLN9YYqaePDeUw/qI2GOV4NX
         ChPtw6L3txE/ZHUcI6HmCn2qrwu2ZQ+e8jtoA1hiDhuXD/U9N2ZSvuY4ynivTJZNuO
         QAKS4LiOJ+4AA==
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
Subject: [PATCH 16/36] iio: gyro: itg3200: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:59 +0100
Message-Id: <20220621202719.13644-17-jic23@kernel.org>
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
 drivers/iio/gyro/itg3200_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index a7f1bbb5f289..0491c64e1b32 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -364,7 +364,7 @@ static int itg3200_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused itg3200_suspend(struct device *dev)
+static int itg3200_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct itg3200 *st = iio_priv(indio_dev);
@@ -375,14 +375,15 @@ static int __maybe_unused itg3200_suspend(struct device *dev)
 				   ITG3200_SLEEP);
 }
 
-static int __maybe_unused itg3200_resume(struct device *dev)
+static int itg3200_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
 	return itg3200_initial_setup(indio_dev);
 }
 
-static SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg3200_suspend, itg3200_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg3200_suspend,
+				itg3200_resume);
 
 static const struct i2c_device_id itg3200_id[] = {
 	{ "itg3200", 0 },
@@ -400,7 +401,7 @@ static struct i2c_driver itg3200_driver = {
 	.driver = {
 		.name	= "itg3200",
 		.of_match_table = itg3200_of_match,
-		.pm	= &itg3200_pm_ops,
+		.pm	= pm_sleep_ptr(&itg3200_pm_ops),
 	},
 	.id_table	= itg3200_id,
 	.probe		= itg3200_probe,
-- 
2.36.1


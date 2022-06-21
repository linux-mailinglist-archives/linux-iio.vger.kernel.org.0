Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86637553B6C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354258AbiFUUUg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbiFUUUf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0A1CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98390B81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8CEC3411C;
        Tue, 21 Jun 2022 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842832;
        bh=aNsWmTaWWnd1Gh7lA6RZjRrPyI4g7F6B3hrJztzlCJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EybBLBqqI7217oAFeTUSS9E+YYeZhFI5dbpHHcJKd5RyHTUIh5SWzRpDITg6BkWKL
         jSF5Gbo6ts6INYuzV0I1VULf0dACO9+8ghhLtczNC8IMqY9A8qoiFL0kJIDaAXE8FB
         Jd+xqQksmTpL0lq1XugGVI7hzx83C7xwgmGlMvQFbtqlUQuI4em6EeHJ+Tgp0CmD+F
         BCN1dRvKVaD8UJW/ODwE2mgoZMqkdB/PP2BKJgbI596bg8cdIffcnYTNdnlEM9sKfQ
         XmbNHcpCsZKmzNbIOs0O2DQDDB8F2XPgxx9cDw8Cs3+AB0/g0JnMIok9AlHnn886QV
         O3vTeu8+rYqGQ==
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
Subject: [PATCH 18/36] iio: health: afe4404: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:01 +0100
Message-Id: <20220621202719.13644-19-jic23@kernel.org>
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
 drivers/iio/health/afe4404.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 1bb7de60f8ca..dd7800159051 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -415,7 +415,7 @@ static const struct of_device_id afe4404_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, afe4404_of_match);
 
-static int __maybe_unused afe4404_suspend(struct device *dev)
+static int afe4404_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct afe4404_data *afe = iio_priv(indio_dev);
@@ -436,7 +436,7 @@ static int __maybe_unused afe4404_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused afe4404_resume(struct device *dev)
+static int afe4404_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct afe4404_data *afe = iio_priv(indio_dev);
@@ -456,7 +456,8 @@ static int __maybe_unused afe4404_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(afe4404_pm_ops, afe4404_suspend, afe4404_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(afe4404_pm_ops, afe4404_suspend,
+				afe4404_resume);
 
 static int afe4404_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
@@ -607,7 +608,7 @@ static struct i2c_driver afe4404_i2c_driver = {
 	.driver = {
 		.name = AFE4404_DRIVER_NAME,
 		.of_match_table = afe4404_of_match,
-		.pm = &afe4404_pm_ops,
+		.pm = pm_sleep_ptr(&afe4404_pm_ops),
 	},
 	.probe = afe4404_probe,
 	.remove = afe4404_remove,
-- 
2.36.1


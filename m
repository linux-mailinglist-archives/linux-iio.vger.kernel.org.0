Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D41553B67
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354129AbiFUUUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354074AbiFUUUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977B1D31D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B3BB81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2187C341C5;
        Tue, 21 Jun 2022 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842806;
        bh=9UABDwPS1KiPjY6BZQLOSKM6AFWWDu7EeUkin0n4Lss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Px/QcpumqBdxy2AKqdAvaADSSv+i3hS4oBcSqFoSLbgfpgwczhpbhbvWAPo8GbKNx
         UWYKtl4OdxjYL3AfVYv+e0bSLi/7kJhH8tUH2jSPHUrRo7Jdqgelg4n4zZwGLAZJLE
         InHpd8g0T6moT6E+tDS/6p0TpuEhggew2a8NtnufS97NwU/0ztT3+DV7+2fy7naXH0
         FE94ph6RG8EZqIZ/uOCesCecFv9lkg4vicy/1asDgOS23gegt9rSPn0oqz9uEDa2rb
         45U0xl3uFTNTY3pxqnzetPyF8eaxAHScHzW5Liy1R+r5HHtTW/P40ZV3/kT2lQWUJ6
         L2UEyXVspygaA==
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
Subject: [PATCH 15/36] iio: dac: mcp4725: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:58 +0100
Message-Id: <20220621202719.13644-16-jic23@kernel.org>
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
Cc: Philippe Reynes <tremyfr@yahoo.fr>
---
 drivers/iio/dac/mcp4725.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 7fcb86288823..bb4b85a7b95b 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -42,7 +42,7 @@ struct mcp4725_data {
 	struct regulator *vref_reg;
 };
 
-static int __maybe_unused mcp4725_suspend(struct device *dev)
+static int mcp4725_suspend(struct device *dev)
 {
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -55,7 +55,7 @@ static int __maybe_unused mcp4725_suspend(struct device *dev)
 	return i2c_master_send(data->client, outbuf, 2);
 }
 
-static int __maybe_unused mcp4725_resume(struct device *dev)
+static int mcp4725_resume(struct device *dev)
 {
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -68,7 +68,8 @@ static int __maybe_unused mcp4725_resume(struct device *dev)
 
 	return i2c_master_send(data->client, outbuf, 2);
 }
-static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend,
+				mcp4725_resume);
 
 static ssize_t mcp4725_store_eeprom(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
@@ -523,7 +524,7 @@ static struct i2c_driver mcp4725_driver = {
 	.driver = {
 		.name	= MCP4725_DRV_NAME,
 		.of_match_table = mcp4725_of_match,
-		.pm	= &mcp4725_pm_ops,
+		.pm	= pm_sleep_ptr(&mcp4725_pm_ops),
 	},
 	.probe		= mcp4725_probe,
 	.remove		= mcp4725_remove,
-- 
2.36.1


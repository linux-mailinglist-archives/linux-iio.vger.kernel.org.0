Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BC553B63
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354050AbiFUUTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUTo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:19:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEB1CFCD
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5BE2B81809
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6C9C3411C;
        Tue, 21 Jun 2022 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842781;
        bh=oQVK8zu9RDGROfQmKal1LUbnVDhdKjLWODLPg13kPwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RM+k9jC2tvWSW/o/lG23zWtu/8OlQwWu2qR3Ip4HrAkv4un0SMDJp6qlSXTJaYpds
         1lbjyRd97mmaZiLFXieqy7ym9OgqGRLgoi7tKyUvkq+e8Hm/VDpvVsgy3g9Z9DQopE
         ZAymCexpf8+HMQstnEmzNXoo7P/pl1SgX5B8qXKAIiVAdh4Sf4td6DsN0lo+A2Rqx9
         AIIk31O60cKS0O0rmDjJXSl3x1mEdFs6KwIx2KOfXxdzJeISCzN3mNIlNVcHHrGkHr
         Hb0/212gk9kE2o68Th/PMjDulxK4oVl9QJ7yjcTe3BSbrZU+xIlRcdt+kt+cXUPp98
         oMPTp0xek5ExQ==
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
Subject: [PATCH 12/36] iio: dac: ltc1660: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:55 +0100
Message-Id: <20220621202719.13644-13-jic23@kernel.org>
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
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/ltc1660.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ltc1660.c b/drivers/iio/dac/ltc1660.c
index c76233c9bb72..2758fc8a5ad5 100644
--- a/drivers/iio/dac/ltc1660.c
+++ b/drivers/iio/dac/ltc1660.c
@@ -137,20 +137,21 @@ static const struct iio_info ltc1660_info = {
 	.write_raw = &ltc1660_write_raw,
 };
 
-static int __maybe_unused ltc1660_suspend(struct device *dev)
+static int ltc1660_suspend(struct device *dev)
 {
 	struct ltc1660_priv *priv = iio_priv(spi_get_drvdata(
 						to_spi_device(dev)));
 	return regmap_write(priv->regmap, LTC1660_REG_SLEEP, 0x00);
 }
 
-static int __maybe_unused ltc1660_resume(struct device *dev)
+static int ltc1660_resume(struct device *dev)
 {
 	struct ltc1660_priv *priv = iio_priv(spi_get_drvdata(
 						to_spi_device(dev)));
 	return regmap_write(priv->regmap, LTC1660_REG_WAKE, 0x00);
 }
-static SIMPLE_DEV_PM_OPS(ltc1660_pm_ops, ltc1660_suspend, ltc1660_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ltc1660_pm_ops, ltc1660_suspend,
+				ltc1660_resume);
 
 static int ltc1660_probe(struct spi_device *spi)
 {
@@ -233,7 +234,7 @@ static struct spi_driver ltc1660_driver = {
 	.driver = {
 		.name = "ltc1660",
 		.of_match_table = ltc1660_dt_ids,
-		.pm = &ltc1660_pm_ops,
+		.pm = pm_sleep_ptr(&ltc1660_pm_ops),
 	},
 	.probe	= ltc1660_probe,
 	.remove = ltc1660_remove,
-- 
2.36.1


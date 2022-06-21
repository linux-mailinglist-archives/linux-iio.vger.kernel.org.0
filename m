Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4E553B57
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354046AbiFUUSr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353874AbiFUUSU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:18:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2E175B7
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22633CE1BB7
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F112C341C4;
        Tue, 21 Jun 2022 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842695;
        bh=wT0k2V4BfqgDPP8eWfBsEY4I+Qdr87NC2xiZZedL3HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eewN/WNNsCu9O4f1lIsxAvrp7XI3nuv29rdj3ODWUi8WQMEWil14nA8MK81CQWpVM
         kdvOHLaFONTf5ent8GH4OQKbpZdsgHUbQQ5OELcn0RWFfNg5G6PEbX+RkcaeAzT8Y9
         AgjqoLFuPVDVBwhI8pGyjqY888SpYFx03MT0qcJckWfoq9M12OnT1ZV54p1Bukvlga
         MPRMFzg/po9lP25pcxbzTeyBc/mqN+Um+PlX05fP7PXrfLjXmhUBpUhUIKE3G7PI4j
         a2qog0Z7aObtf9uaj8FekMMKAVI1LjASDehQXZz4IzxZdXIu3nvcDvJLDbZ6S2Q5k2
         GJ+thPi3/KgMQ==
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
Subject: [PATCH 01/36] iio: accel: bma220: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:44 +0100
Message-Id: <20220621202719.13644-2-jic23@kernel.org>
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
 drivers/iio/accel/bma220_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index b6d9ab8e2054..fcbd695e4654 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -289,20 +289,20 @@ static int bma220_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-static __maybe_unused int bma220_suspend(struct device *dev)
+static int bma220_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 
 	return bma220_power(spi, false);
 }
 
-static __maybe_unused int bma220_resume(struct device *dev)
+static int bma220_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 
 	return bma220_power(spi, true);
 }
-static SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
 
 static const struct spi_device_id bma220_spi_id[] = {
 	{"bma220", 0},
@@ -318,7 +318,7 @@ MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 static struct spi_driver bma220_driver = {
 	.driver = {
 		.name = "bma220_spi",
-		.pm = &bma220_pm_ops,
+		.pm = pm_sleep_ptr(&bma220_pm_ops),
 		.acpi_match_table = bma220_acpi_id,
 	},
 	.probe =            bma220_probe,
-- 
2.36.1


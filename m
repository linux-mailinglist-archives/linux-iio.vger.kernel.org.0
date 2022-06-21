Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA3553B64
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354065AbiFUUTw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:19:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA02613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAC70B81B24
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1F6C341C4;
        Tue, 21 Jun 2022 20:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842788;
        bh=0oSGiJpWCxBQCdZZZqvVuQT2Cw5szPuHbWL/hBhsH2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc1f2PJxhiGbZO4czhKfFDnnfhrbnLMGClHK3ujRm6IILi6Na5NjcppE8eCN/mIRn
         My4PNbQrxX6fIsQWRY3dXIJg0jGl5YdYTAsRdq9y1/MiRxiRIEJvuai0yYe1rXBFzy
         1b7NKRSMV8YPI+Ip4009HMZmMiKy47PB1pGkmRBKeCoJ6eQp029woDzBemKfJ5v65s
         rmuuFnhrLp2mKQkUHF63qIVXmuEy6HL+266650GbR7z5Z1/CK2O/Wob9urLayyPxKu
         KlZoEHAkndVvZHsMBzR62CD3bBa6setU8DIhJzPs4xd/fFFnaomhrp5Ajr0n1wkmQ2
         9kxC69CFk35nw==
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
Subject: [PATCH 13/36] iio: dac: max517: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:56 +0100
Message-Id: <20220621202719.13644-14-jic23@kernel.org>
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
 drivers/iio/dac/max517.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index a6ef555153f4..373ce6ff83b7 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -100,21 +100,21 @@ static int max517_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int __maybe_unused max517_suspend(struct device *dev)
+static int max517_suspend(struct device *dev)
 {
 	u8 outbuf = COMMAND_PD;
 
 	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
 }
 
-static int __maybe_unused max517_resume(struct device *dev)
+static int max517_resume(struct device *dev)
 {
 	u8 outbuf = 0;
 
 	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
 }
 
-static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
 
 static const struct iio_info max517_info = {
 	.read_raw = max517_read_raw,
@@ -201,7 +201,7 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
 static struct i2c_driver max517_driver = {
 	.driver = {
 		.name	= MAX517_DRV_NAME,
-		.pm	= &max517_pm_ops,
+		.pm	= pm_sleep_ptr(&max517_pm_ops),
 	},
 	.probe		= max517_probe,
 	.id_table	= max517_id,
-- 
2.36.1


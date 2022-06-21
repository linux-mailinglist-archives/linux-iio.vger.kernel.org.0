Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C226E553B71
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354269AbiFUUVH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbiFUUVG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8E2613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE44B81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7C7C341C6;
        Tue, 21 Jun 2022 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842862;
        bh=4nXMTIXPmZTLehtRlxc9hUBdnfHSp93MugvSXw6q7oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQumyHYl90RFjGD+tplBwRXteBPjTeE3qd2/VtfcUQ3XRmzsQcVxzezUTjdSW49Ey
         AbkIN/ggxyeHMIpvMQqnVI3WppoIRbO0B/QrbBSb7NbNhvX8ZlubkNX4kiM4VjfInB
         97ALuQPEgrIRNc8GsedwBHWzL3XfvF8Tz/9FwShIpQGiqpIry7OEYMLfQoSqeC1meC
         sfYkzXSDTw4q4TpgEb9xSPrZc5zHaE9BjymdB0rPcKKAt31XPp2yXW8ZJZg+ttG368
         xACE+guf4fiHkz/bwdrB5FSFlmAVmoJyzn8o/w/PHvOTldHJYcc0k0aAmyirrvLEO5
         bOFXvEZXiTD5g==
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
Subject: [PATCH 22/36] iio: light: bh1750: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:27:05 +0100
Message-Id: <20220621202719.13644-23-jic23@kernel.org>
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
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/light/bh1750.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 48484b9401b9..471985c220bb 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -277,7 +277,7 @@ static int bh1750_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused bh1750_suspend(struct device *dev)
+static int bh1750_suspend(struct device *dev)
 {
 	int ret;
 	struct bh1750_data *data =
@@ -294,7 +294,7 @@ static int __maybe_unused bh1750_suspend(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
+static DEFINE_SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
 
 static const struct i2c_device_id bh1750_id[] = {
 	{ "bh1710", BH1710 },
@@ -320,7 +320,7 @@ static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
 		.of_match_table = bh1750_of_match,
-		.pm = &bh1750_pm_ops,
+		.pm = pm_sleep_ptr(&bh1750_pm_ops),
 	},
 	.probe = bh1750_probe,
 	.remove = bh1750_remove,
-- 
2.36.1


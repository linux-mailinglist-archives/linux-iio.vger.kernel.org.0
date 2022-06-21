Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D8553B62
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354033AbiFUUTk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUTj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:19:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B762613C
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F32CCE1C39
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC99C341C4;
        Tue, 21 Jun 2022 20:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842775;
        bh=gRHf8QVxLTOp4IR+16PDiLQPXJOi9Sjm3BEQHvf9SZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHiRvUnVTNqoIUdRr9s6bA3BBSJOcbdA8zJlQX7XQ8KoxsIVZA9LccFEVhPcm3wvF
         utybZzjn8ann2WNDsfmFHdZMAj1/6zuCSj/FUz6/UTjCmT96EdclVnUlWRtx1+kfkk
         GB1tvijuRJqmQ3fAvSIVhf1RnF8uYNtqAVn62BFkoj3hP8GOZGsWTquek9+wbyrJcx
         OUvJa5IOw6JnONjdLUjJlQzHE4LAQ+f7x05z3Pla76nPdqbOdp3AKitnHlzRb/NH0x
         XyM/0RM1qMQqadTG+4E9P9wm86DnYH3qW9sfLbdALZAA3R7MOobvx0s781NqQKeVXp
         IX8unnAbhtfrQ==
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
Subject: [PATCH 11/36] iio: dac: ds4424: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:54 +0100
Message-Id: <20220621202719.13644-12-jic23@kernel.org>
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
Cc: Ismail H. Kose <ihkose@gmail.com>
---
 drivers/iio/dac/ds4424.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 5a5e967b0be4..509394690bcc 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -171,7 +171,7 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int __maybe_unused ds4424_suspend(struct device *dev)
+static int ds4424_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -189,7 +189,7 @@ static int __maybe_unused ds4424_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ds4424_resume(struct device *dev)
+static int ds4424_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -206,7 +206,7 @@ static int __maybe_unused ds4424_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
 
 static const struct iio_info ds4424_info = {
 	.read_raw = ds4424_read_raw,
@@ -312,7 +312,7 @@ static struct i2c_driver ds4424_driver = {
 	.driver = {
 		.name	= "ds4424",
 		.of_match_table = ds4424_of_match,
-		.pm     = &ds4424_pm_ops,
+		.pm     = pm_sleep_ptr(&ds4424_pm_ops),
 	},
 	.probe		= ds4424_probe,
 	.remove		= ds4424_remove,
-- 
2.36.1


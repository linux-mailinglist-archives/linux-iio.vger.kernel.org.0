Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73A553B65
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiFUUUB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354074AbiFUUUB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54C27B16
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F3F0B81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58010C3411C;
        Tue, 21 Jun 2022 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842797;
        bh=h5ecam/1HcRbl4PmcgXX9VUG/kll21fK5pRUgNPqSgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inqs8EmfPF6WGpB0tQmoJ6rp10+0XZtd0NvpilCJbHEDVop6/kL/XgsScpp4yS/FK
         FQSxPNcT3C5odRkZv5IudDTGsgb6twUs0Cm8qtEjmTk1j/uaTdaNuipyV/9lCzPohF
         61Z7nx93aeW9o+WIWUE0gr5DtswsyJeu1snOhbKlYby19r7OGtc0mOH2tC0zMXz/rb
         4AJ4jHuDbQ3X0o6q49t1rTFoggckHqGMwTcdypF/703DwEXsaHAfhGKJ7gmMDJRaOV
         +OUT68xm+IhtW/XAw/Y1Db0/9Y1Rezm6ulFtr9j6O2oqwC/qrGiXrWmmx887e6Mg7F
         bYERbrYTSUsrQ==
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
Subject: [PATCH 14/36] iio: dac: max5821: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Tue, 21 Jun 2022 21:26:57 +0100
Message-Id: <20220621202719.13644-15-jic23@kernel.org>
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
 drivers/iio/dac/max5821.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 540f9ea7cada..e001b594d5b1 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -267,7 +267,7 @@ static int max5821_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int __maybe_unused max5821_suspend(struct device *dev)
+static int max5821_suspend(struct device *dev)
 {
 	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
 			 MAX5821_EXTENDED_DAC_A |
@@ -277,7 +277,7 @@ static int __maybe_unused max5821_suspend(struct device *dev)
 	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
 }
 
-static int __maybe_unused max5821_resume(struct device *dev)
+static int max5821_resume(struct device *dev)
 {
 	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
 			 MAX5821_EXTENDED_DAC_A |
@@ -287,7 +287,8 @@ static int __maybe_unused max5821_resume(struct device *dev)
 	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
 }
 
-static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend,
+				max5821_resume);
 
 static const struct iio_info max5821_info = {
 	.read_raw = max5821_read_raw,
@@ -374,7 +375,7 @@ static struct i2c_driver max5821_driver = {
 	.driver = {
 		.name	= "max5821",
 		.of_match_table = max5821_of_match,
-		.pm     = &max5821_pm_ops,
+		.pm     = pm_sleep_ptr(&max5821_pm_ops),
 	},
 	.probe		= max5821_probe,
 	.id_table	= max5821_id,
-- 
2.36.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF4779DD0
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHLG5x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjHLG5w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 02:57:52 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D32DC2728;
        Fri, 11 Aug 2023 23:57:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="176431199"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2023 15:57:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E7309417439A;
        Sat, 12 Aug 2023 15:57:47 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] iio: magnetometer: yamaha-yas530: Use i2c_get_match_data()
Date:   Sat, 12 Aug 2023 07:57:40 +0100
Message-Id: <20230812065741.20990-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
References: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Simplify the probe() by replacing device_get_match_data() with
i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Split dropping enum chip_ids as separate patch
---
 drivers/iio/magnetometer/yamaha-yas530.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index c5e485bfc6fc..7b041bb38693 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1434,9 +1434,7 @@ static int yas5xx_probe(struct i2c_client *i2c)
 		goto assert_reset;
 	}
 
-	ci = device_get_match_data(dev);
-	if (!ci)
-		ci = (const struct yas5xx_chip_info *)id->driver_data;
+	ci = i2c_get_match_data(i2c);
 	yas5xx->chip_info = ci;
 
 	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
-- 
2.25.1


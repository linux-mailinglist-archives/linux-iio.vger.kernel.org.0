Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BB77A0C0
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjHLPTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHLPTL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 11:19:11 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE43B10FB;
        Sat, 12 Aug 2023 08:19:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="172766721"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Aug 2023 00:19:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 57B6140065C1;
        Sun, 13 Aug 2023 00:19:10 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: light: opt4001: Use i2c_get_match_data()
Date:   Sat, 12 Aug 2023 16:19:08 +0100
Message-Id: <20230812151908.188696-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace device_get_match_data()->i2c_get_match_data() to extend matching
support for ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 502946bf9f94..6cf60151b3d8 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -412,7 +412,7 @@ static int opt4001_probe(struct i2c_client *client)
 	if (dev_id != OPT4001_DEVICE_ID_VAL)
 		dev_warn(&client->dev, "Device ID: %#04x unknown\n", dev_id);
 
-	chip->chip_info = device_get_match_data(&client->dev);
+	chip->chip_info = i2c_get_match_data(client);
 
 	indio_dev->channels = opt4001_channels;
 	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
-- 
2.25.1


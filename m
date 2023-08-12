Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034377A0A2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjHLPIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLPIl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 11:08:41 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 844F3171B;
        Sat, 12 Aug 2023 08:08:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176450786"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Aug 2023 00:08:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D7414003EB6;
        Sun, 13 Aug 2023 00:08:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: potentiometer: ad5110: Use i2c_get_match_data()
Date:   Sat, 12 Aug 2023 16:08:38 +0100
Message-Id: <20230812150838.185055-1-biju.das.jz@bp.renesas.com>
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

Replace device_get_match_data()->i2c_get_match_data by making similar I2C
and DT-based matching table to extend matching support for ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/potentiometer/ad5110.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
index 991e745c4f93..aaf02cc7aeba 100644
--- a/drivers/iio/potentiometer/ad5110.c
+++ b/drivers/iio/potentiometer/ad5110.c
@@ -278,14 +278,19 @@ static const struct of_device_id ad5110_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad5110_of_match);
 
+#define AD5110_ID_TABLE(_name, cfg) {				\
+	.name = _name,						\
+	.driver_data = (kernel_ulong_t)&ad5110_cfg[cfg],	\
+}
+
 static const struct i2c_device_id ad5110_id[] = {
-	{ "ad5110-10", AD5110_10 },
-	{ "ad5110-80", AD5110_80 },
-	{ "ad5112-05", AD5112_05 },
-	{ "ad5112-10", AD5112_10 },
-	{ "ad5112-80", AD5112_80 },
-	{ "ad5114-10", AD5114_10 },
-	{ "ad5114-80", AD5114_80 },
+	AD5110_ID_TABLE("ad5110-10", AD5110_10),
+	AD5110_ID_TABLE("ad5110-80", AD5110_80),
+	AD5110_ID_TABLE("ad5112-05", AD5112_05),
+	AD5110_ID_TABLE("ad5112-10", AD5112_10),
+	AD5110_ID_TABLE("ad5112-80", AD5112_80),
+	AD5110_ID_TABLE("ad5114-10", AD5114_10),
+	AD5110_ID_TABLE("ad5114-80", AD5114_80),
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5110_id);
@@ -305,7 +310,7 @@ static int ad5110_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 	data->enable = 1;
-	data->cfg = device_get_match_data(dev);
+	data->cfg = i2c_get_match_data(client);
 
 	/* refresh RDAC register with EEPROM */
 	ret = ad5110_write(data, AD5110_RESET, 0);
-- 
2.25.1


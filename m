Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A3075BF68
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGUHQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUHQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 03:16:10 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AB1A2715;
        Fri, 21 Jul 2023 00:16:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,220,1684767600"; 
   d="scan'208";a="173993438"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Jul 2023 16:16:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.55])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 16AA04007F54;
        Fri, 21 Jul 2023 16:16:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Date:   Fri, 21 Jul 2023 08:16:03 +0100
Message-Id: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
_data() by making similar I2C and DT-based matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Added similar similar I2C and DT-based matching table.
 * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
 * Dropped error check as all tables have data pointers.

Note:
 This patch is only compile tested.
---
 drivers/iio/potentiometer/mcp4018.c | 34 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 89daecc90305..b064e86ecce8 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info = {
 	.write_raw = mcp4018_write_raw,
 };
 
+#define MCP4018_ID_TABLE(name, cfg) {				\
+	name, .driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
+}
+
 static const struct i2c_device_id mcp4018_id[] = {
-	{ "mcp4017-502", MCP4018_502 },
-	{ "mcp4017-103", MCP4018_103 },
-	{ "mcp4017-503", MCP4018_503 },
-	{ "mcp4017-104", MCP4018_104 },
-	{ "mcp4018-502", MCP4018_502 },
-	{ "mcp4018-103", MCP4018_103 },
-	{ "mcp4018-503", MCP4018_503 },
-	{ "mcp4018-104", MCP4018_104 },
-	{ "mcp4019-502", MCP4018_502 },
-	{ "mcp4019-103", MCP4018_103 },
-	{ "mcp4019-503", MCP4018_503 },
-	{ "mcp4019-104", MCP4018_104 },
-	{}
+	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
+	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
+	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
+	MCP4018_ID_TABLE("mcp4017-104", MCP4018_104),
+	MCP4018_ID_TABLE("mcp4018-502", MCP4018_502),
+	MCP4018_ID_TABLE("mcp4018-103", MCP4018_103),
+	MCP4018_ID_TABLE("mcp4018-503", MCP4018_503),
+	MCP4018_ID_TABLE("mcp4018-104", MCP4018_104),
+	MCP4018_ID_TABLE("mcp4019-502", MCP4018_502),
+	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
+	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
+	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4018_id);
 
@@ -157,9 +161,7 @@ static int mcp4018_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->cfg = device_get_match_data(dev);
-	if (!data->cfg)
-		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
+	data->cfg = i2c_get_match_data(client);
 
 	indio_dev->info = &mcp4018_info;
 	indio_dev->channels = &mcp4018_channel;
-- 
2.25.1


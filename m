Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9D75E165
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGWK2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGWK2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 06:28:01 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227A1185;
        Sun, 23 Jul 2023 03:27:48 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,226,1684767600"; 
   d="scan'208";a="170498440"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2023 19:27:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.13])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 16B054000937;
        Sun, 23 Jul 2023 19:27:45 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 RESEND] iio: potentiometer: mcp4531: Use i2c_get_match_data()
Date:   Sun, 23 Jul 2023 11:27:43 +0100
Message-Id: <20230723102743.102284-1-biju.das.jz@bp.renesas.com>
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

Replace device_get_match_data() and i2c_match_id() by i2c_get_match
_data() by making similar I2C and DT-based matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added .name field to MCP4531_ID_TABLE macro
 * Replaced MCP4531_ID_TABLE(name, cfg)->MCP4531_ID_TABLE(_name, cfg)
v1->v2:
 * Added similar similar I2C and DT-based matching table.
 * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
 * Dropped error check as all tables have data pointers.

Note:
 This patch is only compile tested.
---
 drivers/iio/potentiometer/mcp4531.c | 139 ++++++++++++++--------------
 1 file changed, 71 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index c513c00c8243..f28880ebd758 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -206,72 +206,77 @@ static const struct iio_info mcp4531_info = {
 	.write_raw = mcp4531_write_raw,
 };
 
+#define MCP4531_ID_TABLE(_name, cfg) {				\
+	.name = _name,						\
+	.driver_data = (kernel_ulong_t)&mcp4531_cfg[cfg],	\
+}
+
 static const struct i2c_device_id mcp4531_id[] = {
-	{ "mcp4531-502", MCP453x_502 },
-	{ "mcp4531-103", MCP453x_103 },
-	{ "mcp4531-503", MCP453x_503 },
-	{ "mcp4531-104", MCP453x_104 },
-	{ "mcp4532-502", MCP453x_502 },
-	{ "mcp4532-103", MCP453x_103 },
-	{ "mcp4532-503", MCP453x_503 },
-	{ "mcp4532-104", MCP453x_104 },
-	{ "mcp4541-502", MCP454x_502 },
-	{ "mcp4541-103", MCP454x_103 },
-	{ "mcp4541-503", MCP454x_503 },
-	{ "mcp4541-104", MCP454x_104 },
-	{ "mcp4542-502", MCP454x_502 },
-	{ "mcp4542-103", MCP454x_103 },
-	{ "mcp4542-503", MCP454x_503 },
-	{ "mcp4542-104", MCP454x_104 },
-	{ "mcp4551-502", MCP455x_502 },
-	{ "mcp4551-103", MCP455x_103 },
-	{ "mcp4551-503", MCP455x_503 },
-	{ "mcp4551-104", MCP455x_104 },
-	{ "mcp4552-502", MCP455x_502 },
-	{ "mcp4552-103", MCP455x_103 },
-	{ "mcp4552-503", MCP455x_503 },
-	{ "mcp4552-104", MCP455x_104 },
-	{ "mcp4561-502", MCP456x_502 },
-	{ "mcp4561-103", MCP456x_103 },
-	{ "mcp4561-503", MCP456x_503 },
-	{ "mcp4561-104", MCP456x_104 },
-	{ "mcp4562-502", MCP456x_502 },
-	{ "mcp4562-103", MCP456x_103 },
-	{ "mcp4562-503", MCP456x_503 },
-	{ "mcp4562-104", MCP456x_104 },
-	{ "mcp4631-502", MCP463x_502 },
-	{ "mcp4631-103", MCP463x_103 },
-	{ "mcp4631-503", MCP463x_503 },
-	{ "mcp4631-104", MCP463x_104 },
-	{ "mcp4632-502", MCP463x_502 },
-	{ "mcp4632-103", MCP463x_103 },
-	{ "mcp4632-503", MCP463x_503 },
-	{ "mcp4632-104", MCP463x_104 },
-	{ "mcp4641-502", MCP464x_502 },
-	{ "mcp4641-103", MCP464x_103 },
-	{ "mcp4641-503", MCP464x_503 },
-	{ "mcp4641-104", MCP464x_104 },
-	{ "mcp4642-502", MCP464x_502 },
-	{ "mcp4642-103", MCP464x_103 },
-	{ "mcp4642-503", MCP464x_503 },
-	{ "mcp4642-104", MCP464x_104 },
-	{ "mcp4651-502", MCP465x_502 },
-	{ "mcp4651-103", MCP465x_103 },
-	{ "mcp4651-503", MCP465x_503 },
-	{ "mcp4651-104", MCP465x_104 },
-	{ "mcp4652-502", MCP465x_502 },
-	{ "mcp4652-103", MCP465x_103 },
-	{ "mcp4652-503", MCP465x_503 },
-	{ "mcp4652-104", MCP465x_104 },
-	{ "mcp4661-502", MCP466x_502 },
-	{ "mcp4661-103", MCP466x_103 },
-	{ "mcp4661-503", MCP466x_503 },
-	{ "mcp4661-104", MCP466x_104 },
-	{ "mcp4662-502", MCP466x_502 },
-	{ "mcp4662-103", MCP466x_103 },
-	{ "mcp4662-503", MCP466x_503 },
-	{ "mcp4662-104", MCP466x_104 },
-	{}
+	MCP4531_ID_TABLE("mcp4531-502", MCP453x_502),
+	MCP4531_ID_TABLE("mcp4531-103", MCP453x_103),
+	MCP4531_ID_TABLE("mcp4531-503", MCP453x_503),
+	MCP4531_ID_TABLE("mcp4531-104", MCP453x_104),
+	MCP4531_ID_TABLE("mcp4532-502", MCP453x_502),
+	MCP4531_ID_TABLE("mcp4532-103", MCP453x_103),
+	MCP4531_ID_TABLE("mcp4532-503", MCP453x_503),
+	MCP4531_ID_TABLE("mcp4532-104", MCP453x_104),
+	MCP4531_ID_TABLE("mcp4541-502", MCP454x_502),
+	MCP4531_ID_TABLE("mcp4541-103", MCP454x_103),
+	MCP4531_ID_TABLE("mcp4541-503", MCP454x_503),
+	MCP4531_ID_TABLE("mcp4541-104", MCP454x_104),
+	MCP4531_ID_TABLE("mcp4542-502", MCP454x_502),
+	MCP4531_ID_TABLE("mcp4542-103", MCP454x_103),
+	MCP4531_ID_TABLE("mcp4542-503", MCP454x_503),
+	MCP4531_ID_TABLE("mcp4542-104", MCP454x_104),
+	MCP4531_ID_TABLE("mcp4551-502", MCP455x_502),
+	MCP4531_ID_TABLE("mcp4551-103", MCP455x_103),
+	MCP4531_ID_TABLE("mcp4551-503", MCP455x_503),
+	MCP4531_ID_TABLE("mcp4551-104", MCP455x_104),
+	MCP4531_ID_TABLE("mcp4552-502", MCP455x_502),
+	MCP4531_ID_TABLE("mcp4552-103", MCP455x_103),
+	MCP4531_ID_TABLE("mcp4552-503", MCP455x_503),
+	MCP4531_ID_TABLE("mcp4552-104", MCP455x_104),
+	MCP4531_ID_TABLE("mcp4561-502", MCP456x_502),
+	MCP4531_ID_TABLE("mcp4561-103", MCP456x_103),
+	MCP4531_ID_TABLE("mcp4561-503", MCP456x_503),
+	MCP4531_ID_TABLE("mcp4561-104", MCP456x_104),
+	MCP4531_ID_TABLE("mcp4562-502", MCP456x_502),
+	MCP4531_ID_TABLE("mcp4562-103", MCP456x_103),
+	MCP4531_ID_TABLE("mcp4562-503", MCP456x_503),
+	MCP4531_ID_TABLE("mcp4562-104", MCP456x_104),
+	MCP4531_ID_TABLE("mcp4631-502", MCP463x_502),
+	MCP4531_ID_TABLE("mcp4631-103", MCP463x_103),
+	MCP4531_ID_TABLE("mcp4631-503", MCP463x_503),
+	MCP4531_ID_TABLE("mcp4631-104", MCP463x_104),
+	MCP4531_ID_TABLE("mcp4632-502", MCP463x_502),
+	MCP4531_ID_TABLE("mcp4632-103", MCP463x_103),
+	MCP4531_ID_TABLE("mcp4632-503", MCP463x_503),
+	MCP4531_ID_TABLE("mcp4632-104", MCP463x_104),
+	MCP4531_ID_TABLE("mcp4641-502", MCP464x_502),
+	MCP4531_ID_TABLE("mcp4641-103", MCP464x_103),
+	MCP4531_ID_TABLE("mcp4641-503", MCP464x_503),
+	MCP4531_ID_TABLE("mcp4641-104", MCP464x_104),
+	MCP4531_ID_TABLE("mcp4642-502", MCP464x_502),
+	MCP4531_ID_TABLE("mcp4642-103", MCP464x_103),
+	MCP4531_ID_TABLE("mcp4642-503", MCP464x_503),
+	MCP4531_ID_TABLE("mcp4642-104", MCP464x_104),
+	MCP4531_ID_TABLE("mcp4651-502", MCP465x_502),
+	MCP4531_ID_TABLE("mcp4651-103", MCP465x_103),
+	MCP4531_ID_TABLE("mcp4651-503", MCP465x_503),
+	MCP4531_ID_TABLE("mcp4651-104", MCP465x_104),
+	MCP4531_ID_TABLE("mcp4652-502", MCP465x_502),
+	MCP4531_ID_TABLE("mcp4652-103", MCP465x_103),
+	MCP4531_ID_TABLE("mcp4652-503", MCP465x_503),
+	MCP4531_ID_TABLE("mcp4652-104", MCP465x_104),
+	MCP4531_ID_TABLE("mcp4661-502", MCP466x_502),
+	MCP4531_ID_TABLE("mcp4661-103", MCP466x_103),
+	MCP4531_ID_TABLE("mcp4661-503", MCP466x_503),
+	MCP4531_ID_TABLE("mcp4661-104", MCP466x_104),
+	MCP4531_ID_TABLE("mcp4662-502", MCP466x_502),
+	MCP4531_ID_TABLE("mcp4662-103", MCP466x_103),
+	MCP4531_ID_TABLE("mcp4662-503", MCP466x_503),
+	MCP4531_ID_TABLE("mcp4662-104", MCP466x_104),
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4531_id);
 
@@ -368,9 +373,7 @@ static int mcp4531_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->cfg = device_get_match_data(dev);
-	if (!data->cfg)
-		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
+	data->cfg = i2c_get_match_data(client);
 
 	indio_dev->info = &mcp4531_info;
 	indio_dev->channels = mcp4531_channels;
-- 
2.25.1


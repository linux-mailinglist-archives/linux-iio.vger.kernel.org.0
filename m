Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547D57812D3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379425AbjHRSYJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379435AbjHRSYD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 14:24:03 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D28452D72;
        Fri, 18 Aug 2023 11:24:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="173296407"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2023 03:24:01 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EE0E54063CA5;
        Sat, 19 Aug 2023 03:23:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] iio: accel: mma8452: Sort match tables
Date:   Fri, 18 Aug 2023 19:23:47 +0100
Message-Id: <20230818182347.332507-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818182347.332507-1-biju.das.jz@bp.renesas.com>
References: <20230818182347.332507-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sort ID table alphabetically by name and OF table by compatible.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/iio/accel/mma8452.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5864ad726e97..d3fd0318e47b 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1535,12 +1535,12 @@ static int mma8452_reset(struct i2c_client *client)
 }
 
 static const struct of_device_id mma8452_dt_ids[] = {
+	{ .compatible = "fsl,fxls8471", .data = &mma_chip_info_table[fxls8471] },
 	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
 	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
 	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
 	{ .compatible = "fsl,mma8652", .data = &mma_chip_info_table[mma8652] },
 	{ .compatible = "fsl,mma8653", .data = &mma_chip_info_table[mma8653] },
-	{ .compatible = "fsl,fxls8471", .data = &mma_chip_info_table[fxls8471] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
@@ -1824,12 +1824,12 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 };
 
 static const struct i2c_device_id mma8452_id[] = {
+	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
 	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
 	{ "mma8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
 	{ "mma8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
 	{ "mma8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
 	{ "mma8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
-	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma8452_id);
-- 
2.25.1


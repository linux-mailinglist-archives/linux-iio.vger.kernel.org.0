Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76527806C1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358403AbjHRH4x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358484AbjHRH4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 03:56:46 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAC8F420F;
        Fri, 18 Aug 2023 00:56:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="176955338"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Aug 2023 16:56:21 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 649C941BBD56;
        Fri, 18 Aug 2023 16:56:18 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums from OF table
Date:   Fri, 18 Aug 2023 08:55:59 +0100
Message-Id: <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop deprecated enums from OF table as corresponding entries
are removed from bindings and it also saves memory.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/iio/magnetometer/ak8975.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8cfceb007936..295b7be5e36d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1074,15 +1074,10 @@ MODULE_DEVICE_TABLE(i2c, ak8975_id);
 
 static const struct of_device_id ak8975_of_match[] = {
 	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
-	{ .compatible = "ak8975", .data = &ak_def_array[AK8975] },
 	{ .compatible = "asahi-kasei,ak8963", .data = &ak_def_array[AK8963] },
-	{ .compatible = "ak8963", .data = &ak_def_array[AK8963] },
 	{ .compatible = "asahi-kasei,ak09911", .data = &ak_def_array[AK09911] },
-	{ .compatible = "ak09911", .data = &ak_def_array[AK09911] },
 	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
-	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
 	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
-	{ .compatible = "ak09916", .data = &ak_def_array[AK09916] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);
-- 
2.25.1


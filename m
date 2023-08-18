Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DC78122A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379147AbjHRRju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379149AbjHRRjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:39:22 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BB223A99;
        Fri, 18 Aug 2023 10:39:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="176988072"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Aug 2023 02:39:20 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D54D940029B7;
        Sat, 19 Aug 2023 02:39:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] iio: dac: ti-dac5571: Sort match tables
Date:   Fri, 18 Aug 2023 18:39:07 +0100
Message-Id: <20230818173907.323640-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
References: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
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

Sort ID table alphabetically by name and OF table by compatible
for single_*bit enums.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/iio/dac/ti-dac5571.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 2bb3f76569ee..efb1269a77c1 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -386,6 +386,7 @@ static void dac5571_remove(struct i2c_client *i2c)
 }
 
 static const struct of_device_id dac5571_of_id[] = {
+	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
 	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
 	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
 	{.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
@@ -395,12 +396,12 @@ static const struct of_device_id dac5571_of_id[] = {
 	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
 	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
 	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
-	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
 
 static const struct i2c_device_id dac5571_id[] = {
+	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
 	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
 	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
 	{"dac7571", (kernel_ulong_t)&dac5571_spec[single_12bit] },
@@ -410,7 +411,6 @@ static const struct i2c_device_id dac5571_id[] = {
 	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
 	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
 	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
-	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, dac5571_id);
-- 
2.25.1


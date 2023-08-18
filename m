Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF57806C0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358394AbjHRH4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358477AbjHRH4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 03:56:44 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25FE54209;
        Fri, 18 Aug 2023 00:56:20 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="173263209"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Aug 2023 16:56:13 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B72AB41BBD7D;
        Fri, 18 Aug 2023 16:56:10 +0900 (JST)
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
Subject: [PATCH v2 2/5] iio: magnetometer: ak8975: Sort ID and ACPI tables
Date:   Fri, 18 Aug 2023 08:55:57 +0100
Message-Id: <20230818075600.24277-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sort ID table alphabetically by name and acpi table by HID.

While at it, drop blank line before ID table.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/iio/magnetometer/ak8975.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 104798549de1..8cfceb007936 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -812,18 +812,6 @@ static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,
 };
 
-static const struct acpi_device_id ak_acpi_match[] = {
-	{"AK8975", (kernel_ulong_t)&ak_def_array[AK8975] },
-	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
-	{"INVN6500", (kernel_ulong_t)&ak_def_array[AK8963] },
-	{"AK009911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"AK09911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"AKM9911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"AK09912", (kernel_ulong_t)&ak_def_array[AK09912] },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
-
 static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 {
 	struct ak8975_data *data = iio_priv(indio_dev);
@@ -1061,16 +1049,27 @@ static int ak8975_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(ak8975_dev_pm_ops, ak8975_runtime_suspend,
 				 ak8975_runtime_resume, NULL);
 
+static const struct acpi_device_id ak_acpi_match[] = {
+	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"AK8975", (kernel_ulong_t)&ak_def_array[AK8975] },
+	{"AK009911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"AK09911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"AK09912", (kernel_ulong_t)&ak_def_array[AK09912] },
+	{"AKM9911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"INVN6500", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
+
 static const struct i2c_device_id ak8975_id[] = {
-	{"ak8975", (kernel_ulong_t)&ak_def_array[AK8975] },
-	{"ak8963", (kernel_ulong_t)&ak_def_array[AK8963] },
 	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"ak8963", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"ak8975", (kernel_ulong_t)&ak_def_array[AK8975] },
 	{"ak09911", (kernel_ulong_t)&ak_def_array[AK09911] },
 	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
 	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, ak8975_id);
 
 static const struct of_device_id ak8975_of_match[] = {
-- 
2.25.1


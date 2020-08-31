Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDC257603
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHaJI3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:4952 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHaJIS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:18 -0400
IronPort-SDR: tlwJoegQ4QilfVWsfdxupVjp0agYyLXg9M/9rMJCghBgW0Ile5cWFkP3LPa8zYvhACpJqtqovh
 OgWXt2J53A/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156194074"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="156194074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:17 -0700
IronPort-SDR: yhkEvU2fz4xplUgOenK6O9OBWsUC20D+Wh2HW0BZAOmaGfxq9fY3kv7X4lcJaZAhqXCbrDSl8l
 BJxbv25+YtBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="300978867"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2020 02:08:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 60E4E4F2; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/8] iio: accel: bma220: Drop ACPI_PTR() and accompanying ifdeffery
Date:   Mon, 31 Aug 2020 12:08:10 +0300
Message-Id: <20200831090813.78841-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver is quite likely used only on ACPI based platforms and
rarely build with CONFIG_ACPI=n. Even though, the few dozens of bytes
is better than ugly ifdeffery and inclusion of heavy header.

As a result, replace acpi.h with mod_devicetable.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index e55c5f5dd6b4..105c1dece890 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -5,8 +5,8 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
-#include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -310,20 +310,18 @@ static const struct spi_device_id bma220_spi_id[] = {
 	{}
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id bma220_acpi_id[] = {
 	{"BMA0220", 0},
 	{}
 };
 
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
-#endif
 
 static struct spi_driver bma220_driver = {
 	.driver = {
 		.name = "bma220_spi",
 		.pm = &bma220_pm_ops,
-		.acpi_match_table = ACPI_PTR(bma220_acpi_id),
+		.acpi_match_table = bma220_acpi_id,
 	},
 	.probe =            bma220_probe,
 	.remove =           bma220_remove,
-- 
2.28.0


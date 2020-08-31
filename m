Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F56257608
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHaJIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:4410 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgHaJIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:25 -0400
IronPort-SDR: myodC5bQWo4DHE5Dv4BSlXYK40iboQvhT4pmJtxwvqIxNgMVk5neNGr2W0ACpjIwn15aFc7QCy
 ONHuhLx16foA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="154339307"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="154339307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:19 -0700
IronPort-SDR: 2nOkjHSKgCF3H4DN8PSnePXN+52eGtIy+3seGRr/P7gjMV2piRyWuKujNUFF5nKuDRI2VaRasd
 6u/0+KShK9yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="340588817"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2020 02:08:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7AE0D536; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/8] iio: accel: bma220: Remove unneeded blank lines
Date:   Mon, 31 Aug 2020 12:08:13 +0300
Message-Id: <20200831090813.78841-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are few blank lines that split structure definitions
with their users. Remove them to increase readability.

While here, update copyright year.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index a766a0e13efb..4a8862ba366c 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -2,7 +2,7 @@
 /**
  * BMA220 Digital triaxial acceleration sensor driver
  *
- * Copyright (c) 2016, Intel Corporation.
+ * Copyright (c) 2016,2020 Intel Corporation.
  */
 
 #include <linux/bits.h>
@@ -304,7 +304,6 @@ static __maybe_unused int bma220_resume(struct device *dev)
 
 	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
 }
-
 static SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
 
 static const struct spi_device_id bma220_spi_id[] = {
@@ -316,7 +315,6 @@ static const struct acpi_device_id bma220_acpi_id[] = {
 	{"BMA0220", 0},
 	{}
 };
-
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 
 static struct spi_driver bma220_driver = {
@@ -329,7 +327,6 @@ static struct spi_driver bma220_driver = {
 	.remove =           bma220_remove,
 	.id_table =         bma220_spi_id,
 };
-
 module_spi_driver(bma220_driver);
 
 MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
-- 
2.28.0


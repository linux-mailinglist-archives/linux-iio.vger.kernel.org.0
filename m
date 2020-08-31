Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0878C257602
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgHaJI2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:58431 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgHaJIV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:21 -0400
IronPort-SDR: ZncNHNkswLmCGN2BwvHutI/G5BvPJaQYCOTiceYzA5I7r6re0qMv8yjNRUtwhuUFrNFspVr8PO
 Mn+ahR5NVbIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="174981583"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="174981583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:17 -0700
IronPort-SDR: 4uvwCxdgbpA4q5u+VBFY7Vwmm3fDf9bJi9uWRiqbrWn5VHBb4+HlCmaREaAAauod5w9JAAYZ7Q
 53F8t4Pz044Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="445638054"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2020 02:08:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 52995199; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/8] iio: accel: bma220: Mark PM functions as __maybe_unused
Date:   Mon, 31 Aug 2020 12:08:09 +0300
Message-Id: <20200831090813.78841-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of using ugly ifdeffery, mark PM functions as __maybe_unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 529c88fc2949..e55c5f5dd6b4 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -288,8 +288,7 @@ static int bma220_remove(struct spi_device *spi)
 	return bma220_deinit(spi);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int bma220_suspend(struct device *dev)
+static __maybe_unused int bma220_suspend(struct device *dev)
 {
 	struct bma220_data *data = iio_priv(dev_get_drvdata(dev));
 
@@ -297,7 +296,7 @@ static int bma220_suspend(struct device *dev)
 	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
 }
 
-static int bma220_resume(struct device *dev)
+static __maybe_unused int bma220_resume(struct device *dev)
 {
 	struct bma220_data *data = iio_priv(dev_get_drvdata(dev));
 
@@ -306,11 +305,6 @@ static int bma220_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
 
-#define BMA220_PM_OPS (&bma220_pm_ops)
-#else
-#define BMA220_PM_OPS NULL
-#endif
-
 static const struct spi_device_id bma220_spi_id[] = {
 	{"bma220", 0},
 	{}
@@ -328,7 +322,7 @@ MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 static struct spi_driver bma220_driver = {
 	.driver = {
 		.name = "bma220_spi",
-		.pm = BMA220_PM_OPS,
+		.pm = &bma220_pm_ops,
 		.acpi_match_table = ACPI_PTR(bma220_acpi_id),
 	},
 	.probe =            bma220_probe,
-- 
2.28.0


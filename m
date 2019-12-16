Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B51215C2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 19:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfLPSYY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 13:24:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:56101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbfLPSTa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 13:19:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 10:19:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="389546049"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2019 10:19:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E822445; Mon, 16 Dec 2019 20:19:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] iio: st_lsm6dsx: Drop unneeded OF code
Date:   Mon, 16 Dec 2019 20:19:24 +0200
Message-Id: <20191216181925.927-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
References: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no need to have OF guard against ID table.
Drop it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index cd47ec1fedcb..0fb32131afce 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 
 #include "st_lsm6dsx.h"
@@ -122,7 +121,7 @@ static struct i2c_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_i2c",
 		.pm = &st_lsm6dsx_pm_ops,
-		.of_match_table = of_match_ptr(st_lsm6dsx_i2c_of_match),
+		.of_match_table = st_lsm6dsx_i2c_of_match,
 	},
 	.probe = st_lsm6dsx_i2c_probe,
 	.id_table = st_lsm6dsx_i2c_id_table,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 67ff36eac247..eb1086e4a951 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 
 #include "st_lsm6dsx.h"
@@ -122,7 +121,7 @@ static struct spi_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_spi",
 		.pm = &st_lsm6dsx_pm_ops,
-		.of_match_table = of_match_ptr(st_lsm6dsx_spi_of_match),
+		.of_match_table = st_lsm6dsx_spi_of_match,
 	},
 	.probe = st_lsm6dsx_spi_probe,
 	.id_table = st_lsm6dsx_spi_id_table,
-- 
2.24.0


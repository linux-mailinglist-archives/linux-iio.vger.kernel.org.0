Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88602338F15
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhCLNsB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 08:48:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:40208 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhCLNri (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Mar 2021 08:47:38 -0500
IronPort-SDR: K3tUmyOjWBJxHKrrWSnDWQfAUegyDoCq6fNtJhUyD3VekVzLXZsCTP00koFEFJTev7WlnP+iDb
 uZ8tuimvUThA==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="176423753"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="176423753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 05:47:37 -0800
IronPort-SDR: VEDT18TQNiGcklXJQN61WOhFptxD8evEnNMPtxFsu0/vNIKx6OmFCECJ8ITVB2uSKubRx0wdHe
 +lFGOCgBiHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="448625404"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2021 05:47:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D50D2AF; Fri, 12 Mar 2021 15:47:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v1 1/1] iio: imu: st_lsm6dsx: Drop unneeded explicit castings
Date:   Fri, 12 Mar 2021 15:47:43 +0200
Message-Id: <20210312134743.4055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In a few places the unnecessary explicit castings are being used.
Drop them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index ec8d4351390a..8b4fc2c15622 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -29,8 +29,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 57e633121bdc..8d4201b86e87 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -34,8 +34,7 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
 
 	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&i3cdev->dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 349ec9c1890d..e80110b6b280 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -29,8 +29,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &st_lsm6dsx_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-- 
2.30.1


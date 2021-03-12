Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3E338F11
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 14:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhCLNpu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 08:45:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:13994 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhCLNp2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Mar 2021 08:45:28 -0500
IronPort-SDR: cGQVmiEC65wWGDQmF5+hvx1UJHPJFJBy0tlUHUYu8BRY+WT6D7osQY13b/ceVZXVQUsNI9/T9Y
 o3YWk3qG0Qhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208673583"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="208673583"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 05:45:28 -0800
IronPort-SDR: qvicjCZFuC+TVHHYZ4UJjxkWE+27T7+tBM7cLe1Q/cBlV+N0SPQlFSdUNETaGpHhp1uRFX4W8p
 pbPLITgikNqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="510330665"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2021 05:45:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D1F12AF; Fri, 12 Mar 2021 15:45:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v1 1/1] iio: imu: fxos8700: Drop unneeded explicit castings
Date:   Fri, 12 Mar 2021 15:45:38 +0200
Message-Id: <20210312134538.3759-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/imu/fxos8700_i2c.c | 3 +--
 drivers/iio/imu/fxos8700_spi.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index 3ceb76366313..40a570325b0a 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -26,8 +26,7 @@ static int fxos8700_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &fxos8700_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_spi.c
index 57e7bb6444e7..27e694cce173 100644
--- a/drivers/iio/imu/fxos8700_spi.c
+++ b/drivers/iio/imu/fxos8700_spi.c
@@ -17,8 +17,7 @@ static int fxos8700_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &fxos8700_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-- 
2.30.1


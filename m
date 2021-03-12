Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D4338F0B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCLNoL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 08:44:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:1261 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231473AbhCLNno (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Mar 2021 08:43:44 -0500
IronPort-SDR: MaAL0pdl+F7MksSxv/r3zFN6pYBXlsv8nrKAt3kqC5MTO9vrGZzWcgbl1vlPholnzfcuPTZpY1
 uLF5Tii6OGIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188196053"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="188196053"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 05:43:43 -0800
IronPort-SDR: QbMPPqD0pq8xGs0CiH/bt1XAZSc8+dTyeUCqbGc4pSyGIsGn7n/ON8MhLnxp9IXBBWjgD32cGv
 5MLkla02i8CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="387352398"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2021 05:43:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77E9D2AF; Fri, 12 Mar 2021 15:43:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v1 1/1] iio: chemical: bmp680: Drop unneeded explicit castings
Date:   Fri, 12 Mar 2021 15:43:49 +0200
Message-Id: <20210312134349.3472-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In few places the unnecessary explicit castings are being used.
Drop them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/chemical/bme680_i2c.c | 3 +--
 drivers/iio/chemical/bme680_spi.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index de9c9e3d23ea..29c0dfa4702b 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -26,8 +26,7 @@ static int bme680_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-				(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index 3b838068a7e4..6f56ad48cc40 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -132,8 +132,7 @@ static int bme680_spi_probe(struct spi_device *spi)
 	regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
 				  bus_context, &bme680_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-				(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-- 
2.30.1


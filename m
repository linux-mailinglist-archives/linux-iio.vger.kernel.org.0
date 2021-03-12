Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E6F338F1B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCLNtF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 08:49:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:55009 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhCLNs4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Mar 2021 08:48:56 -0500
IronPort-SDR: rH11lrFQv4WxOr7qNKzqzBGG31f4evJIuhmO3slpcD4EXjfObR+NqcCPo7u5mYQQXxUN3rpop/
 hhXMoVoUUWOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="250197967"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="250197967"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 05:48:56 -0800
IronPort-SDR: dgyXnK8hy0kotiwv4nNM5fp2++5Jj2k26Lp5YVDGg/OT8ZAjjWEhH4PQY9CCwOPK+ORUsuNMWQ
 2TTf/b9zyiFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="431949942"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2021 05:48:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D4582AF; Fri, 12 Mar 2021 15:49:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: light: gp2ap002: Drop unneeded explicit casting
Date:   Fri, 12 Mar 2021 15:49:03 +0200
Message-Id: <20210312134903.4296-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The unnecessary explicit casting is being used. Drop it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap002.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 7ba7aa59437c..d048ae257c51 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -465,8 +465,7 @@ static int gp2ap002_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init(dev, &gp2ap002_regmap_bus, dev, &config);
 	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 	gp2ap002->map = regmap;
-- 
2.30.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7E183014
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLMTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 08:19:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:50284 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgCLMTn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 08:19:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 05:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="389586523"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2020 05:19:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A604211; Thu, 12 Mar 2020 14:19:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] iio: st_sensors: Drop unneeded casting when print error code
Date:   Thu, 12 Mar 2020 14:19:37 +0200
Message-Id: <20200312121938.45608-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312121938.45608-1-andriy.shevchenko@linux.intel.com>
References: <20200312121938.45608-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Explicit casting in printf() usually shows that something is not okay.
Here, we really don't need it by providing correct specifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 286830fb5d35..b400560bac93 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -49,8 +49,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_i2c(client, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap (%ld)\n",
+			PTR_ERR(sdata->regmap));
 		return PTR_ERR(sdata->regmap);
 	}
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index dcbdef4a77f8..ee70515bb89f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -101,8 +101,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_spi(spi, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap (%ld)\n",
+			PTR_ERR(sdata->regmap));
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.25.1


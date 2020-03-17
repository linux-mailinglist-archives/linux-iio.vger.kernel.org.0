Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C43187E0A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgCQKSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 06:18:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:40545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgCQKSS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 06:18:18 -0400
IronPort-SDR: 8ufNkyB3I+P1a82zvodt+lLjcf5hzRxEjQt2RHwHqBOYhpVLMKuB11G6p9NL49YMLyYGhVyIim
 HLMSvd8XmDaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 03:18:17 -0700
IronPort-SDR: sKmt4jPL+7no4K8LH2xGcL9GYsof+nS3oEgt9chHi/ZR8Xr1OwD57ENdJgqOGhluuiqvR77SWW
 xHrwG0dcxKUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="244435168"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 03:18:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C49B22C; Tue, 17 Mar 2020 12:18:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] iio: pressure: bmp280: Drop unneeded explicit castings
Date:   Tue, 17 Mar 2020 12:18:12 +0200
Message-Id: <20200317101813.30829-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In few places the unnecessary explicit castings are being used.
Drop them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6c2e47d92a11..5db41b1df7eb 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -337,8 +337,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	__be32 tmp = 0;
 	s32 adc_temp, comp_temp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       (u8 *) &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -377,8 +376,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       (u8 *) &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -400,8 +398,8 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
+	__be16 tmp;
 	int ret;
-	__be16 tmp = 0;
 	s32 adc_humidity;
 	u32 comp_humidity;
 
@@ -410,8 +408,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
-			       (u8 *) &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
@@ -747,14 +744,14 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 
 static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 {
+	__be16 tmp;
 	int ret;
-	__be16 tmp = 0;
 
 	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 2);
 	if (ret)
 		return ret;
 
@@ -851,7 +848,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 3);
 	if (ret)
 		return ret;
 
-- 
2.25.1


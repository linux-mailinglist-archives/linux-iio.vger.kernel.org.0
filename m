Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D187D19ED42
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgDESFz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 14:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbgDESFz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:05:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC8720678;
        Sun,  5 Apr 2020 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109953;
        bh=SwbF8pzGE0u/7ftL8nNFyTa7xLILgqw7rzr8Hslscog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZfGafHd7qgI3gQ2QlPEe/6aByNkoqu9/DqWHX2P2KMxYrDFTnivWpocP9zdhbcKx
         eoU/PfKXe65yuE0uYsTiTx5t6T3I477Vx4TGdjRo3SeCBLdwQGbabbXOqJdAPy25g5
         UfkxWMwxIkye2y1DlBhtQuMhDOnAfchZ2xrqAKGs=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 3/6] iio:chemical:bme680: Tidy up parameters to regmap_bulk_read
Date:   Sun,  5 Apr 2020 19:03:18 +0100
Message-Id: <20200405180321.1737310-4-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A mixture of:
* Unnecessary casts of val parameter to u8 * which makes little sense as
  the function take a void *.
* Explicit sizes where we can use the destination type to define that.
  Note that's not true in all cases as we do read 3 bytes into 4 byte
  destinations.

Note that noting was broken here, I'm just trying to ensure this doesn't
get cut and paste into more drivers so cleaning these out subsystem wide.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 36 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ccde4c65ff93..13773e01699b 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -114,14 +114,16 @@ static int bme680_read_calib(struct bme680_data *data,
 	__le16 buf;
 
 	/* Temperature related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_T1_LSB_REG\n");
 		return ret;
 	}
 	calib->par_t1 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_T2_LSB_REG\n");
 		return ret;
@@ -136,14 +138,16 @@ static int bme680_read_calib(struct bme680_data *data,
 	calib->par_t3 = tmp;
 
 	/* Pressure related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P1_LSB_REG\n");
 		return ret;
 	}
 	calib->par_p1 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P2_LSB_REG\n");
 		return ret;
@@ -157,14 +161,16 @@ static int bme680_read_calib(struct bme680_data *data,
 	}
 	calib->par_p3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P4_LSB_REG\n");
 		return ret;
 	}
 	calib->par_p4 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P5_LSB_REG\n");
 		return ret;
@@ -185,14 +191,16 @@ static int bme680_read_calib(struct bme680_data *data,
 	}
 	calib->par_p7 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P8_LSB_REG\n");
 		return ret;
 	}
 	calib->par_p8 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG, (u8 *) &buf, 2);
+	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_P9_LSB_REG\n");
 		return ret;
@@ -276,8 +284,8 @@ static int bme680_read_calib(struct bme680_data *data,
 	}
 	calib->par_gh1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG, (u8 *) &buf,
-			       2);
+	ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG,
+			       &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(dev, "failed to read BME680_GH2_LSB_REG\n");
 		return ret;
@@ -615,7 +623,7 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
-			       (u8 *) &tmp, 3);
+			       &tmp, 3);
 	if (ret < 0) {
 		dev_err(dev, "failed to read temperature\n");
 		return ret;
@@ -656,7 +664,7 @@ static int bme680_read_press(struct bme680_data *data,
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
-			       (u8 *) &tmp, 3);
+			       &tmp, 3);
 	if (ret < 0) {
 		dev_err(dev, "failed to read pressure\n");
 		return ret;
@@ -689,7 +697,7 @@ static int bme680_read_humid(struct bme680_data *data,
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
-			       (u8 *) &tmp, 2);
+			       &tmp, sizeof(tmp));
 	if (ret < 0) {
 		dev_err(dev, "failed to read humidity\n");
 		return ret;
@@ -754,7 +762,7 @@ static int bme680_read_gas(struct bme680_data *data,
 	}
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
-			       (u8 *) &tmp, 2);
+			       &tmp, sizeof(tmp));
 	if (ret < 0) {
 		dev_err(dev, "failed to read gas resistance\n");
 		return ret;
-- 
2.26.0


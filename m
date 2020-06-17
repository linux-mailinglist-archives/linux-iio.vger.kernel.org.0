Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053EF1FCE79
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFQNdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 09:33:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22912 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgFQNdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 09:33:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HDUKZU019771;
        Wed, 17 Jun 2020 09:33:01 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31q670aj5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 09:32:59 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05HDWwgE028848
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Jun 2020 09:32:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 17 Jun
 2020 09:32:57 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Jun 2020 09:32:57 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05HDWtWO018768;
        Wed, 17 Jun 2020 09:32:56 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v1 2/3] iio:adc:ltc2471: add ltc2461/ltc2463 compatible strings
Date:   Wed, 17 Jun 2020 16:35:22 +0300
Message-ID: <20200617133523.58158-2-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617133523.58158-1-darius.berghe@analog.com>
References: <20200617133523.58158-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_03:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 cotscore=-2147483648 spamscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add compatible strings for these devices in the existing ltc2471
driver.

The only difference between 2461/2463 and 2471/2473 is the output
rate of fixed 60sps and selectible 208/833sps respectively.

The driver does not implement changing the sampling rate so the
new devices are fully code comptible with this driver.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 drivers/iio/adc/ltc2471.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 0e5cdb43a943..098765882bba 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
+ * Driver for Linear Technology LTC2471, LTC2473, LTC2461 and LTC2463 voltage
+ * monitors.
  * The LTC2473 is identical to the 2471, but reports a differential signal.
+ * The LTC2463 is identical to the 2461, but reports a differential signal.
  *
  * Copyright (C) 2017 Topic Embedded Products
  * Author: Mike Looijmans <mike.looijmans@topic.nl>
@@ -17,6 +19,8 @@
 enum ltc2471_chips {
 	ltc2471,
 	ltc2473,
+	ltc2461,
+	ltc2463
 };
 
 struct ltc2471_data {
@@ -120,7 +124,7 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->info = &ltc2471_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (id->driver_data == ltc2473)
+	if (id->driver_data == ltc2473 || id->driver_data == ltc2463)
 		indio_dev->channels = ltc2473_channel;
 	else
 		indio_dev->channels = ltc2471_channel;
@@ -139,6 +143,8 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
 static const struct i2c_device_id ltc2471_i2c_id[] = {
 	{ "ltc2471", ltc2471 },
 	{ "ltc2473", ltc2473 },
+	{ "ltc2461", ltc2461 },
+	{ "ltc2463", ltc2463 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
@@ -146,6 +152,8 @@ MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
 static const struct of_device_id ltc2471_of_match[] = {
 	{ .compatible = "adi,ltc2471" },
 	{ .compatible = "adi,ltc2473" },
+	{ .compatible = "adi,ltc2461" },
+	{ .compatible = "adi,ltc2463" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltc2471_of_match);
@@ -161,6 +169,6 @@ static struct i2c_driver ltc2471_i2c_driver = {
 
 module_i2c_driver(ltc2471_i2c_driver);
 
-MODULE_DESCRIPTION("LTC2471/LTC2473 ADC driver");
+MODULE_DESCRIPTION("LTC2471/LTC2473/LTC2461/LTC2463 ADC driver");
 MODULE_AUTHOR("Topic Embedded Products");
 MODULE_LICENSE("GPL v2");
-- 
2.26.2


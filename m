Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A17221FEF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGPJoK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 05:44:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62048 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgGPJoK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 05:44:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G9e8bI031070;
        Thu, 16 Jul 2020 05:44:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3279gmq8hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 05:44:09 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06G9i85N064080
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Jul 2020 05:44:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 05:44:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 05:44:07 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jul 2020 05:44:07 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06G9i21o001073;
        Thu, 16 Jul 2020 05:44:06 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 2/3] ltc2471: ltc2461/ltc2463 compatible strings
Date:   Thu, 16 Jul 2020 12:46:10 +0300
Message-ID: <20200716094611.81746-3-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716094611.81746-1-darius.berghe@analog.com>
References: <20200716094611.81746-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_05:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160075
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add compatible strings for these devices in the existing ltc2471
driver.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 drivers/iio/adc/ltc2471.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index e1c4e966524d..8c57203b1fe4 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -1,5 +1,7 @@
 /*
- * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
+ * Driver for Linear Technology LTC2461, LTC2463, LTC2471 and LTC2473 voltage
+ * monitors.
+ * The LTC2463 is identical to the 2461, but reports a differential signal.
  * The LTC2473 is identical to the 2471, but reports a differential signal.
  *
  * Copyright (C) 2017 Topic Embedded Products
@@ -17,8 +19,10 @@
 #include <linux/mod_devicetable.h>
 
 enum ltc2471_chips {
+	ltc2461,
+	ltc2463,
 	ltc2471,
-	ltc2473,
+	ltc2473
 };
 
 struct ltc2471_data {
@@ -122,7 +126,7 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->info = &ltc2471_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (id->driver_data == ltc2473)
+	if (id->driver_data == ltc2473 || id->driver_data == ltc2463)
 		indio_dev->channels = ltc2473_channel;
 	else
 		indio_dev->channels = ltc2471_channel;
@@ -139,6 +143,8 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ltc2471_i2c_id[] = {
+	{ "ltc2461", ltc2461 },
+	{ "ltc2463", ltc2463 },
 	{ "ltc2471", ltc2471 },
 	{ "ltc2473", ltc2473 },
 	{}
@@ -146,6 +152,8 @@ static const struct i2c_device_id ltc2471_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
 
 static const struct of_device_id ltc2471_of_match[] = {
+	{ .compatible = "adi,ltc2461" },
+	{ .compatible = "adi,ltc2463" },
 	{ .compatible = "adi,ltc2471" },
 	{ .compatible = "adi,ltc2473" },
 	{}
@@ -163,6 +171,6 @@ static struct i2c_driver ltc2471_i2c_driver = {
 
 module_i2c_driver(ltc2471_i2c_driver);
 
-MODULE_DESCRIPTION("LTC2471/LTC2473 ADC driver");
+MODULE_DESCRIPTION("LTC2461/LTC2463/LTC2471/LTC2473 ADC driver");
 MODULE_AUTHOR("Topic Embedded Products");
 MODULE_LICENSE("GPL v2");
-- 
2.27.0


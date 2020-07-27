Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8E22EE13
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgG0N47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 09:56:59 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32350 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgG0N47 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 09:56:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RDo1Cs022833;
        Mon, 27 Jul 2020 09:56:58 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32gek66tyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 09:56:58 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06RDuu7g008191
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 09:56:56 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jul 2020 06:56:55 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 06:56:55 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RDunPJ001316;
        Mon, 27 Jul 2020 09:56:53 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh@kernel.org>
Subject: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
Date:   Mon, 27 Jul 2020 16:58:33 +0300
Message-ID: <20200727135834.84093-3-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727135834.84093-1-darius.berghe@analog.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270102
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


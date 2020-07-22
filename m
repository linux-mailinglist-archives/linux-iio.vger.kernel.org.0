Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C8229219
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgGVH2Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 03:28:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14888 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgGVH2Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 03:28:25 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M7Oxi8025051;
        Wed, 22 Jul 2020 03:28:24 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32cv1457nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 03:28:24 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06M7SNCp022426
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jul 2020 03:28:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jul 2020 03:28:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jul 2020 03:28:21 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jul 2020 03:28:21 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06M7SF2r018214;
        Wed, 22 Jul 2020 03:28:16 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: adxl372_i2c: Add OF device ID table
Date:   Wed, 22 Jul 2020 10:30:03 +0300
Message-ID: <20200722073003.67373-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720134931.71537-1-alexandru.ardelean@analog.com>
References: <20200720134931.71537-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_03:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The driver does not have a struct of_device_id table, but supported
devices are registered via Device Trees. This patch adds OF device ID
table.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* use linux/mod_devicetable.h include instead for the OF table
* remove comma from null terminator

 drivers/iio/accel/adxl372_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index e1affe480c77..9a07ab3d151a 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -46,9 +47,16 @@ static const struct i2c_device_id adxl372_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
 
+static const struct of_device_id adxl372_of_match[] = {
+	{ .compatible = "adi,adxl372" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adxl372_of_match);
+
 static struct i2c_driver adxl372_i2c_driver = {
 	.driver = {
 		.name = "adxl372_i2c",
+		.of_match_table = adxl372_of_match,
 	},
 	.probe = adxl372_i2c_probe,
 	.id_table = adxl372_i2c_id,
-- 
2.17.1


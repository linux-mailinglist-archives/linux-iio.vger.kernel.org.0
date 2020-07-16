Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F94221FF2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGPJoK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 05:44:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61250 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgGPJoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 05:44:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G9fcVK032549;
        Thu, 16 Jul 2020 05:44:08 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3279gmq8hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 05:44:08 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06G9i7Et064075
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Jul 2020 05:44:07 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 05:44:06 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 05:44:06 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jul 2020 05:44:06 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06G9i21n001073;
        Thu, 16 Jul 2020 05:44:05 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 1/3] ltc2471: add of_match_table for existing devices
Date:   Thu, 16 Jul 2020 12:46:09 +0300
Message-ID: <20200716094611.81746-2-darius.berghe@analog.com>
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

OF style match table was missing, this commit adds it.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 drivers/iio/adc/ltc2471.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index b88102b751cf..e1c4e966524d 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/mod_devicetable.h>
 
 enum ltc2471_chips {
 	ltc2471,
@@ -144,9 +145,17 @@ static const struct i2c_device_id ltc2471_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
 
+static const struct of_device_id ltc2471_of_match[] = {
+	{ .compatible = "adi,ltc2471" },
+	{ .compatible = "adi,ltc2473" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltc2471_of_match);
+
 static struct i2c_driver ltc2471_i2c_driver = {
 	.driver = {
 		.name = "ltc2471",
+		.of_match_table = ltc2471_of_match
 	},
 	.probe    = ltc2471_i2c_probe,
 	.id_table = ltc2471_i2c_id,
-- 
2.27.0


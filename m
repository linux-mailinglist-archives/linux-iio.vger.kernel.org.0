Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9164522EE16
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgG0N47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 09:56:59 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29794 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727938AbgG0N44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 09:56:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RDppWM009687;
        Mon, 27 Jul 2020 09:56:55 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5ej4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 09:56:55 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06RDusSA005682
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 09:56:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Jul
 2020 09:56:53 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 09:56:53 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RDunPI001316;
        Mon, 27 Jul 2020 09:56:52 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh@kernel.org>
Subject: [PATCH v3 1/3] ltc2471: add of_match_table for existing devices
Date:   Mon, 27 Jul 2020 16:58:32 +0300
Message-ID: <20200727135834.84093-2-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727135834.84093-1-darius.berghe@analog.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=983
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270102
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


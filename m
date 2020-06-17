Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4291FCE76
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFQNdC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 09:33:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgFQNdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 09:33:02 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HDSVMJ029699;
        Wed, 17 Jun 2020 09:33:00 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31q66c2jnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 09:32:59 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05HDWwtg028844
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Jun 2020 09:32:58 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 17 Jun
 2020 06:32:56 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Jun 2020 06:32:56 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05HDWtWN018768;
        Wed, 17 Jun 2020 09:32:55 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v1 1/3] iio:adc:ltc2471: add match table for existing devices
Date:   Wed, 17 Jun 2020 16:35:21 +0300
Message-ID: <20200617133523.58158-1-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_03:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=991 clxscore=1015
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 cotscore=-2147483648 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

OF style match table is the proper way of matching device tree nodes
with drivers and such table was missing, this commit adds it.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 drivers/iio/adc/ltc2471.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 55fab612843a..0e5cdb43a943 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -143,9 +143,17 @@ static const struct i2c_device_id ltc2471_i2c_id[] = {
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
+		.of_match_table = of_match_ptr(ltc2471_of_match)
 	},
 	.probe    = ltc2471_i2c_probe,
 	.id_table = ltc2471_i2c_id,
-- 
2.26.2


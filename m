Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC81A92C3
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393463AbgDOF5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 01:57:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52438 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389657AbgDOF5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 01:57:31 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03F5tBwk022530;
        Wed, 15 Apr 2020 01:57:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn7uh1tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 01:57:30 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03F5vS7N063676
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 15 Apr 2020 01:57:29 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Apr 2020 22:57:27 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Apr 2020 22:57:27 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Apr 2020 22:57:27 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03F5vNqd029221;
        Wed, 15 Apr 2020 01:57:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandru.tachici@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 2/2] iio: adc: ad7192: move ad7192_of_match table closer to the end of the file
Date:   Wed, 15 Apr 2020 08:58:04 +0300
Message-ID: <20200415055804.17971-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415055804.17971-1-alexandru.ardelean@analog.com>
References: <20200415055804.17971-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_01:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150045
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The change is more cosmetic. There is no need to reference this table in
the probe function since 'of_device_get_match_data' is used, which obtains
this information from the driver object.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7192.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1431f555daa6..fd89a5115c55 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -908,15 +908,6 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static const struct of_device_id ad7192_of_match[] = {
-	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
-	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
-	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
-	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
-	{}
-};
-MODULE_DEVICE_TABLE(of, ad7192_of_match);
-
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
@@ -1050,6 +1041,15 @@ static int ad7192_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ad7192_of_match[] = {
+	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
+	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
+	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad7192_of_match);
+
 static struct spi_driver ad7192_driver = {
 	.driver = {
 		.name	= "ad7192",
-- 
2.17.1


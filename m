Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2415AD0F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBLQSE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 11:18:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39038 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgBLQSD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 11:18:03 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CGEZ4F030718;
        Wed, 12 Feb 2020 11:18:02 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1tyqfpjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 11:18:02 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01CGI1xL052882
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Feb 2020 11:18:01 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 12 Feb
 2020 11:18:00 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Feb 2020 11:18:00 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01CGHsf9001230;
        Wed, 12 Feb 2020 11:17:58 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 3/5] staging: iio: adc: ad7192: removed spi_device_id
Date:   Wed, 12 Feb 2020 18:17:19 +0200
Message-ID: <20200212161721.16200-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212161721.16200-1-alexandru.tachici@analog.com>
References: <20200212161721.16200-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-11,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120125
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch removes spi_device_id table and moves the
init data (id of the chip) in the .data field
of of_device_id table.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 33 +++++++++++---------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 8fca8915543d..8ec28aa8fa8a 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -876,6 +877,15 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static const struct of_device_id ad7192_of_match[] = {
+	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190 },
+	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
+	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
+	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad7192_of_match);
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
@@ -928,7 +938,7 @@ static int ad7192_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	st->devid = spi_get_device_id(spi)->driver_data;
+	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1009,26 +1019,6 @@ static int ad7192_remove(struct spi_device *spi)
 	return 0;
 }
 
-static const struct spi_device_id ad7192_id[] = {
-	{"ad7190", ID_AD7190},
-	{"ad7192", ID_AD7192},
-	{"ad7193", ID_AD7193},
-	{"ad7195", ID_AD7195},
-	{}
-};
-
-MODULE_DEVICE_TABLE(spi, ad7192_id);
-
-static const struct of_device_id ad7192_of_match[] = {
-	{ .compatible = "adi,ad7190" },
-	{ .compatible = "adi,ad7192" },
-	{ .compatible = "adi,ad7193" },
-	{ .compatible = "adi,ad7195" },
-	{}
-};
-
-MODULE_DEVICE_TABLE(of, ad7192_of_match);
-
 static struct spi_driver ad7192_driver = {
 	.driver = {
 		.name	= "ad7192",
@@ -1036,7 +1026,6 @@ static struct spi_driver ad7192_driver = {
 	},
 	.probe		= ad7192_probe,
 	.remove		= ad7192_remove,
-	.id_table	= ad7192_id,
 };
 module_spi_driver(ad7192_driver);
 
-- 
2.20.1


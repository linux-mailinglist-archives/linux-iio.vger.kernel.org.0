Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD3153618
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgBERPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 12:15:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12410 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbgBERPe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 12:15:34 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015H7oth002770;
        Wed, 5 Feb 2020 12:15:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhnkj7gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 12:15:32 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 015HFV8Y030474
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Feb 2020 12:15:31 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 5 Feb 2020
 12:15:30 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 5 Feb 2020 09:15:30 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 015HFNak010661;
        Wed, 5 Feb 2020 12:15:27 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 3/5 V2] staging: iio: adc: ad7192: removed spi_device_id
Date:   Wed, 5 Feb 2020 19:15:09 +0200
Message-ID: <20200205171511.25912-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171511.25912-1-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
 <20200205171511.25912-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_05:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002050130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch removes spi_device_id table and moves the
init data (id of the chip) in the .data field
of of_device_id table.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 8f2fa154876a..e75d808a2f41 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -876,8 +877,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static const struct of_device_id ad7192_of_match[];
+
 static int ad7192_probe(struct spi_device *spi)
 {
+	const struct of_device_id *match;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
@@ -927,8 +931,12 @@ static int ad7192_probe(struct spi_device *spi)
 		goto error_disable_avdd;
 	}
 
+	match = of_match_device(ad7192_of_match, &spi->dev);
+	if (!match)
+		return -EINVAL;
+
 	spi_set_drvdata(spi, indio_dev);
-	st->devid = spi_get_device_id(spi)->driver_data;
+	st->devid = (unsigned long)match->data;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1010,21 +1018,11 @@ static int ad7192_remove(struct spi_device *spi)
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
 static const struct of_device_id ad7192_of_match[] = {
-	{ .compatible = "adi,ad7190" },
-	{ .compatible = "adi,ad7192" },
-	{ .compatible = "adi,ad7193" },
-	{ .compatible = "adi,ad7195" },
+	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190},
+	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
+	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
+	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
 	{}
 };
 
@@ -1037,7 +1035,6 @@ static struct spi_driver ad7192_driver = {
 	},
 	.probe		= ad7192_probe,
 	.remove		= ad7192_remove,
-	.id_table	= ad7192_id,
 };
 module_spi_driver(ad7192_driver);
 
-- 
2.20.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAF18137E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 09:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgCKIlC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 04:41:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46458 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgCKIlC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 04:41:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B8dgfP004402;
        Wed, 11 Mar 2020 04:40:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yp9x3bwgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 04:40:53 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02B8eqsI032334
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Mar 2020 04:40:52 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 01:40:51 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 01:39:42 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Mar 2020 01:40:50 -0700
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02B8eSGL028151;
        Wed, 11 Mar 2020 04:40:47 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 4/4] iio: adc: ad7476: implement devm_add_action_or_reset
Date:   Wed, 11 Mar 2020 10:43:28 +0200
Message-ID: <20200311084328.17680-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311084328.17680-1-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_02:2020-03-10,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 adultscore=0 mlxlogscore=796 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_add_action_or_reset to automatically disable the device
when it is removed or an error occurs during probe routine.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7476.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index cd7d42df2033..e9984a38fc4c 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -256,6 +256,13 @@ static const struct iio_info ad7476_info = {
 	.read_raw = &ad7476_read_raw,
 };
 
+static void ad7476_reg_disable(void *data)
+{
+	struct ad7476_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
 static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
@@ -278,6 +285,11 @@ static int ad7476_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
+				       st);
+	if (ret)
+		return ret;
+
 	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
 						  "adi,conversion-start",
 						  GPIOD_OUT_LOW);
@@ -328,18 +340,6 @@ static int ad7476_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int ad7476_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7476_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(st->reg);
-
-	return 0;
-}
-
 static const struct spi_device_id ad7476_id[] = {
 	{"ad7091", ID_AD7091R},
 	{"ad7091r", ID_AD7091R},
@@ -377,7 +377,6 @@ static struct spi_driver ad7476_driver = {
 		.name	= "ad7476",
 	},
 	.probe		= ad7476_probe,
-	.remove		= ad7476_remove,
 	.id_table	= ad7476_id,
 };
 module_spi_driver(ad7476_driver);
-- 
2.17.1


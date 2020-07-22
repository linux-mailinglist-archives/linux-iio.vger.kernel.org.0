Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAF2291FF
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgGVHUR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 03:20:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2644 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgGVHUR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 03:20:17 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M7EqgJ001349;
        Wed, 22 Jul 2020 03:20:16 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32cv1456w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 03:20:16 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06M7KFYo000995
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jul 2020 03:20:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jul 2020 03:20:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jul 2020 03:20:13 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jul 2020 03:20:13 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06M7K8FA017930;
        Wed, 22 Jul 2020 03:20:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: frequency: ad9523: convert rest of driver to device managed functions
Date:   Wed, 22 Jul 2020 10:22:01 +0300
Message-ID: <20200722072201.64127-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721112409.220536-1-alexandru.ardelean@analog.com>
References: <20200721112409.220536-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_03:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver pretty much uses device managed functions. The only left-over is
the iio_device_register() function, which also requires an action-or-reset
hook to disable the regulator on the remove and error path.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* removed 'probed' message at the end of probe; mostly log spam

 drivers/iio/frequency/ad9523.c | 60 ++++++++++++----------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 334e1d779d6d..bdb0bc3b12dd 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -969,6 +969,13 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void ad9523_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad9523_probe(struct spi_device *spi)
 {
 	struct ad9523_platform_data *pdata = spi->dev.platform_data;
@@ -994,21 +1001,22 @@ static int ad9523_probe(struct spi_device *spi)
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad9523_reg_disable,
+					       st->reg);
+		if (ret)
+			return ret;
 	}
 
 	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 		GPIOD_OUT_HIGH);
-	if (IS_ERR(st->pwrdown_gpio)) {
-		ret = PTR_ERR(st->pwrdown_gpio);
-		goto error_disable_reg;
-	}
+	if (IS_ERR(st->pwrdown_gpio))
+		return PTR_ERR(st->pwrdown_gpio);
 
 	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
 		GPIOD_OUT_LOW);
-	if (IS_ERR(st->reset_gpio)) {
-		ret = PTR_ERR(st->reset_gpio);
-		goto error_disable_reg;
-	}
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
 
 	if (st->reset_gpio) {
 		udelay(1);
@@ -1017,10 +1025,8 @@ static int ad9523_probe(struct spi_device *spi)
 
 	st->sync_gpio = devm_gpiod_get_optional(&spi->dev, "sync",
 		GPIOD_OUT_HIGH);
-	if (IS_ERR(st->sync_gpio)) {
-		ret = PTR_ERR(st->sync_gpio);
-		goto error_disable_reg;
-	}
+	if (IS_ERR(st->sync_gpio))
+		return PTR_ERR(st->sync_gpio);
 
 	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
@@ -1035,34 +1041,9 @@ static int ad9523_probe(struct spi_device *spi)
 
 	ret = ad9523_setup(indio_dev);
 	if (ret < 0)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	dev_info(&spi->dev, "probed %s\n", indio_dev->name);
-
-	return 0;
-
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad9523_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad9523_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad9523_id[] = {
@@ -1076,7 +1057,6 @@ static struct spi_driver ad9523_driver = {
 		.name	= "ad9523",
 	},
 	.probe		= ad9523_probe,
-	.remove		= ad9523_remove,
 	.id_table	= ad9523_id,
 };
 module_spi_driver(ad9523_driver);
-- 
2.17.1


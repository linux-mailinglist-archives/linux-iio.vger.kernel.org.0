Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9146B2B1801
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKMJRN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 04:17:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28472 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbgKMJRM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 04:17:12 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD99TvI028705;
        Fri, 13 Nov 2020 04:17:10 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34npab4y9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 04:17:10 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AD9H9vL056536
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 13 Nov 2020 04:17:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 13 Nov
 2020 04:17:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 13 Nov 2020 04:17:08 -0500
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AD9H6sW025285;
        Fri, 13 Nov 2020 04:17:06 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ad7887: convert probe to device-managed functions
Date:   Fri, 13 Nov 2020 11:16:48 +0200
Message-ID: <20201113091648.148589-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_06:2020-11-12,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130056
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is conversion of the driver to use device-managed functions.
The IIO registration and triggered buffer setup both have device-managed
versions.
The regulator disable needs to be handled via an action_or_reset handler.

With these changes, the remove hook is removed, and the error path is
cleaned up in probe.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7887.c | 43 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 99a480ad3985..4f6f0e0e03ee 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -232,6 +232,13 @@ static const struct iio_info ad7887_info = {
 	.read_raw = &ad7887_read_raw,
 };
 
+static void ad7887_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad7887_probe(struct spi_device *spi)
 {
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
@@ -258,6 +265,10 @@ static int ad7887_probe(struct spi_device *spi)
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7887_reg_disable, st->reg);
+		if (ret)
+			return ret;
 	}
 
 	st->chip_info =
@@ -316,36 +327,13 @@ static int ad7887_probe(struct spi_device *spi)
 		indio_dev->num_channels = st->chip_info->num_channels;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+			&iio_pollfunc_store_time,
 			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
 	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unregister_ring;
-
-	return 0;
-error_unregister_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	if (st->reg)
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7887_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7887_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->reg)
-		regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7887_id[] = {
@@ -359,7 +347,6 @@ static struct spi_driver ad7887_driver = {
 		.name	= "ad7887",
 	},
 	.probe		= ad7887_probe,
-	.remove		= ad7887_remove,
 	.id_table	= ad7887_id,
 };
 module_spi_driver(ad7887_driver);
-- 
2.27.0


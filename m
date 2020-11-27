Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5E2C61E7
	for <lists+linux-iio@lfdr.de>; Fri, 27 Nov 2020 10:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgK0Jkz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Nov 2020 04:40:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54724 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728861AbgK0Jky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 04:40:54 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AR9PJZe032699;
        Fri, 27 Nov 2020 04:40:51 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y08varpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 04:40:51 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AR9en62047494
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 27 Nov 2020 04:40:50 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 27 Nov 2020 01:40:48 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 27 Nov 2020 01:40:48 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AR9ej6m019064;
        Fri, 27 Nov 2020 04:40:45 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <colin.king@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: adc: ad7298: convert probe to device-managed functions
Date:   Fri, 27 Nov 2020 11:40:37 +0200
Message-ID: <20201127094038.91714-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_05:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270058
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the probe of this driver to use device-managed
register functions, and a devm_add_action_or_reset() for the regulator
disable.

With this, the exit & error paths can be removed.
Another side-effect is that this should avoid some static-analyzer's check
with respect to a potential null dereference of the regulator. The null
dereference isn't likely to happen (under normal operation), so there isn't
a requirement to have this fixed/backported in other releases.

As a note: this is removing spi_set_drvdata() since there is no other
spi_get_drvdata() (or dev_get_drvdata()) call that need it.

Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7298.c | 46 +++++++++++++---------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index fa1047f74a1f..ecdb01bd5b2f 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -279,6 +279,13 @@ static const struct iio_info ad7298_info = {
 	.update_scan_mode = ad7298_update_scan_mode,
 };
 
+static void ad7298_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad7298_probe(struct spi_device *spi)
 {
 	struct ad7298_state *st;
@@ -306,9 +313,12 @@ static int ad7298_probe(struct spi_device *spi)
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
-	}
 
-	spi_set_drvdata(spi, indio_dev);
+		ret = devm_add_action_or_reset(&spi->dev, ad7298_reg_disable,
+					       st->reg);
+		if (ret)
+			return ret;
+	}
 
 	st->spi = spi;
 
@@ -334,37 +344,12 @@ static int ad7298_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
 	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 			&ad7298_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_ring;
-
-	return 0;
-
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	if (st->ext_ref)
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7298_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7298_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->ext_ref)
-		regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7298_id[] = {
@@ -378,7 +363,6 @@ static struct spi_driver ad7298_driver = {
 		.name	= "ad7298",
 	},
 	.probe		= ad7298_probe,
-	.remove		= ad7298_remove,
 	.id_table	= ad7298_id,
 };
 module_spi_driver(ad7298_driver);
-- 
2.27.0


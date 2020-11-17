Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA252B5A82
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 08:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgKQHrr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 02:47:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42636 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgKQHrq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 02:47:46 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH7e4uU003064;
        Tue, 17 Nov 2020 02:47:45 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybgt15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 02:47:45 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AH7lhhu004565
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 02:47:44 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 16 Nov 2020 23:47:42 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 16 Nov 2020 23:47:41 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AH7lbGK002920;
        Tue, 17 Nov 2020 02:47:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: adc: ad7887: convert driver to full DT probing
Date:   Tue, 17 Nov 2020 09:52:53 +0200
Message-ID: <20201117075254.4861-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117075254.4861-1-alexandru.ardelean@analog.com>
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_02:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=931
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change removes the SPI device table, adds an OF device table instead.
This should also be usable for ACPI via PRP0001.

This device is usually probed via device-tree, so it makes more sense to
use the OF device table.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7887.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 06f684c053a0..4f68a1b17ec8 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -40,6 +40,7 @@ enum ad7887_channels {
 
 /**
  * struct ad7887_chip_info - chip specifc information
+ * @name:		the name of the part
  * @int_vref_mv:	the internal reference voltage
  * @channels:		channels specification
  * @num_channels:	number of channels
@@ -47,6 +48,7 @@ enum ad7887_channels {
  * @num_dual_channels:	number of channels in dual mode
  */
 struct ad7887_chip_info {
+	const char			*name;
 	u16				int_vref_mv;
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
@@ -218,6 +220,7 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 	 * More devices added in future
 	 */
 	[ID_AD7887] = {
+		.name = "ad7887",
 		.channels = ad7887_channels,
 		.num_channels = ARRAY_SIZE(ad7887_channels),
 		.dual_channels = ad7887_dual_channels,
@@ -239,12 +242,17 @@ static void ad7887_reg_disable(void *data)
 
 static int ad7887_probe(struct spi_device *spi)
 {
+	const struct ad7887_chip_info *info;
 	struct ad7887_state *st;
 	struct iio_dev *indio_dev;
 	bool dual_mode;
 	uint8_t mode;
 	int ret;
 
+	info = device_get_match_data(&spi->dev);
+	if (!info)
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -269,13 +277,12 @@ static int ad7887_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	st->chip_info =
-		&ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+	st->chip_info = info;
 
 	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = st->chip_info->name;
 	indio_dev->info = &ad7887_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -336,18 +343,18 @@ static int ad7887_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-static const struct spi_device_id ad7887_id[] = {
-	{"ad7887", ID_AD7887},
-	{}
+static const struct of_device_id ad7887_of_match[] = {
+	{ .compatible = "adi,ad7887", .data = &ad7887_chip_info_tbl[ID_AD7887] },
+	{ }
 };
-MODULE_DEVICE_TABLE(spi, ad7887_id);
+MODULE_DEVICE_TABLE(of, ad7887_of_match);
 
 static struct spi_driver ad7887_driver = {
 	.driver = {
 		.name	= "ad7887",
+		.of_match_table	= ad7887_of_match,
 	},
 	.probe		= ad7887_probe,
-	.id_table	= ad7887_id,
 };
 module_spi_driver(ad7887_driver);
 
-- 
2.17.1


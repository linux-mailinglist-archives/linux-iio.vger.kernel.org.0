Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737A21E752
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jul 2020 07:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgGNFJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jul 2020 01:09:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30656 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgGNFJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2020 01:09:19 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E504GT028763;
        Tue, 14 Jul 2020 01:09:17 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3279gmfcsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 01:09:17 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06E59GZ8044566
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 14 Jul 2020 01:09:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 14 Jul
 2020 01:09:15 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Jul 2020 01:09:14 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06E59AnP023590;
        Tue, 14 Jul 2020 01:09:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ad7124: move chip ID & name on the chip_info table
Date:   Tue, 14 Jul 2020 08:11:11 +0300
Message-ID: <20200714051111.17892-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_01:2020-07-13,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=867 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007140038
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change does the following:
* removes the SPI device table in favor of the OF device table
* adds 'name' && 'chip_id' fields to chip_info
* implements chip ID & silicon revision checking; the device ID for
  AD7124-4 is 0x0, so just checking that value can be useless;
  but at least the silicon revision isn't 0, so a non-zero value can be
  used to check that "a" device is on the SPI bus; it's probably the best
  way to narrow it down to one of the 2 AD7124 chip IDs

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7124.c | 73 ++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index bb53ab265b64..8dce06e9e69c 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -47,6 +48,15 @@
 #define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
 #define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
 
+/* AD7124 ID */
+#define AD7124_DEVICE_ID_MSK		GENMASK(7, 4)
+#define AD7124_DEVICE_ID_GET(x)		FIELD_GET(AD7124_DEVICE_ID_MSK, x)
+#define AD7124_SILICON_REV_MSK		GENMASK(3, 0)
+#define AD7124_SILICON_REV_GET(x)	FIELD_GET(AD7124_SILICON_REV_MSK, x)
+
+#define CHIPID_AD7124_4			0x0
+#define CHIPID_AD7124_8			0x1
+
 /* AD7124_CHANNEL_X */
 #define AD7124_CHANNEL_EN_MSK		BIT(15)
 #define AD7124_CHANNEL_EN(x)		FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
@@ -120,6 +130,8 @@ static const char * const ad7124_ref_names[] = {
 };
 
 struct ad7124_chip_info {
+	const char *name;
+	unsigned int chip_id;
 	unsigned int num_inputs;
 };
 
@@ -165,9 +177,13 @@ static const struct iio_chan_spec ad7124_channel_template = {
 
 static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
 	[ID_AD7124_4] = {
+		.name = "ad7127-4",
+		.chip_id = CHIPID_AD7124_4,
 		.num_inputs = 8,
 	},
 	[ID_AD7124_8] = {
+		.name = "ad7127-8",
+		.chip_id = CHIPID_AD7124_8,
 		.num_inputs = 16,
 	},
 };
@@ -503,6 +519,34 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	return -EIO;
 }
 
+static int ad7124_check_chip_id(struct ad7124_state *st)
+{
+	unsigned int readval, chip_id, silicon_rev;
+	int ret;
+
+	ret = ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
+	if (ret < 0)
+		return ret;
+
+	chip_id = AD7124_DEVICE_ID_GET(readval);
+	silicon_rev = AD7124_SILICON_REV_GET(readval);
+
+	if (chip_id != st->chip_info->chip_id) {
+		dev_err(&st->sd.spi->dev,
+			"Chip ID mismatch: expected %u, got %u\n",
+			st->chip_info->chip_id, chip_id);
+		return -ENODEV;
+	}
+
+	if (silicon_rev == 0) {
+		dev_err(&st->sd.spi->dev,
+			"Silicon revision empty. Chip may not be present\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ad7124_init_channel_vref(struct ad7124_state *st,
 				    unsigned int channel_number)
 {
@@ -665,25 +709,28 @@ static int ad7124_setup(struct ad7124_state *st)
 
 static int ad7124_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id;
+	const struct ad7124_chip_info *info;
 	struct ad7124_state *st;
 	struct iio_dev *indio_dev;
 	int i, ret;
 
+	info = of_device_get_match_data(&spi->dev);
+	if (!info)
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	id = spi_get_device_id(spi);
-	st->chip_info = &ad7124_chip_info_tbl[id->driver_data];
+	st->chip_info = info;
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
 
 	spi_set_drvdata(spi, indio_dev);
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
 
@@ -721,6 +768,10 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto error_clk_disable_unprepare;
 
+	ret = ad7124_check_chip_id(st);
+	if (ret)
+		goto error_clk_disable_unprepare;
+
 	ret = ad7124_setup(st);
 	if (ret < 0)
 		goto error_clk_disable_unprepare;
@@ -768,16 +819,11 @@ static int ad7124_remove(struct spi_device *spi)
 	return 0;
 }
 
-static const struct spi_device_id ad7124_id_table[] = {
-	{ "ad7124-4", ID_AD7124_4 },
-	{ "ad7124-8", ID_AD7124_8 },
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad7124_id_table);
-
 static const struct of_device_id ad7124_of_match[] = {
-	{ .compatible = "adi,ad7124-4" },
-	{ .compatible = "adi,ad7124-8" },
+	{ .compatible = "adi,ad7124-4",
+		.data = &ad7124_chip_info_tbl[ID_AD7124_4], },
+	{ .compatible = "adi,ad7124-8",
+		.data = &ad7124_chip_info_tbl[ID_AD7124_8], },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ad7124_of_match);
@@ -789,7 +835,6 @@ static struct spi_driver ad71124_driver = {
 	},
 	.probe = ad7124_probe,
 	.remove	= ad7124_remove,
-	.id_table = ad7124_id_table,
 };
 module_spi_driver(ad71124_driver);
 
-- 
2.17.1


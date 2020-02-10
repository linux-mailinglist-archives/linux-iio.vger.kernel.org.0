Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA742157B4E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgBJN2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5034 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731198AbgBJN2j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADSA3n029594;
        Mon, 10 Feb 2020 08:28:38 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udmqt60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:38 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSb1d022069
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Feb
 2020 08:28:36 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 08:28:36 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZm017670;
        Mon, 10 Feb 2020 08:28:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/9] iio: gyro: adis16136: initialize adis_data statically
Date:   Mon, 10 Feb 2020 15:26:00 +0200
Message-ID: <20200210132606.9315-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change overrides commit 380b107bbf944 ("iio: adis: Introduce timeouts
structure"). It removes the memory allocation and moves the 'adis_data'
information to be static on the chip_info struct.

This also adds a timeout structure to ADIS16334, since it was initially
omitted. This was omitted (by accident) when the change was done.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16136.c | 61 +++++++++++++-----------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index d5e03a406d4a..1db1131e5c67 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -59,7 +59,7 @@
 struct adis16136_chip_info {
 	unsigned int precision;
 	unsigned int fullscale;
-	const struct adis_timeout *timeouts;
+	const struct adis_data adis_data;
 };
 
 struct adis16136 {
@@ -466,22 +466,21 @@ static const char * const adis16136_status_error_msgs[] = {
 	[ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL] = "Flash checksum error",
 };
 
-static const struct adis_data adis16136_data = {
-	.diag_stat_reg = ADIS16136_REG_DIAG_STAT,
-	.glob_cmd_reg = ADIS16136_REG_GLOB_CMD,
-	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,
-
-	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,
-
-	.read_delay = 10,
-	.write_delay = 10,
-
-	.status_error_msgs = adis16136_status_error_msgs,
-	.status_error_mask = BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |
-		BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
-		BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
-		BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL),
-};
+#define ADIS16136_DATA(_timeouts)					\
+{									\
+	.diag_stat_reg = ADIS16136_REG_DIAG_STAT,			\
+	.glob_cmd_reg = ADIS16136_REG_GLOB_CMD,				\
+	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,				\
+	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,			\
+	.read_delay = 10,						\
+	.write_delay = 10,						\
+	.status_error_msgs = adis16136_status_error_msgs,		\
+	.status_error_mask = BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |	\
+		BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |			\
+		BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |		\
+		BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL),		\
+	.timeouts = (_timeouts),					\
+}
 
 enum adis16136_id {
 	ID_ADIS16133,
@@ -506,41 +505,25 @@ static const struct adis16136_chip_info adis16136_chip_info[] = {
 	[ID_ADIS16133] = {
 		.precision = IIO_DEGREE_TO_RAD(1200),
 		.fullscale = 24000,
-		.timeouts = &adis16133_timeouts,
+		.adis_data = ADIS16136_DATA(&adis16133_timeouts),
 	},
 	[ID_ADIS16135] = {
 		.precision = IIO_DEGREE_TO_RAD(300),
 		.fullscale = 24000,
-		.timeouts = &adis16133_timeouts,
+		.adis_data = ADIS16136_DATA(&adis16133_timeouts),
 	},
 	[ID_ADIS16136] = {
 		.precision = IIO_DEGREE_TO_RAD(450),
 		.fullscale = 24623,
-		.timeouts = &adis16136_timeouts,
+		.adis_data = ADIS16136_DATA(&adis16136_timeouts),
 	},
 	[ID_ADIS16137] = {
 		.precision = IIO_DEGREE_TO_RAD(1000),
 		.fullscale = 24609,
-		.timeouts = &adis16136_timeouts,
+		.adis_data = ADIS16136_DATA(&adis16136_timeouts),
 	},
 };
 
-static struct adis_data *adis16136_adis_data_alloc(struct adis16136 *st,
-						   struct device *dev)
-{
-	struct adis_data *data;
-
-	data = devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(data, &adis16136_data, sizeof(*data));
-
-	data->timeouts = st->chip_info->timeouts;
-
-	return data;
-}
-
 static int adis16136_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -565,9 +548,7 @@ static int adis16136_probe(struct spi_device *spi)
 	indio_dev->info = &adis16136_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	adis16136_data = adis16136_adis_data_alloc(adis16136, &spi->dev);
-	if (IS_ERR(adis16136_data))
-		return PTR_ERR(adis16136_data);
+	adis16136_data = &adis16136->chip_info->adis_data;
 
 	ret = adis_init(&adis16136->adis, indio_dev, spi, adis16136_data);
 	if (ret)
-- 
2.20.1


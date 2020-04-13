Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81C91A642D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgDMIf1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDMIUT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 04:20:19 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A17C00860B;
        Mon, 13 Apr 2020 01:20:19 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D8IJsC003744;
        Mon, 13 Apr 2020 04:20:19 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30bat4p92s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 04:20:19 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03D8KHXT020286
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 13 Apr 2020 04:20:17 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Apr
 2020 01:20:16 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Apr 2020 01:20:15 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03D8KEkZ026212;
        Mon, 13 Apr 2020 04:20:14 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandru.tachici@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 1/2] iio: adc: ad7192: fix null pointer de-reference crash during probe
Date:   Mon, 13 Apr 2020 11:20:43 +0300
Message-ID: <20200413082044.81101-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_02:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the 'spi_device_id' table was removed, it omitted to cleanup/fix the
assignment:
   'indio_dev->name = spi_get_device_id(spi)->name;'

After that patch 'spi_get_device_id(spi)' returns NULL, so this crashes
during probe with null de-ref.

This change fixes this by introducing an ad7192_chip_info struct, and
defines all part-names [that should be assigned to indio_dev->name] in a
'ad7192_chip_info_tbl' table.

With this change, the old 'st->devid' is also moved to be a
'chip_info->chip_id'. And the old 'ID_AD719X' macros have been renamed to
'CHIPID_AD719X'. Tld identifiers have been re-purposed to be enum/index
values in the new 'ad7192_chip_info_tbl'.

This should fix the bug, and maintain the ABI for the 'indio_dev->name'
field.

Fixes: 66614ab2be38 ("staging: iio: adc: ad7192: removed spi_device_id")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v2 -> v3:
* reworked patch to introduce a chip_info struct for the part-name
* added 2nd patch to move of-table closer to the end of the file; this
  patch is more cosmetic; has no fixes tag, but is on top of the previous

Changelog v1 -> v2:
* fix colon for Fixes tag
* updated commit title a bit; to make it longer

 drivers/iio/adc/ad7192.c | 61 ++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8ec28aa8fa8a..7e8662c5cb0e 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -125,10 +125,10 @@
 #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
 
 /* ID Register Bit Designations (AD7192_REG_ID) */
-#define ID_AD7190		0x4
-#define ID_AD7192		0x0
-#define ID_AD7193		0x2
-#define ID_AD7195		0x6
+#define CHIPID_AD7190		0x4
+#define CHIPID_AD7192		0x0
+#define CHIPID_AD7193		0x2
+#define CHIPID_AD7195		0x6
 #define AD7192_ID_MASK		0x0F
 
 /* GPOCON Register Bit Designations (AD7192_REG_GPOCON) */
@@ -161,7 +161,20 @@ enum {
    AD7192_SYSCALIB_FULL_SCALE,
 };
 
+enum {
+	ID_AD7190,
+	ID_AD7192,
+	ID_AD7193,
+	ID_AD7195,
+};
+
+struct ad7192_chip_info {
+	unsigned int			chip_id;
+	const char			*name;
+};
+
 struct ad7192_state {
+	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
 	struct clk			*mclk;
@@ -172,7 +185,6 @@ struct ad7192_state {
 	u32				conf;
 	u32				scale_avail[8][2];
 	u8				gpocon;
-	u8				devid;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
 	u8				syscalib_mode[8];
@@ -348,7 +360,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 
 	id &= AD7192_ID_MASK;
 
-	if (id != st->devid)
+	if (id != st->chip_info->chip_id)
 		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
 			 id);
 
@@ -363,7 +375,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 		st->mode |= AD7192_MODE_REJ60;
 
 	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
-	if (refin2_en && st->devid != ID_AD7195)
+	if (refin2_en && st->chip_info->chip_id != CHIPID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
@@ -859,11 +871,30 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
+	[ID_AD7190] = {
+		.chip_id = CHIPID_AD7190,
+		.name = "ad7190",
+	},
+	[ID_AD7192] = {
+		.chip_id = CHIPID_AD7192,
+		.name = "ad7192",
+	},
+	[ID_AD7193] = {
+		.chip_id = CHIPID_AD7193,
+		.name = "ad7193",
+	},
+	[ID_AD7195] = {
+		.chip_id = CHIPID_AD7195,
+		.name = "ad7195",
+	},
+};
+
 static int ad7192_channels_config(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	switch (st->devid) {
+	switch (st->chip_info->chip_id) {
 	case ID_AD7193:
 		indio_dev->channels = ad7193_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
@@ -878,10 +909,10 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 }
 
 static const struct of_device_id ad7192_of_match[] = {
-	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190 },
-	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
-	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
-	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
+	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
+	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
+	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad7192_of_match);
@@ -938,16 +969,16 @@ static int ad7192_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
+	st->chip_info = of_device_get_match_data(&spi->dev);
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7192_channels_config(indio_dev);
 	if (ret < 0)
 		goto error_disable_dvdd;
 
-	if (st->devid == ID_AD7195)
+	if (st->chip_info->chip_id == CHIPID_AD7195)
 		indio_dev->info = &ad7195_info;
 	else
 		indio_dev->info = &ad7192_info;
-- 
2.17.1


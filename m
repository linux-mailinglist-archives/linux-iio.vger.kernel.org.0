Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC76C142D29
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgATOVL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 09:21:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52876 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATOVL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 09:21:11 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KEEsdH027028;
        Mon, 20 Jan 2020 09:21:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbctvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 09:21:08 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00KEL6VA044576
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 20 Jan 2020 09:21:06 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Jan 2020 06:21:04 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 20 Jan 2020 06:21:04 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00KEKwid024435;
        Mon, 20 Jan 2020 09:21:02 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/4] iio: adis16480: Make use of __adis_initial_startup
Date:   Mon, 20 Jan 2020 16:20:50 +0200
Message-ID: <20200120142051.28533-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120142051.28533-1-alexandru.ardelean@analog.com>
References: <20200120142051.28533-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001200123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

All actions done in `adis16480_initial_setup()` are now done in
`__adis_initial_startup()` so, there's no need for code duplication.
Furthermore, the call to `adis16480_initial_setup()` is done before any
device configuration since the device will be reset if not already (via
rst pin). This is actually fixing a potential bug since `adis_reset()` was
being called after configuring the device which is obviously a problem.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 55 ++++++++-----------------------------
 1 file changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index e1de25f18e2e..36973662a31d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1014,40 +1014,6 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
-static int adis16480_initial_setup(struct iio_dev *indio_dev)
-{
-	struct adis16480 *st = iio_priv(indio_dev);
-	uint16_t prod_id;
-	unsigned int device_id;
-	int ret;
-
-	adis_reset(&st->adis);
-	msleep(70);
-
-	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_GLOB_CMD, BIT(1));
-	if (ret)
-		return ret;
-	msleep(30);
-
-	ret = adis_check_status(&st->adis);
-	if (ret)
-		return ret;
-
-	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_PROD_ID, &prod_id);
-	if (ret)
-		return ret;
-
-	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
-	if (ret != 1)
-		return -EINVAL;
-
-	if (prod_id != device_id)
-		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
-				device_id, prod_id);
-
-	return 0;
-}
-
 #define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
 #define ADIS16480_DIAG_STAT_YGYRO_FAIL 1
 #define ADIS16480_DIAG_STAT_ZGYRO_FAIL 2
@@ -1075,6 +1041,7 @@ static const char * const adis16480_status_error_msgs[] = {
 static const struct adis_data adis16480_data = {
 	.diag_stat_reg = ADIS16480_REG_DIAG_STS,
 	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,
+	.prod_id_reg = ADIS16480_REG_PROD_ID,
 	.has_paging = true,
 
 	.read_delay = 5,
@@ -1296,18 +1263,22 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		return ret;
 
+	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	if (ret)
+		goto error_stop_device;
+
 	ret = adis16480_get_ext_clocks(st);
 	if (ret)
-		return ret;
+		goto error_stop_device;
 
 	if (!IS_ERR_OR_NULL(st->ext_clk)) {
 		ret = adis16480_ext_clk_config(st, spi->dev.of_node, true);
 		if (ret)
-			return ret;
+			goto error_stop_device;
 
 		st->clk_freq = clk_get_rate(st->ext_clk);
 		st->clk_freq *= 1000; /* micro */
@@ -1319,24 +1290,20 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		goto error_clk_disable_unprepare;
 
-	ret = adis16480_initial_setup(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer;
-
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_stop_device;
+		goto error_cleanup_buffer;
 
 	adis16480_debugfs_init(indio_dev);
 
 	return 0;
 
-error_stop_device:
-	adis16480_stop_device(indio_dev);
 error_cleanup_buffer:
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
 error_clk_disable_unprepare:
 	clk_disable_unprepare(st->ext_clk);
+error_stop_device:
+	adis16480_stop_device(indio_dev);
 	return ret;
 }
 
-- 
2.20.1


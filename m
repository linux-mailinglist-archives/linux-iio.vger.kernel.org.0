Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6F142D26
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 15:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATOVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 09:21:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50510 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATOVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 09:21:09 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KEHZWX020961;
        Mon, 20 Jan 2020 09:21:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkyta4mvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 09:21:05 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00KEL3p7040627
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 20 Jan 2020 09:21:04 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 20 Jan
 2020 06:21:03 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 20 Jan 2020 06:21:02 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00KEKwib024435;
        Mon, 20 Jan 2020 09:20:59 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/4] iio: imu: adis: Add self_test_reg variable
Date:   Mon, 20 Jan 2020 16:20:48 +0200
Message-ID: <20200120142051.28533-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

This patch adds a dedicated self_test_reg variable. This is also a step
to let new drivers make use of `adis_initial_startup()`. Some devices
use MSG_CTRL reg to request a self_test command while others use the
GLOB_CMD register.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adis16201.c         | 1 +
 drivers/iio/accel/adis16209.c         | 1 +
 drivers/iio/gyro/adis16136.c          | 1 +
 drivers/iio/gyro/adis16260.c          | 1 +
 drivers/iio/imu/adis.c                | 6 +++---
 drivers/iio/imu/adis16400.c           | 1 +
 drivers/iio/imu/adis16460.c           | 2 ++
 drivers/iio/imu/adis16480.c           | 3 +++
 drivers/staging/iio/accel/adis16203.c | 1 +
 drivers/staging/iio/accel/adis16240.c | 1 +
 include/linux/iio/imu/adis.h          | 2 ++
 11 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 0f0f27a8184e..4154e7396bbe 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -246,6 +246,7 @@ static const struct adis_data adis16201_data = {
 	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
+	.self_test_reg = ADIS16201_MSC_CTRL_REG,
 	.self_test_no_autoclear = true,
 	.timeouts = &adis16201_timeouts,
 
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index c6dbd2424e10..31d45e7c5485 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -256,6 +256,7 @@ static const struct adis_data adis16209_data = {
 	.diag_stat_reg = ADIS16209_STAT_REG,
 
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
+	.self_test_reg = ADIS16209_MSC_CTRL_REG,
 	.self_test_no_autoclear = true,
 	.timeouts = &adis16209_timeouts,
 
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index d5e03a406d4a..e8375d4a408f 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -472,6 +472,7 @@ static const struct adis_data adis16136_data = {
 	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,
 
 	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,
+	.self_test_reg = ADIS16136_REG_MSC_CTRL,
 
 	.read_delay = 10,
 	.write_delay = 10,
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index be09b3e5910c..9823573e811a 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -346,6 +346,7 @@ static const struct adis_data adis16260_data = {
 	.diag_stat_reg = ADIS16260_DIAG_STAT,
 
 	.self_test_mask = ADIS16260_MSC_CTRL_MEM_TEST,
+	.self_test_reg = ADIS16260_MSC_CTRL,
 	.timeouts = &adis16260_timeouts,
 
 	.status_error_msgs = adis1620_status_error_msgs,
diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 022bb54fb748..d02b1911b0f2 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -346,8 +346,8 @@ static int adis_self_test(struct adis *adis)
 	int ret;
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
-	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
-			adis->data->self_test_mask);
+	ret = __adis_write_reg_16(adis, adis->data->self_test_reg,
+				  adis->data->self_test_mask);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to initiate self test: %d\n",
 			ret);
@@ -359,7 +359,7 @@ static int adis_self_test(struct adis *adis)
 	ret = __adis_check_status(adis);
 
 	if (adis->data->self_test_no_autoclear)
-		__adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
+		__adis_write_reg_16(adis, adis->data->self_test_reg, 0x00);
 
 	return ret;
 }
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index cfb1c19eb930..a59cd7e0c7ed 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1126,6 +1126,7 @@ static const struct adis_data adis16400_data = {
 	.write_delay = 50,
 
 	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,
+	.self_test_reg = ADIS16400_MSC_CTRL,
 
 	.status_error_msgs = adis16400_status_error_msgs,
 	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 9539cfe4a259..42fa473c6d81 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -392,6 +392,8 @@ static const struct adis_timeout adis16460_timeouts = {
 static const struct adis_data adis16460_data = {
 	.diag_stat_reg = ADIS16460_REG_DIAG_STAT,
 	.glob_cmd_reg = ADIS16460_REG_GLOB_CMD,
+	.self_test_mask = BIT(2),
+	.self_test_reg = ADIS16460_REG_GLOB_CMD,
 	.has_paging = false,
 	.read_delay = 5,
 	.write_delay = 5,
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index dac87f1001fd..e1de25f18e2e 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1080,6 +1080,9 @@ static const struct adis_data adis16480_data = {
 	.read_delay = 5,
 	.write_delay = 5,
 
+	.self_test_mask = BIT(1),
+	.self_test_reg = ADIS16480_REG_GLOB_CMD,
+
 	.status_error_msgs = adis16480_status_error_msgs,
 	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |
 		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 39dfe3f7f254..fef52d9b5346 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -250,6 +250,7 @@ static const struct adis_data adis16203_data = {
 	.diag_stat_reg = ADIS16203_DIAG_STAT,
 
 	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
+	.self_test_reg = ADIS16203_MSC_CTRL,
 	.self_test_no_autoclear = true,
 	.timeouts = &adis16203_timeouts,
 
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 39eb8364aa95..8bd35c6c56a1 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -373,6 +373,7 @@ static const struct adis_data adis16240_data = {
 	.diag_stat_reg = ADIS16240_DIAG_STAT,
 
 	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
+	.self_test_reg = ADIS16240_MSC_CTRL,
 	.self_test_no_autoclear = true,
 	.timeouts = &adis16240_timeouts,
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index d2fcf45b4cef..d21a013d1122 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -41,6 +41,7 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @self_test_reg: Register address to request self test command
  * @status_error_msgs: Array of error messgaes
  * @status_error_mask:
  * @timeouts: Chip specific delays
@@ -55,6 +56,7 @@ struct adis_data {
 	unsigned int diag_stat_reg;
 
 	unsigned int self_test_mask;
+	unsigned int self_test_reg;
 	bool self_test_no_autoclear;
 	const struct adis_timeout *timeouts;
 
-- 
2.20.1


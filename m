Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D251BF612
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgD3LEP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 07:04:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40828 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgD3LEP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 07:04:15 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UAnWFL032315;
        Thu, 30 Apr 2020 07:04:13 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30pes2gqmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 07:04:13 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03UB4BWL003415
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 30 Apr 2020 07:04:12 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Apr 2020 04:04:10 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Apr 2020 04:04:10 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 30 Apr 2020 04:04:10 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03UB46tw008447;
        Thu, 30 Apr 2020 07:04:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dragos.bogdan@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: imu: adis16xxx: use helper to access iio core debugfs dir
Date:   Thu, 30 Apr 2020 14:04:22 +0300
Message-ID: <20200430110422.7472-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_07:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO core provides a iio_get_debugfs_dentry() helper.
It seems that the ADIS IMU drivers access that field directly.

This change converts them to use iio_get_debugfs_dentry() instead.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16136.c | 10 ++++------
 drivers/iio/imu/adis16400.c  | 10 ++++------
 drivers/iio/imu/adis16460.c  | 10 ++++------
 drivers/iio/imu/adis16475.c  | 15 ++++++---------
 drivers/iio/imu/adis16480.c  | 16 ++++++----------
 5 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index a4c967a5fc5c..afdc57af475d 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -148,16 +148,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16136_flash_count_fops,
 static int adis16136_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
 	debugfs_create_file_unsafe("serial_number", 0400,
-		indio_dev->debugfs_dentry, adis16136,
-		&adis16136_serial_fops);
+		d, adis16136, &adis16136_serial_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
-		indio_dev->debugfs_dentry,
-		adis16136, &adis16136_product_id_fops);
+		d, adis16136, &adis16136_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
-		indio_dev->debugfs_dentry,
-		adis16136, &adis16136_flash_count_fops);
+		d, adis16136, &adis16136_flash_count_fops);
 
 	return 0;
 }
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 439feb755d82..229f2ff98469 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -281,18 +281,16 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16400_flash_count_fops,
 static int adis16400_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
 	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
 		debugfs_create_file_unsafe("serial_number", 0400,
-				indio_dev->debugfs_dentry, st,
-				&adis16400_serial_number_fops);
+				d, st, &adis16400_serial_number_fops);
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
 		debugfs_create_file_unsafe("product_id", 0400,
-				indio_dev->debugfs_dentry, st,
-				&adis16400_product_id_fops);
+				d, st, &adis16400_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
-			indio_dev->debugfs_dentry, st,
-			&adis16400_flash_count_fops);
+			d, st, &adis16400_flash_count_fops);
 
 	return 0;
 }
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 0957f5cfe9c0..ad20c488a3ba 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -129,16 +129,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
 static int adis16460_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16460 *adis16460 = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
 	debugfs_create_file_unsafe("serial_number", 0400,
-			indio_dev->debugfs_dentry, adis16460,
-			&adis16460_serial_number_fops);
+			d, adis16460, &adis16460_serial_number_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
-			indio_dev->debugfs_dentry, adis16460,
-			&adis16460_product_id_fops);
+			d, adis16460, &adis16460_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
-			indio_dev->debugfs_dentry, adis16460,
-			&adis16460_flash_count_fops);
+			d, adis16460, &adis16460_flash_count_fops);
 
 	return 0;
 }
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index e2bd4214eaeb..4fac24227fae 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -228,20 +228,17 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16475_flash_count_fops,
 static void adis16475_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16475 *st = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
 	debugfs_create_file_unsafe("serial_number", 0400,
-				   indio_dev->debugfs_dentry, st,
-				   &adis16475_serial_number_fops);
+				   d, st, &adis16475_serial_number_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
-				   indio_dev->debugfs_dentry, st,
-				   &adis16475_product_id_fops);
+				   d, st, &adis16475_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
-				   indio_dev->debugfs_dentry, st,
-				   &adis16475_flash_count_fops);
+				   d, st, &adis16475_flash_count_fops);
 	debugfs_create_file("firmware_revision", 0400,
-			    indio_dev->debugfs_dentry, st,
-			    &adis16475_firmware_revision_fops);
-	debugfs_create_file("firmware_date", 0400, indio_dev->debugfs_dentry,
+			    d, st, &adis16475_firmware_revision_fops);
+	debugfs_create_file("firmware_date", 0400, d,
 			    st, &adis16475_firmware_date_fops);
 }
 #else
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index cfae0e4476e7..6a471eee110e 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -284,22 +284,18 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16480_flash_count_fops,
 static int adis16480_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16480 *adis16480 = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
 	debugfs_create_file_unsafe("firmware_revision", 0400,
-		indio_dev->debugfs_dentry, adis16480,
-		&adis16480_firmware_revision_fops);
+		d, adis16480, &adis16480_firmware_revision_fops);
 	debugfs_create_file_unsafe("firmware_date", 0400,
-		indio_dev->debugfs_dentry, adis16480,
-		&adis16480_firmware_date_fops);
+		d, adis16480, &adis16480_firmware_date_fops);
 	debugfs_create_file_unsafe("serial_number", 0400,
-		indio_dev->debugfs_dentry, adis16480,
-		&adis16480_serial_number_fops);
+		d, adis16480, &adis16480_serial_number_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
-		indio_dev->debugfs_dentry, adis16480,
-		&adis16480_product_id_fops);
+		d, adis16480, &adis16480_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
-		indio_dev->debugfs_dentry, adis16480,
-		&adis16480_flash_count_fops);
+		d, adis16480, &adis16480_flash_count_fops);
 
 	return 0;
 }
-- 
2.17.1


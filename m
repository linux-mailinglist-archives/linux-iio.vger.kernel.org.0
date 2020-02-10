Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B963157B4F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgBJN3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:29:12 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6738 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728365AbgBJN2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADOB82009660;
        Mon, 10 Feb 2020 08:28:40 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1tyq81s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:40 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSdjF022079
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:39 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Feb
 2020 08:28:38 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 08:28:37 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZn017670;
        Mon, 10 Feb 2020 08:28:35 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/9] iio: imu: adis: add unlocked __adis_initial_startup()
Date:   Mon, 10 Feb 2020 15:26:01 +0200
Message-ID: <20200210132606.9315-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change splits the __adis_initial_startup() away from
adis_initial_startup(). The unlocked version can be used in certain calls
during probe, where races won't happen since the ADIS driver may not be
registered yet with IIO.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 14 ++++----------
 include/linux/iio/imu/adis.h | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 022bb54fb748..e4897dad34ab 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -365,7 +365,7 @@ static int adis_self_test(struct adis *adis)
 }
 
 /**
- * adis_inital_startup() - Performs device self-test
+ * __adis_initial_startup() - Device initial setup
  * @adis: The adis device
  *
  * Returns 0 if the device is operational, a negative error code otherwise.
@@ -373,28 +373,22 @@ static int adis_self_test(struct adis *adis)
  * This function should be called early on in the device initialization sequence
  * to ensure that the device is in a sane and known state and that it is usable.
  */
-int adis_initial_startup(struct adis *adis)
+int __adis_initial_startup(struct adis *adis)
 {
 	int ret;
 
-	mutex_lock(&adis->state_lock);
-
 	ret = adis_self_test(adis);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
 		__adis_reset(adis);
 		ret = adis_self_test(adis);
-		if (ret) {
+		if (ret)
 			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
-			goto out_unlock;
-		}
 	}
 
-out_unlock:
-	mutex_unlock(&adis->state_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(adis_initial_startup);
+EXPORT_SYMBOL_GPL(__adis_initial_startup);
 
 /**
  * adis_single_conversion() - Performs a single sample conversion
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index d2fcf45b4cef..15e75670f923 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -297,6 +297,7 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 
 int adis_enable_irq(struct adis *adis, bool enable);
 int __adis_check_status(struct adis *adis);
+int __adis_initial_startup(struct adis *adis);
 
 static inline int adis_check_status(struct adis *adis)
 {
@@ -309,7 +310,17 @@ static inline int adis_check_status(struct adis *adis)
 	return ret;
 }
 
-int adis_initial_startup(struct adis *adis);
+/* locked version of __adis_initial_startup() */
+static inline int adis_initial_startup(struct adis *adis)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_initial_startup(adis);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
 
 int adis_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int error_mask,
-- 
2.20.1


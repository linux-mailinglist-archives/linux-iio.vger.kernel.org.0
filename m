Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66B38AD3B
	for <lists+linux-iio@lfdr.de>; Thu, 20 May 2021 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhETMAQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 May 2021 08:00:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28316 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242845AbhETL6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 May 2021 07:58:13 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KBtC6S006366;
        Thu, 20 May 2021 07:56:41 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 38n0hv4bb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 07:56:40 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 14KBucfE019197
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 07:56:39 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 20 May 2021 04:56:38 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 20 May 2021 04:56:38 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 20 May 2021 04:56:38 -0700
Received: from nsa.sphairon.box ([10.44.3.50])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 14KBuXan007744;
        Thu, 20 May 2021 07:56:36 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: adis16136: make use of adis lock helpers
Date:   Thu, 20 May 2021 13:59:09 +0200
Message-ID: <20210520115909.466275-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520115909.466275-1-nuno.sa@analog.com>
References: <20210520115909.466275-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZnJJayLjKitBB285dbhkw0phOjA1a06d
X-Proofpoint-ORIG-GUID: ZnJJayLjKitBB285dbhkw0phOjA1a06d
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_03:2021-05-20,2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the adis lib lock helpers to lock the device. This makes things
consistent with other users of the library.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/gyro/adis16136.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index a11ae9db0d11..d248c8a4a924 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -223,13 +223,12 @@ static ssize_t adis16136_read_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
-	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	int ret;
 
-	mutex_lock(slock);
+	adis_dev_lock(&adis16136->adis);
 	ret = __adis16136_get_freq(adis16136, &freq);
-	mutex_unlock(slock);
+	adis_dev_unlock(&adis16136->adis);
 	if (ret)
 		return ret;
 
@@ -254,11 +253,10 @@ static const unsigned adis16136_3db_divisors[] = {
 static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
-	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	int i, ret;
 
-	mutex_lock(slock);
+	adis_dev_lock(&adis16136->adis);
 	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret)
 		goto out_unlock;
@@ -270,7 +268,7 @@ static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 
 	ret = __adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
 out_unlock:
-	mutex_unlock(slock);
+	adis_dev_unlock(&adis16136->adis);
 
 	return ret;
 }
@@ -278,12 +276,11 @@ static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
-	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	uint16_t val16;
 	int ret;
 
-	mutex_lock(slock);
+	adis_dev_lock(&adis16136->adis);
 
 	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
 				 &val16);
@@ -297,7 +294,7 @@ static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 	*val = freq / adis16136_3db_divisors[val16 & 0x07];
 
 err_unlock:
-	mutex_unlock(slock);
+	adis_dev_unlock(&adis16136->adis);
 
 	return ret ? ret : IIO_VAL_INT;
 }
-- 
2.31.1


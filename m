Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3D1DE098
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEVHIF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 03:08:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63258 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgEVHIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 03:08:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M76eTC002533;
        Fri, 22 May 2020 03:08:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312a17djde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 03:08:03 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04M781Ia022738
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 03:08:02 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 00:08:01 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 00:08:00 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 00:08:00 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04M77wFP030843;
        Fri, 22 May 2020 03:07:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <amit.kucheria@verdurent.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: light: tsl2563: pass iio device as i2c_client private data
Date:   Fri, 22 May 2020 10:08:01 +0300
Message-ID: <20200522070801.28480-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_02:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=964 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We may want to get rid of the iio_priv_to_dev() helper. That's a bit
uncertain at this point. The reason is that we will hide some of the
members of the iio_dev structure (to prevent drivers from accessing them
directly), and that will also mean hiding the implementation of the
iio_priv_to_dev() helper inside the IIO core.

Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
may not be fast anymore, so a general idea is to try to get rid of the
iio_priv_to_dev() altogether.

For this driver, it implies passing the IIO device on the i2c client
private data. The implementation of iio_priv() will not be affected by the
rework/hiding of iio_priv_to_dev().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/tsl2563.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 27a5c28aac7f..2987a7a79a97 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -713,7 +713,7 @@ static int tsl2563_probe(struct i2c_client *client,
 
 	chip = iio_priv(indio_dev);
 
-	i2c_set_clientdata(client, chip);
+	i2c_set_clientdata(client, indio_dev);
 	chip->client = client;
 
 	err = tsl2563_detect(chip);
@@ -797,8 +797,8 @@ static int tsl2563_probe(struct i2c_client *client,
 
 static int tsl2563_remove(struct i2c_client *client)
 {
-	struct tsl2563_chip *chip = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	if (!chip->int_enabled)
@@ -816,7 +816,8 @@ static int tsl2563_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int tsl2563_suspend(struct device *dev)
 {
-	struct tsl2563_chip *chip = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&chip->lock);
@@ -834,7 +835,8 @@ static int tsl2563_suspend(struct device *dev)
 
 static int tsl2563_resume(struct device *dev)
 {
-	struct tsl2563_chip *chip = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&chip->lock);
-- 
2.25.1


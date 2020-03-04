Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687F3178C83
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 09:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgCDIX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 03:23:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47312 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727734AbgCDIX6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 03:23:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0248MV1J023832;
        Wed, 4 Mar 2020 03:23:54 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnranm8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 03:23:54 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0248NrYx038023
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 03:23:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 4 Mar 2020
 03:23:52 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 03:23:52 -0500
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0248NoSZ020227;
        Wed, 4 Mar 2020 03:23:51 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <j.anaszewski@samsung.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: light: gp2ap020a00f: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Wed, 4 Mar 2020 10:26:53 +0200
Message-ID: <20200304082653.19374-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

This change moves the postenable/predisable hooks into the correct
positions.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/gp2ap020a00f.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 4d70c5bf35da..24339098e707 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1390,6 +1390,12 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err < 0) {
+		mutex_unlock(&data->lock);
+		return err;
+	}
+
 	/*
 	 * Enable triggers according to the scan_mask. Enabling either
 	 * LIGHT_CLEAR or LIGHT_IR scan mode results in enabling ALS
@@ -1420,14 +1426,12 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 		goto error_unlock;
 
 	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!data->buffer) {
+	if (!data->buffer)
 		err = -ENOMEM;
-		goto error_unlock;
-	}
-
-	err = iio_triggered_buffer_postenable(indio_dev);
 
 error_unlock:
+	if (err < 0)
+		iio_triggered_buffer_predisable(indio_dev);
 	mutex_unlock(&data->lock);
 
 	return err;
@@ -1440,10 +1444,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto error_unlock;
-
 	for_each_set_bit(i, indio_dev->active_scan_mask,
 		indio_dev->masklength) {
 		switch (i) {
@@ -1466,6 +1466,8 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 		kfree(data->buffer);
 
 error_unlock:
+	iio_triggered_buffer_predisable(indio_dev);
+
 	mutex_unlock(&data->lock);
 
 	return err;
-- 
2.20.1


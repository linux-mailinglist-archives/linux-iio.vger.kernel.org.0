Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8017BB33
	for <lists+linux-iio@lfdr.de>; Fri,  6 Mar 2020 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFLIk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Mar 2020 06:08:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1086 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgCFLIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Mar 2020 06:08:40 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026B7AV0008629;
        Fri, 6 Mar 2020 06:08:38 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnrax09k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 06:08:38 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 026B8b52040800
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Mar 2020 06:08:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 6 Mar 2020
 06:08:36 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 6 Mar 2020 06:08:36 -0500
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 026B8X3D024470;
        Fri, 6 Mar 2020 06:08:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: light: gp2ap020a00f: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Fri, 6 Mar 2020 13:11:37 +0200
Message-ID: <20200306111137.23572-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304082653.19374-1-alexandru.ardelean@analog.com>
References: <20200304082653.19374-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_03:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060080
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

Changelog v1 -> v2:
* Fix omitted compiler warnings: 'warning: unused label 'error_unlock' [-Wunused-label]'
  Reported-by: kbuild test robot <lkp@intel.com>

 drivers/iio/light/gp2ap020a00f.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 4d70c5bf35da..7fbbce0d4bc7 100644
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
@@ -1436,14 +1440,10 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int i, err;
+	int i, err = 0;
 
 	mutex_lock(&data->lock);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto error_unlock;
-
 	for_each_set_bit(i, indio_dev->active_scan_mask,
 		indio_dev->masklength) {
 		switch (i) {
@@ -1465,7 +1465,8 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	if (err == 0)
 		kfree(data->buffer);
 
-error_unlock:
+	iio_triggered_buffer_predisable(indio_dev);
+
 	mutex_unlock(&data->lock);
 
 	return err;
-- 
2.20.1


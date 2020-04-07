Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C021A0FC2
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgDGO6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 10:58:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3082 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728855AbgDGO6c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 10:58:32 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037EsWgJ031822;
        Tue, 7 Apr 2020 10:58:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 306m36b0x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 10:58:30 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 037EwSLW001741
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 7 Apr 2020 10:58:28 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Apr 2020
 07:58:27 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Apr 2020 07:58:26 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 037EwPW2021183;
        Tue, 7 Apr 2020 10:58:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: remove null-checks for 'indio_dev->info'
Date:   Tue, 7 Apr 2020 17:59:18 +0300
Message-ID: <20200407145918.6833-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_07:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070128
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Checking for 'indio_dev->info' is an impossible condition, since an IIO
device should NOT be able to register without that information.
The iio_device_register() function won't allow an IIO device to register if
'indio_dev->info' is NULL.

If that information somehow becomes NULL, then we're likely busted anyway
and we should crash the system, if we haven't already.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e6fa1a4e135d..c96071bfada8 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -54,10 +54,6 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
 	size_t avail;
 	int flushed = 0;
 
-	/* wakeup if the device was unregistered */
-	if (!indio_dev->info)
-		return true;
-
 	/* drain the buffer if it was disabled */
 	if (!iio_buffer_is_active(buf)) {
 		to_wait = min_t(size_t, to_wait, 1);
@@ -109,9 +105,6 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 	size_t to_wait;
 	int ret = 0;
 
-	if (!indio_dev->info)
-		return -ENODEV;
-
 	if (!rb || !rb->access->read)
 		return -EINVAL;
 
@@ -131,11 +124,6 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 
 	add_wait_queue(&rb->pollq, &wait);
 	do {
-		if (!indio_dev->info) {
-			ret = -ENODEV;
-			break;
-		}
-
 		if (!iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size)) {
 			if (signal_pending(current)) {
 				ret = -ERESTARTSYS;
@@ -171,7 +159,7 @@ __poll_t iio_buffer_poll(struct file *filp,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!indio_dev->info || rb == NULL)
+	if (rb == NULL)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
@@ -1100,11 +1088,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		goto out_unlock;
 	}
 
-	if (indio_dev->info == NULL) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
-
 	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
 
 out_unlock:
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C52220343
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 06:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGOEOj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 00:14:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30824 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgGOEOj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 00:14:39 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06F4ADUS011648;
        Wed, 15 Jul 2020 00:14:24 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3279gmjwhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 00:14:24 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06F4ENvk019877
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 15 Jul 2020 00:14:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 15 Jul
 2020 00:14:22 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 15 Jul 2020 00:14:22 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06F4EIVr029729;
        Wed, 15 Jul 2020 00:14:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: fix attach/detach pollfunc order
Date:   Wed, 15 Jul 2020 07:16:29 +0300
Message-ID: <20200715041629.81435-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_02:2020-07-14,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007150033
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The original patch was error-ed by the submitter (me) and not by the author
(Lars).
After looking through the discussion logs (on email), it seems that this
order was wrong for the start, even though the order implemented in the
drivers was correct.

Discussions:
- first RFC: https://lore.kernel.org/linux-iio/20180622135322.3459-1-alexandru.ardelean@analog.com/
- 2nd patch: https://lore.kernel.org/linux-iio/20181219140912.22582-1-alexandru.ardelean@analog.com/
- final patch-sets:
  https://lore.kernel.org/linux-iio/20200522104632.517470-1-alexandru.ardelean@analog.com/
  https://lore.kernel.org/linux-iio/20200525113855.178821-1-alexandru.ardelean@analog.com/

The last one was applied.

The idea is that pollfunc should be attached before calling the
'indio_dev->setup_ops->postenable' hook and should be detached after
calling the 'indio_dev->setup_ops->predisable' hook.

While the drivers were updated to take this into account, the change to the
IIO core was somehow omitted and was made wrong.

This change fixes the order to the proper form.

Fixes f11d59d87b862: ("iio: Move attach/detach of the poll func to the core")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2aec8b85f40d..a7d7e5143ed2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -971,24 +971,29 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 			goto err_disable_buffers;
 	}
 
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		ret = iio_trigger_attach_poll_func(indio_dev->trig,
+						   indio_dev->pollfunc);
+		if (ret)
+			goto err_disable_buffers;
+	}
+
 	if (indio_dev->setup_ops->postenable) {
 		ret = indio_dev->setup_ops->postenable(indio_dev);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: postenable failed (%d)\n", ret);
-			goto err_disable_buffers;
+			goto err_detach_pollfunc;
 		}
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		ret = iio_trigger_attach_poll_func(indio_dev->trig,
-						   indio_dev->pollfunc);
-		if (ret)
-			goto err_disable_buffers;
-	}
-
 	return 0;
 
+err_detach_pollfunc:
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		iio_trigger_detach_poll_func(indio_dev->trig,
+					     indio_dev->pollfunc);
+	}
 err_disable_buffers:
 	list_for_each_entry_continue_reverse(buffer, &iio_dev_opaque->buffer_list,
 					     buffer_list)
@@ -1014,11 +1019,6 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 	if (list_empty(&iio_dev_opaque->buffer_list))
 		return 0;
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		iio_trigger_detach_poll_func(indio_dev->trig,
-					     indio_dev->pollfunc);
-	}
-
 	/*
 	 * If things go wrong at some step in disable we still need to continue
 	 * to perform the other steps, otherwise we leave the device in a
@@ -1032,6 +1032,11 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 			ret = ret2;
 	}
 
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		iio_trigger_detach_poll_func(indio_dev->trig,
+					     indio_dev->pollfunc);
+	}
+
 	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret2 = iio_buffer_disable(buffer, indio_dev);
 		if (ret2 && !ret)
-- 
2.17.1


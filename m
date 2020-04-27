Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685EC1BA445
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgD0NLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 09:11:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3690 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbgD0NLI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 09:11:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RCvlA1022564;
        Mon, 27 Apr 2020 09:10:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj457vke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 09:10:50 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03RDAns5010867
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Apr 2020 09:10:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Apr
 2020 09:10:48 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Apr 2020 09:10:48 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03RDAfUS011495;
        Mon, 27 Apr 2020 09:10:46 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 2/6] iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()
Date:   Mon, 27 Apr 2020 16:10:56 +0300
Message-ID: <20200427131100.50845-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427131100.50845-1-alexandru.ardelean@analog.com>
References: <20200427131100.50845-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_09:2020-04-24,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=946 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270114
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The name (and the wrapper) seems superfluous now, but when more buffers
will be attached to the IIO device this will be a bit more useful.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            |  4 ++++
 drivers/iio/industrialio-buffer.c | 10 ++++++++++
 drivers/iio/industrialio-core.c   |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index fd9a5f1d5e51..39ec0344fb68 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -51,6 +51,8 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
 #define iio_buffer_poll_addr (&iio_buffer_poll)
 #define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
 
+void iio_device_buffers_put(struct iio_dev *indio_dev);
+
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 
@@ -66,6 +68,8 @@ static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 static inline void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
 
+static inline void iio_device_buffers_put(struct iio_dev *indio_dev) {}
+
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
 static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index bc5050191f51..a66d3fbc2905 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1355,6 +1355,16 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
+void iio_device_buffers_put(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (!buffer)
+		return;
+
+	iio_buffer_put(buffer);
+}
+
 /**
  * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
  * @indio_dev: the iio device
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 462d3e810013..32c489139cd2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1481,7 +1481,7 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 
-	iio_buffer_put(indio_dev->buffer);
+	iio_device_buffers_put(indio_dev);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(indio_dev);
-- 
2.17.1


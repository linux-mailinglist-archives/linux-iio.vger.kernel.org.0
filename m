Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439DB1B8D7F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgDZHiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 03:38:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2986 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgDZHiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 03:38:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03Q7YrAL014860;
        Sun, 26 Apr 2020 03:38:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mn4j272a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Apr 2020 03:38:05 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03Q7c4v2028395
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 26 Apr 2020 03:38:04 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Apr 2020 03:38:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Apr 2020 03:38:03 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 26 Apr 2020 03:37:57 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03Q7bqdu011885;
        Sun, 26 Apr 2020 03:37:55 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v5 2/6] iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()
Date:   Sun, 26 Apr 2020 10:38:13 +0300
Message-ID: <20200426073817.33307-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426073817.33307-1-alexandru.ardelean@analog.com>
References: <20200426073817.33307-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_14:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=2
 priorityscore=1501 mlxlogscore=930 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004260070
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


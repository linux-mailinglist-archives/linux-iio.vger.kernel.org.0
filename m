Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F081B6CEA
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 06:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDXE4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 00:56:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgDXE4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 00:56:41 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O4qti2023387;
        Fri, 24 Apr 2020 00:56:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6csfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 00:56:26 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03O4uP8O047667
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 00:56:25 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 23 Apr
 2020 21:56:24 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 23 Apr 2020 21:56:23 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O4uGpm017534;
        Fri, 24 Apr 2020 00:56:21 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 3/7] iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()
Date:   Fri, 24 Apr 2020 07:56:38 +0300
Message-ID: <20200424045642.4903-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424045642.4903-1-alexandru.ardelean@analog.com>
References: <20200424045642.4903-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=2 bulkscore=0 impostorscore=0 mlxlogscore=931 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240035
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
index 68c276edb071..bcf5f561c4b5 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1336,6 +1336,16 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
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
index 3c97090c2ab9..bac865ff673e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1475,7 +1475,7 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 
-	iio_buffer_put(indio_dev->buffer);
+	iio_device_buffers_put(indio_dev);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(indio_dev);
-- 
2.17.1


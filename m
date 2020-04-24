Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABD71B6D12
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 07:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgDXFSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 01:18:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32022 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgDXFSJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 01:18:09 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O53gd1004889;
        Fri, 24 Apr 2020 01:17:57 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6cua3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 01:17:57 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03O5Ht1x049533
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 01:17:55 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 23 Apr
 2020 22:17:53 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 23 Apr 2020 22:17:53 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O5HnSS025747;
        Fri, 24 Apr 2020 01:17:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 1/4] iio: Move scan mask management to the core
Date:   Fri, 24 Apr 2020 08:18:15 +0300
Message-ID: <20200424051818.6408-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424051818.6408-1-alexandru.ardelean@analog.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=2 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Let the core handle the buffer scan mask management including allocation
and channel selection. Having this handled in a central place rather than
open-coding it all over the place will make it easier to change the
implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 17 ++++------
 drivers/iio/industrialio-buffer.c           | 36 +++++++++++++++------
 drivers/iio/inkern.c                        | 15 +++++++++
 include/linux/iio/consumer.h                | 10 ++++++
 4 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 47c96f7f4976..b50f1f48cac6 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -33,8 +33,7 @@ static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
 static void iio_buffer_cb_release(struct iio_buffer *buffer)
 {
 	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
-
-	bitmap_free(cb_buff->buffer.scan_mask);
+	iio_buffer_free_scanmask(buffer);
 	kfree(cb_buff);
 }
 
@@ -72,27 +71,25 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	}
 
 	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
-	cb_buff->buffer.scan_mask = bitmap_zalloc(cb_buff->indio_dev->masklength,
-						  GFP_KERNEL);
-	if (cb_buff->buffer.scan_mask == NULL) {
-		ret = -ENOMEM;
+
+	ret = iio_buffer_alloc_scanmask(&cb_buff->buffer, cb_buff->indio_dev);
+	if (ret)
 		goto error_release_channels;
-	}
+
 	chan = &cb_buff->channels[0];
 	while (chan->indio_dev) {
 		if (chan->indio_dev != cb_buff->indio_dev) {
 			ret = -EINVAL;
 			goto error_free_scan_mask;
 		}
-		set_bit(chan->channel->scan_index,
-			cb_buff->buffer.scan_mask);
+		iio_buffer_channel_enable(&cb_buff->buffer, chan);
 		chan++;
 	}
 
 	return cb_buff;
 
 error_free_scan_mask:
-	bitmap_free(cb_buff->buffer.scan_mask);
+	iio_buffer_free_scanmask(&cb_buff->buffer);
 error_release_channels:
 	iio_channel_release_all(cb_buff->channels);
 error_free_cb_buff:
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 221157136af6..c06691281287 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -206,6 +206,26 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
+int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
+			      struct iio_dev *indio_dev)
+{
+	if (!indio_dev->masklength)
+		return 0;
+
+	buffer->scan_mask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
+	if (buffer->scan_mask == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
+
+void iio_buffer_free_scanmask(struct iio_buffer *buffer)
+{
+	bitmap_free(buffer->scan_mask);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
+
 /**
  * iio_buffer_set_attrs - Set buffer specific attributes
  * @buffer: The buffer for which we are setting attributes
@@ -1301,14 +1321,10 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 				indio_dev->scan_index_timestamp =
 					channels[i].scan_index;
 		}
-		if (indio_dev->masklength && buffer->scan_mask == NULL) {
-			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
-							  GFP_KERNEL);
-			if (buffer->scan_mask == NULL) {
-				ret = -ENOMEM;
-				goto error_cleanup_dynamic;
-			}
-		}
+
+		ret = iio_buffer_alloc_scanmask(buffer, indio_dev);
+		if (ret)
+			goto error_cleanup_dynamic;
 	}
 
 	buffer->scan_el_group.name = iio_scan_elements_group_name;
@@ -1329,7 +1345,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return 0;
 
 error_free_scan_mask:
-	bitmap_free(buffer->scan_mask);
+	iio_buffer_free_scanmask(buffer);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 	kfree(indio_dev->buffer->buffer_group.attrs);
@@ -1342,7 +1358,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!indio_dev->buffer)
 		return;
 
-	bitmap_free(indio_dev->buffer->scan_mask);
+	iio_buffer_free_scanmask(indio_dev->buffer);
 	kfree(indio_dev->buffer->buffer_group.attrs);
 	kfree(indio_dev->buffer->scan_el_group.attrs);
 	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ede99e0d5371..f35cb9985edc 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -11,6 +11,7 @@
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
 #include <linux/iio/consumer.h>
@@ -857,6 +858,20 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
 
+void iio_buffer_channel_enable(struct iio_buffer *buffer,
+			       const struct iio_channel *chan)
+{
+	set_bit(chan->channel->scan_index, buffer->scan_mask);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_channel_enable);
+
+void iio_buffer_channel_disable(struct iio_buffer *buffer,
+				const struct iio_channel *chan)
+{
+	clear_bit(chan->channel->scan_index, buffer->scan_mask);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_channel_disable);
+
 unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 {
 	const struct iio_chan_spec_ext_info *ext_info;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index c4118dcb8e05..dbc87c26250a 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -12,6 +12,7 @@
 
 struct iio_dev;
 struct iio_chan_spec;
+struct iio_buffer;
 struct device;
 
 /**
@@ -342,6 +343,15 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	int *processed, unsigned int scale);
 
+void iio_buffer_channel_enable(struct iio_buffer *buffer,
+			       const struct iio_channel *chan);
+void iio_buffer_channel_disable(struct iio_buffer *buffer,
+				const struct iio_channel *chan);
+
+int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
+			      struct iio_dev *indio_dev);
+void iio_buffer_free_scanmask(struct iio_buffer *buffer);
+
 /**
  * iio_get_channel_ext_info_count() - get number of ext_info attributes
  *				      connected to the channel.
-- 
2.17.1


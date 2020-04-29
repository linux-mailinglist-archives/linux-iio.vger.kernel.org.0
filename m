Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86E21BE261
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgD2PRp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 11:17:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53734 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgD2PRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 11:17:44 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TFHUhv024812;
        Wed, 29 Apr 2020 11:17:30 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj45g5h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 11:17:30 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03TFHPlV027198
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 29 Apr 2020 11:17:26 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 29 Apr
 2020 08:17:24 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 29 Apr 2020 08:17:24 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03TFHM17026989;
        Wed, 29 Apr 2020 11:17:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/2] iio: Move scan mask management to the core
Date:   Wed, 29 Apr 2020 18:17:39 +0300
Message-ID: <20200429151740.85917-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_07:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290128
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Let the core handle the buffer scan mask management including allocation
and channel selection. Having this handled in a central place rather than
open-coding it all over the place will make it easier to change the
implementation (if needed).
At the very least, this change abstracts scan-mask management away from
buffer implementations.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
- split away from initial series; the `buffer->channel_mask` attribute
  requires a bit more dicussion; or may even be dropped; just these 2
  patches helps with diff-ing 2 trees, as applying patches between my
  work tree & IIO has fewer conflicts
- return -EINVAL if masklength is 0 in iio_buffer_alloc_scanmask()
- convert 2nd parameter to `unsigned int masklength` in
  iio_buffer_alloc_scanmask()

 drivers/iio/buffer/industrialio-buffer-cb.c | 17 +++++-----
 drivers/iio/industrialio-buffer.c           | 36 +++++++++++++++------
 drivers/iio/inkern.c                        | 15 +++++++++
 include/linux/iio/consumer.h                | 10 ++++++
 4 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 47c96f7f4976..dc5bb2ab533a 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -34,7 +34,7 @@ static void iio_buffer_cb_release(struct iio_buffer *buffer)
 {
 	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
 
-	bitmap_free(cb_buff->buffer.scan_mask);
+	iio_buffer_free_scanmask(&cb_buff->buffer);
 	kfree(cb_buff);
 }
 
@@ -72,27 +72,26 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	}
 
 	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
-	cb_buff->buffer.scan_mask = bitmap_zalloc(cb_buff->indio_dev->masklength,
-						  GFP_KERNEL);
-	if (cb_buff->buffer.scan_mask == NULL) {
-		ret = -ENOMEM;
+
+	ret = iio_buffer_alloc_scanmask(&cb_buff->buffer,
+					cb_buff->indio_dev->masklength);
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
index eae39eaf49af..c6b63f4474ff 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -208,6 +208,26 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
+int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
+			      unsigned int masklength)
+{
+	if (!masklength)
+		return -EINVAL;
+
+	buffer->scan_mask = bitmap_zalloc(masklength, GFP_KERNEL);
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
@@ -1306,14 +1326,10 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
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
+		ret = iio_buffer_alloc_scanmask(buffer, indio_dev->masklength);
+		if (ret)
+			goto error_cleanup_dynamic;
 	}
 
 	buffer->scan_el_group.name = iio_scan_elements_group_name;
@@ -1334,7 +1350,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return 0;
 
 error_free_scan_mask:
-	bitmap_free(buffer->scan_mask);
+	iio_buffer_free_scanmask(buffer);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 	kfree(buffer->buffer_group.attrs);
@@ -1349,7 +1365,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return;
 
-	bitmap_free(buffer->scan_mask);
+	iio_buffer_free_scanmask(buffer);
 	kfree(buffer->buffer_group.attrs);
 	kfree(buffer->scan_el_group.attrs);
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
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
index c4118dcb8e05..9fcd320c2fb4 100644
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
+			      unsigned int masklength);
+void iio_buffer_free_scanmask(struct iio_buffer *buffer);
+
 /**
  * iio_get_channel_ext_info_count() - get number of ext_info attributes
  *				      connected to the channel.
-- 
2.17.1


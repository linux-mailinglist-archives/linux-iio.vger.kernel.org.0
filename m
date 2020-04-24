Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5D1B6D17
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 07:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgDXFSQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 01:18:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34286 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgDXFSM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 01:18:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O50UPX014606;
        Fri, 24 Apr 2020 01:18:00 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud7n7wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 01:18:00 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03O5Hwf8019485
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 01:17:59 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 22:17:57 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 22:17:57 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 23 Apr 2020 22:17:56 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O5HnSV025747;
        Fri, 24 Apr 2020 01:17:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 4/4] iio: Track enabled channels on a per channel basis
Date:   Fri, 24 Apr 2020 08:18:18 +0300
Message-ID: <20200424051818.6408-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424051818.6408-1-alexandru.ardelean@analog.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=2 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Now that we support multiple channels with the same scan index we can no
longer use the scan mask to track which channels have been enabled.
Otherwise it is not possible to enable channels with the same scan index
independently.

Introduce a new channel mask which is used instead of the scan mask to
track which channels are enabled. Whenever the channel mask is changed a
new scan mask is computed based on it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 62 +++++++++++++++++++++----------
 drivers/iio/inkern.c              | 19 +++++++++-
 include/linux/iio/buffer_impl.h   |  3 ++
 include/linux/iio/consumer.h      |  2 +
 4 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c06691281287..1821a3e32fb3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -216,12 +216,20 @@ int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
 	if (buffer->scan_mask == NULL)
 		return -ENOMEM;
 
+	buffer->channel_mask = bitmap_zalloc(indio_dev->num_channels,
+					     GFP_KERNEL);
+	if (buffer->channel_mask == NULL) {
+		bitmap_free(buffer->scan_mask);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
 
 void iio_buffer_free_scanmask(struct iio_buffer *buffer)
 {
+	bitmap_free(buffer->channel_mask);
 	bitmap_free(buffer->scan_mask);
 }
 EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
@@ -285,7 +293,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
-		       indio_dev->buffer->scan_mask);
+		       indio_dev->buffer->channel_mask);
 
 	return sprintf(buf, "%d\n", ret);
 }
@@ -330,11 +338,12 @@ static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
  * buffers might request, hence this code only verifies that the
  * individual buffers request is plausible.
  */
-static int iio_scan_mask_set(struct iio_dev *indio_dev,
-		      struct iio_buffer *buffer, int bit)
+static int iio_channel_mask_set(struct iio_dev *indio_dev,
+				struct iio_buffer *buffer, int bit)
 {
 	const unsigned long *mask;
 	unsigned long *trialmask;
+	unsigned int ch;
 
 	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
 	if (trialmask == NULL)
@@ -343,8 +352,11 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 		WARN(1, "Trying to set scanmask prior to registering buffer\n");
 		goto err_invalid_mask;
 	}
-	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
-	set_bit(bit, trialmask);
+
+	set_bit(bit, buffer->channel_mask);
+
+	for_each_set_bit(ch, buffer->channel_mask, indio_dev->num_channels)
+		set_bit(indio_dev->channels[ch].scan_index, trialmask);
 
 	if (!iio_validate_scan_mask(indio_dev, trialmask))
 		goto err_invalid_mask;
@@ -363,28 +375,37 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	return 0;
 
 err_invalid_mask:
+	clear_bit(bit, buffer->channel_mask);
 	bitmap_free(trialmask);
 	return -EINVAL;
 }
 
-static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
+static int iio_channel_mask_clear(struct iio_dev *indio_dev,
+				  struct iio_buffer *buffer, int bit)
 {
-	clear_bit(bit, buffer->scan_mask);
+	unsigned int ch;
+
+	clear_bit(bit, buffer->channel_mask);
+
+	bitmap_clear(buffer->scan_mask, 0, indio_dev->masklength);
+
+	for_each_set_bit(ch, buffer->channel_mask, indio_dev->num_channels)
+		set_bit(indio_dev->channels[ch].scan_index, buffer->scan_mask);
 	return 0;
 }
 
-static int iio_scan_mask_query(struct iio_dev *indio_dev,
-			       struct iio_buffer *buffer, int bit)
+static int iio_channel_mask_query(struct iio_dev *indio_dev,
+				 struct iio_buffer *buffer, int bit)
 {
-	if (bit > indio_dev->masklength)
+	if (bit > indio_dev->num_channels)
 		return -EINVAL;
 
-	if (!buffer->scan_mask)
+	if (!buffer->channel_mask)
 		return 0;
 
 	/* Ensure return value is 0 or 1. */
-	return !!test_bit(bit, buffer->scan_mask);
-};
+	return !!test_bit(bit, buffer->channel_mask);
+}
 
 static ssize_t iio_scan_el_store(struct device *dev,
 				 struct device_attribute *attr,
@@ -405,15 +426,15 @@ static ssize_t iio_scan_el_store(struct device *dev,
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
+	ret = iio_channel_mask_query(indio_dev, buffer, this_attr->address);
 	if (ret < 0)
 		goto error_ret;
 	if (!state && ret) {
-		ret = iio_scan_mask_clear(buffer, this_attr->address);
+		ret = iio_channel_mask_clear(indio_dev, buffer, this_attr->address);
 		if (ret)
 			goto error_ret;
 	} else if (state && !ret) {
-		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
+		ret = iio_channel_mask_set(indio_dev, buffer, this_attr->address);
 		if (ret)
 			goto error_ret;
 	}
@@ -459,7 +480,8 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 }
 
 static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
-					const struct iio_chan_spec *chan)
+					const struct iio_chan_spec *chan,
+					unsigned int address)
 {
 	int ret, attrcount = 0;
 	struct iio_buffer *buffer = indio_dev->buffer;
@@ -491,7 +513,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     chan,
 					     &iio_scan_el_show,
 					     &iio_scan_el_store,
-					     chan->scan_index,
+					     address,
 					     0,
 					     &indio_dev->dev,
 					     &buffer->scan_el_dev_attr_list);
@@ -500,7 +522,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     chan,
 					     &iio_scan_el_ts_show,
 					     &iio_scan_el_ts_store,
-					     chan->scan_index,
+					     address,
 					     0,
 					     &indio_dev->dev,
 					     &buffer->scan_el_dev_attr_list);
@@ -1313,7 +1335,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 				continue;
 
 			ret = iio_buffer_add_channel_sysfs(indio_dev,
-							 &channels[i]);
+							 &channels[i], i);
 			if (ret < 0)
 				goto error_cleanup_dynamic;
 			attrcount += ret;
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f35cb9985edc..57cf4b01c403 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -150,6 +150,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 	if (index < 0)
 		goto err_put;
 	channel->channel = &indio_dev->channels[index];
+	channel->channel_index = index;
 
 	return 0;
 
@@ -861,14 +862,28 @@ EXPORT_SYMBOL_GPL(iio_write_channel_raw);
 void iio_buffer_channel_enable(struct iio_buffer *buffer,
 			       const struct iio_channel *chan)
 {
-	set_bit(chan->channel->scan_index, buffer->scan_mask);
+	unsigned int ch;
+
+	set_bit(chan->channel_index, buffer->channel_mask);
+
+	bitmap_clear(buffer->scan_mask, 0, chan->indio_dev->masklength);
+
+	for_each_set_bit(ch, buffer->channel_mask, chan->indio_dev->num_channels)
+		set_bit(chan->indio_dev->channels[ch].scan_index, buffer->scan_mask);
 }
 EXPORT_SYMBOL_GPL(iio_buffer_channel_enable);
 
 void iio_buffer_channel_disable(struct iio_buffer *buffer,
 				const struct iio_channel *chan)
 {
-	clear_bit(chan->channel->scan_index, buffer->scan_mask);
+	unsigned int ch;
+
+	clear_bit(chan->channel_index, buffer->channel_mask);
+
+	bitmap_clear(buffer->scan_mask, 0, chan->indio_dev->masklength);
+
+	for_each_set_bit(ch, buffer->channel_mask, chan->indio_dev->num_channels)
+		set_bit(chan->indio_dev->channels[ch].scan_index, buffer->scan_mask);
 }
 EXPORT_SYMBOL_GPL(iio_buffer_channel_disable);
 
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index a63dc07b7350..801e6ffa062c 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -84,6 +84,9 @@ struct iio_buffer {
 	/** @scan_mask: Bitmask used in masking scan mode elements. */
 	long *scan_mask;
 
+	/** @channel_mask: Bitmask used in masking scan mode elements (per channel). */
+	long *channel_mask;
+
 	/** @demux_list: List of operations required to demux the scan. */
 	struct list_head demux_list;
 
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index dbc87c26250a..6efd7091d3dd 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -19,11 +19,13 @@ struct device;
  * struct iio_channel - everything needed for a consumer to use a channel
  * @indio_dev:		Device on which the channel exists.
  * @channel:		Full description of the channel.
+ * @channel_index:	Offset of the channel into the devices channel array.
  * @data:		Data about the channel used by consumer.
  */
 struct iio_channel {
 	struct iio_dev *indio_dev;
 	const struct iio_chan_spec *channel;
+	unsigned int channel_index;
 	void *data;
 };
 
-- 
2.17.1


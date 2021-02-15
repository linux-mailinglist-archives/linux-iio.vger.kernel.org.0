Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ADE31B76D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBOKkN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:40:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60914 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhBOKkD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:40:03 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAa69B023078;
        Mon, 15 Feb 2021 05:39:08 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gavkhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:39:08 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11FAd6wD023145
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Feb 2021 05:39:07 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 15 Feb 2021 02:39:05 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 15 Feb 2021 02:39:05 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 15 Feb 2021 02:39:05 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUh017530;
        Mon, 15 Feb 2021 05:39:02 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 14/24] iio: buffer: wrap all buffer attributes into iio_dev_attr
Date:   Mon, 15 Feb 2021 12:40:33 +0200
Message-ID: <20210215104043.91251-15-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215104043.91251-1-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-15_04:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=974 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change wraps all buffer attributes into iio_dev_attr objects, and
assigns a reference to the IIO buffer they belong to.

With the addition of multiple IIO buffers per one IIO device, we need a way
to know which IIO buffer is being enabled/disabled/controlled.

We know that all buffer attributes are device_attributes. So we can wrap
them with a iio_dev_attr types. In the iio_dev_attr type, we can also hold
a reference to an IIO buffer.
So, we end up being able to allocate wrapped attributes for all buffer
attributes (even the one from other drivers).

The neat part with this mechanism, is that we don't need to add any extra
cleanup, because these attributes are being added to a dynamic list that
will get cleaned up via iio_free_chan_devattr_list().

With this change, the 'buffer->scan_el_dev_attr_list' list is being renamed
to 'buffer->buffer_attr_list', effectively merging (or finalizing the
merge) of the buffer/ & scan_elements/ attributes internally.

Accessing these new buffer attributes can now be done via
'to_iio_dev_attr(attr)->buffer' inside the show/store handlers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 76 ++++++++++++++++++++-----------
 include/linux/iio/buffer_impl.h   |  4 +-
 2 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e6edec3bcb73..8dc140f13b99 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -253,8 +253,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
 				char *buf)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
@@ -367,8 +366,8 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	int ret;
 	bool state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_buffer *buffer = this_attr->buffer;
 
 	ret = strtobool(buf, &state);
 	if (ret < 0)
@@ -402,8 +401,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%d\n", buffer->scan_timestamp);
 }
@@ -415,7 +413,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	bool state;
 
 	ret = strtobool(buf, &state);
@@ -448,7 +446,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     IIO_SEPARATE,
 				     &indio_dev->dev,
 				     buffer,
-				     &buffer->scan_el_dev_attr_list);
+				     &buffer->buffer_attr_list);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -460,7 +458,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     0,
 				     &indio_dev->dev,
 				     buffer,
-				     &buffer->scan_el_dev_attr_list);
+				     &buffer->buffer_attr_list);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -473,7 +471,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     buffer,
-					     &buffer->scan_el_dev_attr_list);
+					     &buffer->buffer_attr_list);
 	else
 		ret = __iio_add_chan_devattr("en",
 					     chan,
@@ -483,7 +481,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     buffer,
-					     &buffer->scan_el_dev_attr_list);
+					     &buffer->buffer_attr_list);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -495,8 +493,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%d\n", buffer->length);
 }
@@ -506,7 +503,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
 
@@ -538,8 +535,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
@@ -1154,7 +1150,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1183,8 +1179,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%u\n", buffer->watermark);
 }
@@ -1195,7 +1190,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 					  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
 
@@ -1228,8 +1223,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
@@ -1254,6 +1248,26 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
+#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
+
+static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
+					      struct attribute *attr)
+{
+	struct device_attribute *dattr = to_dev_attr(attr);
+	struct iio_dev_attr *iio_attr;
+
+	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
+	if (!iio_attr)
+		return NULL;
+
+	iio_attr->buffer = buffer;
+	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
+
+	list_add(&iio_attr->l, &buffer->buffer_attr_list);
+
+	return &iio_attr->dev_attr.attr;
+}
+
 static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
 						   struct attribute **buffer_attrs,
 						   int buffer_attrcount,
@@ -1329,7 +1343,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	}
 
 	scan_el_attrcount = 0;
-	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
+	INIT_LIST_HEAD(&buffer->buffer_attr_list);
 	channels = indio_dev->channels;
 	if (channels) {
 		/* new magic */
@@ -1376,9 +1390,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 
 	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
 
-	attrn = buffer_attrcount;
+	for (i = 0; i < buffer_attrcount; i++) {
+		struct attribute *wrapped;
+
+		wrapped = iio_buffer_wrap_attr(buffer, attr[i]);
+		if (!wrapped) {
+			ret = -ENOMEM;
+			goto error_free_scan_mask;
+		}
+		attr[i] = wrapped;
+	}
 
-	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
+	attrn = 0;
+	list_for_each_entry(p, &buffer->buffer_attr_list, l)
 		attr[attrn++] = &p->dev_attr.attr;
 
 	buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
@@ -1412,7 +1436,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 error_free_scan_mask:
 	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
-	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
 
 	return ret;
 }
@@ -1443,7 +1467,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 	bitmap_free(buffer->scan_mask);
 	kfree(buffer->buffer_group.name);
 	kfree(buffer->buffer_group.attrs);
-	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
 }
 
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 3e555e58475b..41044320e581 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -97,8 +97,8 @@ struct iio_buffer {
 	/* @scan_timestamp: Does the scan mode include a timestamp. */
 	bool scan_timestamp;
 
-	/* @scan_el_dev_attr_list: List of scan element related attributes. */
-	struct list_head scan_el_dev_attr_list;
+	/* @buffer_attr_list: List of buffer attributes. */
+	struct list_head buffer_attr_list;
 
 	/*
 	 * @buffer_group: Attributes of the new buffer group.
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8D30AB32
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 16:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhBAPZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 10:25:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48300 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhBAOt5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2021 09:49:57 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111El4L2009549;
        Mon, 1 Feb 2021 09:48:42 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36d26a4h7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:48:42 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 111EmfCn030283
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 09:48:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 1 Feb 2021 09:48:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 1 Feb 2021 09:48:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 1 Feb 2021 09:48:40 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111EmNuE027350;
        Mon, 1 Feb 2021 09:48:37 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 08/11] iio: buffer: wrap all buffer attributes into iio_dev_attr
Date:   Mon, 1 Feb 2021 16:51:02 +0200
Message-ID: <20210201145105.20459-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201145105.20459-1-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102010079
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
 drivers/iio/industrialio-buffer.c | 66 +++++++++++++++++++++----------
 include/linux/iio/buffer_impl.h   |  4 +-
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a525e88b302f..49996bed5f4c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -448,7 +448,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     IIO_SEPARATE,
 				     &indio_dev->dev,
 				     buffer,
-				     &buffer->scan_el_dev_attr_list);
+				     &buffer->buffer_attr_list);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -460,7 +460,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     0,
 				     &indio_dev->dev,
 				     buffer,
-				     &buffer->scan_el_dev_attr_list);
+				     &buffer->buffer_attr_list);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -473,7 +473,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     buffer,
-					     &buffer->scan_el_dev_attr_list);
+					     &buffer->buffer_attr_list);
 	else
 		ret = __iio_add_chan_devattr("en",
 					     chan,
@@ -483,7 +483,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     buffer,
-					     &buffer->scan_el_dev_attr_list);
+					     &buffer->buffer_attr_list);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -495,8 +495,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%d\n", buffer->length);
 }
@@ -506,7 +505,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
 
@@ -538,8 +537,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
@@ -1154,7 +1152,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1185,8 +1183,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%u\n", buffer->watermark);
 }
@@ -1197,7 +1194,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 					  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
 
@@ -1230,8 +1227,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
@@ -1256,6 +1252,26 @@ static struct attribute *iio_buffer_attrs[] = {
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
@@ -1331,7 +1347,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	}
 
 	scan_el_attrcount = 0;
-	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
+	INIT_LIST_HEAD(&buffer->buffer_attr_list);
 	channels = indio_dev->channels;
 	if (channels) {
 		/* new magic */
@@ -1378,9 +1394,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 
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
@@ -1412,7 +1438,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 error_free_scan_mask:
 	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
-	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
 
 	return ret;
 }
@@ -1443,7 +1469,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
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


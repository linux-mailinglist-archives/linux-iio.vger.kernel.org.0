Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372E2B69D7
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKQQTB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:19:01 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32836 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbgKQQTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:19:00 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGImGr028498;
        Tue, 17 Nov 2020 11:18:48 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td199y7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:48 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIdx2039798
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:40 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Nov
 2020 08:18:38 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 08:18:38 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTT032565;
        Tue, 17 Nov 2020 11:18:36 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 07/12] iio: buffer: re-route core buffer attributes via it's new kobj_type
Date:   Tue, 17 Nov 2020 18:23:35 +0200
Message-ID: <20201117162340.43924-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For the buffer attributes that are present inside the IIO core buffer logic
we can re-route them to expand the attribute into iio_buffer objects.

The rest, will still expand to device_attributes.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 113 +++++++++++++++++-------------
 1 file changed, 64 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 445709ef245c..8b4b7baf21da 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -572,22 +572,18 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static ssize_t iio_buffer_read_length(struct device *dev,
-				      struct device_attribute *attr,
+static ssize_t iio_buffer_read_length(struct iio_buffer *buffer,
+				      struct iio_buf_attr *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
-
 	return sprintf(buf, "%d\n", buffer->length);
 }
 
-static ssize_t iio_buffer_write_length(struct device *dev,
-				       struct device_attribute *attr,
+static ssize_t iio_buffer_write_length(struct iio_buffer *buffer,
+				       struct iio_buf_attr *attr,
 				       const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	unsigned int val;
 	int ret;
 
@@ -615,13 +611,10 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t iio_buffer_show_enable(struct device *dev,
-				      struct device_attribute *attr,
+static ssize_t iio_buffer_show_enable(struct iio_buffer *buffer,
+				      struct iio_buf_attr *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
-
 	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
 
@@ -1227,15 +1220,14 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 	iio_buffer_deactivate_all(indio_dev);
 }
 
-static ssize_t iio_buffer_store_enable(struct device *dev,
-				       struct device_attribute *attr,
+static ssize_t iio_buffer_store_enable(struct iio_buffer *buffer,
+				       struct iio_buf_attr *attr,
 				       const char *buf,
 				       size_t len)
 {
 	int ret;
 	bool requested_state;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1260,23 +1252,19 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	return (ret < 0) ? ret : len;
 }
 
-static ssize_t iio_buffer_show_watermark(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t iio_buffer_show_watermark(struct iio_buffer *buffer,
+					 struct iio_buf_attr *attr,
 					 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
-
 	return sprintf(buf, "%u\n", buffer->watermark);
 }
 
-static ssize_t iio_buffer_store_watermark(struct device *dev,
-					  struct device_attribute *attr,
+static ssize_t iio_buffer_store_watermark(struct iio_buffer *buffer,
+					  struct iio_buf_attr *attr,
 					  const char *buf,
 					  size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	unsigned int val;
 	int ret;
 
@@ -1305,36 +1293,51 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t iio_dma_show_data_available(struct device *dev,
-						struct device_attribute *attr,
-						char *buf)
+static ssize_t iio_dma_show_data_available(struct iio_buffer *buffer,
+					   struct iio_buf_attr *attr,
+					   char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
-
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
 
-static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
-		   iio_buffer_write_length);
-static struct device_attribute dev_attr_length_ro = __ATTR(length,
+#define IIO_BUF_ATTR(_name, _mode, _show, _store)	\
+	struct iio_buf_attr iio_buf_attr_##_name =	\
+		__ATTR(_name, _mode, _show, _store)
+
+static IIO_BUF_ATTR(length, S_IRUGO | S_IWUSR,
+		    iio_buffer_read_length, iio_buffer_write_length);
+static struct iio_buf_attr buf_attr_length_ro = __ATTR(length,
 	S_IRUGO, iio_buffer_read_length, NULL);
-static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
-		   iio_buffer_show_enable, iio_buffer_store_enable);
-static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
-		   iio_buffer_show_watermark, iio_buffer_store_watermark);
-static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
+static IIO_BUF_ATTR(enable, S_IRUGO | S_IWUSR,
+		    iio_buffer_show_enable, iio_buffer_store_enable);
+static IIO_BUF_ATTR(watermark, S_IRUGO | S_IWUSR,
+		    iio_buffer_show_watermark, iio_buffer_store_watermark);
+static struct iio_buf_attr buf_attr_watermark_ro = __ATTR(watermark,
 	S_IRUGO, iio_buffer_show_watermark, NULL);
-static DEVICE_ATTR(data_available, S_IRUGO,
-		iio_dma_show_data_available, NULL);
+static IIO_BUF_ATTR(data_available, S_IRUGO,
+		    iio_dma_show_data_available, NULL);
 
 static struct attribute *iio_buffer_attrs[] = {
-	&dev_attr_length.attr,
-	&dev_attr_enable.attr,
-	&dev_attr_watermark.attr,
-	&dev_attr_data_available.attr,
+	&iio_buf_attr_length.attr,
+	&iio_buf_attr_enable.attr,
+	&iio_buf_attr_watermark.attr,
+	&iio_buf_attr_data_available.attr,
 };
 
+static bool iio_buffer_attr_is_core(struct attribute *attr)
+{
+	struct attribute *a;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(iio_buffer_attrs); i++) {
+		a = iio_buffer_attrs[i];
+		if (!strcmp(attr->name, a->name))
+			return true;
+	}
+
+	return false;
+}
+
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 #define to_iio_buf_attr(_attr) container_of(_attr, struct iio_buf_attr, attr)
 
@@ -1344,6 +1347,12 @@ static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
 {
 	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
 	struct device_attribute *dattr;
+	struct iio_buf_attr *battr;
+
+	if (iio_buffer_attr_is_core(attr)) {
+		battr = to_iio_buf_attr(attr);
+		return battr->show(buffer, battr, buf);
+	}
 
 	dattr = to_dev_attr(attr);
 
@@ -1357,6 +1366,12 @@ static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
 {
 	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
 	struct device_attribute *dattr;
+	struct iio_buf_attr *battr;
+
+	if (iio_buffer_attr_is_core(attr)) {
+		battr = to_iio_buf_attr(attr);
+		return battr->store(buffer, battr, buf, len);
+	}
 
 	dattr = to_dev_attr(attr);
 
@@ -1453,10 +1468,10 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 
 	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
 	if (!buffer->access->set_length)
-		attr[0] = &dev_attr_length_ro.attr;
+		attr[0] = &buf_attr_length_ro.attr;
 
 	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
-		attr[2] = &dev_attr_watermark_ro.attr;
+		attr[2] = &buf_attr_watermark_ro.attr;
 
 	if (buffer->attrs)
 		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
-- 
2.17.1


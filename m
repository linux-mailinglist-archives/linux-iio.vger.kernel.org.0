Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7E300991
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbhAVQzh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 11:55:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56024 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729166AbhAVQXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 11:23:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MG0sw2026099;
        Fri, 22 Jan 2021 11:22:39 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rbtndg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:22:39 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MGMcC2003235
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 Jan 2021 11:22:38 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 Jan 2021 11:22:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Fri, 22 Jan 2021 11:22:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 Jan 2021 11:22:37 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MGMOCt016711;
        Fri, 22 Jan 2021 11:22:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 07/12][RESEND] iio: buffer: re-route core buffer attributes via it's new kobj_type
Date:   Fri, 22 Jan 2021 18:25:24 +0200
Message-ID: <20210122162529.84978-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122162529.84978-1-alexandru.ardelean@analog.com>
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220088
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
index 524b897a1877..8470921cf2fa 100644
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
 
@@ -1476,10 +1491,10 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 
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


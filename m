Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF11AC5F3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405655AbgDPObR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 10:31:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32204 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388206AbgDPObI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 10:31:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GESLf9028407;
        Thu, 16 Apr 2020 10:31:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn9ady19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 10:31:05 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03GEV4xv050325
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Apr 2020 10:31:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Apr
 2020 10:31:03 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Apr 2020 10:31:03 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03GEV1gm014494;
        Thu, 16 Apr 2020 10:31:01 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: rework buffer attr read-only stat-flags with 'is_visible' hook
Date:   Thu, 16 Apr 2020 17:31:43 +0300
Message-ID: <20200416143143.80046-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_05:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=937 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The kernel provides a facility for attribute groups to specify the stat
flags of a sysfs file with an 'is_visible()' hook. This mechanism is
usually more flexible than assigning read-only attributes at construction
time.
It's added-value is a bit more apparent when the number of attributes
grows, so for sysfs buffer attributes this change may not be that be useful
quite now.

It should become more useful as the sysfs structure for buffer attributes
gets changed a bit.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 48 ++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 221157136af6..60bb03e72afc 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1214,24 +1214,50 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 	return sprintf(buf, "%zu\n", bytes);
 }
 
+enum {
+	IIO_BUFFER_ATTR_LENGTH,
+	IIO_BUFFER_ATTR_ENABLE,
+	IIO_BUFFER_ATTR_WATERMARK,
+	IIO_BUFFER_ATTR_DATA_AVAILABLE,
+	__IIO_BUFFER_ATTR_MAX
+};
+
+static umode_t iio_buffer_attr_group_is_visible(struct kobject *kobj,
+						struct attribute *attr,
+						int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	switch (index) {
+	case IIO_BUFFER_ATTR_LENGTH:
+		if (!buffer->access->set_length)
+			return S_IRUGO;
+		return attr->mode;
+	case IIO_BUFFER_ATTR_WATERMARK:
+		if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
+			return S_IRUGO;
+		return attr->mode;
+	default:
+		return attr->mode;
+	}
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 		   iio_buffer_write_length);
-static struct device_attribute dev_attr_length_ro = __ATTR(length,
-	S_IRUGO, iio_buffer_read_length, NULL);
 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
 static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
-static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
-	S_IRUGO, iio_buffer_show_watermark, NULL);
 static DEVICE_ATTR(data_available, S_IRUGO,
 		iio_dma_show_data_available, NULL);
 
 static struct attribute *iio_buffer_attrs[] = {
-	&dev_attr_length.attr,
-	&dev_attr_enable.attr,
-	&dev_attr_watermark.attr,
-	&dev_attr_data_available.attr,
+	[IIO_BUFFER_ATTR_LENGTH] = &dev_attr_length.attr,
+	[IIO_BUFFER_ATTR_ENABLE] = &dev_attr_enable.attr,
+	[IIO_BUFFER_ATTR_WATERMARK] = &dev_attr_watermark.attr,
+	[IIO_BUFFER_ATTR_DATA_AVAILABLE] = &dev_attr_data_available.attr,
 };
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
@@ -1266,11 +1292,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
-	if (!buffer->access->set_length)
-		attr[0] = &dev_attr_length_ro.attr;
-
-	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
-		attr[2] = &dev_attr_watermark_ro.attr;
 
 	if (buffer->attrs)
 		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
@@ -1279,6 +1300,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
 
 	buffer->buffer_group.name = "buffer";
+	buffer->buffer_group.is_visible = iio_buffer_attr_group_is_visible;
 	buffer->buffer_group.attrs = attr;
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
-- 
2.17.1


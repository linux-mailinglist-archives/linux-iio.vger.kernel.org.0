Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A332E1B7975
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgDXPWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 11:22:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44368 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727088AbgDXPWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 11:22:24 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OFCxLN018030;
        Fri, 24 Apr 2020 11:22:21 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6ej79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 11:22:21 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03OFMKvn008455
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 11:22:20 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 08:22:18 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 08:22:18 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 24 Apr 2020 08:22:18 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03OFMG4P027806;
        Fri, 24 Apr 2020 11:22:17 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: extend short-hand use for 'indio_dev->buffer'
Date:   Fri, 24 Apr 2020 18:22:43 +0300
Message-ID: <20200424152243.39410-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_08:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=2 bulkscore=0 impostorscore=0 mlxlogscore=866 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240121
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change is both cosmetic and a prequel to adding support for attaching
multiple buffers per IIO device.

The IIO buffer sysfs attrs are mostly designed to support only one attached
buffer, and in order to support more, we need to centralize [in each attr
function] the buffer which is being accessed.

This also makes it a bit more uniform, as in some functions there is a
short-hand 'buffer' variable and at the same time the 'indio_dev->buffer'
is still access directly.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 61 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 221157136af6..eae39eaf49af 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -189,10 +189,12 @@ __poll_t iio_buffer_poll(struct file *filp,
  */
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
 {
-	if (!indio_dev->buffer)
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (!buffer)
 		return;
 
-	wake_up(&indio_dev->buffer->pollq);
+	wake_up(&buffer->pollq);
 }
 
 void iio_buffer_init(struct iio_buffer *buffer)
@@ -262,10 +264,11 @@ static ssize_t iio_scan_el_show(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
-		       indio_dev->buffer->scan_mask);
+		       buffer->scan_mask);
 
 	return sprintf(buf, "%d\n", ret);
 }
@@ -381,7 +384,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -410,7 +413,9 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return sprintf(buf, "%d\n", indio_dev->buffer->scan_timestamp);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	return sprintf(buf, "%d\n", buffer->scan_timestamp);
 }
 
 static ssize_t iio_scan_el_ts_store(struct device *dev,
@@ -420,6 +425,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 	bool state;
 
 	ret = strtobool(buf, &state);
@@ -427,11 +433,11 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	indio_dev->buffer->scan_timestamp = state;
+	buffer->scan_timestamp = state;
 error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
@@ -439,10 +445,10 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 }
 
 static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
+					struct iio_buffer *buffer,
 					const struct iio_chan_spec *chan)
 {
 	int ret, attrcount = 0;
-	struct iio_buffer *buffer = indio_dev->buffer;
 
 	ret = __iio_add_chan_devattr("index",
 				     chan,
@@ -518,7 +524,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 		return len;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 	} else {
 		buffer->access->set_length(buffer, val);
@@ -539,7 +545,9 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 				      char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
 
 static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
@@ -1129,6 +1137,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1138,17 +1147,15 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 
 	/* Find out if it is in the list */
-	inlist = iio_buffer_is_active(indio_dev->buffer);
+	inlist = iio_buffer_is_active(buffer);
 	/* Already in desired state */
 	if (inlist == requested_state)
 		goto done;
 
 	if (requested_state)
-		ret = __iio_update_buffers(indio_dev,
-					 indio_dev->buffer, NULL);
+		ret = __iio_update_buffers(indio_dev, buffer, NULL);
 	else
-		ret = __iio_update_buffers(indio_dev,
-					 NULL, indio_dev->buffer);
+		ret = __iio_update_buffers(indio_dev, NULL, buffer);
 
 done:
 	mutex_unlock(&indio_dev->mlock);
@@ -1190,7 +1197,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 		goto out;
 	}
 
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1207,11 +1214,9 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 						char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	size_t bytes;
-
-	bytes = iio_buffer_data_available(indio_dev->buffer);
+	struct iio_buffer *buffer = indio_dev->buffer;
 
-	return sprintf(buf, "%zu\n", bytes);
+	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
 
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
@@ -1292,7 +1297,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 			if (channels[i].scan_index < 0)
 				continue;
 
-			ret = iio_buffer_add_channel_sysfs(indio_dev,
+			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
 							 &channels[i]);
 			if (ret < 0)
 				goto error_cleanup_dynamic;
@@ -1332,20 +1337,22 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
-	kfree(indio_dev->buffer->buffer_group.attrs);
+	kfree(buffer->buffer_group.attrs);
 
 	return ret;
 }
 
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
-	if (!indio_dev->buffer)
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (!buffer)
 		return;
 
-	bitmap_free(indio_dev->buffer->scan_mask);
-	kfree(indio_dev->buffer->buffer_group.attrs);
-	kfree(indio_dev->buffer->scan_el_group.attrs);
-	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
+	bitmap_free(buffer->scan_mask);
+	kfree(buffer->buffer_group.attrs);
+	kfree(buffer->scan_el_group.attrs);
+	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
 /**
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF81CB113
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEHNy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57678 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728390AbgEHNyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:25 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dib8K031165;
        Fri, 8 May 2020 09:54:12 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2j6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:12 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048DsBvm040869
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:11 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 09:54:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 09:54:10 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 09:54:10 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwx030263;
        Fri, 8 May 2020 09:54:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 13/14] iio: unpack all iio buffer attributes correctly
Date:   Fri, 8 May 2020 16:53:47 +0300
Message-ID: <20200508135348.15229-14-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

WIP

This change fixes how IIO buffer attributes get unpacked.
There could be a saner way to unpack these without needed to change the
drivers that attach buffer attributes incorrectly via
iio_buffer_set_attrs()

It seems that the design idea was that there is a single buffer per IIO
device, so all drivers attached buffer attributes for FIFO to the IIO
buffer.

Now with the change to add a device object to the IIO buffer, and shifting
around the device-attributes, a 'device' object unpacks to an IIO buffer
object, which needs some special handling.'

One idea to fix this, is to get rid of iio_buffer_set_attrs() somehow.
Or, to maybe allocate some wrapper device-attributes.

With this change, IIO still needs (to work with the older ABI):
- symlink the chardev of the first IIO buffer device to the IIO device

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c                   |  6 ++-
 drivers/iio/accel/bmc150-accel-core.c         |  6 ++-
 .../buffer/industrialio-buffer-dmaengine.c    |  4 +-
 drivers/iio/industrialio-buffer.c             | 51 +++++++++++--------
 include/linux/iio/buffer.h                    |  3 ++
 5 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 60daf04ce188..528bce008671 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -745,7 +745,8 @@ static ssize_t adxl372_get_fifo_enabled(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
 	struct adxl372_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->fifo_mode);
@@ -755,7 +756,8 @@ static ssize_t adxl372_get_fifo_watermark(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
 	struct adxl372_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->watermark);
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 121b4e89f038..c02287165980 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -763,7 +763,8 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
 					       struct device_attribute *attr,
 					       char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int wm;
 
@@ -778,7 +779,8 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_attached_iio_dev(buffer);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	bool state;
 
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 6dedf12b69a4..7728fdadcc3e 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -130,9 +130,9 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
 static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 	struct dmaengine_buffer *dmaengine_buffer =
-		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
+		iio_buffer_to_dmaengine_buffer(buffer);
 
 	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
 }
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b14281442387..aa2f46c0949f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -29,6 +29,19 @@ static const char * const iio_endian_prefix[] = {
 	[IIO_LE] = "le",
 };
 
+struct iio_buffer *dev_to_iio_buffer(struct device *dev)
+{
+	return container_of(dev, struct iio_buffer, dev);
+}
+EXPORT_SYMBOL_GPL(dev_to_iio_buffer);
+
+struct iio_dev *iio_buffer_get_attached_iio_dev(struct iio_buffer *buffer)
+{
+	return buffer ? NULL : buffer->indio_dev;
+}
+EXPORT_SYMBOL_GPL(iio_buffer_get_attached_iio_dev);
+
+
 static bool iio_buffer_is_active(struct iio_buffer *buf)
 {
 	return !list_empty(&buf->buffer_list);
@@ -324,9 +337,8 @@ static ssize_t iio_scan_el_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
@@ -436,10 +448,10 @@ static ssize_t iio_scan_el_store(struct device *dev,
 				 const char *buf,
 				 size_t len)
 {
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	int ret;
 	bool state;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strtobool(buf, &state);
@@ -474,8 +486,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 
 	return sprintf(buf, "%d\n", buffer->scan_timestamp);
 }
@@ -485,9 +496,9 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 				    const char *buf,
 				    size_t len)
 {
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
 	bool state;
 
 	ret = strtobool(buf, &state);
@@ -563,8 +574,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 
 	return sprintf(buf, "%d\n", buffer->length);
 }
@@ -573,8 +583,8 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	unsigned int val;
 	int ret;
 
@@ -606,8 +616,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 
 	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
@@ -1207,10 +1216,10 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 				       const char *buf,
 				       size_t len)
 {
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	int ret;
 	bool requested_state;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1239,8 +1248,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 
 	return sprintf(buf, "%u\n", buffer->watermark);
 }
@@ -1250,8 +1258,8 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 					  const char *buf,
 					  size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	unsigned int val;
 	int ret;
 
@@ -1284,8 +1292,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = dev_to_iio_buffer(dev);
 
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index fbba4093f06c..a688e98c694c 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,6 +11,9 @@
 
 struct iio_buffer;
 
+struct iio_buffer *dev_to_iio_buffer(struct device *dev);
+struct iio_dev *iio_buffer_get_attached_iio_dev(struct iio_buffer *buffer);
+
 void iio_buffer_set_attrs(struct iio_buffer *buffer,
 			 const struct attribute **attrs);
 
-- 
2.17.1


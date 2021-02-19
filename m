Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EFD31F97F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBSMlW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 07:41:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57880 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhBSMlT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 07:41:19 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JCdRmr005376;
        Fri, 19 Feb 2021 07:40:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjb27dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 07:40:27 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11JCeQjq052011
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 07:40:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 07:40:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 07:40:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 07:40:25 -0500
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11JCeH4t008911;
        Fri, 19 Feb 2021 07:40:23 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 4/6] iio: buffer-dma: Allow to provide custom buffer ops
Date:   Fri, 19 Feb 2021 14:40:10 +0200
Message-ID: <20210219124012.92897-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219124012.92897-1-alexandru.ardelean@analog.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some devices that want to make use of the DMA buffer might need to do
something special, like write a register when the buffer is enabled.

Extend the API to allow those drivers to provide their own buffer ops.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c                 |  3 ++-
 drivers/iio/buffer/industrialio-buffer-dma.c  |  4 +++-
 .../buffer/industrialio-buffer-dmaengine.c    | 23 +++++++++++++------
 include/linux/iio/buffer-dma.h                |  5 +++-
 include/linux/iio/buffer-dmaengine.h          |  6 +++--
 5 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2e84623f732e..bfa00100a631 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -113,7 +113,8 @@ static int adi_axi_adc_config_dma_buffer(struct device *dev,
 		dma_name = "rx";
 
 	return devm_iio_dmaengine_buffer_setup(indio_dev->dev.parent,
-					       indio_dev, dma_name);
+					       indio_dev, dma_name,
+					       NULL, NULL);
 }
 
 static int adi_axi_adc_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 1ae47ed8ef22..aa56c10418d0 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -892,13 +892,15 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_set_length);
  * allocations are done from a memory region that can be accessed by the device.
  */
 int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-	struct device *dev, const struct iio_dma_buffer_ops *ops)
+	struct device *dev, const struct iio_dma_buffer_ops *ops,
+	void *driver_data)
 {
 	iio_buffer_init(&queue->buffer);
 	queue->buffer.length = PAGE_SIZE;
 	queue->buffer.watermark = queue->buffer.length / 2;
 	queue->dev = dev;
 	queue->ops = ops;
+	queue->driver_data = driver_data;
 
 	INIT_LIST_HEAD(&queue->incoming);
 	INIT_LIST_HEAD(&queue->outgoing);
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 6db24be7e11d..a4e7b97ce239 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -163,6 +163,8 @@ static const struct attribute *iio_dmaengine_buffer_attrs[] = {
  * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
  * @dev: Parent device for the buffer
  * @channel: DMA channel name, typically "rx".
+ * @ops: Custom iio_dma_buffer_ops, if NULL default ops will be used
+ * @driver_data: Driver data to be passed to custom iio_dma_buffer_ops
  *
  * This allocates a new IIO buffer which internally uses the DMAengine framework
  * to perform its transfers. The parent device will be used to request the DMA
@@ -172,7 +174,8 @@ static const struct attribute *iio_dmaengine_buffer_attrs[] = {
  * release it.
  */
 static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+	const char *channel, const struct iio_dma_buffer_ops *ops,
+	void *driver_data)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
@@ -211,7 +214,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
 
 	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
-		&iio_dmaengine_default_ops);
+		ops ? ops : &iio_dmaengine_default_ops, driver_data);
 
 	dmaengine_buffer->queue.buffer.attrs = iio_dmaengine_buffer_attrs;
 	dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;
@@ -249,6 +252,8 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
  * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_buffer_alloc()
  * @dev: Parent device for the buffer
  * @channel: DMA channel name, typically "rx".
+ * @ops: Custom iio_dma_buffer_ops, if NULL default ops will be used
+ * @driver_data: Driver data to be passed to custom iio_dma_buffer_ops
  *
  * This allocates a new IIO buffer which internally uses the DMAengine framework
  * to perform its transfers. The parent device will be used to request the DMA
@@ -257,7 +262,8 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
  * The buffer will be automatically de-allocated once the device gets destroyed.
  */
 static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+	const char *channel, const struct iio_dma_buffer_ops *ops,
+	void *driver_data)
 {
 	struct iio_buffer **bufferp, *buffer;
 
@@ -266,7 +272,7 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 	if (!bufferp)
 		return ERR_PTR(-ENOMEM);
 
-	buffer = iio_dmaengine_buffer_alloc(dev, channel);
+	buffer = iio_dmaengine_buffer_alloc(dev, channel, ops, driver_data);
 	if (IS_ERR(buffer)) {
 		devres_free(bufferp);
 		return buffer;
@@ -283,6 +289,8 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
  * @dev: Parent device for the buffer
  * @indio_dev: IIO device to which to attach this buffer.
  * @channel: DMA channel name, typically "rx".
+ * @ops: Custom iio_dma_buffer_ops, if NULL default ops will be used
+ * @driver_data: Driver data to be passed to custom iio_dma_buffer_ops
  *
  * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
  * and attaches it to an IIO device with iio_device_attach_buffer().
@@ -290,13 +298,14 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
  * IIO device.
  */
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    const char *channel)
+	struct iio_dev *indio_dev, const char *channel,
+	const struct iio_dma_buffer_ops *ops,
+	void *driver_data)
 {
 	struct iio_buffer *buffer;
 
 	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
-						 channel);
+						 channel, ops, driver_data);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index f6f2ce3e2ed1..1eec7efe44cf 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -110,6 +110,8 @@ struct iio_dma_buffer_queue {
 
 	bool active;
 
+	void *driver_data;
+
 	unsigned int num_blocks;
 	struct iio_dma_buffer_block **blocks;
 	unsigned int max_offset;
@@ -144,7 +146,8 @@ int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
 
 int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-	struct device *dma_dev, const struct iio_dma_buffer_ops *ops);
+	struct device *dma_dev, const struct iio_dma_buffer_ops *ops,
+	void *driver_data);
 void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
 void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
 
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 5c355be89814..1fca8cdbf14e 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -8,10 +8,12 @@
 #define __IIO_DMAENGINE_H__
 
 struct iio_dev;
+struct iio_dma_buffer_ops;
 struct device;
 
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    const char *channel);
+	struct iio_dev *indio_dev, const char *channel,
+	const struct iio_dma_buffer_ops *ops,
+	void *driver_data);
 
 #endif
-- 
2.27.0


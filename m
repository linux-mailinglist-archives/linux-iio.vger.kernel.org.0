Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D747319C86
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 11:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBLKTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 05:19:07 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2054 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230448AbhBLKS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 05:18:57 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11CAFKQb026370;
        Fri, 12 Feb 2021 05:18:06 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qkgjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 05:18:05 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11CAI4Er023454
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 12 Feb 2021 05:18:04 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 12 Feb 2021 05:18:03 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 12 Feb 2021 05:18:03 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 12 Feb 2021 05:18:03 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11CAHu5m029319;
        Fri, 12 Feb 2021 05:18:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 3/5] iio: buffer-dma: Allow to provide custom buffer ops
Date:   Fri, 12 Feb 2021 12:20:19 +0200
Message-ID: <20210212102021.47276-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212102021.47276-1-alexandru.ardelean@analog.com>
References: <20210212102021.47276-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_03:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120077
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
 drivers/iio/adc/adi-axi-adc.c                      |  2 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  4 +++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 14 ++++++++++----
 include/linux/iio/buffer-dma.h                     |  5 ++++-
 include/linux/iio/buffer-dmaengine.h               |  4 +++-
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 74a6da35fd69..45ce97d1f41e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -116,7 +116,7 @@ static int adi_axi_adc_config_dma_buffer(struct device *dev,
 		dma_name = "rx";
 
 	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
-						 dma_name);
+						 dma_name, NULL, NULL);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index befb0a3d2def..57f2284a292f 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -883,13 +883,15 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_set_length);
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
index bb022922ec23..0736526b36ec 100644
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
 struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+	const char *channel, const struct iio_dma_buffer_ops *ops,
+	void *driver_data)
 {
 	struct iio_buffer **bufferp, *buffer;
 
@@ -266,7 +272,7 @@ struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 	if (!bufferp)
 		return ERR_PTR(-ENOMEM);
 
-	buffer = iio_dmaengine_buffer_alloc(dev, channel);
+	buffer = iio_dmaengine_buffer_alloc(dev, channel, ops, driver_data);
 	if (IS_ERR(buffer)) {
 		devres_free(bufferp);
 		return buffer;
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 315a8d750986..c23fad847f0d 100644
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
index 5b502291d6a4..464adee95d4b 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,10 +7,12 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+struct iio_dma_buffer_ops;
 struct iio_buffer;
 struct device;
 
 struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-						   const char *channel);
+	const char *channel, const struct iio_dma_buffer_ops *ops,
+	void *driver_data);
 
 #endif
-- 
2.17.1


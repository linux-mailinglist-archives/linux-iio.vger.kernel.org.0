Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80FF31B109
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 16:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhBNP5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 10:57:07 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhBNP5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 10:57:06 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EFovBN020903;
        Sun, 14 Feb 2021 10:56:12 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gatp9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 10:56:12 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11EFuAMN015190
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 14 Feb 2021 10:56:10 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Sun, 14 Feb 2021 07:56:09 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Sun, 14 Feb 2021 07:56:09 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 14 Feb 2021 07:56:09 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11EFu6gr004472;
        Sun, 14 Feb 2021 10:56:06 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer-dma,adi-axi-adc: introduce devm_iio_dmaengine_buffer_setup()
Date:   Sun, 14 Feb 2021 17:58:17 +0200
Message-ID: <20210214155817.68678-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140134
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change does a conversion of the devm_iio_dmaengine_buffer_alloc() to
devm_iio_dmaengine_buffer_setup(). This will allocate an IIO DMA buffer and
attach it to the IIO device, similar to devm_iio_triggered_buffer_setup()
(though the underlying code is different, the final logic is the same).

Since the only user of the devm_iio_dmaengine_buffer_alloc() was the
adi-axi-adc driver, this change does the replacement in a single go in the
driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Related to
  https://lore.kernel.org/linux-iio/20210214143313.67202-2-alexandru.ardelean@analog.com/T/


 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/iio/adc/adi-axi-adc.c                 | 12 ++-----
 .../buffer/industrialio-buffer-dmaengine.c    | 33 +++++++++++++++++--
 include/linux/iio/buffer-dmaengine.h          |  7 ++--
 4 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 4b15b3e9358b..5f8c6c303ff2 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -285,6 +285,7 @@ I2C
 IIO
   devm_iio_device_alloc()
   devm_iio_device_register()
+  devm_iio_dmaengine_buffer_setup()
   devm_iio_kfifo_buffer_setup()
   devm_iio_triggered_buffer_setup()
   devm_iio_trigger_alloc()
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9109da2d2e15..2e84623f732e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -104,7 +104,6 @@ static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
 static int adi_axi_adc_config_dma_buffer(struct device *dev,
 					 struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer;
 	const char *dma_name;
 
 	if (!device_property_present(dev, "dmas"))
@@ -113,15 +112,8 @@ static int adi_axi_adc_config_dma_buffer(struct device *dev,
 	if (device_property_read_string(dev, "dma-names", &dma_name))
 		dma_name = "rx";
 
-	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
-						 dma_name);
-	if (IS_ERR(buffer))
-		return PTR_ERR(buffer);
-
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	return 0;
+	return devm_iio_dmaengine_buffer_setup(indio_dev->dev.parent,
+					       indio_dev, dma_name);
 }
 
 static int adi_axi_adc_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b0cb9a35f5cd..9981896e1495 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -244,7 +244,7 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
  *
  * The buffer will be automatically de-allocated once the device gets destroyed.
  */
-struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel)
 {
 	struct iio_buffer **bufferp, *buffer;
@@ -265,7 +265,36 @@ struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return buffer;
 }
-EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
+
+/**
+ * devm_iio_dmaengine_buffer_setup() - Setup a DMA buffer for an IIO device
+ * @dev: Parent device for the buffer
+ * @indio_dev: IIO device to which to attach this buffer.
+ * @channel: DMA channel name, typically "rx".
+ *
+ * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
+ * and attaches it to an IIO device with iio_device_attach_buffer().
+ * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
+ * IIO device.
+ */
+int devm_iio_dmaengine_buffer_setup(struct device *dev,
+				    struct iio_dev *indio_dev,
+				    const char *channel)
+{
+	struct iio_buffer *buffer;
+
+	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
+						 channel);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_setup);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 5b502291d6a4..5c355be89814 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,10 +7,11 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
-struct iio_buffer;
+struct iio_dev;
 struct device;
 
-struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-						   const char *channel);
+int devm_iio_dmaengine_buffer_setup(struct device *dev,
+				    struct iio_dev *indio_dev,
+				    const char *channel);
 
 #endif
-- 
2.17.1


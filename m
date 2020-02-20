Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1416604B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 16:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgBTPAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 10:00:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24942 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbgBTPAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 10:00:37 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KEhvIp010963;
        Thu, 20 Feb 2020 10:00:35 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8ucu4ekc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 10:00:35 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01KF0Yux001143
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Feb 2020 10:00:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 20 Feb
 2020 10:00:33 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 20 Feb 2020 10:00:33 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01KF0Uq8025958;
        Thu, 20 Feb 2020 10:00:30 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/5] iio: buffer-dmaengine: add dev-managed calls for buffer alloc/free
Date:   Thu, 20 Feb 2020 17:03:13 +0200
Message-ID: <20200220150317.1864-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=2 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, when using a 'iio_dmaengine_buffer_alloc()', an matching call to
'iio_dmaengine_buffer_free()' must be made.

With this change, this can be avoided by using
'devm_iio_dmaengine_buffer_alloc()'. The buffer will get free'd via the
device's devres handling.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../buffer/industrialio-buffer-dmaengine.c    | 70 +++++++++++++++++++
 include/linux/iio/buffer-dmaengine.h          |  5 ++
 2 files changed, 75 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b129693af0fd..eff89037e3f5 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -229,6 +229,76 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
 
+static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
+{
+	iio_dmaengine_buffer_free(*(struct iio_buffer **)res);
+}
+
+/**
+ * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_buffer_alloc()
+ * @dev: Parent device for the buffer
+ * @channel: DMA channel name, typically "rx".
+ *
+ * This allocates a new IIO buffer which internally uses the DMAengine framework
+ * to perform its transfers. The parent device will be used to request the DMA
+ * channel.
+ *
+ * Once done using the buffer iio_dmaengine_buffer_free() should be used to
+ * release it.
+ */
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+	const char *channel)
+{
+	struct iio_buffer **bufferp, *buffer;
+
+	bufferp = devres_alloc(__devm_iio_dmaengine_buffer_free,
+			       sizeof(*bufferp), GFP_KERNEL);
+	if (!bufferp)
+		return ERR_PTR(-ENOMEM);
+
+	buffer = iio_dmaengine_buffer_alloc(dev, channel);
+	if (!IS_ERR(buffer)) {
+		*bufferp = buffer;
+		devres_add(dev, bufferp);
+	} else {
+		devres_free(bufferp);
+	}
+
+	return buffer;
+}
+EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
+
+static int devm_iio_dmaengine_buffer_match(struct device *dev, void *res,
+	void *data)
+{
+	struct iio_buffer **r = res;
+
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+
+	return *r == data;
+}
+
+/**
+ * devm_iio_dmaengine_buffer_free - iio_dmaengine_buffer_free
+ * @dev: Device this iio_buffer belongs to
+ * @buffer: The iio_buffer associated with the device
+ *
+ * Free buffer allocated with devm_iio_dmaengine_buffer_alloc().
+ */
+void devm_iio_dmaengine_buffer_free(struct device *dev,
+	struct iio_buffer *buffer)
+{
+	int rc;
+
+	rc = devres_release(dev, __devm_iio_dmaengine_buffer_free,
+			    devm_iio_dmaengine_buffer_match, buffer);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_free);
+
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index b3a57444a886..8dcd973d76c1 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -14,4 +14,9 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel);
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+	const char *channel);
+void devm_iio_dmaengine_buffer_free(struct device *dev,
+	struct iio_buffer *buffer);
+
 #endif
-- 
2.20.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A321701E6
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 16:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBZPFv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 10:05:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48004 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727968AbgBZPFu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Feb 2020 10:05:50 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QEn7EO014792;
        Wed, 26 Feb 2020 10:05:49 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwg1qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 10:05:47 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01QF5jPf060235
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Feb 2020 10:05:45 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Feb 2020 07:05:44 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 26 Feb 2020 07:05:44 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01QF5c9K003536;
        Wed, 26 Feb 2020 10:05:41 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/7] iio: buffer-dmaengine: add dev-managed calls for buffer alloc
Date:   Wed, 26 Feb 2020 17:08:31 +0200
Message-ID: <20200226150835.19649-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226150835.19649-1-alexandru.ardelean@analog.com>
References: <20200226150835.19649-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_05:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260108
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
 .../buffer/industrialio-buffer-dmaengine.c    | 39 +++++++++++++++++++
 include/linux/iio/buffer-dmaengine.h          |  3 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b129693af0fd..8f5fe2988a07 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -229,6 +229,45 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
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
+ * The buffer will be automatically de-allocated once the device gets destroyed.
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
+	if (IS_ERR(buffer)) {
+		devres_free(bufferp);
+		return buffer;
+	}
+
+	*bufferp = buffer;
+	devres_add(dev, bufferp);
+
+	return buffer;
+}
+EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
+
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index b3a57444a886..0e503db71289 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -14,4 +14,7 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel);
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+						   const char *channel);
+
 #endif
-- 
2.20.1


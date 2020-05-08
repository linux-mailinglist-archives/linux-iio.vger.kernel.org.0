Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87BC1CB17C
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHONL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:13:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23038 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbgEHONL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 10:13:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048E52xY006944;
        Fri, 8 May 2020 10:13:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2mad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 10:13:09 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048ED8Ad046078
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 10:13:08 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 10:13:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 10:13:07 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 10:13:07 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048ED5JY031800;
        Fri, 8 May 2020 10:13:05 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: core: wrap IIO device into a iio_dev_priv object
Date:   Fri, 8 May 2020 17:13:04 +0300
Message-ID: <20200508141306.17222-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=2
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are plenty of bad designs we want to discourage or not have to review
manually usually about accessing private (marked as [INTERN]) fields of
'struct iio_dev'.

This is difficult, as a lot of users copy drivers, and not always the best
examples.

A better idea is to hide those fields into the framework.
For 'struct iio_dev' this is a 'struct iio_dev_priv' which wraps a public
'struct iio_dev' object.

In the next patches, some fields will be moved to this new struct, each
with it's own rework.

This rework will not be complete[-able] for a while, as many fields need
some drivers to be reworked in order to finalize them
(e.g. 'indio_dev->mlock').

But some fields can already be moved, and in time, all of them may get
there (in the 'struct iio_dev_priv' object).

We also need to hide the implementations for 'iio_priv()' &
'iio_priv_to_dev()', as the pointer arithmetic will not match once things
are moved.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Just as a note here, I've been running this patchset without a problem
for 2 weeks now in a work branch.
But it's only been a setup, so no idea if some other thing may cause
bigger issues.

This small patchset is meant to kickstart this, for GSoC people or for
people wanting to start contributing to IIO.

 drivers/iio/iio_core.h          | 11 +++++++++++
 drivers/iio/industrialio-core.c | 32 +++++++++++++++++++++++++++-----
 include/linux/iio/iio.h         | 12 ++----------
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index fd9a5f1d5e51..84f3b4590c05 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -17,6 +17,17 @@ struct iio_dev;
 
 extern struct device_type iio_device_type;
 
+/**
+ * struct iio_dev_priv - industrial I/O device private information
+ * @indio_dev:			public IIO device object
+ */
+struct iio_dev_priv {
+	struct iio_dev			indio_dev;
+};
+
+#define to_iio_dev_priv(indio_dev)	\
+	container_of(indio_dev, struct iio_dev_priv, indio_dev)
+
 int __iio_add_chan_devattr(const char *postfix,
 			   struct iio_chan_spec const *chan,
 			   ssize_t (*func)(struct device *dev,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 462d3e810013..f0888dd84d3d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -164,6 +164,23 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 };
 
+
+void *iio_priv(const struct iio_dev *indio_dev)
+{
+	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
+	return (char *)iio_dev_priv + ALIGN(sizeof(struct iio_dev_priv), IIO_ALIGN);
+}
+EXPORT_SYMBOL_GPL(iio_priv);
+
+struct iio_dev *iio_priv_to_dev(void *priv)
+{
+	struct iio_dev_priv *iio_dev_priv =
+		(struct iio_dev_priv *)((char *)priv -
+				  ALIGN(sizeof(struct iio_dev_priv), IIO_ALIGN));
+	return &iio_dev_priv->indio_dev;
+}
+EXPORT_SYMBOL_GPL(iio_priv_to_dev);
+
 /**
  * iio_find_channel_from_si() - get channel from its scan index
  * @indio_dev:		device
@@ -1476,6 +1493,8 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(device);
+	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
+
 	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
@@ -1484,7 +1503,7 @@ static void iio_dev_release(struct device *device)
 	iio_buffer_put(indio_dev->buffer);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
-	kfree(indio_dev);
+	kfree(iio_dev_priv);
 }
 
 struct device_type iio_device_type = {
@@ -1498,10 +1517,11 @@ struct device_type iio_device_type = {
  **/
 struct iio_dev *iio_device_alloc(int sizeof_priv)
 {
+	struct iio_dev_priv *iio_dev_priv;
 	struct iio_dev *dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev);
+	alloc_size = sizeof(struct iio_dev_priv);
 	if (sizeof_priv) {
 		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
 		alloc_size += sizeof_priv;
@@ -1509,10 +1529,12 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	/* ensure 32-byte alignment of whole construct ? */
 	alloc_size += IIO_ALIGN - 1;
 
-	dev = kzalloc(alloc_size, GFP_KERNEL);
-	if (!dev)
+	iio_dev_priv = kzalloc(alloc_size, GFP_KERNEL);
+	if (!iio_dev_priv)
 		return NULL;
 
+	dev = &iio_dev_priv->indio_dev;
+
 	dev->dev.groups = dev->groups;
 	dev->dev.type = &iio_device_type;
 	dev->dev.bus = &iio_bus_type;
@@ -1526,7 +1548,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	if (dev->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
-		kfree(dev);
+		kfree(iio_dev_priv);
 		return NULL;
 	}
 	dev_set_name(&dev->dev, "iio:device%d", dev->id);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 5f9f439a4f01..38c4ea505394 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -678,16 +678,8 @@ static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
 #define IIO_ALIGN L1_CACHE_BYTES
 struct iio_dev *iio_device_alloc(int sizeof_priv);
 
-static inline void *iio_priv(const struct iio_dev *indio_dev)
-{
-	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
-}
-
-static inline struct iio_dev *iio_priv_to_dev(void *priv)
-{
-	return (struct iio_dev *)((char *)priv -
-				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
-}
+void *iio_priv(const struct iio_dev *indio_dev);
+struct iio_dev *iio_priv_to_dev(void *priv);
 
 void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
-- 
2.17.1


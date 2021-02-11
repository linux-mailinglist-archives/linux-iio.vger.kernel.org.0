Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C93318A6E
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBKM0A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:26:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22194 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230239AbhBKMXs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:23:48 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCLtWw025272;
        Thu, 11 Feb 2021 07:22:52 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw905b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:22:52 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCMpdF004264
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:22:51 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 07:22:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 07:22:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 11 Feb 2021 07:22:50 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWf011557;
        Thu, 11 Feb 2021 07:22:47 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 07/17] iio: add reference to iio buffer on iio_dev_attr
Date:   Thu, 11 Feb 2021 14:24:42 +0200
Message-ID: <20210211122452.78106-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a reference to a 'struct iio_buffer' object on the
iio_dev_attr object. This way, we can use the created iio_dev_attr objects
on per-buffer basis (since they're allocated anyway).

A minor downside of this change is that the number of parameters on
__iio_add_chan_devattr() grows by 1. This looks like it could do with a bit
of a re-think.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            | 2 ++
 drivers/iio/industrialio-buffer.c | 4 ++++
 drivers/iio/industrialio-core.c   | 6 ++++++
 drivers/iio/industrialio-event.c  | 1 +
 include/linux/iio/sysfs.h         | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 7d5b179c1fe7..731f5170d5b9 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 
+struct iio_buffer;
 struct iio_chan_spec;
 struct iio_dev;
 
@@ -43,6 +44,7 @@ int __iio_add_chan_devattr(const char *postfix,
 			   u64 mask,
 			   enum iio_shared_by shared_by,
 			   struct device *dev,
+			   struct iio_buffer *buffer,
 			   struct list_head *attr_list);
 void iio_free_chan_devattr_list(struct list_head *attr_list);
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index fcbbffb904bf..530b8697f3d8 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -447,6 +447,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     0,
 				     IIO_SEPARATE,
 				     &indio_dev->dev,
+				     buffer,
 				     &buffer->scan_el_dev_attr_list);
 	if (ret)
 		return ret;
@@ -458,6 +459,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     0,
 				     0,
 				     &indio_dev->dev,
+				     buffer,
 				     &buffer->scan_el_dev_attr_list);
 	if (ret)
 		return ret;
@@ -470,6 +472,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     chan->scan_index,
 					     0,
 					     &indio_dev->dev,
+					     buffer,
 					     &buffer->scan_el_dev_attr_list);
 	else
 		ret = __iio_add_chan_devattr("en",
@@ -479,6 +482,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     chan->scan_index,
 					     0,
 					     &indio_dev->dev,
+					     buffer,
 					     &buffer->scan_el_dev_attr_list);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2db460ac30b2..2e8e656e41dd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1114,6 +1114,7 @@ int __iio_add_chan_devattr(const char *postfix,
 			   u64 mask,
 			   enum iio_shared_by shared_by,
 			   struct device *dev,
+			   struct iio_buffer *buffer,
 			   struct list_head *attr_list)
 {
 	int ret;
@@ -1129,6 +1130,7 @@ int __iio_add_chan_devattr(const char *postfix,
 		goto error_iio_dev_attr_free;
 	iio_attr->c = chan;
 	iio_attr->address = mask;
+	iio_attr->buffer = buffer;
 	list_for_each_entry(t, attr_list, l)
 		if (strcmp(t->dev_attr.attr.name,
 			   iio_attr->dev_attr.attr.name) == 0) {
@@ -1165,6 +1167,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 				     0,
 				     IIO_SEPARATE,
 				     &indio_dev->dev,
+				     NULL,
 				     &iio_dev_opaque->channel_attr_list);
 	if (ret < 0)
 		return ret;
@@ -1190,6 +1193,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					     i,
 					     shared_by,
 					     &indio_dev->dev,
+					     NULL,
 					     &iio_dev_opaque->channel_attr_list);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
@@ -1226,6 +1230,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 					     i,
 					     shared_by,
 					     &indio_dev->dev,
+					     NULL,
 					     &iio_dev_opaque->channel_attr_list);
 		kfree(avail_postfix);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
@@ -1322,6 +1327,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					i,
 					ext_info->shared,
 					&indio_dev->dev,
+					NULL,
 					&iio_dev_opaque->channel_attr_list);
 			i++;
 			if (ret == -EBUSY && ext_info->shared)
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index ea8947cc21e4..a30e289fc362 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -385,6 +385,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 
 		ret = __iio_add_chan_devattr(postfix, chan, show, store,
 			 (i << 16) | spec_index, shared_by, &indio_dev->dev,
+			 NULL,
 			&iio_dev_opaque->event_interface->dev_attr_list);
 		kfree(postfix);
 
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index b532c875bc24..e51fba66de4b 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -9,6 +9,7 @@
 #ifndef _INDUSTRIAL_IO_SYSFS_H_
 #define _INDUSTRIAL_IO_SYSFS_H_
 
+struct iio_buffer;
 struct iio_chan_spec;
 
 /**
@@ -17,12 +18,14 @@ struct iio_chan_spec;
  * @address:	associated register address
  * @l:		list head for maintaining list of dynamically created attrs
  * @c:		specification for the underlying channel
+ * @buffer:	the IIO buffer to which this attribute belongs to (if any)
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
 	u64 address;
 	struct list_head l;
 	struct iio_chan_spec const *c;
+	struct iio_buffer *buffer;
 };
 
 #define to_iio_dev_attr(_dev_attr)				\
-- 
2.17.1


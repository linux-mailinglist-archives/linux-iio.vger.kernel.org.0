Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88C33A2BE1
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFJMsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:48:12 -0400
Received: from aposti.net ([89.234.176.197]:54506 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFJMsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 08:48:11 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] iio: core: Support removing extended name in attribute filename
Date:   Thu, 10 Jun 2021 13:45:55 +0100
Message-Id: <20210610124556.34507-2-paul@crapouillou.net>
In-Reply-To: <20210610124556.34507-1-paul@crapouillou.net>
References: <20210610124556.34507-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By default, when a channel has an extended name, it will appear in the
filename of channel attributes. E.g. if the extended name is "aux", the
filename of a "sample_rate" attribute will be something like:
in_voltage0_aux_sample_rate

Add a mechanism to disable this feature. This will be used to add a
"extended_name" channel attribute.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/iio_core.h            |  3 ++-
 drivers/iio/industrialio-buffer.c | 12 ++++++++----
 drivers/iio/industrialio-core.c   | 32 ++++++++++++++++++++-----------
 drivers/iio/industrialio-event.c  |  3 ++-
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 8f4a9b264962..2e1a251d5550 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -50,7 +50,8 @@ int __iio_add_chan_devattr(const char *postfix,
 			   enum iio_shared_by shared_by,
 			   struct device *dev,
 			   struct iio_buffer *buffer,
-			   struct list_head *attr_list);
+			   struct list_head *attr_list,
+			   bool extend_name);
 void iio_free_chan_devattr_list(struct list_head *attr_list);
 
 int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9a8e16c7e9af..053f8896c81c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -492,7 +492,8 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     IIO_SEPARATE,
 				     &indio_dev->dev,
 				     buffer,
-				     &buffer->buffer_attr_list);
+				     &buffer->buffer_attr_list,
+				     true);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -504,7 +505,8 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     0,
 				     &indio_dev->dev,
 				     buffer,
-				     &buffer->buffer_attr_list);
+				     &buffer->buffer_attr_list,
+				     true);
 	if (ret)
 		return ret;
 	attrcount++;
@@ -517,7 +519,8 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     buffer,
-					     &buffer->buffer_attr_list);
+					     &buffer->buffer_attr_list,
+					     true);
 	else
 		ret = __iio_add_chan_devattr("en",
 					     chan,
@@ -527,7 +530,8 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     buffer,
-					     &buffer->buffer_attr_list);
+					     &buffer->buffer_attr_list,
+					     true);
 	if (ret)
 		return ret;
 	attrcount++;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 59efb36db2c7..ec34d930920c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -981,7 +981,8 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 						struct device_attribute *attr,
 						const char *buf,
 						size_t len),
-			   enum iio_shared_by shared_by)
+			   enum iio_shared_by shared_by,
+			   bool extend_name)
 {
 	int ret = 0;
 	char *name = NULL;
@@ -990,25 +991,28 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 
 	/* Build up postfix of <extend_name>_<modifier>_postfix */
 	if (chan->modified && (shared_by == IIO_SEPARATE)) {
-		if (chan->extend_name)
+		if (extend_name && chan->extend_name) {
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
 						 iio_modifier_names[chan
 								    ->channel2],
 						 chan->extend_name,
 						 postfix);
-		else
+		} else {
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s",
 						 iio_modifier_names[chan
 								    ->channel2],
 						 postfix);
+		}
 	} else {
-		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)
+		if (!extend_name || chan->extend_name == NULL
+		    || shared_by != IIO_SEPARATE) {
 			full_postfix = kstrdup(postfix, GFP_KERNEL);
-		else
+		} else {
 			full_postfix = kasprintf(GFP_KERNEL,
 						 "%s_%s",
 						 chan->extend_name,
 						 postfix);
+		}
 	}
 	if (full_postfix == NULL)
 		return -ENOMEM;
@@ -1118,7 +1122,8 @@ int __iio_add_chan_devattr(const char *postfix,
 			   enum iio_shared_by shared_by,
 			   struct device *dev,
 			   struct iio_buffer *buffer,
-			   struct list_head *attr_list)
+			   struct list_head *attr_list,
+			   bool extend_name)
 {
 	int ret;
 	struct iio_dev_attr *iio_attr, *t;
@@ -1128,7 +1133,8 @@ int __iio_add_chan_devattr(const char *postfix,
 		return -ENOMEM;
 	ret = __iio_device_attr_init(&iio_attr->dev_attr,
 				     postfix, chan,
-				     readfunc, writefunc, shared_by);
+				     readfunc, writefunc,
+				     shared_by, extend_name);
 	if (ret)
 		goto error_iio_dev_attr_free;
 	iio_attr->c = chan;
@@ -1171,7 +1177,8 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 				     IIO_SEPARATE,
 				     &indio_dev->dev,
 				     NULL,
-				     &iio_dev_opaque->channel_attr_list);
+				     &iio_dev_opaque->channel_attr_list,
+				     true);
 	if (ret < 0)
 		return ret;
 
@@ -1197,7 +1204,8 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					     shared_by,
 					     &indio_dev->dev,
 					     NULL,
-					     &iio_dev_opaque->channel_attr_list);
+					     &iio_dev_opaque->channel_attr_list,
+					     true);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
 		else if (ret < 0)
@@ -1234,7 +1242,8 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 					     shared_by,
 					     &indio_dev->dev,
 					     NULL,
-					     &iio_dev_opaque->channel_attr_list);
+					     &iio_dev_opaque->channel_attr_list,
+					     true);
 		kfree(avail_postfix);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
@@ -1331,7 +1340,8 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					ext_info->shared,
 					&indio_dev->dev,
 					NULL,
-					&iio_dev_opaque->channel_attr_list);
+					&iio_dev_opaque->channel_attr_list,
+					true);
 			i++;
 			if (ret == -EBUSY && ext_info->shared)
 				continue;
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index d0732eac0f0a..e693d1374c9b 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -387,7 +387,8 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 		ret = __iio_add_chan_devattr(postfix, chan, show, store,
 			 (i << 16) | spec_index, shared_by, &indio_dev->dev,
 			 NULL,
-			&iio_dev_opaque->event_interface->dev_attr_list);
+			&iio_dev_opaque->event_interface->dev_attr_list,
+			true);
 		kfree(postfix);
 
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
-- 
2.30.2


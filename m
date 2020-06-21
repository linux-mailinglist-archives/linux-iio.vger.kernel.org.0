Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2450D202A80
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgFUMcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 08:32:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12566 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730084AbgFUMcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 08:32:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05LCN7G9029966;
        Sun, 21 Jun 2020 08:31:47 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31sfc5abfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jun 2020 08:31:47 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05LCVj31063681
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 21 Jun 2020 08:31:46 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 21 Jun 2020 05:31:44 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 21 Jun 2020 05:31:44 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05LCVWVf007980;
        Sun, 21 Jun 2020 08:31:41 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 6/7] iio: core: move iio_dev's buffer_list to the private iio device object
Date:   Sun, 21 Jun 2020 15:33:44 +0300
Message-ID: <20200621123345.2469-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621123345.2469-1-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_05:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 priorityscore=1501 mlxlogscore=999 cotscore=-2147483648 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006210101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves the 'buffer_list' away from the public IIO device object
into the private part.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 38 +++++++++++++++++++------------
 drivers/iio/industrialio-core.c   |  2 +-
 include/linux/iio/iio-opaque.h    |  2 ++
 include/linux/iio/iio.h           |  2 --
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 329dd4d6757a..2aec8b85f40d 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -19,6 +19,7 @@
 #include <linux/sched/signal.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
@@ -599,8 +600,10 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 static void iio_buffer_activate(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
 	iio_buffer_get(buffer);
-	list_add(&buffer->buffer_list, &indio_dev->buffer_list);
+	list_add(&buffer->buffer_list, &iio_dev_opaque->buffer_list);
 }
 
 static void iio_buffer_deactivate(struct iio_buffer *buffer)
@@ -612,10 +615,11 @@ static void iio_buffer_deactivate(struct iio_buffer *buffer)
 
 static void iio_buffer_deactivate_all(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer, *_buffer;
 
 	list_for_each_entry_safe(buffer, _buffer,
-			&indio_dev->buffer_list, buffer_list)
+			&iio_dev_opaque->buffer_list, buffer_list)
 		iio_buffer_deactivate(buffer);
 }
 
@@ -688,6 +692,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	struct iio_buffer *insert_buffer, struct iio_buffer *remove_buffer,
 	struct iio_device_config *config)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned long *compound_mask;
 	const unsigned long *scan_mask;
 	bool strict_scanmask = false;
@@ -710,12 +715,12 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	 * to verify.
 	 */
 	if (remove_buffer && !insert_buffer &&
-		list_is_singular(&indio_dev->buffer_list))
+		list_is_singular(&iio_dev_opaque->buffer_list))
 			return 0;
 
 	modes = indio_dev->modes;
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		if (buffer == remove_buffer)
 			continue;
 		modes &= buffer->access->modes;
@@ -736,7 +741,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		 * Keep things simple for now and only allow a single buffer to
 		 * be connected in hardware mode.
 		 */
-		if (insert_buffer && !list_empty(&indio_dev->buffer_list))
+		if (insert_buffer && !list_empty(&iio_dev_opaque->buffer_list))
 			return -EINVAL;
 		config->mode = INDIO_BUFFER_HARDWARE;
 		strict_scanmask = true;
@@ -756,7 +761,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 
 	scan_timestamp = false;
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		if (buffer == remove_buffer)
 			continue;
 		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
@@ -902,10 +907,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 
 static int iio_update_demux(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer;
 	int ret;
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret = iio_buffer_update_demux(indio_dev, buffer);
 		if (ret < 0)
 			goto error_clear_mux_table;
@@ -913,7 +919,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
 	return 0;
 
 error_clear_mux_table:
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list)
 		iio_buffer_demux_free(buffer);
 
 	return ret;
@@ -922,6 +928,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
 static int iio_enable_buffers(struct iio_dev *indio_dev,
 	struct iio_device_config *config)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer;
 	int ret;
 
@@ -958,7 +965,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		indio_dev->info->hwfifo_set_watermark(indio_dev,
 			config->watermark);
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret = iio_buffer_enable(buffer, indio_dev);
 		if (ret)
 			goto err_disable_buffers;
@@ -983,7 +990,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	return 0;
 
 err_disable_buffers:
-	list_for_each_entry_continue_reverse(buffer, &indio_dev->buffer_list,
+	list_for_each_entry_continue_reverse(buffer, &iio_dev_opaque->buffer_list,
 					     buffer_list)
 		iio_buffer_disable(buffer, indio_dev);
 err_run_postdisable:
@@ -998,12 +1005,13 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 
 static int iio_disable_buffers(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer;
 	int ret = 0;
 	int ret2;
 
 	/* Wind down existing buffers - iff there are any */
-	if (list_empty(&indio_dev->buffer_list))
+	if (list_empty(&iio_dev_opaque->buffer_list))
 		return 0;
 
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
@@ -1024,7 +1032,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 			ret = ret2;
 	}
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret2 = iio_buffer_disable(buffer, indio_dev);
 		if (ret2 && !ret)
 			ret = ret2;
@@ -1047,6 +1055,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *insert_buffer,
 		       struct iio_buffer *remove_buffer)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_device_config new_config;
 	int ret;
 
@@ -1071,7 +1080,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		iio_buffer_activate(indio_dev, insert_buffer);
 
 	/* If no buffers in list, we are done */
-	if (list_empty(&indio_dev->buffer_list))
+	if (list_empty(&iio_dev_opaque->buffer_list))
 		return 0;
 
 	ret = iio_enable_buffers(indio_dev, &new_config);
@@ -1420,10 +1429,11 @@ static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
  */
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int ret;
 	struct iio_buffer *buf;
 
-	list_for_each_entry(buf, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret = iio_push_to_buffer(buf, data);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 67b8c7eb8b46..051cb05a8da7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1553,7 +1553,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 		return NULL;
 	}
 	dev_set_name(&dev->dev, "iio:device%d", dev->id);
-	INIT_LIST_HEAD(&dev->buffer_list);
+	INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
 
 	return dev;
 }
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 9419a05c698d..af6c69a40169 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -6,6 +6,7 @@
 /**
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
+ * @buffer_list:		list of all buffers currently attached
  * @channel_attr_list:		keep track of automatically created channel
  *				attributes
  * @chan_attr_group:		group for all attrs in base directory
@@ -16,6 +17,7 @@
  */
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
+	struct list_head		buffer_list;
 	struct list_head		channel_attr_list;
 	struct attribute_group		chan_attr_group;
 #if defined(CONFIG_DEBUG_FS)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 30e6fc1506ea..219847f6f5c6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -490,7 +490,6 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
- * @buffer_list:	[INTERN] list of all buffers currently attached
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
@@ -531,7 +530,6 @@ struct iio_dev {
 	struct iio_event_interface	*event_interface;
 
 	struct iio_buffer		*buffer;
-	struct list_head		buffer_list;
 	int				scan_bytes;
 	struct mutex			mlock;
 
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD46990D5
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 11:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBPKNd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 05:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBPKNc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 05:13:32 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0F518C6
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 02:13:30 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GABjmw002478;
        Thu, 16 Feb 2023 05:13:12 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ns89qb1vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 05:13:11 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 31GADA4d042597
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Feb 2023 05:13:10 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 16 Feb 2023 05:13:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 16 Feb 2023 05:13:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 16 Feb 2023 05:13:09 -0500
Received: from nsa.sphairon.box ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 31GAD0ru028929;
        Thu, 16 Feb 2023 05:13:07 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/3] iio: buffer: fix coding style warnings
Date:   Thu, 16 Feb 2023 11:14:52 +0100
Message-ID: <20230216101452.591805-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216101452.591805-1-nuno.sa@analog.com>
References: <20230216101452.591805-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rvKoXKgEExpaOby2zLocnoDgQAl-2bg5
X-Proofpoint-GUID: rvKoXKgEExpaOby2zLocnoDgQAl-2bg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160085
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just cosmetics. No functional change intended...

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 98 +++++++++++++++----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7e7ee307a3f7..e02a4cb3d491 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -194,7 +194,7 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 	written = 0;
 	add_wait_queue(&rb->pollq, &wait);
 	do {
-		if (indio_dev->info == NULL)
+		if (!indio_dev->info)
 			return -ENODEV;
 
 		if (!iio_buffer_space_available(rb)) {
@@ -210,7 +210,7 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 			}
 
 			wait_woken(&wait, TASK_INTERRUPTIBLE,
-					MAX_SCHEDULE_TIMEOUT);
+				   MAX_SCHEDULE_TIMEOUT);
 			continue;
 		}
 
@@ -242,7 +242,7 @@ static __poll_t iio_buffer_poll(struct file *filp,
 	struct iio_buffer *rb = ib->buffer;
 	struct iio_dev *indio_dev = ib->indio_dev;
 
-	if (!indio_dev->info || rb == NULL)
+	if (!indio_dev->info || !rb)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
@@ -407,9 +407,9 @@ static ssize_t iio_scan_el_show(struct device *dev,
 
 /* Note NULL used as error indicator as it doesn't make sense. */
 static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
-					  unsigned int masklength,
-					  const unsigned long *mask,
-					  bool strict)
+						unsigned int masklength,
+						const unsigned long *mask,
+						bool strict)
 {
 	if (bitmap_empty(mask, masklength))
 		return NULL;
@@ -427,7 +427,7 @@ static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 }
 
 static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+				   const unsigned long *mask)
 {
 	if (!indio_dev->setup_ops->validate_scan_mask)
 		return true;
@@ -446,7 +446,7 @@ static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
  * individual buffers request is plausible.
  */
 static int iio_scan_mask_set(struct iio_dev *indio_dev,
-		      struct iio_buffer *buffer, int bit)
+			     struct iio_buffer *buffer, int bit)
 {
 	const unsigned long *mask;
 	unsigned long *trialmask;
@@ -538,7 +538,6 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret < 0 ? ret : len;
-
 }
 
 static ssize_t iio_scan_el_ts_show(struct device *dev,
@@ -703,7 +702,7 @@ static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 }
 
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
-				const unsigned long *mask, bool timestamp)
+				  const unsigned long *mask, bool timestamp)
 {
 	unsigned int bytes = 0;
 	int length, i, largest = 0;
@@ -729,7 +728,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 }
 
 static void iio_buffer_activate(struct iio_dev *indio_dev,
-	struct iio_buffer *buffer)
+				struct iio_buffer *buffer)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
@@ -750,12 +749,12 @@ static void iio_buffer_deactivate_all(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer, *_buffer;
 
 	list_for_each_entry_safe(buffer, _buffer,
-			&iio_dev_opaque->buffer_list, buffer_list)
+				 &iio_dev_opaque->buffer_list, buffer_list)
 		iio_buffer_deactivate(buffer);
 }
 
 static int iio_buffer_enable(struct iio_buffer *buffer,
-	struct iio_dev *indio_dev)
+			     struct iio_dev *indio_dev)
 {
 	if (!buffer->access->enable)
 		return 0;
@@ -763,7 +762,7 @@ static int iio_buffer_enable(struct iio_buffer *buffer,
 }
 
 static int iio_buffer_disable(struct iio_buffer *buffer,
-	struct iio_dev *indio_dev)
+			      struct iio_dev *indio_dev)
 {
 	if (!buffer->access->disable)
 		return 0;
@@ -771,7 +770,7 @@ static int iio_buffer_disable(struct iio_buffer *buffer,
 }
 
 static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
-	struct iio_buffer *buffer)
+					      struct iio_buffer *buffer)
 {
 	unsigned int bytes;
 
@@ -779,13 +778,13 @@ static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 		return;
 
 	bytes = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
-		buffer->scan_timestamp);
+				       buffer->scan_timestamp);
 
 	buffer->access->set_bytes_per_datum(buffer, bytes);
 }
 
 static int iio_buffer_request_update(struct iio_dev *indio_dev,
-	struct iio_buffer *buffer)
+				     struct iio_buffer *buffer)
 {
 	int ret;
 
@@ -794,7 +793,7 @@ static int iio_buffer_request_update(struct iio_dev *indio_dev,
 		ret = buffer->access->request_update(buffer);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
-			       "Buffer not started: buffer parameter update failed (%d)\n",
+				"Buffer not started: buffer parameter update failed (%d)\n",
 				ret);
 			return ret;
 		}
@@ -804,7 +803,7 @@ static int iio_buffer_request_update(struct iio_dev *indio_dev,
 }
 
 static void iio_free_scan_mask(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+			       const unsigned long *mask)
 {
 	/* If the mask is dynamically allocated free it, otherwise do nothing */
 	if (!indio_dev->available_scan_masks)
@@ -820,8 +819,9 @@ struct iio_device_config {
 };
 
 static int iio_verify_update(struct iio_dev *indio_dev,
-	struct iio_buffer *insert_buffer, struct iio_buffer *remove_buffer,
-	struct iio_device_config *config)
+			     struct iio_buffer *insert_buffer,
+			     struct iio_buffer *remove_buffer,
+			     struct iio_device_config *config)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned long *compound_mask;
@@ -861,7 +861,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	if (insert_buffer) {
 		modes &= insert_buffer->access->modes;
 		config->watermark = min(config->watermark,
-			insert_buffer->watermark);
+					insert_buffer->watermark);
 	}
 
 	/* Definitely possible for devices to support both of these. */
@@ -887,7 +887,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 
 	/* What scan mask do we actually have? */
 	compound_mask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
-	if (compound_mask == NULL)
+	if (!compound_mask)
 		return -ENOMEM;
 
 	scan_timestamp = false;
@@ -908,18 +908,18 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 
 	if (indio_dev->available_scan_masks) {
 		scan_mask = iio_scan_mask_match(indio_dev->available_scan_masks,
-				    indio_dev->masklength,
-				    compound_mask,
-				    strict_scanmask);
+						indio_dev->masklength,
+						compound_mask,
+						strict_scanmask);
 		bitmap_free(compound_mask);
-		if (scan_mask == NULL)
+		if (!scan_mask)
 			return -EINVAL;
 	} else {
 		scan_mask = compound_mask;
 	}
 
 	config->scan_bytes = iio_compute_scan_bytes(indio_dev,
-				    scan_mask, scan_timestamp);
+						    scan_mask, scan_timestamp);
 	config->scan_mask = scan_mask;
 	config->scan_timestamp = scan_timestamp;
 
@@ -951,16 +951,16 @@ static void iio_buffer_demux_free(struct iio_buffer *buffer)
 }
 
 static int iio_buffer_add_demux(struct iio_buffer *buffer,
-	struct iio_demux_table **p, unsigned int in_loc, unsigned int out_loc,
-	unsigned int length)
+				struct iio_demux_table **p, unsigned int in_loc,
+				unsigned int out_loc,
+				unsigned int length)
 {
-
 	if (*p && (*p)->from + (*p)->length == in_loc &&
-		(*p)->to + (*p)->length == out_loc) {
+	    (*p)->to + (*p)->length == out_loc) {
 		(*p)->length += length;
 	} else {
 		*p = kmalloc(sizeof(**p), GFP_KERNEL);
-		if (*p == NULL)
+		if (!(*p))
 			return -ENOMEM;
 		(*p)->from = in_loc;
 		(*p)->to = out_loc;
@@ -1024,7 +1024,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 		out_loc += length;
 	}
 	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
-	if (buffer->demux_bounce == NULL) {
+	if (!buffer->demux_bounce) {
 		ret = -ENOMEM;
 		goto error_clear_mux_table;
 	}
@@ -1057,7 +1057,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
 }
 
 static int iio_enable_buffers(struct iio_dev *indio_dev,
-	struct iio_device_config *config)
+			      struct iio_device_config *config)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer, *tmp = NULL;
@@ -1075,7 +1075,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		ret = indio_dev->setup_ops->preenable(indio_dev);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
-			       "Buffer not started: buffer preenable failed (%d)\n", ret);
+				"Buffer not started: buffer preenable failed (%d)\n", ret);
 			goto err_undo_config;
 		}
 	}
@@ -1115,7 +1115,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		ret = indio_dev->setup_ops->postenable(indio_dev);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
-			       "Buffer not started: postenable failed (%d)\n", ret);
+				"Buffer not started: postenable failed (%d)\n", ret);
 			goto err_detach_pollfunc;
 		}
 	}
@@ -1191,15 +1191,15 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 }
 
 static int __iio_update_buffers(struct iio_dev *indio_dev,
-		       struct iio_buffer *insert_buffer,
-		       struct iio_buffer *remove_buffer)
+				struct iio_buffer *insert_buffer,
+				struct iio_buffer *remove_buffer)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_device_config new_config;
 	int ret;
 
 	ret = iio_verify_update(indio_dev, insert_buffer, remove_buffer,
-		&new_config);
+				&new_config);
 	if (ret)
 		return ret;
 
@@ -1255,7 +1255,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		return 0;
 
 	if (insert_buffer &&
-	    (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT))
+	    insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
 		return -EINVAL;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
@@ -1272,7 +1272,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		goto out_unlock;
 	}
 
-	if (indio_dev->info == NULL) {
+	if (!indio_dev->info) {
 		ret = -ENODEV;
 		goto out_unlock;
 	}
@@ -1609,7 +1609,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 
 	buffer_attrcount = 0;
 	if (buffer->attrs) {
-		while (buffer->attrs[buffer_attrcount] != NULL)
+		while (buffer->attrs[buffer_attrcount])
 			buffer_attrcount++;
 	}
 
@@ -1636,7 +1636,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 			}
 
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
-							 &channels[i]);
+							   &channels[i]);
 			if (ret < 0)
 				goto error_cleanup_dynamic;
 			scan_el_attrcount += ret;
@@ -1644,10 +1644,10 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 				iio_dev_opaque->scan_index_timestamp =
 					channels[i].scan_index;
 		}
-		if (indio_dev->masklength && buffer->scan_mask == NULL) {
+		if (indio_dev->masklength && !buffer->scan_mask) {
 			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
 							  GFP_KERNEL);
-			if (buffer->scan_mask == NULL) {
+			if (!buffer->scan_mask) {
 				ret = -ENOMEM;
 				goto error_cleanup_dynamic;
 			}
@@ -1763,7 +1763,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 			goto error_unwind_sysfs_and_mask;
 	}
 
-	sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
+	sz = sizeof(*iio_dev_opaque->buffer_ioctl_handler);
 	iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
 	if (!iio_dev_opaque->buffer_ioctl_handler) {
 		ret = -ENOMEM;
@@ -1812,14 +1812,14 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
  * a time.
  */
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+				   const unsigned long *mask)
 {
 	return bitmap_weight(mask, indio_dev->masklength) == 1;
 }
 EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
 
 static const void *iio_demux(struct iio_buffer *buffer,
-				 const void *datain)
+			     const void *datain)
 {
 	struct iio_demux_table *t;
 
-- 
2.39.2


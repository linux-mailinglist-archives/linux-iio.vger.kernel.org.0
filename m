Return-Path: <linux-iio+bounces-7148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E1492430C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0671C22491
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14761BD016;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8ACQCOB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A551B47D0;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=NHTJSJhKRF0rN55b4zzDLzpnO165XQhiH3/14Or4KdQsP4BPt0ljumFUmdCTPojfHzYQOu2ohz25i1KT/nIxBEFw05TmlTlCDYmRundtFfAZFDiTZH/5uBFUBeX1AgapFfME14gvGCIekcubBCbDyPfBwBM97cRxqDHtMUn1DpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=H6knCmshjK5jGEsidqg9p/dgF02XphFvTsPHqzn4WQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6gdui5iPeKfHXIuNCHYkmgw9qZP2BJgc7Ml+rFjVoELVpA92+KoxTzArmb5RPdbM0SJhKLrfVfjIZ+kGAwBNuHd8vGoqpLPIkqQ9i9O44/RZ/p1n9CQQqQAj9+SlFFn1XmIePWZmFq6D4SxM2etQP3wNIwVVs5d/Im8CEYd99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8ACQCOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D908C4AF0D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=H6knCmshjK5jGEsidqg9p/dgF02XphFvTsPHqzn4WQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B8ACQCOBSeXAMiWqKyyqtsTCs74VAAHr503UAPluDfd1+Ch9KQW1z4c7ILOQy72E+
	 qRT7aPuRAuLdaqchknQHgetoXFjBbhGS1cDXg6tc8uE//VsfwpdfRjVA1uegXLmhRr
	 SZJ/r1jJjiJmX7EF80VUJIL/oJRRcqbcTWeJJxpBq6CkelmfK3GK3Smxlwg2baHKmk
	 Q3X0DZeLJc21GI+YTzCZ2wP3gpDgHn1B4ZHyT04Ly5u6wcRJ6OvDu6iZeLmKlxlmSl
	 9nKGpc4oKhncgjOlgiFUYKXYP42H1QgIwqTcpeccj6KJlQQas1FwriZR1w4FvGoow/
	 U8v74wm39pdEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B7C3065E;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:35 +0200
Subject: [PATCH 03/20] iio: buffer: make use of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-3-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=8943;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=U7dr1egZgx9NyisqCoR3KT604oyD4R25bPaOlNgH5Bg=;
 b=GJ1AZCX6hZqMIVksHzM6CH1VBok4DW6f0RMeoXqxnKC2jOlLABH/eJIND/PEHVWvtyddGVxTV
 LjVguhviQOeA7/zdTDikSWTmyzmmqGOdJEPwuoReCfjpCo6L0VhKQYN
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

While at it, remove some unneeded line breaks.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c   |  2 +-
 drivers/iio/buffer/industrialio-hw-consumer.c |  4 +--
 drivers/iio/industrialio-buffer.c             | 50 ++++++++++++---------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4c12b7a94af59..4befc9f55201e 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -77,7 +77,7 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	}
 
 	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
-	cb_buff->buffer.scan_mask = bitmap_zalloc(cb_buff->indio_dev->masklength,
+	cb_buff->buffer.scan_mask = bitmap_zalloc(iio_get_masklength(cb_buff->indio_dev),
 						  GFP_KERNEL);
 	if (cb_buff->buffer.scan_mask == NULL) {
 		ret = -ENOMEM;
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index fb58f599a80b1..526b2a8d725d1 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -52,6 +52,7 @@ static const struct iio_buffer_access_funcs iio_hw_buf_access = {
 static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
 {
+	unsigned int mask_longs = BITS_TO_LONGS(iio_get_masklength(indio_dev));
 	struct hw_consumer_buffer *buf;
 
 	list_for_each_entry(buf, &hwc->buffers, head) {
@@ -59,8 +60,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 			return buf;
 	}
 
-	buf = kzalloc(struct_size(buf, scan_mask, BITS_TO_LONGS(indio_dev->masklength)),
-		      GFP_KERNEL);
+	buf = kzalloc(struct_size(buf, scan_mask, mask_longs), GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 0138b21b244f0..389bfb238b510 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -473,18 +473,19 @@ static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
 static int iio_scan_mask_set(struct iio_dev *indio_dev,
 			     struct iio_buffer *buffer, int bit)
 {
+	unsigned int masklength = iio_get_masklength(indio_dev);
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	if (!indio_dev->masklength) {
+	if (!masklength) {
 		WARN(1, "Trying to set scanmask prior to registering buffer\n");
 		return -EINVAL;
 	}
 
-	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
+	trialmask = bitmap_alloc(masklength, GFP_KERNEL);
 	if (!trialmask)
 		return -ENOMEM;
-	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
+	bitmap_copy(trialmask, buffer->scan_mask, masklength);
 	set_bit(bit, trialmask);
 
 	if (!iio_validate_scan_mask(indio_dev, trialmask))
@@ -492,12 +493,11 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 
 	if (indio_dev->available_scan_masks) {
 		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
-					   indio_dev->masklength,
-					   trialmask, false);
+					   masklength, trialmask, false);
 		if (!mask)
 			goto err_invalid_mask;
 	}
-	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
+	bitmap_copy(buffer->scan_mask, trialmask, masklength);
 
 	bitmap_free(trialmask);
 
@@ -517,7 +517,7 @@ static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
 static int iio_scan_mask_query(struct iio_dev *indio_dev,
 			       struct iio_buffer *buffer, int bit)
 {
-	if (bit > indio_dev->masklength)
+	if (bit > iio_get_masklength(indio_dev))
 		return -EINVAL;
 
 	if (!buffer->scan_mask)
@@ -733,8 +733,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 	int length, i, largest = 0;
 
 	/* How much space will the demuxed element take? */
-	for_each_set_bit(i, mask,
-			 indio_dev->masklength) {
+	for_each_set_bit(i, mask, iio_get_masklength(indio_dev)) {
 		length = iio_storage_bytes_for_si(indio_dev, i);
 		if (length < 0)
 			return length;
@@ -855,6 +854,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 			     struct iio_device_config *config)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	unsigned int masklength = iio_get_masklength(indio_dev);
 	unsigned long *compound_mask;
 	const unsigned long *scan_mask;
 	bool strict_scanmask = false;
@@ -863,7 +863,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	unsigned int modes;
 
 	if (insert_buffer &&
-	    bitmap_empty(insert_buffer->scan_mask, indio_dev->masklength)) {
+	    bitmap_empty(insert_buffer->scan_mask, masklength)) {
 		dev_dbg(&indio_dev->dev,
 			"At least one scan element must be enabled first\n");
 		return -EINVAL;
@@ -917,7 +917,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	}
 
 	/* What scan mask do we actually have? */
-	compound_mask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
+	compound_mask = bitmap_zalloc(masklength, GFP_KERNEL);
 	if (!compound_mask)
 		return -ENOMEM;
 
@@ -927,20 +927,19 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		if (buffer == remove_buffer)
 			continue;
 		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
-			  indio_dev->masklength);
+			  masklength);
 		scan_timestamp |= buffer->scan_timestamp;
 	}
 
 	if (insert_buffer) {
 		bitmap_or(compound_mask, compound_mask,
-			  insert_buffer->scan_mask, indio_dev->masklength);
+			  insert_buffer->scan_mask, masklength);
 		scan_timestamp |= insert_buffer->scan_timestamp;
 	}
 
 	if (indio_dev->available_scan_masks) {
 		scan_mask = iio_scan_mask_match(indio_dev->available_scan_masks,
-						indio_dev->masklength,
-						compound_mask,
+						masklength, compound_mask,
 						strict_scanmask);
 		bitmap_free(compound_mask);
 		if (!scan_mask)
@@ -1005,6 +1004,7 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
 static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				   struct iio_buffer *buffer)
 {
+	unsigned int masklength = iio_get_masklength(indio_dev);
 	int ret, in_ind = -1, out_ind, length;
 	unsigned int in_loc = 0, out_loc = 0;
 	struct iio_demux_table *p = NULL;
@@ -1016,17 +1016,13 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 
 	/* First work out which scan mode we will actually have */
 	if (bitmap_equal(indio_dev->active_scan_mask,
-			 buffer->scan_mask,
-			 indio_dev->masklength))
+			 buffer->scan_mask, masklength))
 		return 0;
 
 	/* Now we have the two masks, work from least sig and build up sizes */
-	for_each_set_bit(out_ind,
-			 buffer->scan_mask,
-			 indio_dev->masklength) {
+	for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
 		in_ind = find_next_bit(indio_dev->active_scan_mask,
-				       indio_dev->masklength,
-				       in_ind + 1);
+				       masklength, in_ind + 1);
 		while (in_ind != out_ind) {
 			ret = iio_storage_bytes_for_si(indio_dev, in_ind);
 			if (ret < 0)
@@ -1036,8 +1032,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			/* Make sure we are aligned */
 			in_loc = roundup(in_loc, length) + length;
 			in_ind = find_next_bit(indio_dev->active_scan_mask,
-					       indio_dev->masklength,
-					       in_ind + 1);
+					       masklength, in_ind + 1);
 		}
 		ret = iio_storage_bytes_for_si(indio_dev, in_ind);
 		if (ret < 0)
@@ -1646,6 +1641,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 					     int index)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	unsigned int masklength = iio_get_masklength(indio_dev);
 	struct iio_dev_attr *p;
 	const struct iio_dev_attr *id_attr;
 	struct attribute **attr;
@@ -1708,8 +1704,8 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 				iio_dev_opaque->scan_index_timestamp =
 					channels[i].scan_index;
 		}
-		if (indio_dev->masklength && !buffer->scan_mask) {
-			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
+		if (masklength && !buffer->scan_mask) {
+			buffer->scan_mask = bitmap_zalloc(masklength,
 							  GFP_KERNEL);
 			if (!buffer->scan_mask) {
 				ret = -ENOMEM;
@@ -1879,7 +1875,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask)
 {
-	return bitmap_weight(mask, indio_dev->masklength) == 1;
+	return bitmap_weight(mask, iio_get_masklength(indio_dev)) == 1;
 }
 EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
 

-- 
2.45.2




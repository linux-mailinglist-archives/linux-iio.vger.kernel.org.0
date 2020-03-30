Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD578197F24
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgC3O5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:57:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgC3O5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:57:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id c81so20254979wmd.4
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2020 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fIaXa8uK/WZTy8opHuTaH+q3Qa7m/kORnCdBZQVGvYo=;
        b=CmgboEZifRwMbontnP+q9feUUpsOFLN35CSGlS7zvTg75farBF7GsQAS+ufTN2Csai
         pYMhuEn/YRBYUMA2sexG1MafbO+m3tzBumXJoJ0+h53VqghkkerkJAq1Cc5cjAzKCVgf
         /SeIptw23BWFCsfBRFEd21nBGVoV9oCh9XguRLHtKYRTb59RxWITrWuXUdvDG5usebG6
         o4m4kQaYAGPi/6wdOBPh7JTMFVCUVXjIGc7Yv6AgvnjieWeuPwMk0brZDh9MWGPKSZIH
         aQ28cLUD1LbQQKROWLjw9Y6gC4LKykNwe+zb598EjXP11d5q94obqhYkSsDgk1CBUsar
         XeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIaXa8uK/WZTy8opHuTaH+q3Qa7m/kORnCdBZQVGvYo=;
        b=fYJsj8nVSxuRhtw3MEgC4XnnW26Zm7NR6EzVwG+PJM+wPHWwteCuuS35Al8OGHclYa
         KUzlD9SQ35b0L5sodGFKStfymhb9r0bpByIsO1V16Qlfon8N1LeNAjdGZkn1Hty13rwv
         FzheuWc+X0WeWVCpa98uDvOOosydRe1n3eu98oeTdJCtAhxsbYd9n23WY/GvBOmzaARP
         sA1bVlnQRjkkNxV4Hu9YXIi/UNwxonvESJ0eYDf1xN0Z4xDSlDz5lO6MPG1XxFf7KFZV
         qTwlja7aM9FGs+t3pjB2RStRDzGXk7yMIJ6kLKHylKmDqqVHPTDiaNZwFgr7UOtEgMDM
         x+vQ==
X-Gm-Message-State: ANhLgQ280IlytusNGuLdk6SuY3CUpM6fHw34sG9xMGZWfxxE+RRCToXd
        3pGllHEdPNtS28Wr3/whArMWbUIu
X-Google-Smtp-Source: ADFU+vujkyrGB/kdj6QDk87hgyyCY+bgOhC73SMqp29Dw0jLI6w/wO4R0okxHhBlwSo09hbkGF7sEA==
X-Received: by 2002:a1c:51:: with SMTP id 78mr13141747wma.157.1585580229319;
        Mon, 30 Mar 2020 07:57:09 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id y200sm21584944wmc.20.2020.03.30.07.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:57:08 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
        lars@metafoo.de, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 1/3] iio: core: rename 'indio_dev->buffer_list' -> 'indio_dev->active_buffers'
Date:   Mon, 30 Mar 2020 17:57:03 +0300
Message-Id: <20200330145705.29447-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330145705.29447-1-alexandru.ardelean@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since we want to add support for attaching multiple buffers, and we want to
add a new list to 'struct iio_dev', it's a good idea to rename the current
'indio->buffer_list' to 'indio_dev->active_buffers'.

Fortunately, this is a private field, which is used in
'drivers/iio/industrial-buffer.c', so this is simple to rename.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 28 ++++++++++++++--------------
 drivers/iio/industrialio-core.c   |  2 +-
 include/linux/iio/iio.h           |  4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e6fa1a4e135d..a585c304cad4 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -591,7 +591,7 @@ static void iio_buffer_activate(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer)
 {
 	iio_buffer_get(buffer);
-	list_add(&buffer->buffer_list, &indio_dev->buffer_list);
+	list_add(&buffer->buffer_list, &indio_dev->active_buffers);
 }
 
 static void iio_buffer_deactivate(struct iio_buffer *buffer)
@@ -606,7 +606,7 @@ static void iio_buffer_deactivate_all(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer, *_buffer;
 
 	list_for_each_entry_safe(buffer, _buffer,
-			&indio_dev->buffer_list, buffer_list)
+			&indio_dev->active_buffers, buffer_list)
 		iio_buffer_deactivate(buffer);
 }
 
@@ -701,12 +701,12 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	 * to verify.
 	 */
 	if (remove_buffer && !insert_buffer &&
-		list_is_singular(&indio_dev->buffer_list))
+		list_is_singular(&indio_dev->active_buffers))
 			return 0;
 
 	modes = indio_dev->modes;
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
 		if (buffer == remove_buffer)
 			continue;
 		modes &= buffer->access->modes;
@@ -727,7 +727,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		 * Keep things simple for now and only allow a single buffer to
 		 * be connected in hardware mode.
 		 */
-		if (insert_buffer && !list_empty(&indio_dev->buffer_list))
+		if (insert_buffer && !list_empty(&indio_dev->active_buffers))
 			return -EINVAL;
 		config->mode = INDIO_BUFFER_HARDWARE;
 		strict_scanmask = true;
@@ -747,7 +747,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 
 	scan_timestamp = false;
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
 		if (buffer == remove_buffer)
 			continue;
 		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
@@ -896,7 +896,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer;
 	int ret;
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
 		ret = iio_buffer_update_demux(indio_dev, buffer);
 		if (ret < 0)
 			goto error_clear_mux_table;
@@ -904,7 +904,7 @@ static int iio_update_demux(struct iio_dev *indio_dev)
 	return 0;
 
 error_clear_mux_table:
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list)
 		iio_buffer_demux_free(buffer);
 
 	return ret;
@@ -948,7 +948,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		indio_dev->info->hwfifo_set_watermark(indio_dev,
 			config->watermark);
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
 		ret = iio_buffer_enable(buffer, indio_dev);
 		if (ret)
 			goto err_disable_buffers;
@@ -968,7 +968,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	return 0;
 
 err_disable_buffers:
-	list_for_each_entry_continue_reverse(buffer, &indio_dev->buffer_list,
+	list_for_each_entry_continue_reverse(buffer, &indio_dev->active_buffers,
 					     buffer_list)
 		iio_buffer_disable(buffer, indio_dev);
 err_run_postdisable:
@@ -988,7 +988,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 	int ret2;
 
 	/* Wind down existing buffers - iff there are any */
-	if (list_empty(&indio_dev->buffer_list))
+	if (list_empty(&indio_dev->active_buffers))
 		return 0;
 
 	/*
@@ -1004,7 +1004,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 			ret = ret2;
 	}
 
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buffer, &indio_dev->active_buffers, buffer_list) {
 		ret2 = iio_buffer_disable(buffer, indio_dev);
 		if (ret2 && !ret)
 			ret = ret2;
@@ -1052,7 +1052,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		iio_buffer_activate(indio_dev, insert_buffer);
 
 	/* If no buffers in list, we are done */
-	if (list_empty(&indio_dev->buffer_list))
+	if (list_empty(&indio_dev->active_buffers))
 		return 0;
 
 	ret = iio_enable_buffers(indio_dev, &new_config);
@@ -1413,7 +1413,7 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 	int ret;
 	struct iio_buffer *buf;
 
-	list_for_each_entry(buf, &indio_dev->buffer_list, buffer_list) {
+	list_for_each_entry(buf, &indio_dev->active_buffers, buffer_list) {
 		ret = iio_push_to_buffer(buf, data);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 157d95a24faa..a13957644c1d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1523,7 +1523,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 			return NULL;
 		}
 		dev_set_name(&dev->dev, "iio:device%d", dev->id);
-		INIT_LIST_HEAD(&dev->buffer_list);
+		INIT_LIST_HEAD(&dev->active_buffers);
 	}
 
 	return dev;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e975020abaa6..a123f8acb192 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -490,7 +490,7 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
- * @buffer_list:	[INTERN] list of all buffers currently attached
+ * @active_buffers:	[INTERN] list of all buffers currently enabled/active
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
@@ -534,7 +534,7 @@ struct iio_dev {
 	struct iio_event_interface	*event_interface;
 
 	struct iio_buffer		*buffer;
-	struct list_head		buffer_list;
+	struct list_head		active_buffers;
 	int				scan_bytes;
 	struct mutex			mlock;
 
-- 
2.20.1


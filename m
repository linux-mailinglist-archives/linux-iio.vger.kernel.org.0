Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010894A7292
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiBBOCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiBBOCV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:21 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65009C061714
        for <linux-iio@vger.kernel.org>; Wed,  2 Feb 2022 06:02:21 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4BAD4200004;
        Wed,  2 Feb 2022 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54lkbiUOUtFbbsDCt5nxtddUwiAiARkbTVaGUdXwcOM=;
        b=nfiQx85idCEL8pQQyIOfmIv9avYe5ZSJwHdbmFA7j1NtMDa3tmWTEhf7kyP2KYJw4OVgBN
        fLfbfsn7ka10pxh7bFEzw8jMiIVzFKCLSgzxSt7UqR/XrJMtGDjU+OILvEALL+5A1wCUG4
        r4xGCLfcTKB6KSfBVB/aDq81KDTq4KwdlkCOk0UgQroDdScqzMF6lSt3+aFHl8tzHlZvuz
        d73aelIIf3niNu5ZY4NOdpVH0ydfzwm7kZJeVg/mJ5REYMBlHdtPbjb6CAPPxbE/wIIB8s
        XI8NLPeJne3MX6AS+VhzT2IZPO97Yf5jCeb3dGqGckTCtfwQMIEv5JVyJ0lKVA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 10/12] iio: core: Move the currentmode entry to the opaque structure
Date:   Wed,  2 Feb 2022 15:02:06 +0100
Message-Id: <20220202140208.391394-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This entry should, under no situation, be modified by device
drivers. Now that we have limited its read access to device drivers
really needing it and did so through a dedicated helper, we can
easily move this variable to the opaque structure in order to
prevent any further modification from non-authorized code (out of the
core, basically).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/industrialio-buffer.c  | 12 ++++++------
 drivers/iio/industrialio-core.c    | 10 +++++++---
 drivers/iio/industrialio-trigger.c |  2 +-
 include/linux/iio/iio-opaque.h     |  4 ++++
 include/linux/iio/iio.h            |  4 ----
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 94eb9f6cf128..2a5a09693b08 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1065,7 +1065,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	indio_dev->active_scan_mask = config->scan_mask;
 	indio_dev->scan_timestamp = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
-	indio_dev->currentmode = config->mode;
+	iio_dev_opaque->currentmode = config->mode;
 
 	iio_update_demux(indio_dev);
 
@@ -1101,7 +1101,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 			goto err_disable_buffers;
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
 		ret = iio_trigger_attach_poll_func(indio_dev->trig,
 						   indio_dev->pollfunc);
 		if (ret)
@@ -1120,7 +1120,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	return 0;
 
 err_detach_pollfunc:
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
 		iio_trigger_detach_poll_func(indio_dev->trig,
 					     indio_dev->pollfunc);
 	}
@@ -1132,7 +1132,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
 err_undo_config:
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
+	iio_dev_opaque->currentmode = INDIO_DIRECT_MODE;
 	indio_dev->active_scan_mask = NULL;
 
 	return ret;
@@ -1162,7 +1162,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 			ret = ret2;
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
 		iio_trigger_detach_poll_func(indio_dev->trig,
 					     indio_dev->pollfunc);
 	}
@@ -1181,7 +1181,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 
 	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
 	indio_dev->active_scan_mask = NULL;
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
+	iio_dev_opaque->currentmode = INDIO_DIRECT_MODE;
 
 	return ret;
 }
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f8fcfe12dfa2..b757273e6652 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -190,7 +190,9 @@ EXPORT_SYMBOL_GPL(iio_device_id);
  */
 bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
-	return indio_dev->currentmode
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	return iio_dev_opaque->currentmode
 		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
 		   INDIO_BUFFER_SOFTWARE);
 }
@@ -2073,12 +2075,14 @@ EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
 
 /**
  * iio_device_get_current_mode() - helper function providing read-only access to
- *				   the @currentmode variable
+ *				   the opaque @currentmode variable
  * @indio_dev:			   IIO device structure for device
  */
 int iio_device_get_current_mode(struct iio_dev *indio_dev)
 {
-	return indio_dev->currentmode;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	return iio_dev_opaque->currentmode;
 }
 EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
 
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..585b6cef8fcc 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -444,7 +444,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	int ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 2be12b7b5dc5..6b3586b3f952 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -7,6 +7,9 @@
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
  * @id:			used to identify device internally
+ * @currentmode:		operating mode currently in use, may be eventually
+ *				checked by device drivers but should be considered
+ *				read-only as this is a core internal bit
  * @driver_module:		used to make it harder to undercut users
  * @info_exist_lock:		lock to prevent use during removal
  * @trig_readonly:		mark the current trigger immutable
@@ -36,6 +39,7 @@
  */
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
+	int				currentmode;
 	int				id;
 	struct module			*driver_module;
 	struct mutex			info_exist_lock;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 31098ffa7dc9..85cb924debd9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -494,9 +494,6 @@ struct iio_buffer_setup_ops {
  *			also be filed up by the IIO core, as a result of
  *			enabling particular features in the driver
  *			(see iio_triggered_event_setup()).
- * @currentmode:	[INTERN] operating mode currently in use, may be
- *			eventually checked by device drivers but should be
- *			considered read-only as this is a core internal bit
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @buffer:		[DRIVER] any buffer present
@@ -523,7 +520,6 @@ struct iio_buffer_setup_ops {
  */
 struct iio_dev {
 	int				modes;
-	int				currentmode;
 	struct device			dev;
 
 	struct iio_buffer		*buffer;
-- 
2.27.0


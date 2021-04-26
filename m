Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3698E36B851
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhDZRvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237456AbhDZRvU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BED1661007;
        Mon, 26 Apr 2021 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459438;
        bh=TpO0tlWZAgzLPF0zY06lQwcFnXhSyZDGtnwvKLikdtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GK+B3OXvAsEAlb+qGIQJ14Z1wEe2b5mFp5Q1rAJvWtolkKmfMPh/qAoltdwU5Jtm9
         3LxN+Wacmal42JNFY508hl6uEtWbZ25nvTY+Ce2+JROmFkhG+bUC7JnV/f5UKAXKk/
         ppK4b+dPnnhPYNYTLZrup9B7UzcWCPlQRpQ2jYJJKGF9OveNQxBKs+qWtXItHqjJ72
         1/zCeTBn//xym9AlB4MsWYE4ZIl3wlgHmAXOAAO9vBeABFBUymTOOgvRC0abfBHbBI
         Z0flcxcom2jgcve8Km7PYMpVhKcXBeArN7Xf8DLNRVK7eeyZhLg25VZBep06KNpVhW
         kUOdCAWpVJhsg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/9] iio: core: move @trig_readonly from struct iio_dev to struct iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:06 +0100
Message-Id: <20210426174911.397061-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is only set via the iio_trig_set_immutable() call and later used
by the IIO core so there is no benefit in drivers being able to access
it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-trigger.c | 10 +++++++---
 include/linux/iio/iio-opaque.h     |  2 ++
 include/linux/iio/iio.h            |  2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b489eeeb0004..b23caa2f2aa1 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -117,14 +117,17 @@ EXPORT_SYMBOL(iio_trigger_unregister);
 
 int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig)
 {
+	struct iio_dev_opaque *iio_dev_opaque;
+
 	if (!indio_dev || !trig)
 		return -EINVAL;
 
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	mutex_lock(&indio_dev->mlock);
-	WARN_ON(indio_dev->trig_readonly);
+	WARN_ON(iio_dev_opaque->trig_readonly);
 
 	indio_dev->trig = iio_trigger_get(trig);
-	indio_dev->trig_readonly = true;
+	iio_dev_opaque->trig_readonly = true;
 	mutex_unlock(&indio_dev->mlock);
 
 	return 0;
@@ -402,6 +405,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 					 size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_trigger *oldtrig = indio_dev->trig;
 	struct iio_trigger *trig;
 	int ret;
@@ -411,7 +415,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
-	if (indio_dev->trig_readonly) {
+	if (iio_dev_opaque->trig_readonly) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EPERM;
 	}
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 96dd265103d0..10aa97239117 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -8,6 +8,7 @@
  * @indio_dev:			public industrial I/O device information
  * @id:			used to identify device internally
  * @driver_module:		used to make it harder to undercut users
+ * @trig_readonly:		mark the current trigger immutable
  * @event_interface:		event chrdevs associated with interrupt lines
  * @attached_buffers:		array of buffers statically attached by the driver
  * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
@@ -30,6 +31,7 @@ struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
 	int				id;
 	struct module			*driver_module;
+	bool				trig_readonly;
 	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
 	unsigned int			attached_buffers_cnt;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9e8e1358a032..672f141f74c5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -503,7 +503,6 @@ struct iio_buffer_setup_ops {
  * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
  * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @trig:		[INTERN] current device trigger (buffer modes)
- * @trig_readonly:	[INTERN] mark the current trigger immutable
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @pollfunc_event:	[DRIVER] function run on events trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -535,7 +534,6 @@ struct iio_dev {
 	bool				scan_timestamp;
 	unsigned			scan_index_timestamp;
 	struct iio_trigger		*trig;
-	bool				trig_readonly;
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
 
-- 
2.31.1


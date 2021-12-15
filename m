Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73846475B9A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbhLOPNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:53 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:39103 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbhLOPNw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:52 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F0C7020000E;
        Wed, 15 Dec 2021 15:13:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 07/10] iio: core: Hide write accesses to iio_dev->currentmode
Date:   Wed, 15 Dec 2021 16:13:41 +0100
Message-Id: <20211215151344.163036-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to later move this variable within the opaque structure and now
that there is a read-only helper for it, let's create a write helper.

The idea behind these changes is to limit the temptation of using
->currentmode directly, and this will soon be fully addressed by making
the modification to this variable impossible from a device driver by
moving it to the opaque structure. But for now, let's just do a
transparent change and use a new helper when ->currentmode needs to be
accessed for modifications.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/industrialio-buffer.c |  6 +++---
 drivers/iio/industrialio-core.c   | 11 +++++++++++
 include/linux/iio/iio.h           |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f4dbab7c44fa..190f9cc5fb2c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1065,7 +1065,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	indio_dev->active_scan_mask = config->scan_mask;
 	indio_dev->scan_timestamp = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
-	indio_dev->currentmode = config->mode;
+	iio_set_internal_mode(indio_dev, config->mode);
 
 	iio_update_demux(indio_dev);
 
@@ -1132,7 +1132,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
 err_undo_config:
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
+	iio_set_internal_mode(indio_dev, INDIO_DIRECT_MODE);
 	indio_dev->active_scan_mask = NULL;
 
 	return ret;
@@ -1181,7 +1181,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 
 	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
 	indio_dev->active_scan_mask = NULL;
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
+	iio_set_internal_mode(indio_dev, INDIO_DIRECT_MODE);
 
 	return ret;
 }
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a1d6e30d034a..5c7e0c9e1f59 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2068,6 +2068,17 @@ int iio_get_internal_mode(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_get_internal_mode);
 
+/**
+ * iio_set_internal_mode() - helper function providing write-only access to the
+ *			     internal @currentmode variable
+ * @indio_dev:		IIO device structure for device
+ **/
+void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
+{
+	indio_dev->currentmode = mode;
+}
+EXPORT_SYMBOL_GPL(iio_set_internal_mode);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index dcab17f44552..27551d251904 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -679,6 +679,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
 
 int iio_get_internal_mode(struct iio_dev *indio_dev);
+void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
 
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
-- 
2.27.0


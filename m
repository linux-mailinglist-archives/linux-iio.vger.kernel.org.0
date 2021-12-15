Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2FE475B9B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhLOPNy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:54 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:35819 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243841AbhLOPNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:53 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E2A6F200015;
        Wed, 15 Dec 2021 15:13:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 08/10] iio: core: Move iio_dev->currentmode to the opaque structure
Date:   Wed, 15 Dec 2021 16:13:42 +0100
Message-Id: <20211215151344.163036-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This entry should, under no situation, be modified by device
drivers. Now that we have limited its read access to device drivers
really needing it, and handled modifications through another dedicated
helper within the core, we can easily move this variable to the opaque
structure as well as the write helper in order to prevent device driver
from playing with it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/industrialio-core.c | 15 +++------------
 include/linux/iio/iio-opaque.h  | 16 ++++++++++++++++
 include/linux/iio/iio.h         |  5 -----
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5c7e0c9e1f59..9836a57ff151 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2064,21 +2064,12 @@ EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
  **/
 int iio_get_internal_mode(struct iio_dev *indio_dev)
 {
-	return indio_dev->currentmode;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	return iio_dev_opaque->currentmode;
 }
 EXPORT_SYMBOL_GPL(iio_get_internal_mode);
 
-/**
- * iio_set_internal_mode() - helper function providing write-only access to the
- *			     internal @currentmode variable
- * @indio_dev:		IIO device structure for device
- **/
-void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
-{
-	indio_dev->currentmode = mode;
-}
-EXPORT_SYMBOL_GPL(iio_set_internal_mode);
-
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 2be12b7b5dc5..72f35270a387 100644
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
@@ -71,4 +75,16 @@ struct iio_dev_opaque {
 #define to_iio_dev_opaque(_indio_dev)		\
 	container_of((_indio_dev), struct iio_dev_opaque, indio_dev)
 
+/**
+ * iio_set_internal_mode() - helper function providing write-only access to the
+ *			     internal @currentmode variable
+ * @indio_dev:		IIO device structure for device
+ **/
+static inline void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	iio_dev_opaque->currentmode = mode;
+}
+
 #endif
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 27551d251904..d04ab89fa0c2 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -492,9 +492,6 @@ struct iio_buffer_setup_ops {
  *			registering the IIO device and can be filed up by the
  *			IIO core depending on the features advertised by the
  *			driver during other steps of the registration
- * @currentmode:	[INTERN] operating mode currently in use, may be
- *			eventually checked by device drivers but should be
- *			considered read-only as this is a core internal bit
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @buffer:		[DRIVER] any buffer present
@@ -521,7 +518,6 @@ struct iio_buffer_setup_ops {
  */
 struct iio_dev {
 	int				modes;
-	int				currentmode;
 	struct device			dev;
 
 	struct iio_buffer		*buffer;
@@ -679,7 +675,6 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
 
 int iio_get_internal_mode(struct iio_dev *indio_dev);
-void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
 
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
-- 
2.27.0


Return-Path: <linux-iio+bounces-8141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B32945F5F
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8994282748
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E118B48C;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQRyTdO7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A57200102
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=q9TlMBUIK4TLDqx/dHvmNRaDQCmPX2u1GMJz8aSFVqAqRHVKGIfmVVErBHKQphmxaCyGg4+E8bTQsuY2UuqrOgsdP7LRqcqZiUCYVNlK2wl+2qkI13IA28yypf5PtxOZaE1o68GP5OSF9Tr8DUCNWXHoXLjJIUwJxNkb4aS13lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=BZDlAk8Wm2QMWNQDVQ7q+eRUAvHFgtUzJMbUrkJJWKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7C9NEFDKWnFaDk3Il2NgULn+PZ9JHoWOPqqniSTbPyKN3T8/luHynvl3YiDIlMIhy7p0LJ6FigL4ODjmQHMVmNFA8w7MkNLYxl2V0sEh6Yq0CqKFuxEAhBzOrzNqnC0GoeAQykkhH5A8vXAULVXrC5ly+sD/M4D9yClyM5HoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQRyTdO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 964BEC4AF0E;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=BZDlAk8Wm2QMWNQDVQ7q+eRUAvHFgtUzJMbUrkJJWKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DQRyTdO7xpsd40pmVpTxuNAXECQ0c9ZC3AxTdw0W4qptQmhazyT5VHwK5o0hm0/e8
	 Y5khIx4DyingIPM5crC38vZXfdWV7CzSwGQ556O8DAso6MF/TAknPYguVrYrM06m9Z
	 DBUoU+QD+CowLSxyaBEhE3Q2lFRUuJSXWA80l/FSNpYQtfaQzyG7TSU5SAp3PTVscs
	 GMK+Zn1zhE20b6C1ZbqsI4yRppExAVFasHOLhg+N7OzPUpiG4uIi5nx/b+1Yr1kyKF
	 GQIFLLiSKC2uSaucCrlkkViVg7FrlPPSu9j74UIYNyB3EFi53gaJsv14u6IWkqaFif
	 UWc1Lt1uaBEsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89182C52D71;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:00 +0200
Subject: [PATCH v2 2/8] iio: backend: add debugFs interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-2-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=8853;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fD0/XWI5OHLEOk1nmWEr7V7mRvj+jbAaYeKyy5Sww+c=;
 b=vLRGTWjitG37eJYi9c+2gDsBmVjd/0XHr5QjvyzsqE0iieJE576PAlQz5wont+KMPvz7f38o2
 jc7sI7P3VCgDxfd8lX3+y4M00lDKgHNlKTrIaCPlX3HGBFqfH+t/4U7
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This adds a basic debugfs interface for backends. Two new ops are being
added:

 * debugfs_reg_access: Analogous to the core IIO one but for backend
   devices.
 * debugfs_print_chan_status: One useful usecase for this one is for
   testing test tones in a digital interface and "ask" the backend to
   dump more details on why a test tone might have errors.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/ABI/testing/debugfs-iio-backend |  20 ++++
 MAINTAINERS                                   |   1 +
 drivers/iio/industrialio-backend.c            | 145 ++++++++++++++++++++++++++
 include/linux/iio/backend.h                   |  14 +++
 4 files changed, 180 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-iio-backend b/Documentation/ABI/testing/debugfs-iio-backend
new file mode 100644
index 000000000000..01ab94469432
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-iio-backend
@@ -0,0 +1,20 @@
+What:		/sys/kernel/debug/iio/iio:deviceX/backendY/name
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Name of Backend Y connected to device X.
+
+What:		/sys/kernel/debug/iio/iio:deviceX/backendY/direct_reg_access
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Directly access the registers of backend Y. Typical usage is:
+
+		Reading address 0x50
+		echo 0x50 > direct_reg_access
+		cat direct_reg_access
+
+		Writing address 0x50
+		echo 0x50 0x3 > direct_reg_access
+		//readback address 0x50
+		cat direct_reg_access
diff --git a/MAINTAINERS b/MAINTAINERS
index cd677bcc54da..c28bcbc94725 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10885,6 +10885,7 @@ M:	Nuno Sa <nuno.sa@analog.com>
 R:	Olivier Moysan <olivier.moysan@foss.st.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-iio-backend
 F:	drivers/iio/industrialio-backend.c
 F:	include/linux/iio/backend.h
 
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 0cf80ffd2e61..468eadeaf23d 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -32,6 +32,7 @@
 #define dev_fmt(fmt) "iio-backend: " fmt
 
 #include <linux/cleanup.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -53,6 +54,14 @@ struct iio_backend {
 	struct device *dev;
 	struct module *owner;
 	void *priv;
+	const char *name;
+	unsigned int cached_reg_addr;
+	/*
+	 * This index is relative to the frontend. Meaning that for
+	 * frontends with multiple backends, this will be the index of this
+	 * backend. Used for the debugfs directory name.
+	 */
+	u8 idx;
 };
 
 /*
@@ -117,6 +126,138 @@ static DEFINE_MUTEX(iio_back_lock);
 			__stringify(op));			\
 }
 
+static ssize_t iio_backend_debugfs_read_reg(struct file *file,
+					    char __user *userbuf,
+					    size_t count, loff_t *ppos)
+{
+	struct iio_backend *back = file->private_data;
+	char read_buf[20];
+	unsigned int val;
+	int ret, len;
+
+	ret = iio_backend_op_call(back, debugfs_reg_access,
+				  back->cached_reg_addr, 0, &val);
+	if (ret)
+		return ret;
+
+	len = scnprintf(read_buf, sizeof(read_buf), "0x%X\n", val);
+
+	return simple_read_from_buffer(userbuf, count, ppos, read_buf, len);
+}
+
+static ssize_t iio_backend_debugfs_write_reg(struct file *file,
+					     const char __user *userbuf,
+					     size_t count, loff_t *ppos)
+{
+	struct iio_backend *back = file->private_data;
+	unsigned int val;
+	char buf[80];
+	ssize_t rc;
+	int ret;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf, count);
+	if (rc < 0)
+		return rc;
+
+	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
+
+	switch (ret) {
+	case 1:
+		return count;
+	case 2:
+		ret = iio_backend_op_call(back, debugfs_reg_access,
+					  back->cached_reg_addr, val, NULL);
+		if (ret)
+			return ret;
+		return count;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations iio_backend_debugfs_reg_fops = {
+	.open = simple_open,
+	.read = iio_backend_debugfs_read_reg,
+	.write = iio_backend_debugfs_write_reg,
+};
+
+static ssize_t iio_backend_debugfs_read_name(struct file *file,
+					     char __user *userbuf,
+					     size_t count, loff_t *ppos)
+{
+	struct iio_backend *back = file->private_data;
+	char name[128];
+	int len;
+
+	len = scnprintf(name, sizeof(name), "%s\n", back->name);
+
+	return simple_read_from_buffer(userbuf, count, ppos, name, len);
+}
+
+static const struct file_operations iio_backend_debugfs_name_fops = {
+	.open = simple_open,
+	.read = iio_backend_debugfs_read_name,
+};
+
+/**
+ * iio_backend_debugfs_add - Add debugfs interfaces for Backends
+ * @back: Backend device
+ * @indio_dev: IIO device
+ */
+void iio_backend_debugfs_add(struct iio_backend *back,
+			     struct iio_dev *indio_dev)
+{
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct dentry *back_d;
+	char name[128];
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS) || !d)
+		return;
+	if (!back->ops->debugfs_reg_access && !back->name)
+		return;
+
+	snprintf(name, sizeof(name), "backend%d", back->idx);
+
+	back_d = debugfs_create_dir(name, d);
+	if (!back_d)
+		return;
+
+	if (back->ops->debugfs_reg_access)
+		debugfs_create_file("direct_reg_access", 0600, back_d, back,
+				    &iio_backend_debugfs_reg_fops);
+
+	if (back->name)
+		debugfs_create_file("name", 0400, back_d, back,
+				    &iio_backend_debugfs_name_fops);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_debugfs_add, IIO_BACKEND);
+
+/**
+ * iio_backend_debugfs_print_chan_status - Print channel status
+ * @back: Backend device
+ * @chan: Channel number
+ * @buf: Buffer where to print the status
+ * @len: Available space
+ *
+ * One usecase where this is useful is for testing test tones in a digital
+ * interface and "ask" the backend to dump more details on why a test tone might
+ * have errors.
+ *
+ * RETURNS:
+ * Number of copied bytes on success, negative error code on failure.
+ */
+ssize_t iio_backend_debugfs_print_chan_status(struct iio_backend *back,
+					      unsigned int chan, char *buf,
+					      size_t len)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return -ENODEV;
+
+	return iio_backend_op_call(back, debugfs_print_chan_status, chan, buf,
+				   len);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_debugfs_print_chan_status, IIO_BACKEND);
+
 /**
  * iio_backend_chan_enable - Enable a backend channel
  * @back: Backend device
@@ -577,6 +718,9 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 		if (ret)
 			return ERR_PTR(ret);
 
+		if (name)
+			back->idx = index;
+
 		return back;
 	}
 
@@ -668,6 +812,7 @@ int devm_iio_backend_register(struct device *dev,
 		return -ENOMEM;
 
 	back->ops = info->ops;
+	back->name = info->name;
 	back->owner = dev->driver->owner;
 	back->dev = dev;
 	back->priv = priv;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index f120fa2e0a43..9d0dba7ab9e7 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -22,6 +22,8 @@ enum iio_backend_data_source {
 	IIO_BACKEND_DATA_SOURCE_MAX
 };
 
+#define iio_backend_debugfs_ptr(ptr)	PTR_IF(IS_ENABLED(CONFIG_DEBUG_FS), ptr)
+
 /**
  * IIO_BACKEND_EX_INFO - Helper for an IIO extended channel attribute
  * @_name: Attribute name
@@ -81,6 +83,8 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @debugfs_print_chan_status: Print channel status into a buffer.
+ * @debugfs_reg_access: Read or write register value of backend.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +117,11 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*debugfs_print_chan_status)(struct iio_backend *back,
+					 unsigned int chan, char *buf,
+					 size_t len);
+	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
+				  unsigned int writeval, unsigned int *readval);
 };
 
 /**
@@ -163,4 +172,9 @@ __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 int devm_iio_backend_register(struct device *dev,
 			      const struct iio_backend_info *info, void *priv);
 
+ssize_t iio_backend_debugfs_print_chan_status(struct iio_backend *back,
+					      unsigned int chan, char *buf,
+					      size_t len);
+void iio_backend_debugfs_add(struct iio_backend *back,
+			     struct iio_dev *indio_dev);
 #endif

-- 
2.45.2




Return-Path: <linux-iio+bounces-760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C8D80A715
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9A9281C38
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555B3159F;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7ujl4oU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BC6286A6;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADCABC43215;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048450;
	bh=H2gtlQ6Zzoeth9ElZdqz3cf+dkbNxVLOUrVSAv3m37s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s7ujl4oUVT5pnOgvIPAmSm6bFIYf6FB5gcXfWxZuVoNXJOU1f6WHCelqIh4zYTZ9V
	 NCudFmUI4lN/0PW4PehcwUhM1oVRt2TATrAmi0fhR6H5sj7RrxCMINhag8zIpjs9yv
	 EK3QtWbg5MiNJVQ9cl4tFcbDdEK4gB/G1gMEQw+jJ3VoXcEDkw9Td28+fx5oJKPe+J
	 qijW30cNicYqTXMRRI/zVh+roEUbLqJ07FsZMMNKNAndAYGxcs81vvU7Tb79lHkaKI
	 uDro4Wpno4fO7WjCXWEo7s7mjg8iLJ4NtCgsg/GQfXpugkyIvMbZRfuVa5bQ+uYL69
	 lLPRCkMTBPh3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B025C4167B;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Dec 2023 16:14:13 +0100
Subject: [PATCH v2 6/8] iio: add the IIO backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-dev-iio-backend-v2-6-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
In-Reply-To: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702048448; l=16660;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gXxm+BaOfbgEiRCFJUeqdjZePnZ90HgQhjAjUUE5m5k=;
 b=PV1mxMByDM1t0jQ45uwMs6OVEQyfd9HFYzMkEOJaT73iaURlfw9H3RNG82gqjfdkHkq4kxPjk
 ttjBuPruXR0DFshAk4fV0BVG9gPUb2t0W+FoMWvEdoGpy0aVQJNCLxk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

This is a Framework to handle complex IIO aggregate devices.

The typical architecture is to have one device as the frontend device which
can be "linked" against one or multiple backend devices. All the IIO and
userspace interface is expected to be registers/managed by the frontend
device which will callback into the backends when needed (to get/set
some configuration that it does not directly control).

The basic framework interface is pretty simple:
 - Backends should register themselves with @devm_iio_backend_register()
 - Frontend devices should get backends with @devm_iio_backend_get()

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 MAINTAINERS                        |   8 +
 drivers/iio/Kconfig                |   5 +
 drivers/iio/Makefile               |   1 +
 drivers/iio/industrialio-backend.c | 386 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  68 +++++++
 5 files changed, 468 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1338e1176ea5..637ce907dcbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10320,6 +10320,14 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
 
+IIO BACKEND FRAMEWORK
+M:	Nuno Sa <nuno.sa@analog.com>
+R:	Olivier Moysan <olivier.moysan@foss.st.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/industrialio-backend.c
+F:	include/linux/iio/backend.h
+
 IIO DIGITAL POTENTIOMETER DAC
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 52eb46ef84c1..451671112f73 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -71,6 +71,11 @@ config IIO_TRIGGERED_EVENT
 	help
 	  Provides helper functions for setting up triggered events.
 
+config IIO_BACKEND
+	tristate
+	help
+	  Framework to handle complex IIO aggregate devices.
+
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/addac/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 9622347a1c1b..0ba0e1521ba4 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
 obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
 obj-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
 obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
+obj-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
 
 obj-y += accel/
 obj-y += adc/
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
new file mode 100644
index 000000000000..3400b3b5a93b
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Framework to handle complex IIO aggregate devices.
+ *
+ * The typical architecture is to have one device as the frontend device which
+ * can be "linked" against one or multiple backend devices. All the IIO and
+ * userspace interface is expected to be registers/managed by the frontend
+ * device which will callback into the backends when needed (to get/set some
+ * configuration that it does not directly control).
+ *
+ * The framework interface is pretty simple:
+ *   - Backends should register themselves with @devm_iio_backend_register()
+ *   - Frontend devices should get backends with @devm_iio_backend_get()
+ *
+ * Also to note that the primary target for this framework are converters like
+ * ADC/DACs so @iio_backend_ops will have some operations typical of converter
+ * devices. On top of that, this is "generic" for all IIO which means any kind
+ * of device can make use of the framework. That said, If the @iio_backend_ops
+ * struct begins to grow out of control, we can always refactor things so that
+ * the industrialio-backend.c is only left with the really generic stuff. Then,
+ * we can build on top of it depending on the needs.
+ *
+ * Copyright (C) 2023 Analog Devices Inc.
+ */
+#define pr_fmt(fmt) "iio-backend: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include <linux/iio/backend.h>
+
+struct iio_backend {
+	struct list_head entry;
+	const struct iio_backend_ops *ops;
+	struct device *dev;
+	struct module *owner;
+	void *priv;
+	/*
+	 * mutex used to synchronize backend callback access with concurrent
+	 * calls to @iio_backend_unregister. The lock makes sure a device is
+	 * not unregistered while a callback is being run.
+	 */
+	struct mutex lock;
+	struct kref ref;
+};
+
+/*
+ * Helper struct for requesting buffers. Allows for multiple buffers per
+ * backend.
+ */
+struct iio_backend_buffer_pair {
+	struct iio_backend *back;
+	struct iio_buffer *buffer;
+};
+
+static LIST_HEAD(iio_back_list);
+static DEFINE_MUTEX(iio_back_lock);
+
+/*
+ * Helper macros to properly call backend ops. The main point for these macros
+ * is to properly lock the backend mutex on every call plus checking if the
+ * backend device is still around (by looking at the *ops pointer).
+ */
+
+#define iio_backend_check_op(back, op) ({ \
+	struct iio_backend *____back = back;				\
+	int ____ret = 0;						\
+									\
+	lockdep_assert_held(&____back->lock);				\
+	if (!____back->ops) {						\
+		pr_warn_once("Backend is no longer available\n");	\
+		____ret = -ENODEV;					\
+	} else if (!____back->ops->op) {				\
+		____ret = -EOPNOTSUPP;					\
+	}								\
+									\
+	____ret;								\
+})
+
+#define iio_backend_op_call(back, op, args...) ({		\
+	struct iio_backend *__back = back;			\
+	int __ret;						\
+								\
+	guard(mutex)(&__back->lock);				\
+	__ret = iio_backend_check_op(__back, op);		\
+	if (!__ret)						\
+		__ret = __back->ops->op(__back, ##args);	\
+								\
+	__ret;							\
+})
+
+#define iio_backend_ptr_op_call(back, op, args...) ({		\
+	struct iio_backend *__back = back;			\
+	void *ptr_err;						\
+	int __ret;						\
+								\
+	guard(mutex)(&__back->lock);				\
+	__ret = iio_backend_check_op(__back, op);		\
+	if (__ret)						\
+		ptr_err = ERR_PTR(__ret);			\
+	else							\
+		ptr_err = __back->ops->op(__back, ##args);	\
+								\
+	ptr_err;						\
+})
+
+#define iio_backend_void_op_call(back, op, args...) {		\
+	struct iio_backend *__back = back;			\
+	int __ret;						\
+								\
+	guard(mutex)(&__back->lock);				\
+	__ret = iio_backend_check_op(__back, op);		\
+	if (!__ret)						\
+		__back->ops->op(__back, ##args);		\
+}
+
+/**
+ * iio_backend_chan_enable - Enable a backend channel.
+ * @back:	Backend device.
+ * @chan:	Channel number.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan)
+{
+	return iio_backend_op_call(back, chan_enable, chan);
+}
+EXPORT_SYMBOL_GPL(iio_backend_chan_enable);
+
+/**
+ * iio_backend_chan_disable - Disable a backend channel.
+ * @back:	Backend device.
+ * @chan:	Channel number.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan)
+{
+	return iio_backend_op_call(back, chan_disable, chan);
+}
+EXPORT_SYMBOL_GPL(iio_backend_chan_disable);
+
+/**
+ * iio_backend_chan_enable - Enable the backend.
+ * @back:	Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, enable);
+}
+EXPORT_SYMBOL_GPL(iio_backend_enable);
+
+/**
+ * iio_backend_disable - Disable the backend.
+ * @back:	Backend device
+ */
+void iio_backend_disable(struct iio_backend *back)
+{
+	iio_backend_void_op_call(back, disable);
+}
+EXPORT_SYMBOL_GPL(iio_backend_disable);
+
+/**
+ * iio_backend_data_format_set - Configure the channel data format
+ * @back:	Backend device
+ * @chan:	Channel number.
+ * @data:	Data format.
+ *
+ * Properly configure a channel with respect to the expected data format. A
+ * @struct iio_backend_data_fmt must be passed with the settings.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure
+ */
+int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
+				const struct iio_backend_data_fmt *data)
+{
+	if (!data || data->type >= IIO_BACKEND_DATA_TYPE_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_format_set, chan, data);
+}
+EXPORT_SYMBOL_GPL(iio_backend_data_format_set);
+
+static void iio_backend_free_buffer(void *arg)
+{
+	struct iio_backend_buffer_pair *pair = arg;
+
+	iio_backend_void_op_call(pair->back, free_buffer, pair->buffer);
+}
+
+/**
+ * devm_iio_backend_request_buffer - Request an IIO buffer from the backend.
+ * @dev:	Device to bind the buffer lifetime.
+ * @back:	Backend device.
+ * @indio_dev:	IIO device.
+ *
+ * Request an IIO buffer from the backend. The type of the buffer (typically
+ * INDIO_BUFFER_HARDWARE) is up to the backend to decide. This is because,
+ * normally, the backend dictates what kind of buffering we can get.
+ *
+ * The backend .free_buffer() hooks is automatically called on @dev detach.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure
+ */
+int devm_iio_backend_request_buffer(struct device *dev,
+				    struct iio_backend *back,
+				    struct iio_dev *indio_dev)
+{
+	struct iio_backend_buffer_pair *pair;
+	struct iio_buffer *buffer;
+
+	buffer = iio_backend_ptr_op_call(back, request_buffer, indio_dev);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	/* backend lock should not be need after getting the buffer */
+	pair = devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
+	if (!pair)
+		return -ENOMEM;
+
+	/* weak reference should be all what we need */
+	pair->back = back;
+	pair->buffer = buffer;
+
+	return devm_add_action_or_reset(dev, iio_backend_free_buffer, pair);
+}
+EXPORT_SYMBOL_GPL(devm_iio_backend_request_buffer);
+
+static void iio_backend_free(struct kref *ref)
+{
+	struct iio_backend *back = container_of(ref, struct iio_backend, ref);
+
+	kfree(back);
+}
+
+static void iio_backend_release(void *arg)
+{
+	struct iio_backend *back = arg;
+
+	module_put(back->owner);
+	kref_put(&back->ref, iio_backend_free);
+}
+
+/**
+ * devm_iio_backend_get - Get a backend device
+ * @dev:	Device where to look for the backend.
+ * @name:	Backend name.
+ *
+ * Get's the backend associated with @dev.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
+{
+	struct fwnode_handle *fwnode;
+	struct iio_backend *back;
+	int index = 0, ret;
+
+	if (name) {
+		index = device_property_match_string(dev, "io-backends-names",
+						     name);
+		if (index < 0)
+			return ERR_PTR(index);
+	}
+
+	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
+	if (IS_ERR(fwnode)) {
+		dev_err(dev, "Cannot get Firmware reference\n");
+		return ERR_CAST(fwnode);
+	}
+
+	guard(mutex)(&iio_back_lock);
+	list_for_each_entry(back, &iio_back_list, entry) {
+		struct device_link *link;
+
+		if (!device_match_fwnode(back->dev, fwnode))
+			continue;
+
+		fwnode_handle_put(fwnode);
+		kref_get(&back->ref);
+		if (!try_module_get(back->owner)) {
+			dev_err(dev, "Cannot get module reference\n");
+			return ERR_PTR(-ENODEV);
+		}
+
+		ret = devm_add_action_or_reset(dev, iio_backend_release, back);
+		if (ret)
+			return ERR_PTR(ret);
+
+		link = device_link_add(dev, back->dev,
+				       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!link)
+			dev_warn(dev, "Could not link to supplier(%s)\n",
+				 dev_name(back->dev));
+
+		dev_dbg(dev, "Found backend(%s) device\n", dev_name(back->dev));
+		return back;
+	}
+
+	fwnode_handle_put(fwnode);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(devm_iio_backend_get);
+
+/**
+ * iio_backend_get_priv - Get driver private data
+ * @back:	Backend device
+ */
+void *iio_backend_get_priv(const struct iio_backend *back)
+{
+	return back->priv;
+}
+EXPORT_SYMBOL_GPL(iio_backend_get_priv);
+
+static void iio_backend_unregister(void *arg)
+{
+	struct iio_backend *back = arg;
+
+	mutex_lock(&iio_back_lock);
+	list_del(&back->entry);
+	mutex_unlock(&iio_back_lock);
+
+	mutex_lock(&back->lock);
+	back->ops = NULL;
+	mutex_unlock(&back->lock);
+	kref_put(&back->ref, iio_backend_free);
+}
+
+/**
+ * devm_iio_backend_register - Register a new backend device
+ * @dev:	Backend device being registered.
+ * @ops:	Backend ops
+ * @priv:	Device private data.
+ *
+ * @ops and @priv are both mandatory. Not providing them results in -EINVAL.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv)
+{
+	struct iio_backend *back;
+
+	if (!ops || !priv) {
+		dev_err(dev, "No backend ops or private data given\n");
+		return -EINVAL;
+	}
+
+	back = kzalloc(sizeof(*back), GFP_KERNEL);
+	if (!back)
+		return -ENOMEM;
+
+	kref_init(&back->ref);
+	mutex_init(&back->lock);
+	back->ops = ops;
+	back->owner = dev->driver->owner;
+	back->dev = dev;
+	back->priv = priv;
+	mutex_lock(&iio_back_lock);
+	list_add(&back->entry, &iio_back_list);
+	mutex_unlock(&iio_back_lock);
+
+	return devm_add_action_or_reset(dev, iio_backend_unregister, back);
+}
+EXPORT_SYMBOL_GPL(devm_iio_backend_register);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Framework to handle complex IIO aggregate devices");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
new file mode 100644
index 000000000000..d2555333cb19
--- /dev/null
+++ b/include/linux/iio/backend.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _IIO_BACKEND_H_
+#define _IIO_BACKEND_H_
+
+#include <linux/types.h>
+
+struct iio_backend;
+struct device;
+struct iio_dev;
+
+enum iio_backend_data_type {
+	IIO_BACKEND_TWOS_COMPLEMENT,
+	IIO_BACKEND_OFFSET_BINARY,
+	IIO_BACKEND_DATA_TYPE_MAX
+};
+
+/**
+ * struct iio_backend_data_fmt - Backend data format
+ * @type:		Data type.
+ * @sign_extend:	Bool to tell if the data is sign extended.
+ * @enable:		Enable/Disable the data format module. If disabled,
+ *			not formatting will happen.
+ */
+struct iio_backend_data_fmt {
+	enum iio_backend_data_type type;
+	bool sign_extend;
+	bool enable;
+};
+
+/**
+ * struct iio_backend_ops - operations structure for an iio_backend
+ * @enable:		Enable backend.
+ * @disable:		Disable backend.
+ * @chan_enable:	Enable one channel.
+ * @chan_disable:	Disable one channel.
+ * @data_format_set:	Configure the data format for a specific channel.
+ * @request_buffer:	Request an IIO buffer.
+ * @free_buffer:	Free an IIO buffer.
+ **/
+struct iio_backend_ops {
+	int (*enable)(struct iio_backend *back);
+	void (*disable)(struct iio_backend *back);
+	int (*chan_enable)(struct iio_backend *back, unsigned int chan);
+	int (*chan_disable)(struct iio_backend *back, unsigned int chan);
+	int (*data_format_set)(struct iio_backend *back, unsigned int chan,
+			       const struct iio_backend_data_fmt *data);
+	struct iio_buffer *(*request_buffer)(struct iio_backend *back,
+					     struct iio_dev *indio_dev);
+	void (*free_buffer)(struct iio_backend *back,
+			    struct iio_buffer *buffer);
+};
+
+int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
+int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
+int iio_backend_enable(struct iio_backend *back);
+void iio_backend_disable(struct iio_backend *back);
+int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
+				const struct iio_backend_data_fmt *data);
+int devm_iio_backend_request_buffer(struct device *dev,
+				    struct iio_backend *back,
+				    struct iio_dev *indio_dev);
+
+void *iio_backend_get_priv(const struct iio_backend *conv);
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv);
+
+#endif

-- 
2.43.0



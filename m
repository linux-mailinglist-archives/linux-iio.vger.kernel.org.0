Return-Path: <linux-iio+bounces-2100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5E8472B6
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 16:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3F9B2631E
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8D1468EF;
	Fri,  2 Feb 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiwUG8Qx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8233145B2F;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886594; cv=none; b=jSkdak3hz+HAEzVfYyt6MLId+ulfVFhxDi9bNnPmZL539iaVV53Tm8yKK3J0oWkXuofCLsnQC1SbkDTnd79worxNH9YnUu71WAQjCmqEIoSHlQB7QAUJzQPGzdsh7XPmOoW4vZuPt+TBh1bkCTLtFWUKyDu2i1kFj26SwrmEnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886594; c=relaxed/simple;
	bh=Ov4eYQWRF023uuAdWs7JubMLCVkLZZzGQjMyRWQ0t/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kO2g6U21fmsUehCcZnDolUPTkV1kEkEF5Uif2FC97lqtIzNlMrYXSIoiFnd7ptban2a50rn6ssvu8CBvMu3IqnRSBCVioIoXEiHLIaNK4fDm4+5O1MK+YUFr/gvZk9lvkL9taJ6RG4TT7zYilKacLbYPPGOPebWTw4BYEwiuV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiwUG8Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38A7BC43609;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886594;
	bh=Ov4eYQWRF023uuAdWs7JubMLCVkLZZzGQjMyRWQ0t/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iiwUG8QxDqBatxMFM1oRmf1pHvvELsUBMB82Z+mapgJ4UYprXVqGHnyKClkvTUufJ
	 t/nFLtOkpZ7XTXrKKpkdjfqIzXgEMT1D3dGHQDMepMMOnR0QScmMGCxLVUIAE2V604
	 012N/J1DGUW8TZA5UOmZ0q/mdO+5LDViE12uwN5fMN7gELzP/RjH22nq79EE/AXVMW
	 fTcPOLNblQafrzr+E5V1mVkvo1xXp86Fj/XkMhlfJMbgqQbNrCk3thHyn0cmZTYEWw
	 unIwLaEvVz0Q722d216lasi+qIoayQDMuWmKICu3/QfTx3YxpSfTAqijJMtq/642lu
	 yOvum7jdxbsDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1CC4828F;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Feb 2024 16:08:36 +0100
Subject: [PATCH v8 5/7] iio: add the IIO backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-iio-backend-v8-5-f65ee8c8203d@analog.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
In-Reply-To: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886592; l=17909;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bb+xU0rcI2MgjpfvWbh3PiaXUDyQeZukxcMl5CmMylo=;
 b=QErsg5Hu+TwBySOBxIMhvlXTUo3oqi3X3hA3nS8fUguHiaZ2jHpFOmA7B2TiXpSosapHFw38o
 ZGnzmbPOFjCDixNKeZUxJQW7E7L6bWYNdlwFHe4q6PIFiDmRe45RQjt
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
 drivers/iio/Kconfig                |   9 +
 drivers/iio/Makefile               |   1 +
 drivers/iio/industrialio-backend.c | 412 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  72 +++++++
 5 files changed, 502 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e5dfd169a19..f59b46983d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10403,6 +10403,14 @@ L:	linux-media@vger.kernel.org
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
index 52eb46ef84c1..9c351ffc7bed 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -71,6 +71,15 @@ config IIO_TRIGGERED_EVENT
 	help
 	  Provides helper functions for setting up triggered events.
 
+config IIO_BACKEND
+	tristate
+	help
+	  Framework to handle complex IIO aggregate devices. The typical
+	  architecture that can make use of this framework is to have one
+	  device as the frontend device which can be "linked" against one or
+	  multiple backend devices. The framework then makes it easy to get
+	  and control such backend devices.
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
index 000000000000..2cc0b4bba0a0
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,412 @@
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
+};
+
+/*
+ * Helper struct for requesting buffers. This ensures that we have all data
+ * that we need to free the buffer in a device managed action.
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
+ * Helper macros to call backend ops. Makes sure the option is supported
+ */
+#define iio_backend_check_op(back, op) ({ \
+	struct iio_backend *____back = back;				\
+	int ____ret = 0;						\
+									\
+	if (!____back->ops->op)						\
+		____ret = -EOPNOTSUPP;					\
+									\
+	____ret;							\
+})
+
+#define iio_backend_op_call(back, op, args...) ({		\
+	struct iio_backend *__back = back;			\
+	int __ret;						\
+								\
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
+	__ret = iio_backend_check_op(__back, op);		\
+	if (!__ret)						\
+		__back->ops->op(__back, ##args);		\
+}
+
+/**
+ * iio_backend_chan_enable - Enable a backend channel
+ * @back:	Backend device
+ * @chan:	Channel number
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan)
+{
+	return iio_backend_op_call(back, chan_enable, chan);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_chan_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_chan_disable - Disable a backend channel
+ * @back:	Backend device
+ * @chan:	Channel number
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan)
+{
+	return iio_backend_op_call(back, chan_disable, chan);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_chan_disable, IIO_BACKEND);
+
+static void __iio_backend_disable(void *back)
+{
+	iio_backend_void_op_call(back, disable);
+}
+
+/**
+ * devm_iio_backend_enable - Device managed backend enable
+ * @dev:	Consumer device for the backend
+ * @back:	Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_iio_backend_enable(struct device *dev, struct iio_backend *back)
+{
+	int ret;
+
+	ret = iio_backend_op_call(back, enable);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, __iio_backend_disable, back);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_data_format_set - Configure the channel data format
+ * @back:	Backend device
+ * @chan:	Channel number
+ * @data:	Data format
+ *
+ * Properly configure a channel with respect to the expected data format. A
+ * @struct iio_backend_data_fmt must be passed with the settings.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
+				const struct iio_backend_data_fmt *data)
+{
+	if (!data || data->type >= IIO_BACKEND_DATA_TYPE_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_format_set, chan, data);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_format_set, IIO_BACKEND);
+
+static void iio_backend_free_buffer(void *arg)
+{
+	struct iio_backend_buffer_pair *pair = arg;
+
+	iio_backend_void_op_call(pair->back, free_buffer, pair->buffer);
+}
+
+/**
+ * devm_iio_backend_request_buffer - Device managed buffer request
+ * @dev:	Consumer device for the backend
+ * @back:	Backend device
+ * @indio_dev:	IIO device
+ *
+ * Request an IIO buffer from the backend. The type of the buffer (typically
+ * INDIO_BUFFER_HARDWARE) is up to the backend to decide. This is because,
+ * normally, the backend dictates what kind of buffering we can get.
+ *
+ * The backend .free_buffer() hooks is automatically called on @dev detach.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
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
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
+
+static void iio_backend_release(void *arg)
+{
+	struct iio_backend *back = arg;
+
+	module_put(back->owner);
+}
+
+static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
+{
+	struct device_link *link;
+	int ret;
+
+	/*
+	 * Make sure the provider cannot be unloaded before the consumer module.
+	 * Note that device_links would still guarantee that nothing is
+	 * accessible (and breaks) but this makes it explicit that the consumer
+	 * module must be also unloaded.
+	 */
+	if (!try_module_get(back->owner)) {
+		pr_err("%s: Cannot get module reference\n", dev_name(dev));
+		return -ENODEV;
+	}
+
+	ret = devm_add_action_or_reset(dev, iio_backend_release, back);
+	if (ret)
+		return ret;
+
+	link = device_link_add(dev, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		pr_err("%s: Could not link to supplier(%s)\n", dev_name(dev),
+		       dev_name(back->dev));
+		return -EINVAL;
+	}
+
+	pr_debug("%s: Found backend(%s) device\n", dev_name(dev),
+		 dev_name(back->dev));
+
+	return 0;
+}
+
+/**
+ * devm_iio_backend_get - Device managed backend device get
+ * @dev:	Consumer device for the backend
+ * @name:	Backend name
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
+		/* not an error if optional */
+		pr_debug("%s: Cannot get Firmware reference\n", dev_name(dev));
+		return ERR_CAST(fwnode);
+	}
+
+	guard(mutex)(&iio_back_lock);
+	list_for_each_entry(back, &iio_back_list, entry) {
+		if (!device_match_fwnode(back->dev, fwnode))
+			continue;
+
+		fwnode_handle_put(fwnode);
+		ret = __devm_iio_backend_get(dev, back);
+		if (ret)
+			return ERR_PTR(ret);
+
+		return back;
+	}
+
+	fwnode_handle_put(fwnode);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
+
+/**
+ * __devm_iio_backend_get_from_fwnode_lookup - Device managed fwnode backend device get
+ * @dev:	Consumer device for the backend
+ * @fwnode:	Firmware node of the backend device
+ *
+ * Search the backend list for a device matching @fwnode.
+ * This API should not be used and it's only present for preventing the first
+ * user of this framework to break it's DT ABI.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *
+__devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
+					  struct fwnode_handle *fwnode)
+{
+	struct iio_backend *back;
+	int ret;
+
+	guard(mutex)(&iio_back_lock);
+	list_for_each_entry(back, &iio_back_list, entry) {
+		if (!device_match_fwnode(back->dev, fwnode))
+			continue;
+
+		ret = __devm_iio_backend_get(dev, back);
+		if (ret)
+			return ERR_PTR(ret);
+
+		return back;
+	}
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup, IIO_BACKEND);
+
+/**
+ * iio_backend_get_priv - Get driver private data
+ * @back:	Backend device
+ */
+void *iio_backend_get_priv(const struct iio_backend *back)
+{
+	return back->priv;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_get_priv, IIO_BACKEND);
+
+static void iio_backend_unregister(void *arg)
+{
+	struct iio_backend *back = arg;
+
+	mutex_lock(&iio_back_lock);
+	list_del(&back->entry);
+	mutex_unlock(&iio_back_lock);
+}
+
+/**
+ * devm_iio_backend_register - Device managed backend device register
+ * @dev:	Backend device being registered
+ * @ops:	Backend ops
+ * @priv:	Device private data
+ *
+ * @ops is mandatory. Not providing it results in -EINVAL.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv)
+{
+	struct iio_backend *back;
+
+	if (!ops) {
+		pr_err("%s: No backend ops given\n", dev_name(dev));
+		return -EINVAL;
+	}
+
+	/*
+	 * Through device_links, we guarantee that a frontend device cannot be
+	 * bound/exist if the backend driver is not around. Hence, we can bind
+	 * the backend object lifetime with the device being passed since
+	 * removing it will tear the frontend/consumer down.
+	 */
+	back = devm_kzalloc(dev, sizeof(*back), GFP_KERNEL);
+	if (!back)
+		return -ENOMEM;
+
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
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_register, IIO_BACKEND);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Framework to handle complex IIO aggregate devices");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
new file mode 100644
index 000000000000..a6d79381866e
--- /dev/null
+++ b/include/linux/iio/backend.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _IIO_BACKEND_H_
+#define _IIO_BACKEND_H_
+
+#include <linux/types.h>
+
+struct fwnode_handle;
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
+int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
+int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
+				const struct iio_backend_data_fmt *data);
+int devm_iio_backend_request_buffer(struct device *dev,
+				    struct iio_backend *back,
+				    struct iio_dev *indio_dev);
+
+void *iio_backend_get_priv(const struct iio_backend *conv);
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *
+__devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
+					  struct fwnode_handle *fwnode);
+
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv);
+
+#endif

-- 
2.43.0



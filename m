Return-Path: <linux-iio+bounces-1154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3481A2A4
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E51F222A9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27D40BF5;
	Wed, 20 Dec 2023 15:31:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195D3F8F5;
	Wed, 20 Dec 2023 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKBKDgK001699;
	Wed, 20 Dec 2023 10:31:27 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4umkwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:31:26 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BKFVPv6005309
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Dec 2023 10:31:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 20 Dec
 2023 10:31:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 20 Dec 2023 10:31:23 -0500
Received: from [127.0.0.1] ([10.44.3.57])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BKFUxXB006998;
	Wed, 20 Dec 2023 10:31:19 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 20 Dec 2023 16:34:09 +0100
Subject: [PATCH v4 6/8] iio: add the IIO backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-iio-backend-v4-6-998e9148b692@analog.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
In-Reply-To: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703086446; l=19009;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BUP0BsuXjRj0m3UNPyIIkIk8XhiRYbShLEeViMklU2w=;
 b=8YRh+gtwM/LoG0ocyNZJYp4QFbKsCjxqEirJ7R0EguobR6KY2oWFMfMacySuFV2aEP3wf+UAw
 LFAehoVyQRtA1YozqK2yhKE5o35ICKJ0zUN01q/Ru7m+H9neB48oTqF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5Mfuz6mCDH3n4FBiGfNi6koJjC5VMxA9
X-Proofpoint-GUID: 5Mfuz6mCDH3n4FBiGfNi6koJjC5VMxA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200111

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
 drivers/iio/industrialio-backend.c | 456 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  75 ++++++
 5 files changed, 545 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3029841e92a8..df5f5b988926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10334,6 +10334,14 @@ L:	linux-media@vger.kernel.org
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
index 000000000000..75a0a66003e1
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,456 @@
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
+EXPORT_SYMBOL_NS_GPL(iio_backend_chan_enable, IIO_BACKEND);
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
+EXPORT_SYMBOL_NS_GPL(iio_backend_chan_disable, IIO_BACKEND);
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
+EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_disable - Disable the backend.
+ * @back:	Backend device
+ */
+void iio_backend_disable(struct iio_backend *back)
+{
+	iio_backend_void_op_call(back, disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
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
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
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
+static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
+{
+	struct device_link *link;
+	int ret;
+
+	kref_get(&back->ref);
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
+	if (!link)
+		pr_warn("%s: Could not link to supplier(%s)\n", dev_name(dev),
+			dev_name(back->dev));
+
+	pr_debug("%s: Found backend(%s) device\n", dev_name(dev),
+		 dev_name(back->dev));
+	return 0;
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
+ * devm_iio_backend_get_optional - Get optional backend device
+ * @dev:	Device where to look for the backend.
+ * @name:	Backend name.
+ *
+ * Same as @devm_iio_backend_get() but return NULL if backend not found.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise or NULL if not found.
+ */
+struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
+						  const char *name)
+{
+	struct iio_backend *back;
+
+	back = devm_iio_backend_get(dev, name);
+	if (IS_ERR(back) && PTR_ERR(back) == -ENOENT)
+		return NULL;
+
+	return back;
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_optional, IIO_BACKEND);
+
+/**
+ * devm_iio_backend_get_from_fwnode_lookup
+ * @dev:	Device where to bind the backend lifetime.
+ * @fwnode:	Firmware node of the backend device.
+ *
+ * It directly looks the backend device list for a device matching @fwnode.
+ * This API should not be used and it's only present for preventing the first
+ * user of this framework to break it's DT ABI.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *
+devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
+					struct fwnode_handle *fwnode)
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
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_from_fwnode_lookup, IIO_BACKEND);
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
+		pr_err("%s: No backend ops or private data given\n",
+		       dev_name(dev));
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
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_register, IIO_BACKEND);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Framework to handle complex IIO aggregate devices");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
new file mode 100644
index 000000000000..239d4db08cee
--- /dev/null
+++ b/include/linux/iio/backend.h
@@ -0,0 +1,75 @@
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
+struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
+						  const char *name);
+struct iio_backend *
+devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
+					struct fwnode_handle *fwnode);
+
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv);
+
+#endif

-- 
2.43.0



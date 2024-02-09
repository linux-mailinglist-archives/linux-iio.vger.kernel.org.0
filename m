Return-Path: <linux-iio+bounces-2337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F584F872
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2F11C22D64
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8873178;
	Fri,  9 Feb 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YeGMSxOB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848571B59;
	Fri,  9 Feb 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492385; cv=none; b=AD54/uPaHwndzF4iMRJrind4NOeZbdz8XOMjYljskxTMS9T8T07HRYLrJcLW2daQDMGmaTTmLbjVXrxsoE17SrzpzGw7mGs2tvFv9UUIdShGgd79DGEdlUN280yly2AWQLMN2ZoWgLi4trqDBfpPAH91Rw3vCfizFfZpweYGG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492385; c=relaxed/simple;
	bh=VAafmV8xcrx+AoAEG2FPYLeVZspGc177EtOxK23puaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MKLcPnxe4/JZHmlHdS1Vcc6Z19y2TTerG+Xuv4GEtJ4O0aRvkzcWqGn6Rb329Loh6FSi1VGeStEsFjoOAuZ+GuGDctEeUs30Ucpd+A3d5DEG3fdv/k5L0LxhwYqSiMJ/uxtyZyHDxdUFdUygdQnWLpil5eMBcuFFhxwitwwtCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YeGMSxOB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419DJTup013489;
	Fri, 9 Feb 2024 10:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=ZBdO5r03C9T5Ar3anH+GVGpNT/OL9sgnA2kVsjhSKYg=; b=
	YeGMSxOBKsub3vvMh4Ck0dyofilep3joTIG+Cdej/PVnd9WozhJSDhD3RKIWtauu
	uk+9dpBZc7xgtYje+MV03V1DQGB4EhdtEDcClVPN/DJFJP7Kfur34pTpz9kueS8W
	r30C9TP2CRpjy0ujVLkfYMFgCtbFiYhJuPw3qzH4nQvbMHhyoXbnbWkup3RhjX1e
	bi9tHzWB3ATgTr8U1uU41VyDNkCRw6fThmYpi5PwrseaRE3f6tGtENdMZCfWSOUL
	4BajspXW9e+VntwqKlm+dzVp8pAstP38S/DGTubpbymGVo0VDUoHsHnt6jDTsA6x
	zI4WAIEpCvnmGrltDyPfDg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423p9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:26:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 419FPuxO047866
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:25:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:25:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:25:55 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FPVJ5013228;
	Fri, 9 Feb 2024 10:25:46 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 9 Feb 2024 16:28:55 +0100
Subject: [PATCH v10 5/7] iio: add the IIO backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-iio-backend-v10-5-3ed842064318@analog.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <andy.shevchenko@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707492532; l=18513;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=VAafmV8xcrx+AoAEG2FPYLeVZspGc177EtOxK23puaM=;
 b=hZU+l9MWntfzAePvvdbcavYgPZieGJVU9gIHcQ6z0OMOtjnI+1qfJIDLvYwPGsg/7mLOQxqzt
 5FT68NplqQiA2wLF+vveyhunggo+nEtISlFO45mARZdc0TFyGiCc6Cw
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9zsoUZx8CA7Gtq7zMKXmlLUX6LKFXNno
X-Proofpoint-ORIG-GUID: 9zsoUZx8CA7Gtq7zMKXmlLUX6LKFXNno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090113

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
 drivers/iio/industrialio-backend.c | 418 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  72 +++++++
 5 files changed, 508 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87b61a53462b..98a9c56099f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10417,6 +10417,14 @@ L:	linux-media@vger.kernel.org
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
index 000000000000..2fea2bbbe47f
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,418 @@
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
+ *                                           -------------------------------------------------------
+ * ------------------                        | ------------         ------------      -------  FPGA|
+ * |     ADC        |------------------------| | ADC CORE |---------| DMA CORE |------| RAM |      |
+ * | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend) |---------|          |------|     |      |
+ * |                |------------------------| ------------         ------------      -------      |
+ * ------------------                        -------------------------------------------------------
+ *
+ * The framework interface is pretty simple:
+ *   - Backends should register themselves with devm_iio_backend_register()
+ *   - Frontend devices should get backends with devm_iio_backend_get()
+ *
+ * Also to note that the primary target for this framework are converters like
+ * ADC/DACs so iio_backend_ops will have some operations typical of converter
+ * devices. On top of that, this is "generic" for all IIO which means any kind
+ * of device can make use of the framework. That said, If the iio_backend_ops
+ * struct begins to grow out of control, we can always refactor things so that
+ * the industrialio-backend.c is only left with the really generic stuff. Then,
+ * we can build on top of it depending on the needs.
+ *
+ * Copyright (C) 2023-2024 Analog Devices Inc.
+ */
+#define dev_fmt(fmt) "iio-backend: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/types.h>
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
+ * Helper macros to call backend ops. Makes sure the option is supported.
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
+	pair = devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
+	if (!pair)
+		return -ENOMEM;
+
+	buffer = iio_backend_ptr_op_call(back, request_buffer, indio_dev);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
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
+	if (!try_module_get(back->owner))
+		return dev_err_probe(dev, -ENODEV,
+				     "Cannot get module reference\n");
+
+	ret = devm_add_action_or_reset(dev, iio_backend_release, back);
+	if (ret)
+		return ret;
+
+	link = device_link_add(dev, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not link to supplier(%s)\n",
+				     dev_name(back->dev));
+
+	dev_dbg(dev, "Found backend(%s) device\n", dev_name(back->dev));
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
+	unsigned int index;
+	int ret;
+
+	if (name) {
+		ret = device_property_match_string(dev, "io-backend-names",
+						   name);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		index = ret;
+	} else {
+		index = 0;
+	}
+
+	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
+	if (IS_ERR(fwnode)) {
+		dev_err_probe(dev, PTR_ERR(fwnode),
+			      "Cannot get Firmware reference\n");
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
+	guard(mutex)(&iio_back_lock);
+	list_del(&back->entry);
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
+	if (!ops)
+		return dev_err_probe(dev, -EINVAL, "No backend ops given\n");
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
+	scoped_guard(mutex, &iio_back_lock)
+		list_add(&back->entry, &iio_back_list);
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



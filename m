Return-Path: <linux-iio+bounces-4204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278348A2F93
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725FBB2212F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D684DEE;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR3Qs6zF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DD83CD7;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928971; cv=none; b=NuoYE6PoD6TfIXcl9FJkZ1P1RP82/e4Wuf3FAc7k5mhSb6yndzJ1HAfryF+6wBxCAN1duGpm1z/tnYXEywuCCg9W2KgGwjnzviAFk7prcqG6tgGr8yo8kEb0g4JSXmXWFD5tWqXhzQPgQF08U6sBipd2D3cAt2RSkA10nmy9gSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928971; c=relaxed/simple;
	bh=PpK7qn90WCr6KYLm21sL+PSnpeMrugx9ObI3H9j7sgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tO+ZbU9usXmJrtSh2QwssLwB8D3Q5ZbP9Gnf4S5MvQH+sgCemRO3j7AU3S9EwSu6lvKilfwyK7Z82yXeCzY0OOujlKs9MgJfFQRfnYuK1UrFOc6eIQx3Ksuahcd0St7/WS1Qa/HxHy/4mhPvR5Zeo2OHchoMAmdMlc/9Ul6ArC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR3Qs6zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D7D3C4AF11;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928970;
	bh=PpK7qn90WCr6KYLm21sL+PSnpeMrugx9ObI3H9j7sgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QR3Qs6zF1nkhQTXlUOM5WzeFopNiT9l8ejI1eewQEMa+rssjozCivkwm0Uv37DbMI
	 H4OW3eVJogsKyBLmCZFtrRa3PGsXLfvhzOj++RkupyVd++2yIVICW35RP1xmsQXZIX
	 cMhnzZ7R4E9piUgJ78NotbxeJHS1V+WzAAeFdCR7JP/UR2wTGBs9k/cCAyuCy03Y5A
	 jIFkCIf5GrowsHczvO7aM7qMAmuzeDiMkKyu3TP6zyo1iCrUZdzng88UndOGCKxFbf
	 hinouWsnYJObzkS0eyTRYt+tEAJdJblH0e5bkfApGodt1oPVoIdhYQ3EQ9YpVM9o2Z
	 4/dSTcp6Dthmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EAC04FFE;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 12 Apr 2024 15:36:15 +0200
Subject: [PATCH v3 08/10] iio: backend: add new functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-iio-backend-axi-dac-v3-8-3e9d4c5201fb@analog.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
In-Reply-To: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712928968; l=11939;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JTce4VAzVRMIj8i1O5Q/CkJZnomMUJ28yaNvN40DHoY=;
 b=xSeYv+1hOMQPcjmEwfE4whSGz9LVOdRXdWQtgEmZheluQbf2zaCxz2PcFqE69XELGXkKeVmqE
 IgSt0rOB0L8D2i7+xB9xA6NBSQC8hDUXREloIcFH1rm89iRv003xpLD
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This adds the needed backend ops for supporting a backend inerfacing
with an high speed dac. The new ops are:

* data_source_set();
* set_sampling_freq();
* extend_chan_spec();
* ext_info_set();
* ext_info_get().

Also to note the new helpers that are meant to be used by the backends
when extending an IIO channel (adding extended info):

* iio_backend_ext_info_set();
* iio_backend_ext_info_get().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 179 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  49 ++++++++++
 2 files changed, 228 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2fea2bbbe47fd..f08ed6d70ae59 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -43,10 +43,12 @@
 #include <linux/types.h>
 
 #include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
 
 struct iio_backend {
 	struct list_head entry;
 	const struct iio_backend_ops *ops;
+	struct device *frontend_dev;
 	struct device *dev;
 	struct module *owner;
 	void *priv;
@@ -186,6 +188,44 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_format_set, IIO_BACKEND);
 
+/**
+ * iio_backend_data_source_set - Select data source
+ * @back:	Backend device
+ * @chan:	Channel number
+ * @data:	Data source
+ *
+ * A given backend may have different sources to stream/sync data. This allows
+ * to choose that source.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
+				enum iio_backend_data_source data)
+{
+	if (data >= IIO_BACKEND_DATA_SOURCE_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_source_set, chan, data);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_set, IIO_BACKEND);
+
+/**
+ * iio_backend_set_sampling_freq - Set channel sampling rate
+ * @back:		Backend device
+ * @chan:		Channel number
+ * @sample_rate_hz:	Sample rate
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
+				  u64 sample_rate_hz)
+{
+	return iio_backend_op_call(back, set_sample_rate, chan, sample_rate_hz);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_set_sampling_freq, IIO_BACKEND);
+
 static void iio_backend_free_buffer(void *arg)
 {
 	struct iio_backend_buffer_pair *pair = arg;
@@ -231,6 +271,143 @@ int devm_iio_backend_request_buffer(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
 
+static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device *dev)
+{
+	struct iio_backend *back = ERR_PTR(-ENODEV), *iter;
+
+	/*
+	 * We deliberately go through all backends even after finding a match.
+	 * The reason is that we want to catch frontend devices which have more
+	 * than one backend in which case returning the first we find is bogus.
+	 * For those cases, frontends need to explicitly define
+	 * get_iio_backend() in struct iio_info.
+	 */
+	guard(mutex)(&iio_back_lock);
+	list_for_each_entry(iter, &iio_back_list, entry) {
+		if (dev == iter->frontend_dev) {
+			if (!IS_ERR(back)) {
+				dev_warn(dev,
+					 "Multiple backends! get_iio_backend() needs to be implemented");
+				return ERR_PTR(-ENODEV);
+			}
+
+			back = iter;
+		}
+	}
+
+	return back;
+}
+
+/**
+ * iio_backend_ext_info_get - IIO ext_info read callback
+ * @indio_dev:	IIO device
+ * @private:	Data private to the driver
+ * @chan:	IIO channel
+ * @buf:	Buffer where to place the attribute data
+ *
+ * This helper is intended to be used by backends that extend an IIO channel
+ * (through iio_backend_extend_chan_spec()) with extended info. In that case,
+ * backends are not supposed to give their own callbacks (as they would not have
+ * a way to get the backend from indio_dev). This is the getter.
+ *
+ * RETURNS:
+ * Number of bytes written to buf, negative error number on failure.
+ */
+ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan, char *buf)
+{
+	struct iio_backend *back;
+
+	/*
+	 * The below should work for the majority of the cases. It will not work
+	 * when one frontend has multiple backends in which case we'll need a
+	 * new callback in struct iio_info so we can directly request the proper
+	 * backend from the frontend. Anyways, let's only introduce new options
+	 * when really needed...
+	 */
+	back = iio_backend_from_indio_dev_parent(indio_dev->dev.parent);
+	if (IS_ERR(back))
+		return PTR_ERR(back);
+
+	return iio_backend_op_call(back, ext_info_get, private, chan, buf);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_get, IIO_BACKEND);
+
+/**
+ * iio_backend_ext_info_set - IIO ext_info write callback
+ * @indio_dev:	IIO device
+ * @private:	Data private to the driver
+ * @chan:	IIO channel
+ * @buf:	Buffer holding the sysfs attribute
+ * @len:	Buffer length
+ *
+ * This helper is intended to be used by backends that extend an IIO channel
+ * (trough iio_backend_extend_chan_spec()) with extended info. In that case,
+ * backends are not supposed to give their own callbacks (as they would not have
+ * a way to get the backend from indio_dev). This is the setter.
+ *
+ * RETURNS:
+ * Buffer length on success, negative error number on failure.
+ */
+ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len)
+{
+	struct iio_backend *back;
+
+	back = iio_backend_from_indio_dev_parent(indio_dev->dev.parent);
+	if (IS_ERR(back))
+		return PTR_ERR(back);
+
+	return iio_backend_op_call(back, ext_info_set, private, chan, buf, len);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
+
+/**
+ * iio_backend_extend_chan_spec - Extend an IIO channel
+ * @indio_dev:	IIO device
+ * @back:	Backend device
+ * @chan:	IIO channel
+ *
+ * Some backends may have their own functionalities and hence capable of
+ * extending a frontend's channel.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
+				 struct iio_backend *back,
+				 struct iio_chan_spec *chan)
+{
+	const struct iio_chan_spec_ext_info *frontend_ext_info = chan->ext_info;
+	const struct iio_chan_spec_ext_info *back_ext_info;
+	int ret;
+
+	ret = iio_backend_op_call(back, extend_chan_spec, chan);
+	if (ret)
+		return ret;
+	/*
+	 * Let's keep things simple for now. Don't allow to overwrite the
+	 * frontend's extended info. If ever needed, we can support appending
+	 * it.
+	 */
+	if (frontend_ext_info && chan->ext_info != frontend_ext_info)
+		return -EOPNOTSUPP;
+	if (!chan->ext_info)
+		return 0;
+
+	/* Don't allow backends to get creative and force their own handlers */
+	for (back_ext_info = chan->ext_info; back_ext_info->name; back_ext_info++) {
+		if (back_ext_info->read != iio_backend_ext_info_get)
+			return -EINVAL;
+		if (back_ext_info->write != iio_backend_ext_info_set)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, IIO_BACKEND);
+
 static void iio_backend_release(void *arg)
 {
 	struct iio_backend *back = arg;
@@ -263,6 +440,8 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
 				     "Could not link to supplier(%s)\n",
 				     dev_name(back->dev));
 
+	back->frontend_dev = dev;
+
 	dev_dbg(dev, "Found backend(%s) device\n", dev_name(back->dev));
 
 	return 0;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index a6d79381866ec..9d144631134db 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 
+struct iio_chan_spec;
 struct fwnode_handle;
 struct iio_backend;
 struct device;
@@ -15,6 +16,26 @@ enum iio_backend_data_type {
 	IIO_BACKEND_DATA_TYPE_MAX
 };
 
+enum iio_backend_data_source {
+	IIO_BACKEND_INTERNAL_CONTINUOS_WAVE,
+	IIO_BACKEND_EXTERNAL,
+	IIO_BACKEND_DATA_SOURCE_MAX
+};
+
+/**
+ * IIO_BACKEND_EX_INFO - Helper for an IIO extended channel attribute
+ * @_name:	Attribute name
+ * @_shared:	Whether the attribute is shared between all channels
+ * @_what:	Data private to the driver
+ */
+#define IIO_BACKEND_EX_INFO(_name, _shared, _what) {	\
+	.name = (_name),				\
+	.shared = (_shared),				\
+	.read =  iio_backend_ext_info_get,		\
+	.write = iio_backend_ext_info_set,		\
+	.private = (_what),				\
+}
+
 /**
  * struct iio_backend_data_fmt - Backend data format
  * @type:		Data type.
@@ -35,8 +56,13 @@ struct iio_backend_data_fmt {
  * @chan_enable:	Enable one channel.
  * @chan_disable:	Disable one channel.
  * @data_format_set:	Configure the data format for a specific channel.
+ * @data_source_set:	Configure the data source for a specific channel.
+ * @set_sample_rate:	Configure the sampling rate for a specific channel.
  * @request_buffer:	Request an IIO buffer.
  * @free_buffer:	Free an IIO buffer.
+ * @extend_chan_spec:	Extend an IIO channel.
+ * @ext_info_set:	Extended info setter.
+ * @ext_info_get:	Extended info getter.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -45,10 +71,21 @@ struct iio_backend_ops {
 	int (*chan_disable)(struct iio_backend *back, unsigned int chan);
 	int (*data_format_set)(struct iio_backend *back, unsigned int chan,
 			       const struct iio_backend_data_fmt *data);
+	int (*data_source_set)(struct iio_backend *back, unsigned int chan,
+			       enum iio_backend_data_source data);
+	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
+			       u64 sample_rate_hz);
 	struct iio_buffer *(*request_buffer)(struct iio_backend *back,
 					     struct iio_dev *indio_dev);
 	void (*free_buffer)(struct iio_backend *back,
 			    struct iio_buffer *buffer);
+	int (*extend_chan_spec)(struct iio_backend *back,
+				struct iio_chan_spec *chan);
+	int (*ext_info_set)(struct iio_backend *back, uintptr_t private,
+			    const struct iio_chan_spec *chan,
+			    const char *buf, size_t len);
+	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
+			    const struct iio_chan_spec *chan, char *buf);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -56,10 +93,22 @@ int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
 int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
 int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 				const struct iio_backend_data_fmt *data);
+int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
+				enum iio_backend_data_source data);
+int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
+				  u64 sample_rate_hz);
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);
+ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len);
+ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan, char *buf);
 
+int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
+				 struct iio_backend *back,
+				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *

-- 
2.44.0




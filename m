Return-Path: <linux-iio+bounces-3864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7F890019
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEF628BBE1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4848175E;
	Thu, 28 Mar 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgXVrjiV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C780BF4;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=RJthlyDx0A1A0rH+mz3JefTKAGEtgmzd0YAGJ5yKxEKyYWPzYStSIlprXJrxgt+TQGVZCUkXYnHLNjfSg1S7fJ6+f3Qvo+Zs88Evo9aMlicEnpUr+j78Qb9IkpXInALGAvh9H88PpJolBmmiZxHR525SHTGWHOB+TxEYSeSzk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=zchI4s+oG36h0qA+IWC4oD50p5rN0c8B1V2I1xsqhnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAaHd8o0uAgb7eqQElQv6JKa41sgnIXpjrqqbRJRv/hesYvzUfVYNz5OWt5tZAf8elr9v4f7j3BD/9/06CLJQ2y7hLqkAzQx57sTYqj1E2vYFKeXs62ScGWX0+jZxVJrHSsD11qn1gebDwdzuYFMReD/RLQstgIClX/my6Zfluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgXVrjiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90760C3278C;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=zchI4s+oG36h0qA+IWC4oD50p5rN0c8B1V2I1xsqhnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MgXVrjiV3dPofEe6vK6SkIZuMJL1F+nFJpfCCa0lL4wGidl2k5cW0pBd5XprnyJe3
	 ey6B+gLxmZawZ5xf3nk4SIT7gPmw2wwzkvkLALpJZkRF4qnoUE1+ltRf5VrdSCSApN
	 nUeX/Q3vW6DIk3ssznBF42sHyyMeFeg7CIp6LMSGq2L7EMGuMU4eI+fdw/zHoyHgS3
	 RD/NZ1l0l5zOBn3dEFhcgtyru/Bk+SyLbfSAbg4DVg2MXlJMTdASlERS3K96RG8Jwn
	 RdBF9zjuq6FYKmRu48jZ7F0Iegubblw3WOvPwMTZgwiMeiGUnrrdexSO4Tt5nqBu8Q
	 sTOX49Z7HHeSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876ECCD1284;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:32 +0100
Subject: [PATCH 08/10] iio: backend: add new functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-8-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=10519;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7tO0Yxz4B8NnjPj8QREz6EaLoC8LjeYSjQuvStb9dNo=;
 b=Q+Ea9/YbCHhtw91DmLIZQh1erOUZseAKnqc1KzWH3FjwpRm1wZRXr4GXDpTexiT8POcDCscef
 vInGjDL8yF4DSjJmsAGgRfRAp+wmyToW2z6OkiDEajumJFA4t2jsAfU
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
 drivers/iio/industrialio-backend.c | 144 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  49 +++++++++++++
 2 files changed, 193 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2fea2bbbe47f..0a26dd8c6343 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -43,6 +43,7 @@
 #include <linux/types.h>
 
 #include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
 
 struct iio_backend {
 	struct list_head entry;
@@ -186,6 +187,44 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
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
+ * @sample_rate:	Sample rate
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
+				  u64 sample_rate)
+{
+	return iio_backend_op_call(back, set_sample_rate, chan, sample_rate);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_set_sampling_freq, IIO_BACKEND);
+
 static void iio_backend_free_buffer(void *arg)
 {
 	struct iio_backend_buffer_pair *pair = arg;
@@ -231,6 +270,111 @@ int devm_iio_backend_request_buffer(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
 
+/**
+ * iio_backend_ext_info_get - IIO ext_info read callback
+ * @indio_dev:	IIO device
+ * @private:	Data private to the driver
+ * @chan:	IIO channel
+ * @buf:	Buffer where to place the attribute data
+ *
+ * This helper is intended to be used by backends that extend an IIO channel
+ * (trough iio_backend_extend_chan_spec()) with extended info. In that case,
+ * backends are not supposed to give their own callbacks (as they would not
+ * a way to get te backend from indio_dev). This is the getter.
+ *
+ * RETURNS:
+ * Number of bytes written to buf, negative error number on failure.
+ */
+ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan, char *buf)
+{
+	struct iio_backend *back = iio_device_get_drvdata(indio_dev);
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
+ * backends are not supposed to give their own callbacks (as they would not
+ * a way to get te backend from indio_dev). This is the setter.
+ *
+ * RETURNS:
+ * Buffer length on success, negative error number on failure.
+ */
+ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len)
+{
+	struct iio_backend *back = iio_device_get_drvdata(indio_dev);
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
+	const struct iio_chan_spec_ext_info *ext_info = chan->ext_info;
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
+	if (ext_info && chan->ext_info != ext_info)
+		return -EOPNOTSUPP;
+	if (!chan->ext_info)
+		return 0;
+	/*
+	 * !\NOTE: this will break as soon as we have multiple backends on one
+	 * frontend and all of them extend channels. In that case, the core
+	 * backend code has no way to get the correct backend given the
+	 * iio device.
+	 *
+	 * One solution for this could be introducing a new backend
+	 * dedicated callback in struct iio_info so we can callback into the
+	 * frontend so it can give us the right backend given a chan_spec.
+	 */
+	iio_device_set_drvdata(indio_dev, back);
+
+	/* Don't allow backends to get creative and force their own handlers */
+	for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
+		if (ext_info->read != iio_backend_ext_info_get)
+			return -EINVAL;
+		if (ext_info->write != iio_backend_ext_info_set)
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
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index a6d79381866e..09ff2f8f9fd8 100644
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
+	IIO_BACKEND_INTERNAL_CW,
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
+			       u64 sample_rate);
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
+				  u64 sample_rate);
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




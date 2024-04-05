Return-Path: <linux-iio+bounces-4087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5576A89A054
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33831F222AC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878216F292;
	Fri,  5 Apr 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nTMXixRq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82E16F27A;
	Fri,  5 Apr 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329038; cv=none; b=lALvVIUEYyuWHLy/rGHCMYbIK/w47bqkayTs0AVdrcAj9jVG8qcfBvF+1c1rjFZ1q3YxJlUY/6b80SzhwpZhK5etN+gOl7s0VUEcbTUFV9w4mNyuXU9aw9FO1K6DkpCYBK0zuQt7v4l7g7xEVIblVDc0y3pvShHJPPwyuf3jYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329038; c=relaxed/simple;
	bh=xgAmECrFsUTtJCoji/lM3kzwfT9+MC3hA0V2gf7cX68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FPRI2Az79POnmSQCSbc4ANes+8ILUeK5Z7Sg1QMpfsS7OKpqG+VrXCKPI+uJVnnz0d5BLOLCnQP2VjLtspecGr6X/k7h6zrqef8Nd7XcXwk6vO0mcRjv8+0hCIrmPHOZT6BnbaEws3bXSJMJs/bMIRnSLo7IQuYfZFaVIkh/DWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nTMXixRq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EeV2O002582;
	Fri, 5 Apr 2024 10:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=kYL1KZM3x8Q8eUpSr+bjTkFGUBqI96OjKx+ouiwycZA=; b=
	nTMXixRqZVaacNvILm9XNgOPo6aPh2N3dXJ3G4fu6F/4mZf2/L3QSpjj1PeLTAQD
	Y7XIbXhSxILxwefotmIcBr7C527g4B4Ti5MQmJ8cCW5c7P9w8GXgDVPIe57vIFPn
	qscKhVFduQIYgiI8TuFTAVhLsk1jiaPo73gHkPqqPSdWlRQF3n9m17Sz8osQUwFg
	onGJ0ujZHjAjbiMLr6uuH2+dwFkT3FQmbd6kQYrcZgtPo3nEy5WOVeUjQ/68zxR4
	Vdnd25NseY3ZXdTz1VuoYn0WqyhQx5LAbeDGEhZTBIH3JdKu7oWSMQov4ON3zbkC
	B7xLHRotCRyPpvlzfpZeuw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xak96r2k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 435Euul7022821
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:56 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:55 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSI7019011;
	Fri, 5 Apr 2024 10:56:50 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 17:00:07 +0200
Subject: [PATCH v2 09/11] iio: backend: add new functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-9-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=12010;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xgAmECrFsUTtJCoji/lM3kzwfT9+MC3hA0V2gf7cX68=;
 b=+95THANXGfKNXRYHb1Typv/Ol3V3CMkDltLj643MMYxUBNQnMcOAo3Y0OqQUhCJwNguQu3SlQ
 Eqg6TJ/qks/CdUrexRDGH59KEUz4pJl1R1DSgaa/cc8jwYQBrQ8MSTp
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RYEN8pfUEQ5fxG60HsKfhOfRf7Brg4yn
X-Proofpoint-GUID: RYEN8pfUEQ5fxG60HsKfhOfRf7Brg4yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=870 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050106

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
index 2fea2bbbe47f..ac554798897f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -29,6 +29,7 @@
  *
  * Copyright (C) 2023-2024 Analog Devices Inc.
  */
+#include "asm-generic/errno-base.h"
 #define dev_fmt(fmt) "iio-backend: " fmt
 
 #include <linux/cleanup.h>
@@ -43,10 +44,12 @@
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
@@ -186,6 +189,44 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
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
@@ -231,6 +272,142 @@ int devm_iio_backend_request_buffer(struct device *dev,
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
+	if (indio_dev->info->get_iio_backend)
+		back = indio_dev->info->get_iio_backend(indio_dev, chan);
+	else
+		back = iio_backend_from_indio_dev_parent(indio_dev->dev.parent);
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
+	if (indio_dev->info->get_iio_backend)
+		back = indio_dev->info->get_iio_backend(indio_dev, chan);
+	else
+		back = iio_backend_from_indio_dev_parent(indio_dev->dev.parent);
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
index a6d79381866e..9d144631134d 100644
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



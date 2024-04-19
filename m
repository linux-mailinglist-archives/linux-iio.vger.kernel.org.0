Return-Path: <linux-iio+bounces-4366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F208AB211
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8111C2173D
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D73133981;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjYffbgJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A112FB16;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=amHxpyR82XbovW3/cHMKY0NQ1DsSsIv32OP4fZ/wYX6JvZDS9gPOl3DSIlYjbl1yaHXVqtcXqJx/Fqa18FfNUn9YMTD8vD/69c8WducALXVN4szDiR8FfAx83JKBi1LAWr7rRxZiPOkTWNR0ksFAx/VQb05GPYV8mukgxeZxqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=OT1f5HQ85Uw5dWLz6Hgn1lTmPE4744OaSYCe5yedbzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsUl+Ccuc6rnxpEF+J/T1dGvc4z+Y13QNxc6/HczxBSg3WzrkhFFl15AUsJC8U2ZoHTlG0bRoWd1UxI9dJyH6CeA7cJWoIfx9LQKwz6FfqQpEOZgJdbCpCFh0owUB53LLtZCF+7HdXX1E60pZUB6SUJM22udJ0zlC4O9S1HJrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjYffbgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB53AC3277B;
	Fri, 19 Apr 2024 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=OT1f5HQ85Uw5dWLz6Hgn1lTmPE4744OaSYCe5yedbzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NjYffbgJg3Q4Bxx6lFC9MCSFlCiUPp+9G2qjRzPe1CMzA5jYIka2dzM285FDtZ5ST
	 0GhnRe3Pdj0kw1ika+QCYn6vrqtCF4YbDeraU9BV7tE5lkHaEQHoqjdow2E88i9rcY
	 pM9AjLlSL3oVTOwhNg2vlMBbaBaCS5K6WS2iuDyPqLlhnyO/c+xxa5DTAmVAFrxGiX
	 mlrzUjgi8aOvKSawUaSnCL6Rpp4bZ21ni/+Kld8yDNEe46GSn5ztgcxzJScOTsGrep
	 UCsGYr6WPcOJFdRERzSlukAzKOTkBE39PV6A2VBMDmZ0DO6CR9yYZ6qsKiF7yVblMP
	 NGRDoPgdKRnJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C5AC04FF6;
	Fri, 19 Apr 2024 15:36:51 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:44 +0200
Subject: [PATCH 1/8] iio: backend: add API for interface tuning
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=7623;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UN9oAzFiKwoRseAjq8NdAF3wlTP1db9PUGQ2DM4QoRQ=;
 b=zrKmro4hJnByJECx3y8HxHJVzShYKzBsLW3PXbD9QqFSpirl9Mp95kNO7C5vmEUua+V078crW
 O+d96m0jpB5DkKcLVjxjWfjs6oMx8uMb20NKtTmFRMCxYYrFZTcNJMF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This is in preparation for supporting interface tuning in one for the
devices using the axi-adc backend. The new added interfaces are all
needed for that calibration:

 * iio_backend_test_pattern_set();
 * iio_backend_chan_status();
 * iio_backend_iodelay_set();
 * iio_backend_data_sample_trigger().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 86 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 57 +++++++++++++++++++++----
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2fea2bbbe47fd..45eea3b725a35 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -186,6 +186,92 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_format_set, IIO_BACKEND);
 
+/**
+ * iio_backend_test_pattern_set - Configure a test pattern
+ * @back:	Backend device
+ * @chan:	Channel number
+ * @pattern:
+ *
+ * Configure a test pattern on the backend. This is typically used for
+ * calibrating the timings on the data digital interface.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_test_pattern_set(struct iio_backend *back,
+				 unsigned int chan,
+				 enum iio_backend_test_pattern pattern)
+{
+	if (pattern >= IIO_BACKEND_TEST_PATTERN_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, test_pattern_set, chan, pattern);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, IIO_BACKEND);
+
+/**
+ * iio_backend_chan_status - Get the channel status
+ * @back:	Backend device
+ * @chan:	Channel number
+ * @status:	Channel status
+ *
+ * Get the current state of the backend channel. Typically used to check if
+ * there were any errors sending/receiving data.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
+			    struct iio_backend_chan_status *status)
+{
+	return iio_backend_op_call(back, chan_status, chan, status);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
+
+/**
+ * iio_backend_iodelay_set - Set digital I/O delay
+ * @back:	Backend device
+ * @lane:	Lane number
+ * @tap:	Number of taps
+ *
+ * Controls delays on sending/receiving data. One usecase for this is to
+ * calibrate the data digital interface so we get the best results when
+ * transferring data. Note that @tap has no unit since the actual delay per tap
+ * is very backend specific. Hence, frontend devices typically should go through
+ * an array of @taps (the size of that array should typically match the size of
+ * calibration points on the frontend device) and call this API.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
+			    unsigned int tap)
+{
+	return iio_backend_op_call(back, iodelay_set, lane, tap);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_iodelay_set, IIO_BACKEND);
+
+/**
+ * iio_backend_data_sample_trigger - Control when to sample data
+ * @back:	Backend device
+ * @trigger:	Data trigger
+ *
+ * Mostly useful for input backends. Configures the backend for when to sample
+ * data (eg: rising vs falling edge).
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_sample_trigger(struct iio_backend *back,
+				    enum iio_backend_sample_trigger trigger)
+{
+	if (trigger >= IIO_BACKEND_SAMPLE_TRIGGER_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_sample_trigger, trigger);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_sample_trigger, IIO_BACKEND);
+
 static void iio_backend_free_buffer(void *arg)
 {
 	struct iio_backend_buffer_pair *pair = arg;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index a6d79381866ec..ad793fe0d78c2 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -15,6 +15,19 @@ enum iio_backend_data_type {
 	IIO_BACKEND_DATA_TYPE_MAX
 };
 
+/* vendor specific from 32 */
+enum iio_backend_test_pattern {
+	/* modified prbs9 */
+	IIO_BACKEND_ADI_PRBS_9A = 32,
+	IIO_BACKEND_TEST_PATTERN_MAX
+};
+
+enum iio_backend_sample_trigger {
+	IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING,
+	IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING,
+	IIO_BACKEND_SAMPLE_TRIGGER_MAX
+};
+
 /**
  * struct iio_backend_data_fmt - Backend data format
  * @type:		Data type.
@@ -28,15 +41,27 @@ struct iio_backend_data_fmt {
 	bool enable;
 };
 
+/**
+ * struct iio_backend_chan_status - Backend channel status
+ *  @errors:	Errors occurred when sending/receiving data.
+ */
+struct iio_backend_chan_status {
+	bool errors;
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
- * @enable:		Enable backend.
- * @disable:		Disable backend.
- * @chan_enable:	Enable one channel.
- * @chan_disable:	Disable one channel.
- * @data_format_set:	Configure the data format for a specific channel.
- * @request_buffer:	Request an IIO buffer.
- * @free_buffer:	Free an IIO buffer.
+ * @enable:			Enable backend.
+ * @disable:			Disable backend.
+ * @chan_enable:		Enable one channel.
+ * @chan_disable:		Disable one channel.
+ * @data_format_set:		Configure the data format for a specific channel.
+ * @test_pattern_set:		Configure a test pattern.
+ * @chan_status:		Get the channel status.
+ * @iodelay_set:		Set digital I/O delay.
+ * @data_sample_trigger:	Control when to sample data.
+ * @request_buffer:		Request an IIO buffer.
+ * @free_buffer:		Free an IIO buffer.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -45,6 +70,15 @@ struct iio_backend_ops {
 	int (*chan_disable)(struct iio_backend *back, unsigned int chan);
 	int (*data_format_set)(struct iio_backend *back, unsigned int chan,
 			       const struct iio_backend_data_fmt *data);
+	int (*test_pattern_set)(struct iio_backend *back,
+				unsigned int chan,
+				enum iio_backend_test_pattern pattern);
+	int (*chan_status)(struct iio_backend *back, unsigned int chan,
+			   struct iio_backend_chan_status *status);
+	int (*iodelay_set)(struct iio_backend *back, unsigned int chan,
+			   unsigned int tap);
+	int (*data_sample_trigger)(struct iio_backend *back,
+				   enum iio_backend_sample_trigger trigger);
 	struct iio_buffer *(*request_buffer)(struct iio_backend *back,
 					     struct iio_dev *indio_dev);
 	void (*free_buffer)(struct iio_backend *back,
@@ -56,6 +90,15 @@ int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
 int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
 int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 				const struct iio_backend_data_fmt *data);
+int iio_backend_test_pattern_set(struct iio_backend *back,
+				 unsigned int chan,
+				 enum iio_backend_test_pattern pattern);
+int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
+			    struct iio_backend_chan_status *status);
+int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
+			    unsigned int tap);
+int iio_backend_data_sample_trigger(struct iio_backend *back,
+				    enum iio_backend_sample_trigger trigger);
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);

-- 
2.44.0




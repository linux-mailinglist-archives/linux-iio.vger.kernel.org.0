Return-Path: <linux-iio+bounces-4541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE98B3BEF
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70328B24F84
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCF155A5B;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxoaaDve"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAD14A4D2;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146149; cv=none; b=THM8ixQlVeSG01LsmKFW+P86rt93/ZxCdHp/w0hfea9d3OYVqs3R9lDsYbJbvnRElfDrqFImcd4/UI+H41HkuebFqtctDWXYR7oJJWaVGi71TP5KoxRJKHJvlsreKl60e2zMQ92dGmFB/qcg9AGXvD/0vyh4pjQyow5+pvuz/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146149; c=relaxed/simple;
	bh=Z3gkAYW2PvRjX044v4uYLZONVRdduJ/Nc9oceDNoIHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trA8QbZH7lS52VRACBgsnzP5yPcskK8VcYJeN7DWr0Ho2bY7IPxIGl3j4jBtrdbOk80MZxkIdNHtmdN2jLn7Jc1Z7XTcHiuTSrP77FX1kSuWSL2Qchn/uRvGzx7C6LYRNsZ4Z4hUalG+77mY1tEP4pEql4yPI6CAppaJYbyOoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxoaaDve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 820CFC2BD10;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=Z3gkAYW2PvRjX044v4uYLZONVRdduJ/Nc9oceDNoIHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KxoaaDveIkTqHVaog6WghPlZwOkl+zhhZxHikpDcedLWE5Z3LxUFc8MnqoDWhLTwt
	 1UMv2G7feSjpHHToKCf5s3e6vzXiJOTbGnumx7T6gkdpu8YCDc4tVcWC2K3zmBSshm
	 UT099+boUwBpjQUXt9EowY1B7UHm9oKTcCrUufH9yoXPxVW7ycZ6tb9nq+fc5w6ijU
	 fMSzpwR6YjMSmEiO3rdhqiFa2JNohqz6AKcZgUTVDzMTHKyE1wUAX5CcujkBnMRMkt
	 FSFMdK3k1+pR+d3dv0d1ypjtLt+Qs/kgdKv4Mt9wa13xQK1Vw4H3+jvvui0Yo6+DaD
	 IltTDuOWvPzYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A296C19F4F;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Apr 2024 17:42:11 +0200
Subject: [PATCH v2 2/7] iio: backend: add API for interface tuning
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-ad9467-new-features-v2-2-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
In-Reply-To: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=7643;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0GW9xMmjZX/fPa2quDrIgkmNJYy8YWt+hDOKn1LWW34=;
 b=+LcIXxjFLGc6l36uHZlZ2rJd5hGkaWOj2KOj8vmPD/H10yRFlWe1AcHwqFnIA50Y6b921l2YP
 qvl7l7yn/z9BXMrcnwMakqjGbf0emUOurJDetfiaerlmEwD/PHG12u/
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

Interface tuning is the process of going through a set of known points
(typically by the frontend), change some clk or data delays (or both)
and send/receive some known signal (so called test patterns in this
change). The receiving end (either frontend or the backend) is
responsible for validating the signal and see if it's good or not. The
goal for all of this is to come up with ideal delays at the data
interface level so we can have a proper, more reliable data transfer.

Also note that for some devices we can change the sampling rate
(which typically means changing some reference clock) and that can
affect the data interface. In that case, it's import to run the tuning
algorithm again as the values we had before may no longer be the best (or
even valid) ones.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 86 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 36 ++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index c27243e88462..929aff4040ed 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -226,6 +226,92 @@ int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_set_sampling_freq, IIO_BACKEND);
 
+/**
+ * iio_backend_test_pattern_set - Configure a test pattern
+ * @back: Backend device
+ * @chan: Channel number
+ * @pattern: Test pattern
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
+ * @back: Backend device
+ * @chan: Channel number
+ * @error: Error indication
+ *
+ * Get the current state of the backend channel. Typically used to check if
+ * there were any errors sending/receiving data.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
+			    bool *error)
+{
+	return iio_backend_op_call(back, chan_status, chan, error);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
+
+/**
+ * iio_backend_iodelay_set - Set digital I/O delay
+ * @back: Backend device
+ * @lane: Lane number
+ * @taps: Number of taps
+ *
+ * Controls delays on sending/receiving data. One usecase for this is to
+ * calibrate the data digital interface so we get the best results when
+ * transferring data. Note that @taps has no unit since the actual delay per tap
+ * is very backend specific. Hence, frontend devices typically should go through
+ * an array of @taps (the size of that array should typically match the size of
+ * calibration points on the frontend device) and call this API.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
+			    unsigned int taps)
+{
+	return iio_backend_op_call(back, iodelay_set, lane, taps);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_iodelay_set, IIO_BACKEND);
+
+/**
+ * iio_backend_data_sample_trigger - Control when to sample data
+ * @back: Backend device
+ * @trigger: Data trigger
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
index e3e62f65db14..8099759d7242 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -49,6 +49,20 @@ struct iio_backend_data_fmt {
 	bool enable;
 };
 
+/* vendor specific from 32 */
+enum iio_backend_test_pattern {
+	IIO_BACKEND_NO_TEST_PATTERN,
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
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -58,6 +72,10 @@ struct iio_backend_data_fmt {
  * @data_format_set: Configure the data format for a specific channel.
  * @data_source_set: Configure the data source for a specific channel.
  * @set_sample_rate: Configure the sampling rate for a specific channel.
+ * @test_pattern_set: Configure a test pattern.
+ * @chan_status: Get the channel status.
+ * @iodelay_set: Set digital I/O delay.
+ * @data_sample_trigger: Control when to sample data.
  * @request_buffer: Request an IIO buffer.
  * @free_buffer: Free an IIO buffer.
  * @extend_chan_spec: Extend an IIO channel.
@@ -75,6 +93,15 @@ struct iio_backend_ops {
 			       enum iio_backend_data_source data);
 	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
 			       u64 sample_rate_hz);
+	int (*test_pattern_set)(struct iio_backend *back,
+				unsigned int chan,
+				enum iio_backend_test_pattern pattern);
+	int (*chan_status)(struct iio_backend *back, unsigned int chan,
+			   bool *error);
+	int (*iodelay_set)(struct iio_backend *back, unsigned int chan,
+			   unsigned int taps);
+	int (*data_sample_trigger)(struct iio_backend *back,
+				   enum iio_backend_sample_trigger trigger);
 	struct iio_buffer *(*request_buffer)(struct iio_backend *back,
 					     struct iio_dev *indio_dev);
 	void (*free_buffer)(struct iio_backend *back,
@@ -97,6 +124,15 @@ int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
 				enum iio_backend_data_source data);
 int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
 				  u64 sample_rate_hz);
+int iio_backend_test_pattern_set(struct iio_backend *back,
+				 unsigned int chan,
+				 enum iio_backend_test_pattern pattern);
+int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
+			    bool *error);
+int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
+			    unsigned int taps);
+int iio_backend_data_sample_trigger(struct iio_backend *back,
+				    enum iio_backend_sample_trigger trigger);
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);

-- 
2.44.0




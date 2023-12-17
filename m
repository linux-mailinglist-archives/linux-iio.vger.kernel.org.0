Return-Path: <linux-iio+bounces-1021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9481613E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE431C22082
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1446442;
	Sun, 17 Dec 2023 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1gUXqCV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137331DFD8
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B8CC433C8;
	Sun, 17 Dec 2023 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834568;
	bh=zVlMgjkBVMnko79m39DfFVqqMMaSv3sovm3xd6i6fLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1gUXqCV/0vqfEsTbmK9KI3mD65qa/i0bOSjsyKN2uoXv8NEECuJ8Dzivj36xv+f8
	 6e7LQcXVR9RJaKkQhqt9OnKr5IsV+1Jli1kdUljtjcRtm+U41+lACYtCPwDXkX198T
	 PNxKaaDvX/3474s/5MvtyzziCeSJPfr0tLYvtS3aqR2/m5IbXZRKp5I5WCIhc5k50F
	 HNjW8gr9MtpJuica8kN8ic4ENJbRJwxHvEqYz8IRCdf/vJhso7W6PiABtv2DenHg+Y
	 nqhvsrBMltACj1pnhU2HLKgi3R7o6twVxzJAdaWTcN0pBy8E8mmtMuGoVShX3Fz/9J
	 TFCUTkNmWNbvA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 01/10] iio: locking: introduce __cleanup() based direct mode claiming infrastructure
Date: Sun, 17 Dec 2023 17:35:39 +0000
Message-ID: <20231217173548.112701-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
References: <20231217173548.112701-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Allows use of:

       iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
       }

to automatically call iio_device_release_direct_mode() based on scope.
Typically seen in combination with local device specific locks which
are already have automated cleanup options via guard(mutex)(&st->lock)
and scoped_guard().  Using both together allows most error handling to
be automated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c |  4 ++++
 include/linux/iio/iio.h         | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9a85752124dd..c333487bef70 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2131,6 +2131,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
  */
 void iio_device_release_direct_mode(struct iio_dev *indio_dev)
 {
+	/* Auto cleanup can result in this being called with an ERR_PTR */
+	if (IS_ERR(indio_dev))
+		return;
+
 	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
 EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d0ce3b71106a..9fd22b985903 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -644,6 +645,27 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
+
+/* This autocleanup logic is normally used via iio_claim_direct_scoped */
+DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
+	     iio_device_release_direct_mode(_T))
+DEFINE_GUARD_COND(iio_claim_direct, _try, ({
+			struct iio_dev *dev;
+			int d = iio_device_claim_direct_mode(_T);
+
+			if (d < 0)
+				dev = NULL;
+			else
+				dev = _T;
+			dev;
+		}))
+/**
+ * iio_device_claim_direct_scoped() - Scoped call to iio_device_claim_direct.
+ * @fail: What to do on failure to claim device.
+ * @iio_dev: Pointer to the IIO devices structure
+ */
+#define iio_device_claim_direct_scoped(fail, iio_dev) \
+	scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)
 int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
-- 
2.43.0



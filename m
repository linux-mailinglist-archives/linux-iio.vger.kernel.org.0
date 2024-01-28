Return-Path: <linux-iio+bounces-1981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EE883F605
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AF21C227FD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BEF23748;
	Sun, 28 Jan 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbvfsxtE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94B22F17
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454389; cv=none; b=gYpdkZQobyH5o/iFzASQd3steTXcyEa6U9C3hA3mvS98Ht11gQINHWZdg9alw2iNjRPNh6Q1xw0glFQeD20DkMdmAsvUN+GZQI+LrKDyYBkxxbN3LNvnwGpz6lmkpJ3a2jwc4C+btCXnUbOGPQ4zffn4GqnMdMGrFtRDoATljVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454389; c=relaxed/simple;
	bh=hjNOW+p0aQP2NeShdLjPEdtvJrwWqInAgQH8JRBSqPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4O0aO4mZcauH9JEU7Mj7gHL4LdX6QydAIkWu8uZNgcKpK7/W1svZUhKRe3hFJARAwcPcHN//BMp849hmOREOTYdUPXlf7IbmnbWVxm8Kt8MeBH1hZOFgRHjljrb0XCtH7icji1JN7izoq8TFC3TeK9d40K8gCm6O8wHAjrw7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbvfsxtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA03AC43390;
	Sun, 28 Jan 2024 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454389;
	bh=hjNOW+p0aQP2NeShdLjPEdtvJrwWqInAgQH8JRBSqPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbvfsxtEq7v+vIh0RxOU5+emBnv/AOu5x/Z6NOF7I1o6Us10oN7NG3XG0x9EsN8p9
	 PLJrK5CBi/4rf46PUEzsG/Sx5emFQVPkFx7PlIBw31sJK1f+1J8qt7Vlt+NF5rMNqd
	 8YWPDdpgPXKvHodWow9YW5TEWRldQQ5WK7DqsfGYoxBzGoK9OeU8FQlgEG1lf7r5VF
	 RBK4mv+99zv3jQxrRL0cJkhR7TrH2HLTxdvWz7WWst0HyI2xlJlgDdQ8VDpmQAsKeN
	 qjBpasYDKcAz5bWU78euok0+lWBH2CKy6m80LlsS4y2rsTltiS77Zaraa/FfoGtcOJ
	 wHvp7niLxirqA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/10] iio: locking: introduce __cleanup() based direct mode claiming infrastructure
Date: Sun, 28 Jan 2024 15:05:28 +0000
Message-ID: <20240128150537.44592-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128150537.44592-1-jic23@kernel.org>
References: <20240128150537.44592-1-jic23@kernel.org>
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
and scoped_guard(). Using both together allows most error handling to
be automated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Since RFC:
 - Drop the IS_ERR() protection in iio_device_release_direct_mode()
   as nothing in this new infrastructure results in this function
   being passed an error pointer.
 - Add some blank lines to make the header slightly easier to read.
---
 include/linux/iio/iio.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index c5b36d2c1e73..28e78af3614b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -638,6 +639,30 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
+
+/* This autocleanup logic is normally used via iio_claim_direct_scoped */
+DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
+	     iio_device_release_direct_mode(_T))
+
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
+
+/**
+ * iio_device_claim_direct_scoped() - Scoped call to iio_device_claim_direct.
+ * @fail: What to do on failure to claim device.
+ * @iio_dev: Pointer to the IIO devices structure
+ */
+#define iio_device_claim_direct_scoped(fail, iio_dev) \
+	scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)
+
 int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
-- 
2.43.0



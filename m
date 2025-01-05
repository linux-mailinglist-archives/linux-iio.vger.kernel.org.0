Return-Path: <linux-iio+bounces-13900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9FA01AD6
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163C8161E40
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251C159209;
	Sun,  5 Jan 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiOFvpHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422C8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736097990; cv=none; b=Hr2s1AaJ6oQczPVTWiA+PI2x08yj0chzEExK2aU0YqAmPPwyk9uxGxBWC36jo/xtFWuWZtegCCcUMO0ba3iTdVVTrX/SP59SrjcShtWKRZYeB753/CINy178L9U1iB+YVa63PvaT8DO9DmAf3+2uAT59lUSZ2VD/nWCLWoc2n/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736097990; c=relaxed/simple;
	bh=uEy7XfVyKiylyEn4Evs4DnAOBsFPscv+E6YjKvkF2ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c16zRhYXWYfLDw+zlSJDh1yVBD2aV2AJT3Ib283H4cSzGTVvVXCsbaE3EQpBevVCxbYKHZOO4bQo3xystlAZiphcF3VKrGKDRW1T8AgeYT4TbeK96wFexSe9nCgezO97w0420H4W+uB2nT5EPM85o0O/dWUkO24aBURTFZ3uxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiOFvpHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54685C4CEDD;
	Sun,  5 Jan 2025 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736097990;
	bh=uEy7XfVyKiylyEn4Evs4DnAOBsFPscv+E6YjKvkF2ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiOFvpHCe+094RCe6z3zcQ1jFk5jhqgj2FivvaBt4kwMe+Ce9qobHdoBwDy/652I2
	 7RCPu/dgLWqbtK6SR9gGwvJm6NtOJhvSXZh0a4u++CNuTJDpzOqasdsRoq0dXdnYZ4
	 8ZpNCpOLcVXY6gNu/99o1/Ga+g3vax3N0mpJhH7Eb2j9WECQkS3GGvSMPoCLZrUrMp
	 8P+Qfu3yUHowaCwPRwK+mhzg9e69PyosI1vv3Z49e3pL0xJrwGQY71ZoaB31rSXG9F
	 CEY3VS3FFmG1qcnmPNoJVdiAmv78RjIi+kuVevdT0UhUTlFujL6nVQok1A/fImqOw3
	 Ejm93QgGRRkfw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 01/27] iio: core: Rework claim and release of direct mode to work with sparse.
Date: Sun,  5 Jan 2025 17:25:46 +0000
Message-ID: <20250105172613.1204781-2-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Initial thought was to do something similar to __cond_lock()

	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
+ Appropriate static inline iio_device_release_direct_mode()

However with that, sparse generates false positives. E.g.

drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock

So instead, this patch rethinks the return type and makes it more
'conditional lock like' (which is part of what is going on under the hood
anyway) and return a boolean - true for successfully acquired, false for
did not acquire.

To allow a migration path given the rework is now no trivial, take a leaf
out of the naming of the conditional guard we currently have for IIO
device direct mode and drop the _mode postfix from the new functions giving
iio_device_claim_direct() and iio_device_release_direct()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/iio.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 56161e02f002..4ef2f9893421 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
 
+/*
+ * Helper functions that allow claim and release of direct mode
+ * in a fashion that doesn't generate false positives from sparse.
+ */
+static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)
+{
+	int ret = iio_device_claim_direct_mode(indio_dev);
+
+	if (ret)
+		return false;
+
+	__acquire(iio_dev);
+
+	return true;
+}
+
+static inline void iio_device_release_direct(struct iio_dev *indio_dev) __releases(indio_dev)
+{
+	iio_device_release_direct_mode(indio_dev);
+	__release(indio_dev);
+}
+
 /*
  * This autocleanup logic is normally used via
  * iio_device_claim_direct_scoped().
-- 
2.47.1



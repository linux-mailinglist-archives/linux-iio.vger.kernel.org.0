Return-Path: <linux-iio+bounces-14995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BAA27C52
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ADE1650E5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555D1FA15E;
	Tue,  4 Feb 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzvbGM7d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C81CEEBB
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699388; cv=none; b=Qe0pGBPMXoFWvSE3lQHdknSvwZueoLxX8IAaBinRbjgPNQVHzKvBYSR42w/qz+v55tjCJG4/9dkxVce2Xy557jWQWefNWYuu97+EC/1Q/2NjT4iTpOAkuxLyy+331I3BEH4kOnjw6RpYxhmdjs3EnZftNU+LWw2gbECvkfJYs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699388; c=relaxed/simple;
	bh=IQXZ9uesiy3SKg/FgVYHBeGKICU2SVFd1r1iTn5DSwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di/Ttvc61CE0+rsXj90fHWaCk9JYKpYQXmdOEaWEg9r+nquviNUis3uLajiueC556DqYL+tKJ1KnoF7XDtSK6tg9lhL6TKVymprEmWu8veXTTrZgNZc1VC0v9Hv6geJOtV+6TuhlF8UZon8OOmLeHD3vF0TyxGYS1scj9Fz5EdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzvbGM7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FF4C4CEE2;
	Tue,  4 Feb 2025 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699388;
	bh=IQXZ9uesiy3SKg/FgVYHBeGKICU2SVFd1r1iTn5DSwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzvbGM7dLi5DIkUExtl09itx7N+/jGpQvQYS9RLahapKxGyGZZ5k0N2c/nhPALUtn
	 rMTaZOvvrHpOgeOBlBUEwhnkejDT8sWfg0oh2yuNMKvolmVvaV2obXkicIsX6Opv4F
	 ecdoNLaQ3DX0Umfrri5DlrRsjdLd9ROOCu96WVPyT9pNayabebeMP17fUsmTf5vuAn
	 qxrhis9SD7X9NPpOqC8lQGpQ09eeeX89KKQ3HJnQXLLfwbMHlYtnzkTQpJaPP9vzxE
	 RB1JhtgvTuhNOoxqzCwf+w2k5hvAdvJ6E6+Wdr82/8sM9IvSEAmas8d95DjqBn3bqx
	 SKXu5X3KsCZNA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/27] iio: core: Rework claim and release of direct mode to work with sparse.
Date: Tue,  4 Feb 2025 20:02:23 +0000
Message-ID: <20250204200250.636721-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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

To allow a migration path given the rework is now non trivial, take a leaf
out of the naming of the conditional guard we currently have for IIO
device direct mode and drop the _mode postfix from the new functions giving
iio_device_claim_direct() and iio_device_release_direct()

Whilst the kernel supports __cond_acquires() upstream sparse does not
yet do so.  Hence rely on sparse expanding a static inline wrapper
to explicitly see whether __acquire() is called.

Note that even with the solution here, sparse sometimes gives false
positives. However in the few cases seen they were complex code
structures that benefited from simplification anyway.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v1: (Non RFC). Drop the __cond_acquires and __releases markings
   as sparse support is not yet available.
---
 include/linux/iio/iio.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 56161e02f002..fe33835b19cf 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -662,6 +662,31 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
 
+/*
+ * Helper functions that allow claim and release of direct mode
+ * in a fashion that doesn't generate many false positives from sparse.
+ * Note this must remain static inline in the header so that sparse
+ * can see the __acquire() marking. Revisit when sparse supports
+ * __cond_acquires()
+ */
+static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
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
+static inline void iio_device_release_direct(struct iio_dev *indio_dev)
+{
+	iio_device_release_direct_mode(indio_dev);
+	__release(indio_dev);
+}
+
 /*
  * This autocleanup logic is normally used via
  * iio_device_claim_direct_scoped().
-- 
2.48.1



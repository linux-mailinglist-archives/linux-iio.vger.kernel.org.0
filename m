Return-Path: <linux-iio+bounces-15194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B92A2DFB0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C5E1885396
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C891DFD9F;
	Sun,  9 Feb 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOc5JHj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738431DED7B
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124408; cv=none; b=rjPAEOxOqJBprxFv/iyllXPbIwItMxwnXlrcaYaj6Q8dPhst70SaLK3B3XVKxSHdle8b28fwNeDUS28QmBSCymH8r3cfR2d5YlQdU8OgnvuyAs7bpC4SoE8uO3/O3Sqd24crhCbqgXMKEtkolC0ivXmKXm0DcAWXo+PaNk4HnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124408; c=relaxed/simple;
	bh=qOTqh1nP4UcSxvI6b8/TEnuk9ArZHvSLvRZLr6Q7trc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxNs6H4V+7nr8/jXkpW/eeOb9mAQ3HUv5KitAMY9VLJe/dyV0XI/3jDeKtylrjwOQ8m6NxPkIwjAVHjtOU0rlk5PhRqUuQ1alB3Gc09bqtBi5EO2jPYFEPaoBdAQnBicetBtLah+h5s6OHu/RWsS8TxpKcIM7EPDXFdh2G3UuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOc5JHj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C859FC4CEDD;
	Sun,  9 Feb 2025 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124408;
	bh=qOTqh1nP4UcSxvI6b8/TEnuk9ArZHvSLvRZLr6Q7trc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOc5JHj4UEHKs6dNHDxOw6dvaJ9Qhp0l3GAkGBB11jQyQNa/WgMhgS+WOSGxNpYj7
	 dFLUXbUA7fel43t7kwwE+xrOo6WJGH49bb9NZS3XEkO4ex9SKRON4Dxc1hAK92kf7q
	 imRzXa91w/FeCWwx9htXr3etts+Q4AsgE5GuFQYOftzTJwNpj67t4fuci5+S2Aq1VP
	 pSi9w5J4LpWhqOByf0L45VaPyTe40ekTNSNi4wmCcX0ifd1iMqfu+0Q18jJlIM932e
	 L7y1zsg6nrIAO38fvF08eC6/ARtgkxe1jH0P+S43YsxnQ/PyEoPRferEPbGk6YemgB
	 9KgTXtD/2sYBg==
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
Subject: [PATCH v2 01/27] iio: core: Rework claim and release of direct mode to work with sparse.
Date: Sun,  9 Feb 2025 18:05:58 +0000
Message-ID: <20250209180624.701140-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: include linux/compiler_types.h (David)
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



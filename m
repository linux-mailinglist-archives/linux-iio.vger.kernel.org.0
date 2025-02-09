Return-Path: <linux-iio+bounces-15220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE8A2DFDB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595EF3A5632
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158231E1A2B;
	Sun,  9 Feb 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlTmbiJI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73181E0DE6
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124602; cv=none; b=ohaDewu0OIYk1a3kCjTKc/+J/GBRF31XQqNdkc5GNNwAJ2qyeGB7SVrSn0f5jgoOqu2sdrdbXXEAvjYT7AGRsb2zhR8YNJoHTao4m9qtoZJBa0lLx83h99LMKeGFL4+EFGZBT18BFwGnCoAIfzcZPkmAxQQgGNsT6r9z/iI/zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124602; c=relaxed/simple;
	bh=fY6hpho4foOpaaWUGmCtoNz30s9hMcjXQlHYpoZRKQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBUfypDTIkXJE2VjjAmGlrk3Duza21+8zGVDOncLxNztAPEon5nI315KUt22TCfjbK9JSwAqv+p4P0qkklkeKBQVG+0sQ6mL+7A8ZfeC/6IdQuMwR+H86SHz4clyG4EVOlI9Ufw6zWkjQOCadnSxQEwexnrMOOEK+UBaOj8wEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlTmbiJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2BDC4CEDD;
	Sun,  9 Feb 2025 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124602;
	bh=fY6hpho4foOpaaWUGmCtoNz30s9hMcjXQlHYpoZRKQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlTmbiJI4Pt7nlkIvLrpb+cWTn7zp7erRAJoqfSQF18aMvNKOEpwCP+4sMg0JB4TZ
	 CYGwqpy0idOZsSo6IoVWA5j+eCNoO4Rx3gVooNccNmlMIIO6Y2KtSOGOdBuAeweH34
	 j/i3VkeocqPx+ePAq8E+QawawfVfiTjjxJooLywRfgvBJlbnsH22YfbYuDhsjUpIKL
	 caZj7jbhIEwbH7OfoH7FSCjQzCqNmoiytcKpoyiUlR+9kEnUXCe6F50+mUadGrGS90
	 AW1gBn1wLbQg1AwQGVchJnmdbuwUU9hM9jA/dFF5yHaNEs6GDxgyogerjjQBk5OPFO
	 HPhxOZeoyJBaA==
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
Subject: [PATCH v2 27/27] iio: Drop iio_device_claim_direct_scoped() and related infrastructure
Date: Sun,  9 Feb 2025 18:06:24 +0000
Message-ID: <20250209180624.701140-28-jic23@kernel.org>
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

Scoped conditional automated cleanup turned out to be harder to work
with than expected. Despite several attempts to find a better solution
non have surfaced. As such rip it out of the IIO code.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/iio.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 5ed03e36178f..07a0e8132e88 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,7 +9,6 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
-#include <linux/cleanup.h>
 #include <linux/compiler_types.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
@@ -688,32 +687,6 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
 	__release(indio_dev);
 }
 
-/*
- * This autocleanup logic is normally used via
- * iio_device_claim_direct_scoped().
- */
-DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
-	     iio_device_release_direct_mode(_T))
-
-DEFINE_GUARD_COND(iio_claim_direct, _try, ({
-			struct iio_dev *dev;
-			int d = iio_device_claim_direct_mode(_T);
-
-			if (d < 0)
-				dev = NULL;
-			else
-				dev = _T;
-			dev;
-		}))
-
-/**
- * iio_device_claim_direct_scoped() - Scoped call to iio_device_claim_direct.
- * @fail: What to do on failure to claim device.
- * @iio_dev: Pointer to the IIO devices structure
- */
-#define iio_device_claim_direct_scoped(fail, iio_dev) \
-	scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)
-
 int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
-- 
2.48.1



Return-Path: <linux-iio+bounces-15022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DCA27C79
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670F77A225D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951A2063F9;
	Tue,  4 Feb 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijjsQbCL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBA14B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699525; cv=none; b=K31KOkuuaIZ/iBzU5sTH/2KbTSEdnUaI7GS/QeXHJxHEErqzGQplIan6saCsSIVFqVVOti7wQN/glhz+jmHH0ANlqWMnCIXOWK2da3MVRa8I2rrz2UIvFy3bVupsd1Aj6jq6QU3SaAhYf6lN/MsKYGretzop30JS3dDxHAssiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699525; c=relaxed/simple;
	bh=j704jEM6zRl8dthwMF87HDqSIh2q28YaY8n1BVqvnxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw0NmM4++a//BgT4nI6qQELOMbD+pSQQWmp3jzYSlxwAHc2SKCupsBzPHae+wmCrzE0tl3IEDoTc3n5hkaY6hOEAv1KaSbklAta0JYZ/JzDCCH/1Llb4WDbJxwt3fRwoy9dD0QMdfs43Ddz0nUTU3Cws7zs8Qf6kbCNRdgoIMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijjsQbCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1F2C4CEDF;
	Tue,  4 Feb 2025 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699524;
	bh=j704jEM6zRl8dthwMF87HDqSIh2q28YaY8n1BVqvnxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijjsQbCLbSYa4N+/U4AUW5PuTkzRsZ9BQQ0B6mRvM4FB148/YWt8LccharDb0i5RU
	 RwuRBkGQPBANyFCz/5h3HpzsfweWaRJBZfFSIccvAiXRjhB+KREGqcsxF3mtUezLYl
	 0ST4XfyfDPh8B4VLG5nnRVqNIRpjzbZJ+iqJyHDyCsGBeT+FAVNt8uDLro+prERfIf
	 BDyoL/k/EIN0VDfJEDeawLixn8x/ZQXlvv2fwUKGnEwpNR8JaTaSUDfEI6pIOF5bWC
	 Y4AqLVa7+DYAs9g7f4a6P7fNZBwXfwxZquwV5dKqTungZoNDvXaK8eviJMBViDokCu
	 Fyl00NkUdLcjw==
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
Subject: [PATCH 27/27] iio: Drop iio_device_claim_direct_scoped() and related infrastructure
Date: Tue,  4 Feb 2025 20:02:49 +0000
Message-ID: <20250204200250.636721-28-jic23@kernel.org>
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

Scoped conditional automated cleanup turned out to be harder to work
with than expected. Despite several attempts to find a better solution
non have surfaced. As such rip it out of the IIO code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/iio.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index fe33835b19cf..f8541468d391 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,7 +9,6 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
-#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -687,32 +686,6 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
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



Return-Path: <linux-iio+bounces-17692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9409A7CF1D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951313A71E7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AF11714C6;
	Sun,  6 Apr 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKLKW/b3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B41487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960030; cv=none; b=KjhIfG8VXXnsPoz2ZaaCCI3H10jskcArPQQFxhOdQxuHCm+5UuGzbYNOQnErxeLJkGfVlpJdZaN7k+aLUL/vbJHehQuvZFZiTjTAhZGVPvgDgMYbyEusiwl9Ley5SV0T9cVqZUc6si/86xpgVQcjt0h94fgCji+9IGiTPppNH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960030; c=relaxed/simple;
	bh=WgCBp8Ztrk5AA/HvkspT5LSPAsx73/TNUTk5OZkhF+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSW8H6A4ZBwWRgl2CwA3oe+Npq8dAgrc2f5uYG+siDajXZdE05BOJ32xxMF5XRhUaReEvk2rdSMBG7Q//B5Y/xGzzbLbODu+0IZJBvG7BHcYQXR7vxS8UOxmRlkLeY+3EhV/UZBkYYBrwlhU7we3WOLXRgJBv0Iphqz5RGkL/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKLKW/b3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7A3C4CEE3;
	Sun,  6 Apr 2025 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960029;
	bh=WgCBp8Ztrk5AA/HvkspT5LSPAsx73/TNUTk5OZkhF+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKLKW/b3dvxkAU7MbODc6vI1HmrXN4jknkYQMb0XDdUm4GsABVpppAPJbfQ4LPYgZ
	 XdbU0PwFKFf9lwClIDMpm/ZjssvmXw3cOYhEtyNclZyvo8CKJI6xIhurECAflvIVFP
	 pyWxEASawKmPnZjVekwFa29zcAFC0HXuYqQjONC6+HlijoIY04U6+iiohDtkBE/pvO
	 fvcxC0uM7NCRPPI3SQ5N91wSrg1Vxvgvyh9r4AjGuUiDHKwcRFycfscjBpgSQa/KqO
	 br02cgJwWqZhRdfYmKus8YtIoD78wgFoTSQDrqoB5sgv0Uosp5rLUJy1IZrdHYwTIx
	 Vtp3DcnVMFrOg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 04/20] iio: accel: adxl355: Make timestamp 64 bit aligned using aligned_s64
Date: Sun,  6 Apr 2025 18:19:45 +0100
Message-ID: <20250406172001.2167607-5-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The IIO ABI requires 64 bit aligned timestamps. I this case insufficient
padding would have been added on architectures where an s64 is only
32 bit aligned.  Use aligned_s64 to enforce the correct alignment.

Fixes: 327a0eaf19d5 ("iio: accel: adxl355: Add triggered buffer support")
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index e8cd21fa77a6..cbac622ef821 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -231,7 +231,7 @@ struct adxl355_data {
 		u8 transf_buf[3];
 		struct {
 			u8 buf[14];
-			s64 ts;
+			aligned_s64 ts;
 		} buffer;
 	} __aligned(IIO_DMA_MINALIGN);
 };
-- 
2.49.0



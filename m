Return-Path: <linux-iio+bounces-18847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3BCAA0FF3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095CB5A09D7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6F21B9E4;
	Tue, 29 Apr 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbD3+7D2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038421ADC2;
	Tue, 29 Apr 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938943; cv=none; b=QkMkuIhIL1aaM1vYGtVATCsw59sBC+I1xJQzNI08CCLSmJvvKV4zsZHkGpFopgOLCfxMzw4/8X/IWdP5o6blFEIWjfCOljNExZ82ErmT457VlkHdv1+vc2tdrI7HpRjIXAfxF4I8Bdctf9rzpoCwELUB6TTgmAUiXcjG1WRRmgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938943; c=relaxed/simple;
	bh=tAuGyI1OCFBQWPeNVDRkn9CwPlpQwUXg/+69JbVSDP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z17Tdv4ofPqle3qZcFChMpW5JcZkL+LixczbnTHPpidhucSAKBSqAdLl4kDt3m3H6bjAyUbzSdP6J6PrQEjnvlWypuHEr7ry6P9IvBFOjWpG8TbyL/nINVN2bsnHjFDb0P4v4ywej/iHJVGZMs91aUl8UNo+j6x6JmNHedV3hDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbD3+7D2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7394945d37eso5309126b3a.3;
        Tue, 29 Apr 2025 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938941; x=1746543741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eY7XME2pWvlEXcL6Sdf1befWtNH2qmsQQOtaLI/8Q9I=;
        b=hbD3+7D2dx78v71I2po0maKM8PluSL9qPIJNViESXXmTfS1Yy7OCM/8RHsQIyxkMmw
         XTbqbJpG1pPUQhUk3/84pqTzfg8EbvUwNdZiQyGlDKoWYbDzvmKjEccKTMVuuqZuVDCK
         sgbs0SLIito07BMVMjGCPl5NzRvTLzb9XVDnWqOvpUDJ7yZUSzkuLbF+M7Vni0zpfNoM
         FW30osb8u0tIrDJ7bAKvws7/76zE7EY+2kAq2WzRnAqaIzptqpCAGW8TrnvQqOzQMWgC
         L4Jy+hVCLgqrjkmsqUDp60PYqJhU8eQ3izXvBNoZCGBQ1eLYTy5KDrH+kBzVoI5/PDrw
         Fapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938941; x=1746543741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY7XME2pWvlEXcL6Sdf1befWtNH2qmsQQOtaLI/8Q9I=;
        b=QK+i70EceKWU1c/qa09nWSQfHdkG57nj5f15nxZATP8zX0pWKsz36agtLgisKuWIEx
         s/dPURHGHP2ff0XD6a6oZRZpFa0GwuNRu0yJTtp2az0YIHfKFy/d5w1STX5j6WlzPD5f
         w66aKAy1vYrSph1bxUKosYKwt+B0XJ5gYrC2Qd7NAeIu8f9rey3k9ax/sxCq3CwUe9qP
         NR+WRdwI/OZJ4XbrfhUs2heCL64nfx4KVJKa6ScgeB7pHKf/LQIDZXxBFw7r7LevpCoe
         uBgltbin/hsvqugjS2FzopYsDldvTrIkE7wJXfav32fQ70nA2JgcE3OA45gCHYd+DU3s
         4FPg==
X-Forwarded-Encrypted: i=1; AJvYcCUq2EwevDWfq1uwmsbOCPmzJE7wsypOwKKUqsCWzlVLUUkd+NdErlfz9oEjZT2gIazf/pYsbXof@vger.kernel.org, AJvYcCWvanGd1wbeYysoNhR8XqXKW4IZAJJUEAV4prjXNFF2uzRVi8DSx+GG+deHI0Fvr85RghydhvVqyHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqONLQfm14VkbyDouUugX9ttlcP+9y19Zw4q2I4SWFNG9SSYz
	Hg8JyVYuMFi1J3T+YI1mWjXZVaJt7/eWMeN8fHaCWPBuPAm7x15vp2Bsxw==
X-Gm-Gg: ASbGncv4p+ASfklkHPY1hDBJr7f3j0+OjxKqffTc+x7jIk7jZYYHzpNf3SdC9ReiFr6
	Gd6K1PylH/8DbfMHz9inuDDlF92VCueoYPuZDkc1+hY6ZnJPcxdF8Bkq5lJDaceFtI2jcaFpfkI
	5EA1UeqBOh9+apq0NQfe2+aYLGuv21g0fj3c/qzhhgKIzBxJ9uwnNNVEwGITdzCXEGrMdsboVHx
	odJQIJV7sbI7MF41J3T8dSTKf5XGkJvhLDZzINzDdsro3tJ2gjIoBVRjChVI/MzIEiSKqAWUTjh
	cXWMQDBhKgg6EI+JO1frqLG1ZttLa6/0CKUkYD/IaxpMxWcH/nwAzAs=
X-Google-Smtp-Source: AGHT+IGJWPKuqb++uzAeMhvjuy1HD1u5/s4UVbIXxEwOZncnIYhQGbhFWL8X31NPUA0T+fGmAZrZlQ==
X-Received: by 2002:a05:6a20:c886:b0:201:8a13:f224 with SMTP id adf61e73a8af0-2046a47380dmr18619658637.22.1745938940845;
        Tue, 29 Apr 2025 08:02:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f8bb:f2b1:5469:86ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e2593f557sm9955758b3a.42.2025.04.29.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:02:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iio: Fix scan mask subset check logic
Date: Tue, 29 Apr 2025 12:02:12 -0300
Message-Id: <20250429150213.2953747-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
verbose and misleading warnings are printed for devices like the MAX11601:

max1363 1-0064: available_scan_mask 8 subset of 0. Never used
max1363 1-0064: available_scan_mask 9 subset of 0. Never used
max1363 1-0064: available_scan_mask 10 subset of 0. Never used
max1363 1-0064: available_scan_mask 11 subset of 0. Never used
max1363 1-0064: available_scan_mask 12 subset of 0. Never used
max1363 1-0064: available_scan_mask 13 subset of 0. Never used
...
[warnings continue] 

Fix the available_scan_masks sanity check logic so that it
only prints the warning when an element of available_scan_mask
is in fact a subset of a previous one.

These warnings incorrectly report that later scan masks are subsets of
the first one, even when they are not. The issue lies in the logic that
checks for subset relationships between scan masks.

Fix the subset detection to correctly compare each mask only
against previous masks, and only warn when a true subset is found.

With this fix, the warning output becomes both correct and more
informative:

max1363 1-0064: Mask 7 (0xc) is a subset of mask 6 (0xf) and will be ignored

Cc: stable@vger.kernel.org
Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/iio/industrialio-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6a6568d4a2cb..855d5fd3e6b2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1904,6 +1904,11 @@ static int iio_check_extended_name(const struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
+static int is_subset(unsigned long a, unsigned long b)
+{
+	return (a & ~b) == 0;
+}
+
 static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
 {
 	unsigned int num_masks, masklength, longs_per_mask;
@@ -1947,21 +1952,13 @@ static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
 	 * available masks in the order of preference (presumably the least
 	 * costy to access masks first).
 	 */
-	for (i = 0; i < num_masks - 1; i++) {
-		const unsigned long *mask1;
-		int j;
 
-		mask1 = av_masks + i * longs_per_mask;
-		for (j = i + 1; j < num_masks; j++) {
-			const unsigned long *mask2;
-
-			mask2 = av_masks + j * longs_per_mask;
-			if (bitmap_subset(mask2, mask1, masklength))
+	for (i = 1; i < num_masks; ++i)
+		for (int j = 0; j < i; ++j)
+			if (is_subset(av_masks[i], av_masks[j]))
 				dev_warn(indio_dev->dev.parent,
-					 "available_scan_mask %d subset of %d. Never used\n",
-					 j, i);
-		}
-	}
+					 "Mask %d (0x%lx) is a subset of mask %d (0x%lx) and will be ignored\n",
+					 i, av_masks[i], j, av_masks[j]);
 }
 
 /**
-- 
2.34.1



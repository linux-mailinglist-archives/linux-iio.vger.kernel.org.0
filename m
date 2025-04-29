Return-Path: <linux-iio+bounces-18877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF86AA1BEF
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A711BA7907
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AB25F963;
	Tue, 29 Apr 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiTykfXa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0E255E47;
	Tue, 29 Apr 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957846; cv=none; b=l70nzTbqht3AnaDfaQCT1vwh7PtT2sNa/s2qbWQUmXFCos2h8jRwStaEjj1v0qUuaV6dBscdCb2IZLmk8rFNdBGZ7gb1fMOtAj6o7YktDSAOEphyufv3k/SBLN7qC+ANogRRb2ERM0VJhywPactNMQUCUo2Mr78iFwikEZEZqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957846; c=relaxed/simple;
	bh=b9P+UgfataMe9npFhujSSCw+NSSe9o72LKW7kLG5rr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pmxpUhr5V5gyDcfmf3dDXW1B1qv9A4/rFguvMklXzQdTTW0NPwQhJmRVEEg63vnrsx41EhPmseXf2BAHyBGJ2HheRyHpbKfnju4QHJtIUaheIEdSJ/yaIA9Aubwp1L7Zas8QVGOEXgSDhc/RLCMHnyo/dd9JNqLvlTLPTYkwtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiTykfXa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7394945d37eso5641092b3a.3;
        Tue, 29 Apr 2025 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957844; x=1746562644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41KIlBf5hSX/uHIrku9Oh5MYW0T9yTr5WYUE5uD2rjo=;
        b=NiTykfXa3t33zf5COm3fwU+8I1c4NBB2gONuD00YS6PvEzBQtaJ7e0KKmlwIKSo0aN
         TJYY+r8IJXbyFFqWcqAIwSy3VFCLvXnohCnu3qQIrlsVU7m6JnRfO6m9gX5FnI82DwN+
         XNi83iNo8cYxsn9lKs7maz87mqIMPxLHef6uweW09dkU/ZTw8/hP9ThGzpKILxNWDiBf
         0SfYJLF4fMYDYtO/d/fpJ7sCUIUtaL9Tx8fCpyrBKE1LZwe9cUgj7FP2PJKTS0Fr5yKz
         dhF8XV5DWuQgRMQzC/F3YUHloRfv5Hxz1OKCAMbiNA05nGvzFmuo9SBNVNpx3UwysziU
         qitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957844; x=1746562644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41KIlBf5hSX/uHIrku9Oh5MYW0T9yTr5WYUE5uD2rjo=;
        b=bk6NnqkvUe0HoPpQBz963Op48w9tPtAI+bRCx5qrodOjQ5aky6/ZWRSXEYI7MRz/wZ
         zCNjJRVv2QBK06jm3dv9gAfZLXEHcC+YktwrmJEDFnuYq20yhNqG6kQoGmabvEWJczQB
         508Z3j1fDgslB2QFt4wJNhM4ZcMWR+soQr0M18tXA3/us4MrxsnSmAKwvnFhaJ4yYxrg
         36am1hDEAjJxWeCFQ2AJw2G/zjKc4RUqFxnEXxwUz4EwDCzP1XJ2YQxe7n5w0B0YzY0T
         Sazni/Wl/D8kUmZp5xJZADgPQVXeS++jcoG1UWpQzGoeAZ3bIS7nAc2m5vBBhmXZzs5u
         5dkg==
X-Forwarded-Encrypted: i=1; AJvYcCUFcnvxIwUbOJEs6VtdCgfUssshByvmUGf8IkC+T5MXDP7PvGpKU0iNd9FbAwUcQ5FYwwBuVZPH@vger.kernel.org, AJvYcCV8GkSfRc7jG6g0HRnrE6vj2jKh4T0ZZ3zyETCMCGr1e0ShqdkFp15yQ2LlrKkn8udmTAch/V2UCB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWGHbRpyFKAmPETfsQ67Aiopkrgot5DK8Wgy5K9IKilLYsWmb
	K97kolYxFRa6576AO1K1jlN8fxH262hJPcZfzFzKN4yJfZtlf/jQ
X-Gm-Gg: ASbGnctvh4YIPkUZQEQN+EibdDmeOtA8HttsyuokLovE9ZeduRfZ+88GQA0zoj0ILXe
	QpsAP3gENISY/v7MrlZz543pw01hK+ZPqDcd1Q1UMzgXIsv+akPSFJsl+IC+hMGMQdvX7qbQYmf
	TSWl8XMqhdoUT4VCMSsOYOn0WQ6lOZeghfxEgRL215kXwo+6gyiDWxT869ZN/jHwqOIjQxYAbE0
	/a7VqEomCfcAE0v6C852FOXq0/Q0pNcOMvtg0ZsII9PvM47pZRQ1lswumLUmsrs07JtzgmBvEqt
	5HL/sExIOhnKEtSATxpl4Mf/ltOa3P34XqiDnh3aKeweW9ogyp5vZe0=
X-Google-Smtp-Source: AGHT+IHIvcZbvATI08dSByUBSlIDE1R4Ii7zq+IVJrcwHGm3PKguVgOZYb/QgtAWtyzb0+gxHXVBxw==
X-Received: by 2002:a05:6a00:4b08:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-74038a8793amr654527b3a.17.1745957843854;
        Tue, 29 Apr 2025 13:17:23 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3606:d9d6:5c0a:1caa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a90e29sm88619b3a.164.2025.04.29.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: Fix scan mask subset check logic
Date: Tue, 29 Apr 2025 17:17:17 -0300
Message-Id: <20250429201717.3066511-1-festevam@gmail.com>
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

Adding some debug prints show that the mask1 and mask2 indexes
are incorrectly computed, leading to wrong array access.

These incorrect accesses causes the wrong subset output:

iio-core: ******** mask1[0] is 0x1
iio-core: ******** mask2[1] is 0x4
iio-core: ******** mask2[2] is 0x3
iio-core: ******** mask2[3] is 0xf
iio-core: ******** mask2[4] is 0x1000
iio-core: ******** mask2[5] is 0x40000
iio-core: ******** mask2[6] is 0x3000
iio-core: ******** mask2[7] is 0x0
iio-core: ******** mask2[8] is 0xffff0000000e2720
max1363 1-0064: available_scan_mask 8 subset of 0. Never used
iio-core: ******** mask2[9] is 0xffff0000000e2660
max1363 1-0064: available_scan_mask 9 subset of 0. Never used
iio-core: ******** mask2[10] is 0xffff0000000e25a0
max1363 1-0064: available_scan_mask 10 subset of 0. Never used
iio-core: ******** mask2[11] is 0xffff0000000e24e0
max1363 1-0064: available_scan_mask 11 subset of 0. Never used
iio-core: ******** mask2[12] is 0xffff0000000e2420
max1363 1-0064: available_scan_mask 12 subset of 0. Never used
iio-core: ******** mask2[13] is 0xffff0000000e2360
max1363 1-0064: available_scan_mask 13 subset of 0. Never used

Fix the available_scan_masks sanity check logic so that it
only prints the warning when an element of available_scan_mask
is in fact a subset of a previous one.

With this fix, the warning output becomes both correct and more
informative:

max1363 1-0064: Mask 7 (0xc) is a subset of mask 6 (0xf) and will be ignored.

Cc: stable@vger.kernel.org
Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Make it a standalone patch. max1363 fix will be sent later.
- Keep using bitmap_subset().
- Add more information about the error in the commit log.

 drivers/iio/industrialio-core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6a6568d4a2cb..dabfcb50e5fe 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1947,21 +1947,13 @@ static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
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
+	for (i = 1; i < num_masks; i++)
+		for (int j = 0; j < i; j++)
+			if (bitmap_subset(&av_masks[i], &av_masks[j], BITS_PER_LONG))
 				dev_warn(indio_dev->dev.parent,
-					 "available_scan_mask %d subset of %d. Never used\n",
-					 j, i);
-		}
-	}
+					 "Mask %d (0x%lx) is a subset of mask %d (0x%lx) and will be ignored.\n",
+					 i, av_masks[i], j, av_masks[j]);
 }
 
 /**
-- 
2.34.1



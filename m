Return-Path: <linux-iio+bounces-26820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD9CAA199
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 06:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59BBF303BE31
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 05:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3905718D658;
	Sat,  6 Dec 2025 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq6NL0CF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49B136358
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765000145; cv=none; b=i6B0F4LtxOsywB9Z641kfKoBWJ9OZFOnjJ6TO8U9eHVYQNeEY1edkZ0dbcfiAdCV/rsq96YGFvqcbmHhxfnyl/a00xFnIIyZnIjn5lCYP3b0iaxtJFSgHXqUN7DdqtOu1DztQMvgfRm+BwGxFCNJ1Lg62AAL5sg1AlFnfBw0x2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765000145; c=relaxed/simple;
	bh=o2coofrVs1zJomFeinBd2SFMvIp0p05SWzZkRVLf+OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nugYILyimv5HAgzvr6rmB+JSLKCeBIJr76Y5njfncr0FnFf655r3K9lE32hd/VDFjLrs/iXijkYc0tNOab/cooi5p98JmPHhK4nd7q8tpAvQBAWVwBv6hqnEO3jwsKHYgxMpt/atTT1q3TrzdQINH0fo4fIwsk3KQBUj/Mckbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq6NL0CF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555b384acso28816005ad.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 21:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765000143; x=1765604943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+5FbX5Ffi+j43ikWdc2hYKbS6cIVP11o/IGFWxUamw=;
        b=Aq6NL0CFXXBLnPB+bARZA968A5KQA2+rrAga+qWHiuVbr9dWGcELZQ22lN5yvlVIv3
         5ZKRacSFxLfylOwb/dLjXvpWBJxJdrU829KVPWyTUcCj5a60aPhEzppkKwsSvI15ZnNv
         CTGS+71z+BiLuR8SDf8xUgImSoURCBGxSHjRGzKbPoPzfu+p/rR/iyTTYp388PToxIxs
         3NT8fQjX80cmBMYbBL9raapxV3HEIfSgDJXgo+e5T07fv1yaCZFbG8v9CvsvYuN6eb6f
         nIgIHmU7XCtxXfcGbjzmWgdc+Vh0vrQQKnEi3T84D4i/9fD3BS20y/htvrNwRSCfR/aH
         45xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765000143; x=1765604943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+5FbX5Ffi+j43ikWdc2hYKbS6cIVP11o/IGFWxUamw=;
        b=Ed1KDyySHXAOQ4TQ41rWG8pIHKpKDCGdAnkeDeSkjqbEF5aaxq5Beg4aW/tupyINgv
         KfMuova1YSm3t6W9t/SrFCaItPcqbbh+2+0JY8GZ3jsAQUel0hviCgaEb6tqwF+otvjP
         oGzZdZ6+ItIXMVLnjaFXjWMHvDlkO44zBf1XpHP2mjSA21ESE+y2y82o7GJtU4h37tbA
         +DiTwkjbxPkVpbm28KhBah56doummckaFEayxb9177WFVWJDWqXf4huFR5KVBrZyiz9u
         gDag1I8Dm+r+0uzeWZzDoO9003fGr0TEADHsS2Tu0JkuTLyA4Ntibv5PE//hwJIKKV8I
         DW5A==
X-Forwarded-Encrypted: i=1; AJvYcCWjkqsp1MUxXJB2WdkgH2SX5l7qeC0oFk+G3DubpHvFZRhQW3zQDe2/G/ZHhEB5x78Q80HiBN3khfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/Xv9mdCNf5ntzog64+bGWp/dhPl3FbxvTZV0Gw+hKJXxE3Nw
	dMIy556a0cBuTZp24waYD4uGddHCuAATVsSOjss6KvLRk2hkyfysIMLd
X-Gm-Gg: ASbGnctDPdjYobEpmqpfyDkwmyXJZIe2RYPhTlfLB3ZdUMQJMIOek3sz3Z8Q3hB4OvP
	ea7QsDQBRoQMqTDzqOjhEDXjE42TaRw1iO7ERafgka0R0grlrCUGS7zNqMKJK0w0S31q951NKZ0
	6+XxbM8N5m4qQNdfchrE4pcps425Mlic3kWzyacSUOVc9cSYTFrZXr7Dvi9EicHa+eiPSQPKLAe
	hKSp/6FFUPX6ilLCk2IiEYl2RxAKf/RdA5DqV556mfq3UG6aeuAeiMX7cQpDa6qOdQKA7Ez7JhQ
	pLJnnaJ1MzPqK9uTX06GpHnGWSDrRaKLrcG117U84Uum2Zfw7leJL34I3nz6kGdkXiC/4rpQRoI
	O1D1wADsPKmFzIFJgyZDhKjoO95aE/7GIlbIGhOrePA/9SFvVy0T4UMBgfcdVcpmZ34DGZ3w9Fj
	BQsSivHeRK22ssaB2+JzMO/CNZlCWW58I=
X-Google-Smtp-Source: AGHT+IGfWF7c2l+UxfYzOKmNOmjZspZVkTKFm9uM2+JEgBwMh4W018TL8R2geZ+WaGGdnvFYesbq7w==
X-Received: by 2002:a17:902:f693:b0:275:81ca:2c5 with SMTP id d9443c01a7336-29df5de7aa4mr12038745ad.59.1765000142810;
        Fri, 05 Dec 2025 21:49:02 -0800 (PST)
Received: from localhost.localdomain ([103.98.63.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf52fsm65466005ad.39.2025.12.05.21.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 21:49:02 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH v1] staging: iio: frequency: ad9832: replace long/short with u32/u16
Date: Sat,  6 Dec 2025 05:48:31 +0000
Message-ID: <20251206054831.26045-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cleanup the AD9832 header by explicitly including <linux/types.h> and
replacing ambiguous integer types with fixed-width kernel types:

- unsigned long → u32
- unsigned short → u16

This improves type clarity and ensures consistent behavior across
architectures.

Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index d0d840edb8d2..d59ad0627a9b 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -6,6 +6,7 @@
  */
 #ifndef IIO_DDS_AD9832_H_
 #define IIO_DDS_AD9832_H_
+#include <linux/types.h>
 
 /*
  * TODO: struct ad9832_platform_data needs to go into include/linux/iio
@@ -22,12 +23,12 @@
  */
 
 struct ad9832_platform_data {
-	unsigned long		freq0;
-	unsigned long		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	unsigned short		phase2;
-	unsigned short		phase3;
+	u32 freq0;
+	u32 freq1;
+	u16 phase0;
+	u16 phase1;
+	u16 phase2;
+	u16 phase3;
 };
 
 #endif /* IIO_DDS_AD9832_H_ */
-- 
2.43.0



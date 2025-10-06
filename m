Return-Path: <linux-iio+bounces-24769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4ABBD790
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71E5188591B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6434BA22;
	Mon,  6 Oct 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UccO/Fqu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82A168BD
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743692; cv=none; b=CL9gu11ujjTvA8acnVLcPD8vbktGEl61I/BGWBd/VwvZA1lX1Zc3F2AO2XsrN3ZB0ghc4TBUjpVzRk4+ghh+ZpnPXiub/HpPrcrRQpP8KZNpwq1GPQP7LyOBDhoPlyJuwHEfG97o6UM9Uh7UCtlJoUJnzm2nXHWL2gU4ihVjj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743692; c=relaxed/simple;
	bh=RWpmJwgLuM2FIonYsAJTiC7gB8HKm6Y3f9332Ma3b94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7mp3GCRxg+ct/mRePHiMuHAP5MQj2YqqQuyOroyhWlufypXd5AaIO+Eaecto20ydYGIGqOYS/D07nkqc2eGsyshp4lW7eYAYcaYuI5Bz/TN7ouaQUKDD9PW8b318KmaO6WGoiGRHpch4yUMlWl0aHiPKZleFMDzb+YTfd14XBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UccO/Fqu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27ee41e0798so71110375ad.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759743691; x=1760348491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDWMO78/Sngggr60GZi/HLcWQ6AuAiwa+2vlLjX9o2g=;
        b=UccO/FqufmFv3Wvd7yrrz2x2wVNs1nsmN/3RprrZXG/bSQ8DPvXK/iNBQAP5QEYj43
         LpV7WPOIIizUbSZ70QLC9lhEE/qHKeXnbbYdRsSe4Vi7ReJjTT58Arac5vjvslzlVYa2
         9pMsd3QL+/NQxVwUKMQStW8WsGB3WSO7NVudjFRMJ1xhoZdjQo0vjCAY88KGs7QahVT1
         szBMs5mM3QE4ilPrfHZNVcTgc3FlZOsNpOQc/n7q5fLwXMcAgWNrNUAZlVMw7OWzUhVm
         Xplh+bmzf87g5kisEEKHHHeH2PLPiOdDYlB2aqZqWt+9VAhcJlM7hIEyal1oxdSyLv/2
         o/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743691; x=1760348491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDWMO78/Sngggr60GZi/HLcWQ6AuAiwa+2vlLjX9o2g=;
        b=HPt9KlXmBzk9lg9WJFeubXP3+kb3SoJWJpurHYZlDW141L+VBDNez2fxkQJsDr5LAn
         ZuU7/ptvQL/EAn7vX5seIhXn0AIYXvjEc4s/wykXO+cw9r0GtzITrbC1ilstIfnluMb+
         2iKtAO9D8Z3HAurRnIyH/tS23rDVkGHMr0B9cQJ8ChunGUlkKZXCrcXgRJQt0rHcjHSW
         ts0GCSS4FC1ddFkSSiY0oYh99+DcfRgTMR1R4A1FPAD3+YQ7xuiu3kJaawkLO7iMmdJG
         CgSQxKCwB+K18F8T5XkBxez+7YAExqMNqWHnq4rYstjsmGq6ukpnsEbES097cTDvWn4f
         WaNA==
X-Gm-Message-State: AOJu0YxcDc/9Adx1J2ztTmxxcXnOiIZ4uH4I8YRcRYkizRSVw6uScPDi
	bt5EBv+loW81gHfVZJfUTSm0LeKczNImuYeKaorFqfTKioh1q3kVyc4L
X-Gm-Gg: ASbGnctq/b+n2dHyME84bddOjMuabXIwOuESrr27LF5nytAZttiPrLF9qGPow7TrSZ/
	5ibk2QTVyym6FakytzZ0s2MASbqxkIQ3gZsm+tQM+AIMaTUEFBT+aOUZZYriWOOyig9p4juA6Ew
	v896lQ/xRrUJIOi5FSFoNZmyGJiLbDNYgWCmUgwwIKCNKUNlgdqUnibw2965aBjBu8OXXVBDUBu
	0+O2ZZ1AC76zzg44pGvvNz3SVDeVHT65dZdmcWjFS8m/AvOboGWl5mOplXgycAEiRHIVLrLGAd4
	eL2xvxsjbkW2h4Wno1f86Wbwynt7QbGiz3YzwPeclud0NSTX/ysNhjGyF5xQ4BVMBD4i58pPNVX
	I677GGeapoM/G9hRVM+JVfMtwrG6RTsRVMJ6xSPJ7skvmgwxI
X-Google-Smtp-Source: AGHT+IGVuyWx946HsYOHhKNOFxC/pycX88y2x4j3++pl8lUJfoEyLqORuWilWGcjs9C38G+O9ca/Uw==
X-Received: by 2002:a17:903:1a86:b0:268:b8a:5a26 with SMTP id d9443c01a7336-28e9a6b19e2mr157755655ad.54.1759743690647;
        Mon, 06 Oct 2025 02:41:30 -0700 (PDT)
Received: from ASUS ([119.63.139.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b609be239c5sm11325778a12.19.2025.10.06.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:41:29 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Taimoor Zaeem <taimoorzaeem@gmail.com>
Subject: [PATCH 2/2] staging: iio: ad9832: move struct ad9832_platform_data to ad9832.c
Date: Mon,  6 Oct 2025 14:40:25 +0500
Message-ID: <20251006094025.259440-3-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006094025.259440-1-taimoorzaeem@gmail.com>
References: <20251006094025.259440-1-taimoorzaeem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct ad9832_platform_data is only used in ad9832.c
so it moved there instead. With this change, the ad9832.h
file becomes empty, so we can remove it.

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 21 ++++++++++++++--
 drivers/staging/iio/frequency/ad9832.h | 33 --------------------------
 2 files changed, 19 insertions(+), 35 deletions(-)
 delete mode 100644 drivers/staging/iio/frequency/ad9832.h

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 49388da5a684..0517858bc5da 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -23,8 +23,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "ad9832.h"
-
 #include "dds.h"
 
 /* Registers */
@@ -117,6 +115,25 @@ struct ad9832_state {
 	} __aligned(IIO_DMA_MINALIGN);
 };
 
+/**
+ * struct ad9832_platform_data - platform specific information
+ * @freq0:		power up freq0 tuning word in Hz
+ * @freq1:		power up freq1 tuning word in Hz
+ * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
+ * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
+ * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
+ * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
+ */
+
+struct ad9832_platform_data {
+	unsigned long		freq0;
+	unsigned long		freq1;
+	unsigned short		phase0;
+	unsigned short		phase1;
+	unsigned short		phase2;
+	unsigned short		phase3;
+};
+
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
deleted file mode 100644
index d0d840edb8d2..000000000000
--- a/drivers/staging/iio/frequency/ad9832.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * AD9832 SPI DDS driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-#ifndef IIO_DDS_AD9832_H_
-#define IIO_DDS_AD9832_H_
-
-/*
- * TODO: struct ad9832_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad9832_platform_data - platform specific information
- * @freq0:		power up freq0 tuning word in Hz
- * @freq1:		power up freq1 tuning word in Hz
- * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
- * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
- * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
- * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
- */
-
-struct ad9832_platform_data {
-	unsigned long		freq0;
-	unsigned long		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	unsigned short		phase2;
-	unsigned short		phase3;
-};
-
-#endif /* IIO_DDS_AD9832_H_ */
-- 
2.51.0



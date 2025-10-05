Return-Path: <linux-iio+bounces-24739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A13BB9625
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 14:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE24E139D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA542836B5;
	Sun,  5 Oct 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPmQeP/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A80218821
	for <linux-iio@vger.kernel.org>; Sun,  5 Oct 2025 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759666723; cv=none; b=dM7Vs4SDL/Ujav6YKz/25/8JMGIRQr8Rt5zgDLPvJa9NC8qE7rClY1AuKWhUVbNZkfCubpL9sPRhCamxxpgAl/ZIQO7sMy7DHFhgsuWRIGFqG1xPvLTqgtbSOsZ+yPx8EgS1sZG1NPU4WYS9qNlxYFg99dox+t5Nbuge6iNw9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759666723; c=relaxed/simple;
	bh=4g1S8x3yOvkzQXSdP/T9FfbGgHJyz3a/FaA45XPm8HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhvGHGpu0bOna4fqIwB5c+r/dMfnWbGYUs2uN+5hOzw9sGCjV+m4MoFmJddCUnTC1/sLs2j+XmPG3yRYi2P9AWAlhjKGAALBCEBOixzWZqiJdf0M78zkMj9Bv8JisjWiGRgHAAVE3ANMH/Z0n0tZcPBa46TGxbpp+y+n+G3dXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPmQeP/p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso2812724f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Oct 2025 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759666720; x=1760271520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlxENHq5KCP4IeCDtxo/0OOQpWC6mUCvw6ETPSr7Wcc=;
        b=WPmQeP/pdZCmYREpJ5BPMopE/mmHUiRmFkr/hZTey93D0DpmzUyYCp7IU0ELGcOv0N
         EqcLEpe4JQhuPSh0xQDzdzOC3YGY+FjRZq6TKGPSeC5t4Ag62B9txClCkxKAU1tkvyw1
         HTOhxkCiDCwksvSDLIYclLScnYgflobfP/ZFAUfQ0q575/khxi1KwcJnsQD4V/c6PvdQ
         K/nf1vypPSd/DORwMqYQeS+B+5gqO2WLqraSHwGF+1bu2LHpDDM9AUDSClieZM2xsPCn
         9TiUDqXwJG5/e305/qEYzj/Yk1l1ufCTNiBZGzy08J936p+u3Q4RvSGOPRtpprjM8Qgk
         9Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759666720; x=1760271520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlxENHq5KCP4IeCDtxo/0OOQpWC6mUCvw6ETPSr7Wcc=;
        b=OdqI1kiqFIpNBdORyhI7A9Fn3gzBgUfSOSeLizV1Yp4vMw7wommnazN78fWrv4RIXd
         pFnqRPj3jRVDzKmbsASWWFtI1xDTKP+uFGq4+f/5XLATjpGdoB7x/+Q2N1EziHDOgxXl
         DGhCzq8l4fXimbUXD/Db466qo+5H3boj2n+f6vbDb7DpLznBsx4Dz1yq6uAjzQtSRY5j
         Ji1m+IZ96RBeBQpZHrxsqJkBOJVJLEyM2LnbfZrt5q6OQwbTon5SDQlyzfMRb1c/66s3
         jbTXLcwLGpEA4Yid6a2szF2Q82tL8Fh7toBzeavUMLT/w0NNxbSutvV6BGM75gkmq/Wr
         bD2A==
X-Gm-Message-State: AOJu0YxtcXLSD0GIYIbYBehfdPm2FjjzXRp4BzLcOKIx24m/aUKJ98ie
	tetzPF7IiaA/6bTLLGS1RpGPW2O6gudgM2dOrqKztzaqvVfagzLqipYEhLRuletS
X-Gm-Gg: ASbGncvUQYPAbZzSnR673+KnIYJqPTgdtctN/CLTi+Ql0DrierxDnyvXfXIariBhZjM
	OaN8JW/MZhANpXpNJQqKkgyxEm9UQ7Zjp1m/2D71GhARVIAQ9jbZxmoRczUKfLC0NmGyAD4rbBP
	2fdSxlPFwQc0W6TUFg2poAQWc2qD1uArdJzCsAP2RYjo3uaLqJvmlvytXtZdDZLtSO0uohTzIHB
	KspBGjil7rt/Ox4qL8+Zr++lWK/ZqEzOg7LUtfFOPr/GIF6zIIE6tdP4eU0wAiWbTDoNlZ0mdMJ
	Twp7Bo9AMOWotgL+j8HIAJK3nhzjLYgunsbV1KZVN+3ehI7Q0V4C9gmkJXegsM+LxwLgmjHKs9K
	TNkRWy6z41fpNwMkOTtGLsCNLUNx4g+rZzYSdw4OCnNSISg==
X-Google-Smtp-Source: AGHT+IGd7HamBGfyn+haKF73tvPNK3v+CDl+3wiplixcaxjElsQMk6+N5NB41z/7I8JK5+UHRmwl+w==
X-Received: by 2002:a05:6000:186f:b0:405:3028:1be4 with SMTP id ffacd0b85a97d-42567137c45mr4878010f8f.8.1759666720468;
        Sun, 05 Oct 2025 05:18:40 -0700 (PDT)
Received: from ASUS ([182.185.168.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a18b76sm213709195e9.18.2025.10.05.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 05:18:39 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Taimoor Zaeem <taimoorzaeem@gmail.com>
Subject: [PATCH] staging: iio: ad9832: move ad9832_platform_data into include/linux/lib
Date: Sun,  5 Oct 2025 17:18:29 +0500
Message-ID: <20251005121829.175943-1-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move struct ad9832_platform_data from
drivers/staging/iio/frequency/ad9832.h to
include/linux/iio/frequency/ad9832.h.

This clears a TODO item in the drivers.

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c                    | 3 +--
 {drivers/staging => include/linux}/iio/frequency/ad9832.h | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)
 rename {drivers/staging => include/linux}/iio/frequency/ad9832.h (91%)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 49388da5a684..76bc384dfad1 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -22,8 +22,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
-#include "ad9832.h"
+#include <linux/iio/frequency/ad9832.h>
 
 #include "dds.h"
 
diff --git a/drivers/staging/iio/frequency/ad9832.h b/include/linux/iio/frequency/ad9832.h
similarity index 91%
rename from drivers/staging/iio/frequency/ad9832.h
rename to include/linux/iio/frequency/ad9832.h
index d0d840edb8d2..81c97a521812 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/include/linux/iio/frequency/ad9832.h
@@ -7,10 +7,6 @@
 #ifndef IIO_DDS_AD9832_H_
 #define IIO_DDS_AD9832_H_
 
-/*
- * TODO: struct ad9832_platform_data needs to go into include/linux/iio
- */
-
 /**
  * struct ad9832_platform_data - platform specific information
  * @freq0:		power up freq0 tuning word in Hz
-- 
2.51.0



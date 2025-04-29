Return-Path: <linux-iio+bounces-18802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B855EA9FF9A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351151B60DED
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7229899A;
	Tue, 29 Apr 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YiFJHeqh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12F2980AA
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893050; cv=none; b=C2ze1wL3LQiTFSrhDZBYXu1jBDvxN2UzqdHGuw3C7Uw9Va2e0AmNQ9w4jGRscO2m0ih0pDPP6MO2obdN8pHts7iMmkLtEhe/o/jyO3ixKWYWhkNzzezf2Bp+1mmg6rw5MDx3+60rs9Dg4gy882prepm/Aw4qjQ7nVSj5wiGDN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893050; c=relaxed/simple;
	bh=r4Xvne1iEXPAeguZm1TQ8Dfad3TUBl5sXeU4woeJKM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WNqgXiTSQu5cMjvbbuiw+Lhr8WKw7ZWyvBTRRs0ho5oiMe7LLH8KJaY+7JpjWyrDQJ2FpLnus3xT1YxitoEmCg1Uoba6RhIubqHzRbo18OcW23l+BJfhYX7NZUsZkYa1n3ilZeS8OqfnaTf6qDYBpAJZYiB8vezrSmMxfGb6KjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YiFJHeqh; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c14138668so1466199a34.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745893048; x=1746497848; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxAQ7U3+wNbG9z9JR5W9etJLvPLXYYeasvIVL7H/WCo=;
        b=YiFJHeqhOMLOoAOU/0Gx+yDiR6M3p+fyXtgOQzN3m8DaulOAwzwKc9M2Yag7JHDLaM
         l0ZbHJtW/Wra//naTEXyf4pUTZYsIu5J3I6Vc3T07JlgQSbVbtvlS0bjyJxLjSlijEk1
         EP1njqT35xJFsSr7t1R0bXRLd3rkd32l3GQkATNxbKlrx/N1OcYJsETSAycAhTnkNPCv
         P7jms0MBI/Jy413R+H3cwCmwkn5cNZeBkzOEi/dSCbsCS2iPrAaF/nYYJRl6N4CmTOGJ
         u1MlD1Ej8+TZsDQVojQSC8y5KI9pcneKIxwysHEhqNvUSuGMRx14mG37GvC82VA7xmMs
         qhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745893048; x=1746497848;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxAQ7U3+wNbG9z9JR5W9etJLvPLXYYeasvIVL7H/WCo=;
        b=mEESINTOv+mTdAP5LMxwvALqrxC7BI2QP8jxE+LdugxVoJu/EYY2yCSisiSWo/WGzG
         lDr+IgBqg8wDNuUTLB7BZnLUP2M7anDG++0pHUlB85n2r4aXblQ4vvYTH/rtBetC8JfR
         Vc7J4W+AY3nLc5fxQCH7yeFON8tgh3Q+lLIL1btlTqTGz5LWyInu8ZRXgk1U1ZkK1O6A
         zEa57cOHAZuWZMFlSqS5wGxCoJM11Cg5Agvb7TCTkw+4AsrehqRKWJfGI9u4D/VwaWnw
         ajt+irwip25pi/Hkn0tfuM0NIaydT0WDhfgV97qYHVItjgnw0xYpvJ7h6m1mM4ggjC4A
         xQUw==
X-Gm-Message-State: AOJu0YyFqXErOOt2SJAREX+vfC+c19I1i0HDL/lxzE4R2zUoBe204r96
	pKtsuZIZzlWwf5D2hFo8zRcVAwdrT/b0LggRxnUxpz+oKTyeuVFgFH1zLgKmJZA=
X-Gm-Gg: ASbGncsmfNTuriF+wZp+Z5e7toKVx6v+A/IUrmjNS4QwYBmX/1SAEbBOwrIRHrcZpCB
	/jbj7r3cTuMwvP+g1yZR3GJcsNCh6rD4/fxJNuYgye9a4XQw+b4Xmdc6qgj3LG+ZuUfDU9DbkDY
	XwxuMrH1iqIBb6pvEdr6SB4n39puHVAKZEICvXzOZnCBxKgiYZTWuEJSjEwQHntA7Rf03oVcaxa
	CsQuueZ6Icg37GTyLblm0qJ8F+jljUAAZ4ZhjE2UHmg9Fw6oLZNYalbUGWeog3rVP8ci08MnYyz
	+K4yIdiQXR6i+UWozercXjeTZoWbvlQV0S8UcYHStZOX6J3m69Bl/1BDkw==
X-Google-Smtp-Source: AGHT+IHNkH1RRqrvPJPVcOqtzsqUP7XYeUcIbJHZzFCRpW2IVsA6MD82R7M5Yf5Dsop7VZdM8d3xPg==
X-Received: by 2002:a05:6830:6019:b0:72a:4804:77ff with SMTP id 46e09a7af769-7306528b06fmr7224803a34.25.1745893048059;
        Mon, 28 Apr 2025 19:17:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b0f3ffdsm101440a34.9.2025.04.28.19.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 19:17:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 21:17:14 -0500
Subject: [PATCH] iio: adc: ad7606: explicit timestamp alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-adc-ad7606-fix-buffer-alignment-v1-1-88dfc57e5df0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKk2EGgC/x2NQQqDMBBFryKzdiAGTdSrSBcxmdiBGiVpiyDe3
 cHFWzx4/H9CocxUYKxOyPTnwlsSaeoK/NulhZCDOGilO9XqHpk3dMEL1iiDkQ+cfzFSRvfhJa2
 UvjhEH8g2prfBgyztmaR7XqbXdd3U8X3AdQAAAA==
X-Change-ID: 20250428-iio-adc-ad7606-fix-buffer-alignment-9fcde71687dc
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=r4Xvne1iEXPAeguZm1TQ8Dfad3TUBl5sXeU4woeJKM8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoEDavdQc1qtun+85xGI5sUhiW1Z+XwmEcBblY/
 W2NloNufdGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBA2rwAKCRDCzCAB/wGP
 wLIPCACNjO5Z93T2mM8N/PlidRDDnXmwY48keUAbQpoi2XfexXkLj0fQ9tAYn3cq0ZeFSALoZM5
 ZJu9SAJHPXDVf+TJbfr01cbMkdpgKYxtBkAQ7LAM/DLY7Uklhi+kEOlUq7H116bUMn1tt5kdsnC
 OOlWcc9EVc/I45HbtFWLs7fdWJHvMW54bgnXuTqstJI2mWTjLGJ4NZ3lLkWjMxA5P2FgBe+7ZWX
 erFb8DVuIpgPzowsCD/8IrRrFGLApZ+qirxyGKyWoKoV2K8ZeYeYh98OLyE5/tMCcLxyh55BoiT
 2rc5qYjjG7B5xvUL83OOrAWfuLT5u/XfmfKoibXyWi1ZIMdD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use struct with aligned_s64 timestamp to make timestamp alignment
explicit. Technically, what we have works because for all known
architectures, IIO_DMA_MINALIGN is a multiple of __alignof__(s64).
But this way, we don't have to make people read the comments to know
why there are extra elements in each buffer.

---
 drivers/iio/adc/ad7606.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 89d49551eaf515bab9706c12bff056dfcb707b67..441e62c521bcbea69b4f70bb2d55f65334d22276 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -155,12 +155,15 @@ struct ad7606_state {
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
-	 * 16 * 16-bit samples + 64-bit timestamp - for AD7616
-	 * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and similar)
+	 * 16 * 16-bit samples for AD7616
+	 * 8 * 32-bit samples for AD7616C-18 (and similar)
 	 */
-	union {
-		u16 buf16[20];
-		u32 buf32[10];
+	struct {
+		union {
+			u16 buf16[16];
+			u32 buf32[8];
+		};
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 	__be16				d16[2];
 };

---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250428-iio-adc-ad7606-fix-buffer-alignment-9fcde71687dc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>



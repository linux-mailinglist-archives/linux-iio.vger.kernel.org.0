Return-Path: <linux-iio+bounces-18848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22AAA0FF9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF93D1BA1F7D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958A21D3D0;
	Tue, 29 Apr 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L09teQps"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B5218ABA;
	Tue, 29 Apr 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938952; cv=none; b=NGIZT2VUj3Y6+JTLoZ5Joy++A3D99UtgZ1T1em+X+V8g/5P7QJYsGw7xR4CL3/CM1Chx4kpAQ7qJ97m6af1pMrBLWDigqoOMWnOdkdAS/pKlixZgoWuU6Kls7m4Vw4/KczpkH4hJfMDmCHzpY4ddcQbebGbgg0aa1aDeMiUrGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938952; c=relaxed/simple;
	bh=OqRybh9v2ukDv2tsYveLuJ5MKSvcUXUu6YuVqzSprWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bivT9xxyaEVfzdpXxlHgPuvRVIWwhzaYNcOOmVuABTiXmTfDnUS4ji7i7SE3rAXngEQesMqkwWhyE85lUlHcwyZlXkTT50Il6HmuFVjj7nnVgL3F1646TE9jM42H9CmXotO5Rps6f8JNcq61WeEEz3obVtPVwQ963eZaVJw+4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L09teQps; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736b350a22cso5356552b3a.1;
        Tue, 29 Apr 2025 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938950; x=1746543750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZeOBi3zdLXK8sBDqMksfWSquXLKhAXvZPkKxFBGUXc=;
        b=L09teQpsUWInldgoeqMj4ICAMQdCxCPezuizpIedfCKIwzARP2PaiTs0iWQjigpTix
         hZA3177Rq+i5qz4Uvgtq4R2bPNsp9f+B4U4buonlNKJefu58PvDLBiEQL3vn55fl8jmc
         BFtUZQ+vAZ80/nHgCgBNvUQJXgifMUrabPDBAAFJF/BeNXhppnH60PbclJ9+0zQIV7S6
         kjx8wFc55tcZ67ADfpCWQht+wJLFwZAVoQyRJYSlCWp6ClnTZnB1BrfNj50/TZKHzYNx
         Rpx1A/548CEjJLTjeqPRtQe2GXepv4QvAvXhks8UGYurVRiIMMxxSPHfU2ixrCBYpCBJ
         KAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938950; x=1746543750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZeOBi3zdLXK8sBDqMksfWSquXLKhAXvZPkKxFBGUXc=;
        b=as6hGRtarQnC+emshoP/M8PaNuNF/lgQ9d/9RLOcuei+dmxQ1PyGO/vk9TQLIB4KxQ
         nInzjgtPsIQCKJ9tAA2vJHayQ5N/CscTDG9mC9DR+Vrd3y9/J+i/KDWkQvhgsfSRDHEV
         vCyQAIaTn/j7At4c7mfg6FP5nHHIWBk9Ty0Oo10MBy+uXJX6P7o+KpIkGpeheSNt/tS1
         Elm3lDq8kqFue7LUD9EYcuV6EPsOLjHR6R5K0YkTn0WMhCxzWg+IiWam0nGb0urVyyR1
         1zRJad8kksk7VmIhJeYBPV9doTYE39FkXcybVaZmC28ZY4K+kIZMsxCVvhbbYlx77XB3
         oSww==
X-Forwarded-Encrypted: i=1; AJvYcCU7qYJ0CQcuBwdCBULtyG4OalMEMPq28rq3cyPRdFnYeH9m8r0GPX1S757HffO+hvKXWYKg7ITK2k0=@vger.kernel.org, AJvYcCWaxMrUNxK8+79d3tTrddKVC4h2Yx27RLv5sffMgth3mHUjRg5OD8QT8OkVHwMphphF0+iyeaLA@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPTWgfyPctUtZVYmWBPSZ4V7PuF4dbha+jI4DzUoOtn/319K7
	6t1v+XvVQsOcIMWgvIC++XTfYxQWUrXKMgC9xLPOmjHx/CwIdlGY
X-Gm-Gg: ASbGncvkjzz9ogFTY5/MmTV5eH1PvJomlBsySgICMn77dOy2CzHocen7DfSWQGs+YHl
	yJUGf5oUE41V8yBFi1mALq5USofUbiXC9Je7syac9etkOtxmHVIz9fF0kzwBTFwNLpCNx2vuXEF
	eUJgzD+FoAI4n2BjWGuKhiVSF/agpV3m/d4YN/towb/OIEBaoGQSBnOONom24b2fPV8QHV7rhBj
	EJrgeE4Tf5KQ60Ba8O6fZPozafNaPT/6ePs2b0GOJ6SUNByL3nztmkg/84+bA5qTJLU7sETFM0f
	U2MMEV2lFhpyBaPPS2KjBrFtt/g7V41ZbMQDBRsHLA8Z50eknf0v5P8=
X-Google-Smtp-Source: AGHT+IFCo972++VWovC4e4n3GZ7wrhqJx+v5A+dCeDcmFNkDun633clvRk09oymZmgSjtn+ZNtzKlQ==
X-Received: by 2002:a05:6a00:4b06:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-7402913afbbmr4801087b3a.21.1745938943869;
        Tue, 29 Apr 2025 08:02:23 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f8bb:f2b1:5469:86ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e2593f557sm9955758b3a.42.2025.04.29.08.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:02:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: max1363: Reorder max11607_mode_list[]
Date: Tue, 29 Apr 2025 12:02:13 -0300
Message-Id: <20250429150213.2953747-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429150213.2953747-1-festevam@gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The IIO core emits warnings when a scan mask is a subset of a previous one
in the available_scan_masks array. 

In the current max11607_mode_list[], the s0to3 mode (channels 0–3,
mask 0xF) precedes the s2to3 mode (channels 2–3, mask 0xC). Since 0xC is a
subset of 0xF, the following warning is triggered:

max1363 1-0064: Mask 7 (0xc) is a subset of mask 6 (0xf) and will be ignored

Reordering the max11607_mode_list[] to place s0to3 after s2to3 ensures that
more specific scan modes are listed before broader ones, preventing such
warnings.​

This change improves clarity and avoids unnecessary warnings during device
initialization.

Cc: stable@vger.kernel.org
Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/iio/adc/max1363.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index d0c6e94f7204..e8eeb00bef7b 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -577,8 +577,8 @@ static const struct iio_chan_spec max1238_channels[] = MAX1363_12X_CHANS(12);
 
 static const enum max1363_modes max11607_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
-	s2to3,
+	s0to1, s0to2, s2to3,
+	s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
 };
-- 
2.34.1



Return-Path: <linux-iio+bounces-5844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5758FD3D6
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5E828754D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45B13A3F6;
	Wed,  5 Jun 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDEQ7Wo0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5E5380F;
	Wed,  5 Jun 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608059; cv=none; b=khZ/leO8OvazTUZupY+U+KppDpNJ2jhcXs5XQ7UpylUlXuJ6MYe2R10hjKfd1KuRZZeFDEduZsg8nx7KDnfOzXjfniPYEICEwYS7MvoNCVOrpovuq5o5csaEqPd//Nl3k5o22yQHpVqaE1KnzNZCen4fJ8T7u8yY1dPT4uQ2xeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608059; c=relaxed/simple;
	bh=cBU3yekOXtlhNWdWpyG2xf0kFZVmOK5W2mTTLEsUAFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bIS5qqeAaGhRGYspzWLVg9Wil41Z4NmxSE7lWqZ31eFIYa4HHWKZ6hen4WJWmDbdBJENzokrI3qC/C0nHm8kT4xJphZ+YLdsQVpGbHDSBHGyGzr4VOya7w16ZLPaoNDTkbZX2AeFFmiDgNH4fbSXXbdwLJ+84FI66OEz7NywIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDEQ7Wo0; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ba33b08550so2321193eaf.2;
        Wed, 05 Jun 2024 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608055; x=1718212855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iycGYFzd3F+df0p/qsCILVl1cIBvCeHnsWMgOkKCQP4=;
        b=fDEQ7Wo04zJOoc9WWoQqh9GiOiYlVfN+3cnfDoOwQ+jT/n8pl3CMEDZl5LGcFzgo03
         egxt+wJdiEDjmXfZsja7/o9KELsYBm1CFe/CG9G5o0RGSw5K6inoPYnOzhymobiEQtZ6
         FsuHtnLo3D3ao4Z6Z8Q0fuhtdDTXHmxXMq2mlwiWZ4HUHRmIeV8X61JRzCcuMrzXFfs+
         umYZYD2eQQOe1ddijZyyhM2hVuRGD8yCypS1+L68a3ha5UJmQTvcyI6Na+MibPmjo2uh
         SJIkozj18mcwXmSKgtzoOsBAAr2ai3dhRxSTyxX3jdTFUTnMl6MZ+uULPafGsdRI+r+U
         DvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608055; x=1718212855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iycGYFzd3F+df0p/qsCILVl1cIBvCeHnsWMgOkKCQP4=;
        b=All+8lZYEpXV4Os6QOt/fXs51YVTh0E1tA79dAnVXNtsAhjL2sXu4ZbxR/pHO4IAM3
         8QCAOGWCDHhVqw/sAtsPm/sUQuYhwePBIATbKgxciacaBG5silH7H/DrG0zgMFDKtaEs
         wMkVXWd1tj3KOlmZpUyqhn4L5UTHqEVfzSnOx3Q4MDhjMdACqiCJMkEfqnPPLv/RFHxS
         e3nZ+n8ubc0lVnB+DXaFL0s8UcjccfdeHMM0dTifltzfS4S4zjuNyMa3La+849o4X4zk
         HinAHi6/6gUiE24TfekGxMTYyaPkiBp8ulOYStB1ArInugKuNRE8WVlC3yClT3lautmt
         flgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGUUa1XEzRo9nEgG+I6Qh7oBKeYN18iQrRG+DHPJbuhQRO8Ts2cZJyBwJ7crxtyAN3PH8sSpUPWDHxb7hjbc3meQG9DB+ZDcP3ldM0tWVkYG4QWUXaaiA7ivanZQ/iGkTlZONBvA==
X-Gm-Message-State: AOJu0YxdQJ0DfRqSUILvjhzF7Jb+RW8rAxrLqoHQHEt0c9AaaA4uDj3b
	EQllPiJ9zLdjgi7LDfQ7pjo14FEHJcB6VszizvvzAmWjnfJ+tKIX
X-Google-Smtp-Source: AGHT+IGLosO08ZXKoA1XuLlmpddoc2V3y6CwKOw/IuAQwj1zCJCa9l6+oWIoh8BDD8IE8Pbo6tjJnQ==
X-Received: by 2002:a05:6820:62a:b0:5b9:f351:3f8b with SMTP id 006d021491bc7-5ba78d42decmr3790153eaf.0.1717608055299;
        Wed, 05 Jun 2024 10:20:55 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba72cb44f4sm586124eaf.40.2024.06.05.10.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:20:55 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	p.zabel@pengutronix.de,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 1/4] dt-bindings: clock: sun50i-h616-ccu: Add GPADC clocks
Date: Wed,  5 Jun 2024 12:20:46 -0500
Message-Id: <20240605172049.231108-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172049.231108-1-macroalpha82@gmail.com>
References: <20240605172049.231108-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the required clock bindings for the GPADC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 include/dt-bindings/clock/sun50i-h616-ccu.h | 1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
index 6f8f01e67628..ebb146ab7f8c 100644
--- a/include/dt-bindings/clock/sun50i-h616-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
@@ -112,5 +112,6 @@
 #define CLK_HDCP		126
 #define CLK_BUS_HDCP		127
 #define CLK_PLL_SYSTEM_32K	128
+#define CLK_BUS_GPADC		129
 
 #endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bindings/reset/sun50i-h616-ccu.h
index 1bd8bb0a11be..ed177c04afdd 100644
--- a/include/dt-bindings/reset/sun50i-h616-ccu.h
+++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
@@ -66,5 +66,6 @@
 #define RST_BUS_TVE0		57
 #define RST_BUS_HDCP		58
 #define RST_BUS_KEYADC		59
+#define RST_BUS_GPADC		60
 
 #endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */
-- 
2.34.1



Return-Path: <linux-iio+bounces-4318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC08A89CF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 19:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196DE1F21EDD
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6A172BCD;
	Wed, 17 Apr 2024 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQpZt5u/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2650172BB1;
	Wed, 17 Apr 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373472; cv=none; b=IRy0ayjFnOCbY3U59FGw6kLqf97L/sqgQVp47h11eFmlA0NXrJWyez6szfE23lgPRa34b7ESPLZvJij45qPTY2fVXrCwstX+/Jq69q+J5sknywdJC/qrD+awShLfEVtEjwtgnltMNKh5b4iC2NoOmwMS6QeIZmnt5EHIczqrspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373472; c=relaxed/simple;
	bh=yeuqhpeXoirlC61pOihh6SKMLRhOXy2QmFiICFPE+oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfJHTlhv/m6K8LdDg65M6Hw+KcFU4UTt8CEy11FF/JX3hUE8wTEWWditzWokA7CNC8aeYUhMZGa4cLJm0OQyk/uzutqR2hNXKZ0M6c8DDLiLl+Pv+WVxeStyAdhBCgg77HoKCRHdddPg829CCFcPxogMlmvBagf9oq8gOPj3A1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQpZt5u/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so3228877a34.3;
        Wed, 17 Apr 2024 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373470; x=1713978270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=226GLZN1bkJOaHrZzvZZO9lFdGIX7oNyj3T9o9yriN4=;
        b=AQpZt5u/cm5ZL3nDdSDEf6B1nTO5Ua721WtTtl3JawBf27sQE47SGAMJ5iDkq50yvO
         iZXE7jupeJgwUAkO/jMw6Je55qZDdNJ+XO3BbjtHJVd7/uCzdYo8Vb9IMRzsK5wuYSms
         q96DiQVo2fRJPP9vSIAbhXFOxmVII5wrVVwfr17RtePtkbfY/dy4MTAYx3iqDSbiGTO6
         yQa3lFsfX8nTDqWVkiZYfTyq/yjQ2IN59DZIR42+ksBT9SlxteuvZr/0iB5qh6c9ROsm
         V5uEkZTYxg6Dw0WherY18TNmOBSq5haFYV6+m8ptTjvXvP1zqk9qvIjgVh01otfN3voZ
         em5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373470; x=1713978270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=226GLZN1bkJOaHrZzvZZO9lFdGIX7oNyj3T9o9yriN4=;
        b=hOL78LYdrce14A88r5QiLQwg3yxsF7IsOW9QYCbpbNsrsLQqrs8Uj57Yh/SoPX+hR+
         w3/wrs1cj5o+3oQAO7qxmAO94T1Evg1hilMUp6g6oM7lLA+pYE+mSkAYPwakl5qJVu2i
         rd2dH16ar0xLYyyvV3z/2kGNqRx5qA16NfVyURd5GspDK8doeVqQ/wcR4NuMHsAieE26
         8w5S/57cO819GsYt2mRadlTqZEE6BW1ub1V7hLhL+4dK8JvslCq5YDLSz+0vk6ZA1kti
         whIJHdisjFEwp3VOvr4P6jz7EV2L17yDaWM0rpdaAyjqZIAF6doBo7RSHkf4xEYX8y3N
         BHiA==
X-Forwarded-Encrypted: i=1; AJvYcCWCmgt9dEQUYmzQ0MoYILQA/xTLFKm9ZIl8aJof2q7yUjR7qI2rsZ65jyaRYAaFc0QAM3QPjQrCS1VCpsXeQeq+ki8NgqTrQbSMXvpNcQwEUhdunYqiNSW2kkD73ggpewD3tZiZiA==
X-Gm-Message-State: AOJu0YzQG4Cuj0FbauBXQ8b7f9i9Zt1gqQJWIts3NPyu3KwT7W6ZyPnl
	gJC08EUSmSaHNGbFs4TB52/v/gsepifQhdBARbaac78jnRQzLxSP
X-Google-Smtp-Source: AGHT+IGJK2+91vrxlDBl/jROR8Z3vUqIrSc4m5vZDraYX2jSk17Wgxeb08jSE8DG6QAUa4CxZQYN7A==
X-Received: by 2002:a05:6830:4794:b0:6eb:7730:7f1d with SMTP id df20-20020a056830479400b006eb77307f1dmr37887otb.22.1713373469865;
        Wed, 17 Apr 2024 10:04:29 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id k20-20020a056830151400b006eb77e42ff5sm1721615otp.26.2024.04.17.10.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:04:29 -0700 (PDT)
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
Subject: [PATCH 1/3] clk: sunxi-ng: h616: Add clock/reset for GPADC
Date: Wed, 17 Apr 2024 12:04:21 -0500
Message-Id: <20240417170423.20640-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417170423.20640-1-macroalpha82@gmail.com>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the GPADC required clock and reset which is used for the onboard
GPADC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 5 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h      | 2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h | 1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 21e918582aa5..3646be2b88ab 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -489,6 +489,8 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x9b0,
 
 static SUNXI_CCU_GATE(bus_ts_clk, "bus-ts", "ahb3", 0x9bc, BIT(0), 0);
 
+static SUNXI_CCU_GATE(bus_gpadc_clk, "bus-gpadc", "apb1", 0x9ec, BIT(0), 0);
+
 static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
 
 static const char * const audio_parents[] = { "pll-audio-1x", "pll-audio-2x",
@@ -807,6 +809,7 @@ static struct ccu_common *sun50i_h616_ccu_clks[] = {
 	&bus_emac1_clk.common,
 	&ts_clk.common,
 	&bus_ts_clk.common,
+	&bus_gpadc_clk.common,
 	&bus_ths_clk.common,
 	&spdif_clk.common,
 	&bus_spdif_clk.common,
@@ -940,6 +943,7 @@ static struct clk_hw_onecell_data sun50i_h616_hw_clks = {
 		[CLK_BUS_EMAC1]		= &bus_emac1_clk.common.hw,
 		[CLK_TS]		= &ts_clk.common.hw,
 		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
+		[CLK_BUS_GPADC]		= &bus_gpadc_clk.common.hw,
 		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
 		[CLK_SPDIF]		= &spdif_clk.common.hw,
 		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
@@ -1021,6 +1025,7 @@ static struct ccu_reset_map sun50i_h616_ccu_resets[] = {
 	[RST_BUS_EMAC0]		= { 0x97c, BIT(16) },
 	[RST_BUS_EMAC1]		= { 0x97c, BIT(17) },
 	[RST_BUS_TS]		= { 0x9bc, BIT(16) },
+	[RST_BUS_GPADC]		= { 0x9ec, BIT(16) },
 	[RST_BUS_THS]		= { 0x9fc, BIT(16) },
 	[RST_BUS_SPDIF]		= { 0xa2c, BIT(16) },
 	[RST_BUS_DMIC]		= { 0xa4c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
index fdd2f4d5103f..a75803b49f6a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
@@ -51,6 +51,6 @@
 
 #define CLK_BUS_DRAM		56
 
-#define CLK_NUMBER		(CLK_PLL_SYSTEM_32K + 1)
+#define CLK_NUMBER		(CLK_BUS_GPADC + 1)
 
 #endif /* _CCU_SUN50I_H616_H_ */
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



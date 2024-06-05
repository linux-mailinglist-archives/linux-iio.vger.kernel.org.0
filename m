Return-Path: <linux-iio+bounces-5842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 485068FD3D0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBD51F267AA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8613A267;
	Wed,  5 Jun 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU4uYczo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F01386D1;
	Wed,  5 Jun 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608058; cv=none; b=maQLpoxM/F4qao5gHtegGoJ7PR4sy5L0asLSz50SrmH5g+sGzSDkpPWjk6ohMVpMzqXC19vQcloo7GlTMjzV5yRDiuJJK5v1bQ2D8N6sEMD6FsOy00PxlCAEwMoLhwHeTBJN+m5XEacV+gd3bocH4ao6KbWD3isc6J5RrGCEGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608058; c=relaxed/simple;
	bh=lcvuYe7GeCU9jXQJtaC1ntbheOmI8WkJcC1aR3hKv2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTepLfs6QF8mN5x7opZLYZS7FTFvbC0k1ywUzGtOwqoJFjwwLTXMMmhZfiNesc21ajRSxeWsRnZT3430iMiCMEFn/xQLpNZIuONU1brXkuaBaKlwk+cQWp19bzKF3MW373qOP7JSuK99tNTUzcXWjbeR5bbhhde/Jyf5bwwe1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU4uYczo; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b9a35a0901so122090eaf.0;
        Wed, 05 Jun 2024 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608056; x=1718212856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/z8afaos4QN1j31mCC9NKqTF3Z6R6V7O2t8IBODAYE=;
        b=IU4uYczoxD5aP9+hhj1jR6l7DQ5W2JAxhqZV/JsSLeDsaWP1el++CLgbmXxJZrfIZ/
         26gdkTj1eswT4oPeKMV7Ln2i6qf1LLZpJEemoiw3mlTCh1DxvV9jtbMze+h9Pgx7ODwH
         kwOxW5q1Tit3Ors3181FxOK+YtzF4LN6tRHsPfRBiWXBhUvnF1YMnVCMvQ0dw4rzg+zM
         JuETqzKG43X2GV4AcWtPY+vaLzMl0yRWQRdBmYJnm67zDRmaXvf7dF8EMVehka9rVihY
         YD5P/TsYFbFNvd3BRXDTCEpldT3ft7i1nDEdxQ7kpcpaZwv0dCAEIl2P0QBOARSa4Tn7
         WuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608056; x=1718212856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/z8afaos4QN1j31mCC9NKqTF3Z6R6V7O2t8IBODAYE=;
        b=vW0FpxCQI3eMHBvnoGlWNHjuqNRUg3x3urC/+a2scH+EQqJBmijLGNmZRJ0mWZMSB/
         MJG/zt18X/ODBDgyUGwKXzyO/oJwpphT33j6YBW6+KZc/vkFsOKUT4MZvJmHwoFLY6Qg
         UI6hekGWO1M+D/F/0jkySNtSRmXnrcWG7mTZMlV6nhnp0taK2raBHXAfnfIl0bdPSoWw
         tRw6gku1zyvleLAUido5JvxLd14EPVwWmpy+dOTyahltpbumbsLcSVfsVgq0lDqiaDBE
         xv3Ekq0+kLaTHTFwuledkOq8iAC/2a701CVf2gaXgbbnGGHgE6thWGbLSW+RwhiiXC+N
         +qTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs4/TXvXmKKgfaWVPyxHurPx7iL23lc2Z9UZfC6gOHJXrPZyXGCx+T0wtNI7GUT45ETSv9OvplTboZyjHU+yNs9CbjHQ2DMG36y5R/CqnFqQkLlOsQRv3EF4CW72az+d1C57Eu0w==
X-Gm-Message-State: AOJu0YwUK+Fu47+N6yqnbhbhRfRwcOFzXW//VhZfd5Da0nZ3/63IhM+1
	sf3427sz2jHuxOgV74Dvcog8M6AT9e1m0i5PZddPJSGEzOeW6WxC
X-Google-Smtp-Source: AGHT+IF8/BaMC9Cy37HnJE/gDWoJIWn5VGKga5nBgLv3JuPdyTdrRaAwARV/IAT6vrD6FGx0R/k9Gg==
X-Received: by 2002:a05:6820:22a0:b0:5b9:8d0a:1568 with SMTP id 006d021491bc7-5ba78f2e102mr3789488eaf.2.1717608055898;
        Wed, 05 Jun 2024 10:20:55 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba72cb44f4sm586124eaf.40.2024.06.05.10.20.55
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
Subject: [PATCH V2 2/4] clk: sunxi-ng: h616: Add clock/reset for GPADC
Date: Wed,  5 Jun 2024 12:20:47 -0500
Message-Id: <20240605172049.231108-3-macroalpha82@gmail.com>
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

Add the GPADC required clock and reset which is used for the onboard
GPADC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 5 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 45aae1ae5178..64f476c46f5b 100644
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
-- 
2.34.1



Return-Path: <linux-iio+bounces-13138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900B9E6CDB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12CE16793D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210C1FCFE9;
	Fri,  6 Dec 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nhgkgWl2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C01FC106
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483639; cv=none; b=LwlbMB7uM8S7+vX+RJrtyc1dQgYuTRVBjSFASPCFzV5E+CNPChkrmjjzvLX6qFrj3pZuM7l/FGp/kfn3cVtPheW/H2Ytw0O/zz5FH5egyzTZdzgAGuoMtk3I7DJYkt4SAKNPU8MP/FW/OsUtqKb76Cy6o/kJ3rPf+SvXv8+r3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483639; c=relaxed/simple;
	bh=wtbhFgAIjwtZ+tw8WU+bfOrzW74Jy0OL371+f4t8O5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aI8R36mFTS4KTd4emQWDqGhaqClY6vRhzhCvh8X/grDmaUzulP8tOg3h9BNQ7t5+Ib9xKZsA7vphGUjuwSwXvp26lz4dztItnvfZdFgFsf0auTHXw2psdZWgJD0paAwSnC+omej3SIpfo05x3Yb/hFskklUZMz8+qclGJ5KNaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nhgkgWl2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a45f05feso21542235e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483635; x=1734088435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4ybOWdThQduxVTLLkmT3I5G8o7KcPOKxk8AzY6bhhc=;
        b=nhgkgWl2txX1NYdiqSvofStwXS/hGamQ9x6DhLLxxpoh2kuNXnqJLGBxrp29/4O6nU
         gvpW/3MzW4XpgKirPdSDbbgmIa64lDqZzYTilYpoaorKkmRqlm1z1aMg+WEonNTZ/YiW
         xyarKDj66tKX6HFKphTPMDMvUdUvb8EhE5ayAnu0NpzeH0w0OD4cfbB/19zT2U+0wHw5
         5/GVKk4eu+LtAH9MWaFzHw3MFX6Ws7QPfeLIUXZ0xwSXW7koYvDAFHXm59PrB9mLF2Jl
         zrDCwyiQ+pv7wMiLW4TULwd/AkMuI2NnD1gV2wieeX1dZOL30rF/KfD41QerOKDIJDzD
         8uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483635; x=1734088435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4ybOWdThQduxVTLLkmT3I5G8o7KcPOKxk8AzY6bhhc=;
        b=pdjWA3xjIynEfPUBNKgC2Nv6dJZmKEnfo0rPApFfx5A2XuIKevTibyH+tzZFQ/5YbI
         TzZSu/tRTJI37upbfbSP6sQLPb+JqU4q/clLptPW0ZHTe5bh6HcHh3ZQmWDvW8A/is2/
         xZzVBkP2CFeT/m7ISMhfnW1mlKDjqHjoWSm4ThO/tmmxH5vlibXacdlDAo5un6/3XftG
         F+qasizVGtirKC+MrTxSDz17C1I2v7+F3TUmTMUqVKZFZYtLXTugAXXnZ310OXXEcKvx
         ZR2iwhfOs6r2zHZ0iJGLResNYJlSCpe5KWF0C9HkS1+ZNbRjwhR3JGCfNqs0TfcOc1jG
         vh2g==
X-Forwarded-Encrypted: i=1; AJvYcCWMpAYHAczRJz9YUc2u5TGgB8cmvrt2ebylfANQFZEg0nrlcqDd+/cf866fWthfd1Hae3j7ABv/9FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDeAB5MPdpr8rP8UFXzTsI9XIBVKnvMb+8A0OUaHyn1HoQMc+
	2p1kXqn7RyccUlu7sDQdEhZOJ9PLQaUzc870JycUyn8LLFgxt3Wudr0cOYwidGU=
X-Gm-Gg: ASbGnctGxc8o7JRtrfxVvSRT0q76SwIW5LTgI3j/H0ruRfJS44aoGlVEBZthb5j+pGK
	mKb/BcHqNIR3Ywju7+salcCUnXD9XoRU0c7TkXWPxBNhodwdXtG2RsWhXwoAgkrnBIY+vNZfZq2
	4x/SxmDYwMV1RDXWt27dc8aDyw8RWIgPUYsnhEROIFRkDyQURh5sBoaTWqnEWZpNg3fk0puBNGC
	5hpgUnlKvOAdp22ZD4OQIc49O71GaRISwMTqJoXoXHJStpax1o6Y9mrrbRJTFl53CLBxuzv1nDm
	4CUc
X-Google-Smtp-Source: AGHT+IHD5gzyn6ySUv1/2CzhUdrsHWqA+utF/YjxqIPk/7oKZhHl7nuoqefyXJDNZSNZZHnZZAiGvg==
X-Received: by 2002:a5d:5f8c:0:b0:385:fd24:3317 with SMTP id ffacd0b85a97d-3862b33cfbemr2189732f8f.1.1733483635216;
        Fri, 06 Dec 2024 03:13:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:13:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 01/15] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the ADC IP
Date: Fri,  6 Dec 2024 13:13:23 +0200
Message-Id: <20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add clocks, resets and power domains for ADC IP available on the Renesas
RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- rebased on top of the latest r9a08g045-cpg version

 drivers/clk/renesas/r9a08g045-cpg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 559afc417c6c..0e7e3bf05b52 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -187,6 +187,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
 	DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
+	DEF_FIXED("TSU", R9A08G045_CLK_TSU, CLK_PLL2_DIV2, 1, 8),
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
@@ -238,6 +239,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -274,6 +277,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -346,6 +351,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(5)), 0),
 	DEF_PD("scif5",		R9A08G045_PD_SCIF5,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(4)), 0),
+	DEF_PD("adc",		R9A08G045_PD_ADC,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)), 0),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				GENPD_FLAG_ALWAYS_ON),
-- 
2.39.2



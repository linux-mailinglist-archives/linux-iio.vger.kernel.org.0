Return-Path: <linux-iio+bounces-5843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B412D8FD3D3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17841C2421E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E813A3E7;
	Wed,  5 Jun 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7u7KCVb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD00139D05;
	Wed,  5 Jun 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608058; cv=none; b=sgmaAUXYcdv/7V3grplm+g0WDguhuFZaSh5GDS9zmdaXsH4t/NVRFiRcwpyLkDJkBG7oNDrfPV46CJEMMW/AB8kl8qVC5QCNoCf4Q2WABhfg6fhRPuUjZqQ1UaiMXiwYKIsKzAv555ZcA+we+uHMi5fhkadt2rvI8Y5kvsADZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608058; c=relaxed/simple;
	bh=/3WUGbzsfRdMGcgxSF83iPvl5/rRLdUK7to7VHJ/hLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtG+7peA/G/CQ1NdyIVqcji4gMMFEUoOwemclVK2MusX4Jmx7G8ZwuILDj2rTmCn+0rSlwJ0WNLH0F8m0SIMve0q3+mom0uK1mlFN1vuKzFJ/LAkgVeNOEKOaDQJPG0ZerdJmVVo+FUx20+H3XcDw/m5U8hqikNQEAEUC2yiTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7u7KCVb; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9776123a3so138734eaf.0;
        Wed, 05 Jun 2024 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608056; x=1718212856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm8Yhk+byRnbcGcmTatBzsMUgVxwZv9RhcYpdQAuQCI=;
        b=H7u7KCVbtSQBqpNuxoj30UL2rNCILGdQoz6dAFmKrf/epJx/PNJG5OwbFxI7xasF9V
         6KCZxFFiFPt6wqDK/TWxDt9FPIsWJc9/dmGDqXhcGktmpP1dsDlJsI9aWWzvqte3G9oL
         VfUXcRaIYa10FiLcQmNUyLDH/8pToamctqAQmD74ySJFFoflqQVFPmKnPYJwR0oJ3EEJ
         r+o1Bz5SJuVtf7Obubk4/UeQsfsaGlzMeJuoJ3DWxLSKiKksNL+PaYsAGbIFle7EcmP/
         sxDiUH/nxPHB9XmbAzADe0Lnsn5P+91vAL6WEH6DeZ6oY0SKcv/n34vDM+S4OnecBkuj
         Vo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608056; x=1718212856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm8Yhk+byRnbcGcmTatBzsMUgVxwZv9RhcYpdQAuQCI=;
        b=XAxYiMS7yiF6+J1Kq2Eqi86TmUbOP4Qvu9lqleMPIS5B9bT1xEBqfuH2GxFaQna1Mf
         jRf/Uitqs4b3TSofFnALTZyNU6pTXDY38tVJK2QLlEx/DxkeYsk7T99n0p9Eltabg0y9
         8y4hq6bghhWS1iMvvo6b+u/8NS5lDAocvLg3Vy7t1Ez/2JVFcSUS2nkJTYFYgWkphXgP
         c+XeEbXqKNxcaSQoEGJenbt4i6GF7ZPrHOHAxsHZFDfJsfAxq8SrPpkvIaeTrIVsPjvt
         UQ6hbtp37hlno6G7NIV98R6r1i4T3mOezMyFUQfYZ0aKCMIJ5fZGBeUIwyfbe1uz646O
         p8QA==
X-Forwarded-Encrypted: i=1; AJvYcCVJTf82KmKhQQDucQdlBgzwGnwoSwwkqC6779Q7k/XR3GdGSB430XH2GQ4hOtfzo2Zrpf1YrxIjX/cGAqi+qLt8CP6pj2NdNtPTTNfSr0YAkcV5TarTjESIIwuIDfpY2hG2v/WuGg==
X-Gm-Message-State: AOJu0YwMYB/vplp6p5tWzswy3SRdwXcn8/9+Q+8SRnZvE9/7im03OZK9
	TPnzoXzP1LHVhF5F/h4Qz0R5dRUzhMpOj1bXoZ9Y+MifzHoc9IY3
X-Google-Smtp-Source: AGHT+IH4f0Qu8g/XdwPgr2Z7RFxmIcBoFptx44anMYUmu4fxOCuDovIPdBzmN3XV8wodkT07jf/Jug==
X-Received: by 2002:a05:6820:1610:b0:5b9:f121:5287 with SMTP id 006d021491bc7-5ba791a0ab3mr3660070eaf.9.1717608056588;
        Wed, 05 Jun 2024 10:20:56 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba72cb44f4sm586124eaf.40.2024.06.05.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:20:56 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH V2 3/4] arm64: dts: allwinner: h616: Add GPADC device node
Date: Wed,  5 Jun 2024 12:20:48 -0500
Message-Id: <20240605172049.231108-4-macroalpha82@gmail.com>
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

The H616 has a GPADC controller which is identical to the one found on
the D1/T113s/R329/T507 SoCs.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 921d5f61d8d6..30ebc0d23760 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -589,6 +589,17 @@ spdif: spdif@5093000 {
 			status = "disabled";
 		};
 
+		gpadc: adc@5070000 {
+			compatible = "allwinner,sun50i-h616-gpadc",
+				     "allwinner,sun20i-d1-gpadc";
+			reg = <0x05070000 0x400>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
 		ths: thermal-sensor@5070400 {
 			compatible = "allwinner,sun50i-h616-ths";
 			reg = <0x05070400 0x400>;
-- 
2.34.1



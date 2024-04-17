Return-Path: <linux-iio+bounces-4320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5B8A89D5
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 19:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF5E1C23A1E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE9173321;
	Wed, 17 Apr 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oeu7oTlX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062F172BC3;
	Wed, 17 Apr 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373473; cv=none; b=kpeMP1eeesbZ7PHstf9JwLpd0BqzpXBNqAVf4plXxm7Tlsv0ue6vlv7iv5zs27/11woeDPVqfhrR/JkeMyCZm7Wn6LnWlEkcOjpE0Fgv8Qfit0JdGqgTwKF762zNlWn3UiQEcf6LveJQo9Rui0zkTpN39Opm9yP/0n8EsdfDR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373473; c=relaxed/simple;
	bh=a5yNIb3DWETpDcHe/Vm3HaAy/ZuOIsSOSp2yUIilK2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsj8Ar9RXN/+KsOmAoPVPN28nIHbAtHL5vvJOvXeYRX5LwoL/iR00XMlFBa1LH5MQJrdkItxaMnjgBMU71UioInuU31uvANmWtz92vDDbkU3Mi8QKKXaz20NpTym43NB5BiSSyUWoxkmIFqBDEwMvA7E99osa9rw3UtpIe35Qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oeu7oTlX; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ea2375d8d0so5152487a34.0;
        Wed, 17 Apr 2024 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373471; x=1713978271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prMdfKdVjihJkVjtxII37s/3IfYAkYUes4DRF7hF/AA=;
        b=Oeu7oTlX0QvdGUw9kqUg7od8FfyAbkQ7hivpy+sc2UChUJVmwOLsWj29FwfwcfCTKN
         k9sBmb7ksmbM3R3h6Rpri+S0KXD/gg8vlf6SR+I/ud8Pr9YYyq81zaMFnq0DRDxCeC+I
         PaNiLuFeX7ODpfUPQRcxJw+0iTJ/B4REL5itaedZnIlryCEWHnLGNhXHEaGpDg8RNd+s
         hinPPBiMbKzp3uGfAuahy5f5jR8zVEeAQrxcJC7WFC9M2rrIj3+thS0z2xm+s6ja+wbV
         EN5WlVIFkR2T1cxOrWLarg7pb360k4xmBOJjJxkJcR3DgerdmpliJQnhSIC4Z0FSavdw
         fYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373471; x=1713978271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prMdfKdVjihJkVjtxII37s/3IfYAkYUes4DRF7hF/AA=;
        b=Dc1VDWMYMN/VF2pzK3LQbKUjUdOTDo9NZkbET8lfPOkaelhaEcg/hKHhNHk+DwirzP
         GNr0Hdzm84dhN+lZiF5EJb6LurxxQKoKGqc5Z1nszRAwWK6PPsyh4UgJJEsqQqempbZc
         2byFc5YGTXVIbt15GG7tQ2jgb0h0Rz/+SPyX/j9ZU9Fi4+0r08tiP7DjqCdmET9CPLNY
         D4JK4CMtASR4Wusums+nMZUYymiL/bWzaGNnyZj2PfwADU22lKLRNIQHuM7t6485nwsD
         eirOkp3oHQHytDs60hPEzpNdbSR75K1MV1V8Pa6p80pYigLaH5b7nZXxl0NoHZl05c2O
         c6cw==
X-Forwarded-Encrypted: i=1; AJvYcCXhD2V5sSX//iz5YHBBiJpGpStYv2FnU5HyzAB9blOC6p8wDHagXKogEf+qxqurRX8VfwnNo5AQ4iKekFXWBHI4bWBWjp/GJSJfsuLCFtLhmME+iUnerjfx5KKBWjIK+C6mDVDD2w==
X-Gm-Message-State: AOJu0YzjvgzFdXP0k22NyTMIiUBnkVuQodf1Nk0pAmD1PofixCzel1XD
	yyZ0Szab/6ZlPdkeSMW9YI5XFJ4nJuc9+Y6Ic7cXhu+Nw1xUKTj4pE3U4w==
X-Google-Smtp-Source: AGHT+IF8Esnmptd+mkJwzWr0neEUR60f7GHzPM5hDrXG022mYRdPS3fkX8aR4HdDgDvlX+/YdQQOKg==
X-Received: by 2002:a05:6830:1197:b0:6eb:7963:160b with SMTP id u23-20020a056830119700b006eb7963160bmr49471otq.11.1713373471034;
        Wed, 17 Apr 2024 10:04:31 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id k20-20020a056830151400b006eb77e42ff5sm1721615otp.26.2024.04.17.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:04:30 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: allwinner: h616: Add GPADC device node
Date: Wed, 17 Apr 2024 12:04:23 -0500
Message-Id: <20240417170423.20640-4-macroalpha82@gmail.com>
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

The H616 has a GPADC controller which is identical to the one found on
the D1/T113s/R329/T507 SoCs.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index b2e85e52d1a1..3da37948b89f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -581,6 +581,17 @@ spdif: spdif@5093000 {
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



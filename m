Return-Path: <linux-iio+bounces-5845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07048FD3D9
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E92A1F264EA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797413A41B;
	Wed,  5 Jun 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWREmKkT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2712770E;
	Wed,  5 Jun 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608060; cv=none; b=CWBIFSLH+oUUBgu071ywtStgt/pS1TkRhiXsqxtLEIb5Al0RSzBesw8/8Dp4BGjLRpZO6hPXirpqKgXUfUh55j3eW/boiDVwmkbJznNv53h8sDqV8Ws1FFs4fSWRea8XB6FXGAFUAqQ7F3NvP7fbHYxAlBfE8jXBYbwELr6uiJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608060; c=relaxed/simple;
	bh=v38uy+IsAqWrg3+fAws6S2ICkUmrSoIfFgYw6LUYthQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmvtaLMAn/glR7lu2caKVAU6yrLNKYrnNnINhIKQRZ8mixQ9CmNZsmJd6lOHE7VCLKyUdNHG+efskd0pV9USBiSywiPtnFGA+I10/e3b/rarAvcAOCgcqOpJy8wMLHZrBj2wYKC3FuvG+AbiftdnRy2QpNFesLNnKxMbBRD5Ocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWREmKkT; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9776123a3so138743eaf.0;
        Wed, 05 Jun 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608058; x=1718212858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4pcIzPV4SvI/NyTBNCy7Yz0DtvpCZI8zaBZ0O3NwdI=;
        b=fWREmKkTSgieg72gltxefIoY7EtOw4vjVwsJ2Jxdkd780Ci4FiJkagc2W8GXc0OBU2
         MQS4otCInfjS52tW5i7ygFCYPzZIf4AOrHz1cOtwvo+TlYPc8LZvyb76geT0Y2hM8Hpm
         oMxejCvw9r0tlxWqEGWC498H02hhFJifZyT6RYkJk3hYIc8slaavlhQY4uJL6XgHn7cL
         quTOuWGr9ccIbZRFCBrgRfvcLUnnuEmJY8X6qPSt3E8LkUNe4xp7ZNmj5k+Sic8pKur/
         nvx6z1bKxq6ovtGmDBR7QMWpGfAK5+iq5vepNre54Hr4v0/ai+nwgogIP4EZG2skjE4e
         87WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608058; x=1718212858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4pcIzPV4SvI/NyTBNCy7Yz0DtvpCZI8zaBZ0O3NwdI=;
        b=Vri0P91qB00ykHUXWprIHIVX7Yz4GotTULz7+lXRZQj1ca1l963PdfRB0EBsFrxZhi
         tk2yn/UwTiO/mzHwV7BVBHWeaUO02TOuE++x3XBU+kTGYWDlkWSIFgdPSdT+ftoil6In
         WjJ+qK4xefC0KULDqbud3kfNho1WNerm13whtpyCPeKhgb3PoWp+FoIybYXMDvpc8CEC
         x5IS3bPAy2SIRmJoYgk8hKdl+CsC7kIfetVmsijk1lHOxP9SsvlkOQnOH4GaJIJKBETQ
         SXSpwbFpvM0R8py4KZSrYfS898Rjo98llTsc9ZXn5oI0BbNRTD0B8ruqcgjfbriq2mCb
         9PMw==
X-Forwarded-Encrypted: i=1; AJvYcCV7yIL6iAfClVqlBG+YOPacqHWLL7FYhP5d30XTEXaVpIa1uqHc9kHGwOt7eoMHugEbbc1BFDp6M1fyoc18G4ZrOTBUy5WiXlCF4SDxyvJVUwM7lR6nKbDJvJEq4KGCJOlJzoM6Aw==
X-Gm-Message-State: AOJu0YwGCJNXItUc8JTGYLmGybM4ROmTshPzBaZbfI77twfVTauIAB1G
	q9MV7IAHNYos4Lti34a5PNG6aPb8GjYu6iFgUCefe+bBuhanr/05
X-Google-Smtp-Source: AGHT+IGEJO2C3SSIjP34dzzCCjDHbY4yJhxKBT1mGavHFwBkJoiH3hI/Qn94POcXRuJQcwhV0obvmg==
X-Received: by 2002:a05:6820:1c8f:b0:5ba:6b7b:66fe with SMTP id 006d021491bc7-5ba79162559mr3582930eaf.8.1717608057663;
        Wed, 05 Jun 2024 10:20:57 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba72cb44f4sm586124eaf.40.2024.06.05.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:20:57 -0700 (PDT)
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
Subject: [PATCH V2 4/4] arm64: dts: allwinner: anbernic-rg35xx-h: Add ADC joysticks
Date: Wed,  5 Jun 2024 12:20:49 -0500
Message-Id: <20240605172049.231108-5-macroalpha82@gmail.com>
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

Add support for the ADC joysticks found on the Anbernic RG35XX-H. The
joysticks use one channel of the GPADC which is muxed 4 ways by an ADC
mux.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../sun50i-h700-anbernic-rg35xx-h.dts         | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts
index 63036256917f..ff453336eab1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts
@@ -9,6 +9,78 @@
 / {
 	model = "Anbernic RG35XX H";
 	compatible = "anbernic,rg35xx-h", "allwinner,sun50i-h700";
+
+	adc-joystick {
+		compatible = "adc-joystick";
+		io-channels = <&adc_mux 0>,
+			      <&adc_mux 1>,
+			      <&adc_mux 2>,
+			      <&adc_mux 3>;
+		pinctrl-0 = <&joy_mux_pin>;
+		pinctrl-names = "default";
+		poll-interval = <60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axis@0 {
+			reg = <0>;
+			abs-flat = <32>;
+			abs-fuzz = <32>;
+			abs-range = <4096 0>;
+			linux,code = <ABS_X>;
+		};
+
+		axis@1 {
+			reg = <1>;
+			abs-flat = <32>;
+			abs-fuzz = <32>;
+			abs-range = <0 4096>;
+			linux,code = <ABS_Y>;
+		};
+
+		axis@2 {
+			reg = <2>;
+			abs-flat = <32>;
+			abs-fuzz = <32>;
+			abs-range = <0 4096>;
+			linux,code = <ABS_RX>;
+		};
+
+		axis@3 {
+			reg = <3>;
+			abs-flat = <32>;
+			abs-fuzz = <32>;
+			abs-range = <4096 0>;
+			linux,code = <ABS_RY>;
+		};
+	};
+
+	adc_mux: adc-mux {
+		compatible = "io-channel-mux";
+		channels = "left_x", "left_y", "right_x", "right_y";
+		#io-channel-cells = <1>;
+		io-channels = <&gpadc 0>;
+		io-channel-names = "parent";
+		mux-controls = <&gpio_mux>;
+		settle-time-us = <100>;
+	};
+
+	gpio_mux: mux-controller {
+		compatible = "gpio-mux";
+		mux-gpios = <&pio 8 1 GPIO_ACTIVE_LOW>,
+			    <&pio 8 2 GPIO_ACTIVE_LOW>;
+		#mux-control-cells = <0>;
+	};
+};
+
+&gpadc {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	channel@0 {
+		reg = <0>;
+	};
 };
 
 &gpio_keys_gamepad {
@@ -34,3 +106,10 @@ &ehci1 {
 &ohci1 {
 	status = "okay";
 };
+
+&pio {
+	joy_mux_pin: joy-mux-pin {
+		pins = "PI0";
+		function = "gpio_out";
+	};
+};
-- 
2.34.1



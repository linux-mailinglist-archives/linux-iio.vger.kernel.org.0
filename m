Return-Path: <linux-iio+bounces-6439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA3E90BD54
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0861F225DA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC619A2A5;
	Mon, 17 Jun 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFTavih8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351F199236;
	Mon, 17 Jun 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661969; cv=none; b=cisJwfEqIZKJxpGrmMaeFYAaDldoPKpACGeChG/URaVRk+zEcNwet15rj3Hiu7T+VV1Qm42+yu73WERbcBpBYgNrgc0m6wWOuJqhWTZCoQfkBYGI51baxTBjQvIeUTGTP8rqMXuOCLkKSmKJjyqfmhV8i4MvEThRtc6xyrXZyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661969; c=relaxed/simple;
	bh=j6RTuMiwhhPOe4aRhhv5nDakG1pInbsHkJ/5EckbV0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxDokYknitg4pjdfcMstdu1VqusqVCnpsToRUm7wF81ZzHBERG/9mSV/bmmeD1wYnyV0r7tKxs9Odc3Pk3fmGFWl9RZKcdXCVZnhhuTS5D6KYt3bnU+IWWIliLOIgFqLT2SQR3Ha4+SZLeXdFb+Opz/JGZtk9KscdY7MtqhSXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFTavih8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6fa11ac8695so2745676a34.3;
        Mon, 17 Jun 2024 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661967; x=1719266767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BziCaw0KNoy52TFFrJE/sLYMOcgMiEW8rOGB9cWp6c=;
        b=NFTavih8sgTtR24vO82ehbltkanghN6iHYgLY29AQjBls9NUwi2L7ZHFsvTnFTwaFc
         EaAFxv0rY/8elmrv4u/59yEUBHpSTqO/WCtMhmF97DFkcFqBzSw2XQEZFainjmtFxRpQ
         SFlMbBgeiKuM4X8S9GCvBIkwMe3fPsUPuYkQTMKBW1sGQt2osWgPbuvPRyCjSJQv2Mn3
         7pRKYacMckzGZzhzyhdaNu4pqnJ1BfSmHRyJJ1HoFM2w2TKPkHKCZKYzNwNHedTZi78A
         6j6xyRT/r3rnHTCPdxxPqRBP9vTfct+7IkBGequnmkZ/DzIKf3etS68rYgiWuxamR/dc
         lY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661967; x=1719266767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BziCaw0KNoy52TFFrJE/sLYMOcgMiEW8rOGB9cWp6c=;
        b=LixS6Jp4OtNf8pFLqm1KOcdy4YDfxHSe+HgWoUbwblavDUTPnLVkbFkXze5hh9HVJd
         UcpCJga2Td/cBAm/TQfh3SA3kIPYE+X5QZ6ET87K3YexymZJY59Cy/i6PBgQOH8C3SLq
         4Lmw6wXZYZbCeB0a4JgRVTbqrYOe1ycrfFliu33NIHo48n/AEQliN1RaN2WL1+97ZN02
         WiG0yHvUn1WEu8iqx5heOyEe0cWFW2UqjYT7O+Fdqhd1n5xlicJkcRe5liOJbRKrEM1H
         J1QoQNxj7HgZDiNzZGGa/Gykns40Ie7QFwQe9jOudR/yzVfHzqTOJlc8w+3zP0jxseby
         sCsA==
X-Forwarded-Encrypted: i=1; AJvYcCVyNcMhPIE0ucrntdlY7Ni0F77b3bJZ45S/SamIzQV3dq9GNvTDeKCl5mVnaY2P3JzSvDvhOMDVyia09l/c8MH/ZXs/2sQvcglWYdiEzOjHukkvCOQ/Ak0Yg/s2AW4x1Ikd4ujk+A==
X-Gm-Message-State: AOJu0Yz0pDx3+qB+KY0Q9rAWrui4nM5vm2h1/cp1FSRBAVTcUPKiFRWA
	kD1Ss82pruSSwMWKN4yBkv7+NkXvxT/AW0YOYyJ5Zyz7v8xvMAb6
X-Google-Smtp-Source: AGHT+IEr69oVoQp6ZjahqW/ytJ1vFMjRMIerdktekBuGD6FU7Uh8MBILwqS78oEqXitRb7vFWx1GWw==
X-Received: by 2002:a9d:66cd:0:b0:6f9:5b24:4668 with SMTP id 46e09a7af769-6fb9375ce9bmr11413893a34.10.1718661966945;
        Mon, 17 Jun 2024 15:06:06 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:06 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 8/8] arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
Date: Mon, 17 Jun 2024 17:05:35 -0500
Message-Id: <20240617220535.359021-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617220535.359021-1-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the necessary nodes to the AXP717 to allow for monitoring the USB
and battery charger.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../sun50i-h700-anbernic-rg35xx-2024.dts      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index ee30584b6ad7..f15a5d193f7c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -21,6 +21,12 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <1024000>;
+		voltage-max-design-microvolt = <4200000>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -217,6 +223,16 @@ axp717: pmic@3a3 {
 		vin3-supply = <&reg_vcc5v>;
 		vin4-supply = <&reg_vcc5v>;
 
+		axp_adc: adc {
+			compatible = "x-powers,axp717-adc";
+			#io-channel-cells = <1>;
+		};
+
+		battery_power: battery-power {
+			compatible = "x-powers,axp717-battery-power-supply";
+			monitored-battery = <&battery>;
+		};
+
 		regulators {
 			reg_dcdc1: dcdc1 {
 				regulator-always-on;
@@ -307,6 +323,11 @@ reg_cpusldo: cpusldo {
 				/* unused */
 			};
 		};
+
+		usb_power: usb-power {
+			compatible = "x-powers,axp717-usb-power-supply";
+			input-current-limit-microamp = <1500000>;
+		};
 	};
 };
 
-- 
2.34.1



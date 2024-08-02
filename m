Return-Path: <linux-iio+bounces-8164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEC9463E0
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B06282F48
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5B175D50;
	Fri,  2 Aug 2024 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFICEZWi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204216BE17;
	Fri,  2 Aug 2024 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626585; cv=none; b=m7l+yflIHFhqnvd4CcXHeJfOACW5Ri+YpduYdhTJHYrKQR70M90zcK1LQHL6JSza+meQcGj4idHPlfv7dWc1jWuYt4kldoCl97GCyWynkcuN04jjO6q18RAn+4Bm0BCiAMJ+VgmlhS+PMb5Je0DXXfD5/bT79wSDhEVMrLAwbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626585; c=relaxed/simple;
	bh=IGFCSTgJcuoRzGSPK8CuSC3g7DiKhbxO+wXlPg2+FUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryCuyTtcwK4pI7E3UPiWA6DzSLLC4ChG+z0FN0X4HoFUAy4C7wkmKaQjsp6YJYgUfAlMvw49XE2IlL9GZF4vDzoA4MVf59xAPPOqONyklqoEKyTPCopSQpBPU5tyCWvCu+IfpsY5ciXhBjH+x7biOeNTR7bDV98ucwGvm4h8J34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFICEZWi; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db130a872fso5755512b6e.2;
        Fri, 02 Aug 2024 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626582; x=1723231382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bljFmiJkhPU7BKEtswdXuPsqQ0+QMylW7jPglHY9Uc=;
        b=MFICEZWimSkBi2PEXf/cO6ADccLuSaUU7uQrmNxIgaXyAD90MiBwKhNTC1rZkNsoyL
         sM3UW+kgT9fcsQCbXL7AhGg45SldeOCR6BHTc2J3q7aJja8ccoDhrPBsnZBks7BYZx1X
         b5jg0M1ZXk8T8F+OmkW+KlugIWRHE1ONP+nDxMLnjXcncL5StFnsEIZg/0siDMvdQgIt
         V2W5Lf30KXi3Ero04wzpSV4Pm/vOdM0gznpfVTt1A0GtenMQXBEwuLHjmJEM1R2Shwja
         wM3CcDaz6bXu2ORTsH8S186B58IYVd7BccavNPXoQOvMubbeV+POdXUnfG2Tl6Q/41to
         xLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626582; x=1723231382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bljFmiJkhPU7BKEtswdXuPsqQ0+QMylW7jPglHY9Uc=;
        b=w2Sb2dk8WCk5nFs2zKdDN3Sf4Vvj2htLp26NbyrKILGsWnNuazh/m2Zmw40pKI4Zkx
         y1ou8sAtMLwUlmpkwzZLbZujBhd42VA4cIvhOhmmcdi+5/+U4X8Jz2UcC35WMTaSGilZ
         eA1uP/kG88XpbX49OFBu3i5nH5eAuCOjQhL+Ni65WaArmkVOgqWfLlTjCZMWOFRPvyhO
         JOsm+fMauMVCK4OBioe75ogMgjHsJETnMV7ovBOEZjmjmqaNoSlRnTyZ0A34a3Sn7sI9
         t5sld/T07JE0rv4NpDHpO7HBqrf4SyY+vk7fTuwDnGeCuhu6rPodfMaPkUp6jXQ9NEKn
         9CZg==
X-Forwarded-Encrypted: i=1; AJvYcCUcx70Y3Efv5sjH6QXKGGBspzw/tTW6XQBk3v7zmFhTeOHosyfJSf15fqnmzUnZjxI45w5Q4Z0wVfDy@vger.kernel.org, AJvYcCXKupjQFeeDwwAD0nhtL7Ob/zZS8ow104iQSUJs6jfEq9m3PFd0q5eNo2S8m59teC8TrW4nQ6P17fx9@vger.kernel.org
X-Gm-Message-State: AOJu0YyN539MuOYSvupZ++n1YDz4gU68IlDTrKDj2ZxMgA3OxeXANBwT
	mIdatjEHudRs+1AN07FnOkb/MDsUdE4JBNgT7rSHeapM0+klRMD5
X-Google-Smtp-Source: AGHT+IGjBzlQxgg8C+yv67X9RvusG8E8mOEP2cJ31NbvBUQRSj0BF+eewV39CvF2RjsSsdpKP8J97A==
X-Received: by 2002:a05:6808:23c4:b0:3da:b3b3:191 with SMTP id 5614622812f47-3db5583db96mr4810309b6e.48.1722626582119;
        Fri, 02 Aug 2024 12:23:02 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:23:01 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 15/15] arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
Date: Fri,  2 Aug 2024 14:20:26 -0500
Message-Id: <20240802192026.446344-16-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
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
index afb49e65859f..83b5c03b1bb8 100644
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



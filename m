Return-Path: <linux-iio+bounces-8617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B89570E7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D642B282093
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F45188CDA;
	Mon, 19 Aug 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGzOvSUc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C218800A;
	Mon, 19 Aug 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086137; cv=none; b=HuK263qXaoDtmzyKS7ZZJzksVU8g1E3B6les0DHlwIfVaKjt+46/MED0P3EtorLcEjPg1vh03eEeFj8w+E39lkXbKZW283zPqEfnP0m5UU4anBFLWYksIdrGwlG6tsrjZghfZUHrldOp6RiTFIqjPem9jFA/DAwusrjxFbmpRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086137; c=relaxed/simple;
	bh=XsvG87BwJjdkSaTHJqzYZpciQ121wWu6rMuV/WcvVAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LtKaQK2E7ZKl+Qo/fKDg3YEULuN4VkkNO7JyQYDoSnLil9lqiHoqy3mpYyCZPqKySKqFZTbN88Ql7fDzJXqczWL+zc1u4KOH2yiVIZkA4gWTzxSFwJGY+XWd255uvEShwStJUMQs2tIHaJB8pfBWKFzCOmD9NtEp/9km71xob/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGzOvSUc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70938328a0aso2351939a34.1;
        Mon, 19 Aug 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086135; x=1724690935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDgCKdCvmsY03Pik3wYi9u14QEc+d2Lmm2q5fMkp+bI=;
        b=lGzOvSUcMnFiodtRejCfk71HFct2t4rRoPSdLjswuKjcSehz4562tAoVmqHQurjJj5
         ETkCxbpgEl2x0N7q2Td7z7o81bKPalOvI9v3rXnfUIuTWVltgj/vg0Geh/NKxL+o8wnn
         v+76Mpquw1fShmKvv/0wb+PxZruX3jmPnCBuu3T4HWf6/X/wk2AL//Pk2odZsef/jLgk
         +7fzIxdpLyl2xsLGIcPoz7EM0wDCt0m5DnJyHKQEo08LYrC6yjsCv/lrqo7oX0/9XOyV
         ZcApOj2byE0PytGI6Z6tNH+MBambWVKsWcjmEvMVgt3veEnu9rgFHTWzvT/W3P62COZ1
         uWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086135; x=1724690935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDgCKdCvmsY03Pik3wYi9u14QEc+d2Lmm2q5fMkp+bI=;
        b=fgUml1T35zz/zy8Aq/SKTX0DLupWwfG4y44GxST5wEcONnQ2uYwAg04hcwzRI9kqCk
         D9139y66/wGnqta/svrhwotCamywcOfjcGtdhMo6eJGmizuRS4+dTZ4sXn5oBcaKe+eA
         p2aTkAqEL+RBeDml99C6Wno+2Bgxfle+7fDvktE7RDhId3M0tmNQ9UQAOe6rSZTbrLiP
         s5mcpEdI+bipDlB0/qm4jNu5glEA/MBSkThBe3Qw648N+mqkFNcus+8JYSajFVVORTDM
         lzTth/93697LBeE54hpmLSFOMJNQpXX9Qr4mIiSfl0l0tf6d9bkSa7GguKPgaMfk/Urr
         jPHw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Nj6LVWkzIfVl1guf/QD6/qk5XxUg7us8eZhI+B41m80Ou56h7m75s+FyboT6Z1JoinUeIrwxBWft8HlZv4CKexUJK9d82okqCKFddZsxznkWVU20Ksp0YqCRwmdAnrl2TLsp9A==
X-Gm-Message-State: AOJu0Yy+ZlRsgprIkGX2MVj1nNkwYnQpoVL1/10SAMcPN2fjonHiK1Sq
	zx0U6FlDRbMnkuy6TD9NKd1DuDhYmqf6kTc9wYNOEXEjLpJYQFPWN0Rovw==
X-Google-Smtp-Source: AGHT+IEOCZLpFVa3etUE3cD8cEJLVRhuC8dwY9gXtzaL2mwue40C2B/W2Rq9aJPon4OTO+dgphhnHQ==
X-Received: by 2002:a05:6830:358f:b0:709:4e4f:931a with SMTP id 46e09a7af769-70cac8a3c81mr16674258a34.22.1724086135220;
        Mon, 19 Aug 2024 09:48:55 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:55 -0700 (PDT)
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
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 15/15] arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
Date: Mon, 19 Aug 2024 11:46:19 -0500
Message-Id: <20240819164619.556309-16-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the necessary nodes for the AXP717 to allow for monitoring the USB
and battery charger.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../sun50i-h700-anbernic-rg35xx-2024.dts      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index 078b9ea3d9d0..18b63efae083 100644
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
@@ -217,6 +223,16 @@ axp717: pmic@34 {
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



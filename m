Return-Path: <linux-iio+bounces-8679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A3695A764
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BE5B22805
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4B17E00A;
	Wed, 21 Aug 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9f0wx8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C517DFF2;
	Wed, 21 Aug 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277463; cv=none; b=sen0fUNTgrb4CBNyovz0jL3sAx816me0uJU8FMNSM+fY/84gtg5jetPB9JH1TF1ZsyZuyrPrrO5ECsut5/7T/OAQSk4JxNE+7cDpTN3TrZy2YPe1Guuo77l3f/DNBsSEZtbZ6lbqX9A3na0iXPMKFCfKAWK63PKcL2BitwwSwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277463; c=relaxed/simple;
	bh=rOUWIONG2jx+3YsOkzOxNCT50C8BqSOGk+kTUHABbDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMaQdDKUy7sthpPohSSgbVjzmlHq1BB4DuioX/21h+LDnJuL+tYMkcRV+XxgQixBjAFdYzixj/JufLGfeiXCVLpRMfKOTY3R8jMkx/xBeBcjryqTXIN5ry2GrL+7ki3mqkrtpVnnasTM1PtsUtnNoZ3fGXs304H/Sdp+Vg37X9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9f0wx8W; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db23a608eeso95342b6e.1;
        Wed, 21 Aug 2024 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277461; x=1724882261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKDNW6bXNlNSyXqPzsgaizF0W6jVGjlSVIlGtBFqzzU=;
        b=I9f0wx8Wdj9ALcp0jVdYcMZGSwMyW0r7Q2hnaVyUuAAMiT+Lyi+KXfrqlQYygGTtQ1
         rh0RYyQ6cIcfU+b6U1bwXLMYQPvcRvNKXafluMbasmK3WkB1pXpdFx9rgk1WbuSZOf/o
         YNoEJb9nBtzSN2XUtgPxxjYgbfzNy9gM0rf+axK6s/rv88IZl+UrnW+hnB5/wpMQgjIg
         7qJmYA11ECbxyqlvzDC4E5yA5fSk9lQ3B39dlb0qicNZichmArvJVLKXtgu7dzr7hmw3
         1ixwWY7ouOTyq61R2S3DDSv/dUYl2wDJpwH/zFaWkGZW/ElDd+Vir8Pg0fpLR59iBGw7
         qFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277461; x=1724882261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKDNW6bXNlNSyXqPzsgaizF0W6jVGjlSVIlGtBFqzzU=;
        b=TpUzhTK6LiDGQLVF9/Y+hE5jUB1saneKqatrBw9wpOkGNTa0BO3FEdJo8G6/qAclLR
         tQg/TedGQZ8fCA6I5Qt2qCGOiF2/jDcaBifUK/PaNVfF3su9oH3E/VR8r3jLsyoJk8Oe
         SgYQPIVWi+WDBiGcMl0VjLP4CHQmZL+OihRFkZ/ujS9yd3kpBWbwoZG6ukghBt+o688y
         1ijwKFjq9XdmLvLHaGA8yx7jbPMLkHtRX42N2jOS8Z+Misg0OKZxe0AL1xS0xCyrynQY
         Tv+kXVeq6ZKahj+eDDYOqcx2ZB5T1Ny+HQ5Ov72zKrUGCzuId+4hXuj47RoU6qBsBQYp
         OW2g==
X-Forwarded-Encrypted: i=1; AJvYcCW8nyOyu/oF/fxOAMPkujPw7VAyZpribZVHpIl1XpF6oz1dX8TdPizkhaFYZquMSczlCXBJ9tbDGaSu@vger.kernel.org, AJvYcCWiClVqhB50h9H5V4QtYp/+Pb5tkD4iBWdufN8xDZiqyFmsvLibKhQ//TDchMSZVjdPOm7VoT9+NX6w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ryu4EbRbn0GzwZx7HEyM1LZIJwdd0dO3tNd3pdnLHC/CXI9G
	jJdz0u4/mZLBP/0Yj7EsrRB20oNnZFIDMKamU35ZZVlM1CDCl4WG
X-Google-Smtp-Source: AGHT+IEot75d+ugH+I/XEKDoM+SkcrQKtwBcwYYvPfnFSXY6xNGTuXU9+zWMvMu4JO0C2GONh/4oUw==
X-Received: by 2002:a05:6808:1892:b0:3d6:2ff3:937 with SMTP id 5614622812f47-3de1957157cmr4703770b6e.40.1724277460736;
        Wed, 21 Aug 2024 14:57:40 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:40 -0700 (PDT)
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
Subject: [PATCH V4 15/15] arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
Date: Wed, 21 Aug 2024 16:54:56 -0500
Message-Id: <20240821215456.962564-16-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
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



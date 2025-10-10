Return-Path: <linux-iio+bounces-24905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF1BBCCC40
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D634FDABB
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D72F49EC;
	Fri, 10 Oct 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ACNaYjPr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30732F0C7E
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095441; cv=none; b=mvHxjRKW9HQUkNeyGuLwyyRkn2ITwCsRDfejQp3F491cZ8/NW3RZN35DHOq5IAI5Jzj0AhBt94A+E6KKHLCK68/UOFmXzGtg3r0qF15kUqgJegnzYM80FavL0UeogMVVkI8eWNrByv/Ej/6VlaLDOqs1w6xIUt0lMCAuVDyzPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095441; c=relaxed/simple;
	bh=aBMTPtPDt4M1GRWOyqpCZ1qdlJgnotQej/fUpg30pyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sn+tqpiSYzQp5wZZwbJHF4L+UzOxAsTdBYu8c18FnQIShhoMr2N51EtHGqxEFuNmP1NCysupCAZfYAZOo7bahaS6fZrYvJK99UdJ4uVZ3KvyJbFLKk6f/Sy2Kvwo/Nsnc3EL3eSk2dZ2izpdWMtZhQ8ZM0ZiVVp6dCcoxKPRE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ACNaYjPr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so3999748a12.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095436; x=1760700236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCAG8MFE1hhKxgzGizvbP32Gb84eEFJPKvZVLfU2qZI=;
        b=ACNaYjPrzkywZAgQXs1JxRb+ETCWKhV6hSmZVLeqdh0AcLZs5rxOwiFgwACWB4rltk
         CDhOjKYtSG9kOBdKJTsYTyzHTukaKKTNOJTqo+818xxYtja/MrdMp/gxI/n1EoCx/iNv
         cV8pcNzhEVAWrEtg3G/oezIlNoM7hc6O6TnypZ2LbWT+Ulpd+HRL0TnAjF7Yz7OWUBY6
         iHrva5Z+on3L8gAClGfvqIiOI4J+ef6hxBQNa3CgczjVyR7e/31OZpvfbT5kJuEy5ArX
         ButIBM6t0vVXjhj2fgT5WaQdwYlUJvv3Nve7tvIFfZXjXDgotpuY1Q+BAVg6amSbYryd
         dBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095436; x=1760700236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCAG8MFE1hhKxgzGizvbP32Gb84eEFJPKvZVLfU2qZI=;
        b=C3HbGIYVYedX7qVebSKOC26f8S+la6q3PjbG3yiEjSWx9brgUucEasntFVh996TFAy
         eNE3A2ZGN2kaQ2gjjjk+aHqSoGV86CIY3uVQhvjI9+ZHZr1CS9xpIuF0xNuXST7G7iNJ
         n2wONokvFbvW4UrIu6DcSzFK2an+N/5xLtUYciZizYK0n8+HvcoK88tYCWFDjHuXKBXy
         JsIObtmtSlsB2VQ0vNoIR497aZyQ1eA3m9GPkHNJLQ/JIwK42Q5JR8eaqvKENIsF6xdR
         v6EFE82hqtw5kfXLTUOaJdUqLTQ04tI8a+eAEYYjq07tO39hNxIsx3w+QXLH3ewsaLQy
         LeBA==
X-Forwarded-Encrypted: i=1; AJvYcCVcpFzWndqqHj3OJtuJEwotytpBWNheuJ6L5X0GoVrxwP/ydJLjPyCe1jA9wfVsCIU7jGljSf2PsS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysm/CvVi3KttVePkvvsRbDVatXGKVsGWLsa2LJ3VgeEqzkKiGi
	VKt69x4xWNGkpIjV5qNHYkDkPmka+AagEW/CK3ZvrSUSHY5rnXv8w3i8JqpcPcTsD+g=
X-Gm-Gg: ASbGncuJrP2EYrkZid5RoMZyhlGR8XTA2aB6LN9qz1bNz3/aMKnFFZ01dK1M114yk2N
	o8i2Tq/DEQHxMEBhidVtUA6gNzyht1UX1GW9qZu8uFVUj0ttgzyJsHBdKVkxk+mJ67Pwm4G3CWK
	FfA4iMHf7486ljjmvbncnkJlB8UekyYX1J7EjZIV4uFhWvPFab4XGjigssO8SHV4YbNASUAxbvs
	ZAMhJDiaMXjqRe8TU3iI5apKbD982PBAKKR7FKz5DEH0LSTSDfuVBHxZ8u1XHURMdWjcu497Hkx
	YY1o5bZRbwuG10jrNBR5FA4smzMptmvZbcLtughQ6mtOHFFRTOm3FZ9mfa8WNIEDWpM2l/e6U78
	dSvoD9nY0naR4YqB8rcIP/km/n6m/Z/hLTqHL2cf/NVc8A1y3srwyZFCpxA0GmhOI+K3wDGA+BM
	UgDw2E6emrUugSkuE3T74=
X-Google-Smtp-Source: AGHT+IGsAakh/8g2j83SKx9fw/+oQlSgc9qI6tjYbD9FJ2KHiIAG+QpeQGgMy8xOFcppj58CQxNe8A==
X-Received: by 2002:a17:907:961b:b0:b3a:ecc1:7769 with SMTP id a640c23a62f3a-b50ac0cb195mr1154612866b.52.1760095435795;
        Fri, 10 Oct 2025 04:23:55 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:22:04 +0200
Subject: [PATCH RFC 6/6] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251010-bat-temp-adc-v1-6-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=2583;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aBMTPtPDt4M1GRWOyqpCZ1qdlJgnotQej/fUpg30pyI=;
 b=DG6raoy42scFWp8jMx4GHyDTeTHosn+ep/uPea5mNpCWeWqjD8FtINPdQuqqrvkBh+hTj9hB9
 b2JrnMH1voTC9ep4hy/q8gBtWKN+XacHVXEgdX0i+73ImCPhJE5J0Yz
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a generic-adc-thermal node to convert the voltage read by the
battery temperature ADC into degree Celsius using the provided lookup
table.

This will later be used as input for the fuel gauge node (QGauge on the
PM7250B).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 71e87ab92955..24855cec7880 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -107,6 +107,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
 		io-channel-names = "sensor-channel";
 	};
 
+	bat_therm_sensor: thermal-sensor-bat-therm {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+		io-channels = <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
+		io-channel-names = "sensor-channel";
+		/*
+		 * Voltage to temperature table for 10kΩ (B=3435K) NTC with a
+		 * 1.875V reference and 30kΩ pull-up.
+		 */
+		temperature-lookup-table = <
+			(-40000) 1673
+			(-38000) 1649
+			(-36000) 1623
+			(-34000) 1596
+			(-32000) 1566
+			(-30000) 1535
+			(-28000) 1502
+			(-26000) 1467
+			(-24000) 1430
+			(-22000) 1392
+			(-20000) 1352
+			(-18000) 1311
+			(-16000) 1269
+			(-14000) 1226
+			(-12000) 1182
+			(-10000) 1138
+			 (-8000) 1093
+			 (-6000) 1049
+			 (-4000) 1004
+			 (-2000) 960
+			       0 917
+			    2000 874
+			    4000 832
+			    6000 791
+			    8000 752
+			   10000 713
+			   12000 676
+			   14000 640
+			   16000 606
+			   18000 573
+			   20000 541
+			   22000 511
+			   24000 483
+			   26000 455
+			   28000 430
+			   30000 405
+			   32000 382
+			   34000 360
+			   36000 340
+			   38000 320
+			   40000 302
+			   42000 285
+			   44000 269
+			   46000 253
+			   48000 239
+			   50000 225
+			   52000 213
+			   54000 201
+			   56000 190
+			   58000 179
+			   60000 169
+			   62000 160
+			   64000 152
+			   66000 143
+			   68000 136
+			   70000 128
+			   72000 122
+			   74000 115
+			   76000 109
+			   78000 104
+			   80000 98
+			   82000 93
+			   84000 89
+			   86000 84
+			   88000 80
+			   90000 76
+			   92000 73
+			   94000 69
+			   96000 66
+			   98000 63>;
+	};
+
 	thermal-zones {
 		chg-skin-thermal {
 			thermal-sensors = <&pm7250b_adc_tm 0>;

-- 
2.51.0



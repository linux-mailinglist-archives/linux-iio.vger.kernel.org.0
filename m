Return-Path: <linux-iio+bounces-18672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2027A9D496
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14DA1BC3648
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D14225775;
	Fri, 25 Apr 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2g/Q1T7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CD208997;
	Fri, 25 Apr 2025 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618062; cv=none; b=MRVRpjLNl+TNdEvHX12CxxEuAvuBwYOK28yhWIL6wyup8wKIKBaOS6km15kWt4gSeg9oAqxiTSUShmCdxgOMlCWeDzxfyH2TrXySSTgX3euVx3d3Go2LWdMG8aXVGcyN1vwZTvLTYSjQP0e1uoeqO6dV0ZoI5dcZCszmcykCZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618062; c=relaxed/simple;
	bh=/Qg+jrzz7ohQYOyGyC0DRfDJYxTT87vaFSUzkC7isnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=udeblBQq04/R2OUo3MaSiBKqGc2Df/ik0eLBHocGPdpZDPUJ2oXgkscXpUDcPCZcGdJSXPeUkqXYWvzwWg2mu4ikX222G11UXltwJ/l5CXnjwHOZ5ARqLlQpDqGxytVFiznDpAyX0/p5f52yVJ0lu7Etbjip9RIocIPPsircJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2g/Q1T7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so31535825ad.2;
        Fri, 25 Apr 2025 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745618059; x=1746222859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCobKniwenRsZRQXHN93hhOkNZYsytudx8yyvFZoPso=;
        b=d2g/Q1T79dgYBiYRTA04dDbvWn9pCspC9OGzX06qmOjCDFRXb5xBodSBXbt3SOH1eC
         paro7FkDpSs/oWMRN/VsMtxiEaiXAx5fVhlefpnpSNf6szA2HM18rpHXgsGuclFEJVnP
         ivSvc84YrHz4/Qv0NNVehRmSDcDGZSs6++/wpRTjx+31JGq5DU6qvmMNdVHhIu1N25ai
         VYAWCChKFTWJBifB5DxNWJcz3sTfhh/O4ynrhSiU547inNwVN9AtzJEa8x53SWZfkRCQ
         OVrZXaXCWFhziYa3pA/GWvNMXoz5WdqWtONNK/2QJO+LIUG9vQP6QRuE+4+tRKtwIdie
         FC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618059; x=1746222859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCobKniwenRsZRQXHN93hhOkNZYsytudx8yyvFZoPso=;
        b=p46CZIvrDFTnxWY/F8sc6JaNSz4ysPtIKaeB298eQF5mUIlMyBDdL4d4qi3Xzh/Jqr
         lQ6HKMMuemlVnmFSfECHPNlLMy2lnw7czPPISRgOr9MkGevXS59dBaF1YyQgIkSLR+Sv
         HxqUAur27moHMEzPhshiRWI9j1RGN/alr1CPYXJyFAZ4cV1tpedfjFbxDZhIrAJNUgCu
         4Uuz6ciy14I+tu/P7C3f2qCfzpvZ7MWLRoFi6lskYFeyDZj7Zh3U6ZJR3zYf40PcvibA
         3Tzy92Or4ZPsxoDMmCerb2m40R+QqvUwO7yoiSBilhxQKE/aJ36EOgDmqIh3M/OHg/mk
         gFyg==
X-Forwarded-Encrypted: i=1; AJvYcCU2PS6xK9akhyUEjTUUGTkPvMPrc0qe7CG1QVXTotbVqpcs5elYW5nsdVLbs2bkg9T4n+s4w/B6vL+N@vger.kernel.org, AJvYcCUklnHfbY3V5tIg1CyOb67e8rxXegKbbvplf0c1E27kdfW6LE/z21P78rp+CcDeZgqj3A/9wY5UUbnWcvr9@vger.kernel.org, AJvYcCWwKVgYs1RzZJNBSloqM3JBkg66pLyLULiSzX8y0yNFA24JiG8a69aW5KfGm/kKD9AblnrXZI32zahl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmz6ZNM1CxQGUXhVi1BKPxBnsf1Dc83scWoYn6bXYlddvpEKp0
	P8uzabcs3cYUe3okcR66W8pbDK/gCkXOGN80QIK2v1KhfKXHPUE9EQIXESiQnck=
X-Gm-Gg: ASbGnctS+KK48BsuT8SQfWS32jbAToOzFnce04gdgLP0+WcwyaF116x2seWH0NUgWkT
	+F4XCm/LkB4PFKQj2K7EXNkjOw/ZBPO5IShu7TDxtOv4W0K/1UZqtgTJ4+DqPibuYjsgnASF0d9
	Wk+bF6ruu20sAqLAJWXFLkLfcrNPZQIkPg2QyZCQmVflDKGxRv5dRdJdpAFv4jDBW0mTKV1D8uf
	oQQMnd18dlj+me5nmHHslsOWM+I5vkDot+ZfoyobZiv3+i0uySPiyUVuBlhTVSCT+IEtc8fNTwF
	FB6plhUPQtgc4xKxVj8fzOogxZ2acFVbK/nHroTqBXw/scG6cf4sP9EPKKYBWfQ=
X-Google-Smtp-Source: AGHT+IEhyiPUvx6/TQLgHrek4gH35yub8pGeGVD8zCIOvwyadYampCv51ThIk0Qc/PvSpWTxrFLFWA==
X-Received: by 2002:a17:902:d4ca:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22dbf5fb486mr54033065ad.23.1745618058561;
        Fri, 25 Apr 2025 14:54:18 -0700 (PDT)
Received: from localhost ([2409:40c0:2025:2c31:c6a3:5653:2e03:8d7a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f7749938sm2211580a91.11.2025.04.25.14.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:54:18 -0700 (PDT)
From: surajsonawane0215@gmail.com
To: jic23@kernel.org
Cc: surajsonawane0215@gmail.com,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: chemical: Add sharp,gp2y1010au0f
Date: Sat, 26 Apr 2025 03:21:49 +0530
Message-Id: <20250425215149.49068-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Add Device Tree bindings for Sharp GP2Y1010AU0F optical dust sensor.
The sensor measures particulate matter concentration via infrared
scattering and requires:

1. GPIO for LED pulse control (280μs pulses with 40μs delay)
2. ADC channel for analog output measurement
3. Power regulator (vdd-supply)

Datasheet:
https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 .../iio/chemical/sharp,gp2y1010au0f.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
new file mode 100644
index 000000000..358c2b2f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sharp,gp2y1010au0f.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp GP2Y1010AU0F Optical Dust Sensor
+
+maintainers:
+  - Suraj Sonawane <surajsonawane0215@gmail.com>
+
+description: |
+  Optical dust sensor measuring particulate matter concentration via infrared scattering.
+  Requires ADC for analog output and GPIO for pulsed LED control with strict timing.
+  Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
+
+properties:
+  compatible:
+    const: sharp,gp2y1010au0f
+
+  vdd-supply:
+    description: Phandle to the regulator that provides power to the sensor
+
+  led-gpios:
+    description: GPIO connected to the sensor's LED control pin (V-LED)
+    maxItems: 1
+
+  io-channels:
+    description: ADC channel connected to the sensor's analog output (Vo)
+    maxItems: 1
+
+  io-channel-names:
+    const: dust
+
+  sharp,led-on-delay-us:
+    description: Time in microseconds to wait after turning LED on before ADC read
+    default: 40
+    minimum: 0
+    maximum: 100
+
+  sharp,measurement-window-us:
+    description: Measurement window in microseconds after LED turn-on
+    default: 200
+    minimum: 0
+    maximum: 280
+
+required:
+  - compatible
+  - led-gpios
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dust_sensor {
+        compatible = "sharp,gp2y1010au0f";
+        vdd-supply = <&vcc>;
+        led-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
+        io-channels = <&adc 0>;
+        io-channel-names = "dust";
+        sharp,led-on-delay-us = <40>;
+        sharp,measurement-window-us = <200>;
+    };
-- 
2.34.1



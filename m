Return-Path: <linux-iio+bounces-8973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB319684E3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96C283A1C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2641D364B;
	Mon,  2 Sep 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fEK1B1K5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14511D2794
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273430; cv=none; b=UfCHlHcC0nRYM8UCpnt5JGgBmxZQrVpK5nJT7t15DJ04sDWGUagB13FQD2W/rEyrWOMzFwN26Wo9N7e4buWJgR0xF+A+11PBSpuXcalfDdlefEfydz7xSYXQHKK6YhqzzBnG5S1ITaHp5nLEOG/RIIjssVJOXG4+QIGryeCnl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273430; c=relaxed/simple;
	bh=+xcwvwnOEos+K8uKWPlM5UqP6pRbIIK5EdikTy64FQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjKV0I89zgBDRJKyGI6G1L3SOi2K1JdxbTRdDTwo9set5lNdiEOQ2hF55e+CtV3f7cl0f1yPihCgsGu5b6ynh+W6UOq1b5MhDjzgJPzaxGHyTM3ii7EtKX7NU4Rgl3t3cvylxaNJdaVYzflnNSLlrhVAylceAH+aQXMUe99/M5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fEK1B1K5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53345604960so4524821e87.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725273426; x=1725878226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj6lOb0yjAx7sj403+lOC5LTgqreAMB1j3nLGDxealA=;
        b=fEK1B1K5nEIs3Mnr5RgbvWmFk0PKayS9lPXB8Djy56RxWoucyv9rL9bOZy95QS+HH2
         E88tK7Sq+yjHNVfv/qowhu2Y0yQQJIJGnIZhyZQLSVC20rfRf8bl3/wH7K1ArW3MC8/T
         H8EzRGjJ4cCxbxR0Hk2rgk12rC/wbBT4H8tIZojHunNST/dRpdnuMMoboX9988axRufl
         ug3zaRLKOsLaFyfEnub5myTFOZuFhUw6HImuPnv/ginBYWlYB9kEfcCz77WG4eMNkDLg
         tcCkHGTvxv73X4molRt5QBtIiClx6VPw1wOVD6ID3E0Yl951ILi5B541GRrfRMuiFxSn
         NPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273426; x=1725878226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj6lOb0yjAx7sj403+lOC5LTgqreAMB1j3nLGDxealA=;
        b=CbQusD3Xd4OW4yJxNhgCXFzwLH/l+Gqtmt6qh0qxnqNaHaKL7cRQ4ZtzXHEJiAzO9M
         1/Tr8cU+yJvSOwSdfxxoKfoD/WVOcGh8HFtOGEsGIF+44UDBjBGutWNsMg3FCcVeuSPd
         GPyP3BAqmtc0AREs1QX4Tn43IJSNZwmDmjke/odiG1sj7nzi/m0zcSZTjRiXZD6KFjpf
         xB/KC0fESBPUNMidPjLp0irj/VdBznyRAEmdAerULj9poxvKg58s9wfzxeiO1Jl01sP6
         HWuRd2W5Yy1+mvTpig36LbSHYORFCVjebAWFMgIkjzXJmS0MkONDwVz1w4EDvPAXBUMK
         Azzw==
X-Gm-Message-State: AOJu0YyZHLowEPgJ5Yuxo80ndJMNBrpwzQXii6Iex5xTab0BeSGg02G6
	HU6OEBz0yV7LsrajbSBlffrL5UZ2Ol/w6GKkEpFgxsAqA+kCVM1POtPbhbrXyscX9Filq/v0IU3
	EV1c=
X-Google-Smtp-Source: AGHT+IE2DvfTc9clWhRcBzgZkoCye+ZIyZvHBSUEKE3j6/foUVQ0qS7Ex9pf2WIZFfDqtljDp9VoMA==
X-Received: by 2002:a05:6512:3f01:b0:52c:c032:538d with SMTP id 2adb3069b0e04-53546b2a7a1mr6980668e87.27.1725273425775;
        Mon, 02 Sep 2024 03:37:05 -0700 (PDT)
Received: from neptune.local ([2a02:2f0e:3004:6100:e124:ce40:67a4:fcf0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm540876766b.182.2024.09.02.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:37:05 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings
Date: Mon,  2 Sep 2024 13:36:30 +0300
Message-ID: <20240902103638.686039-8-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902103638.686039-1-aardelean@baylibre.com>
References: <20240902103638.686039-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver will support the AD7606C-16 and AD7606C-18.
This change adds the compatible strings for these devices.

The AD7606C-16,18 channels also support these (individually configurable)
types of channels:
 - bipolar single-ended
 - unipolar single-ended
 - bipolar differential

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 .../bindings/iio/adc/adi,ad7606.yaml          | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 69408cae3db9..a1b8bfff76cb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -14,6 +14,8 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7605-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
 
 properties:
@@ -24,6 +26,8 @@ properties:
       - adi,ad7606-6
       - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
       - adi,ad7606b
+      - adi,ad7606c-16
+      - adi,ad7606c-18
       - adi,ad7616
 
   reg:
@@ -114,6 +118,25 @@ properties:
       assumed that the pins are hardwired to VDD.
     type: boolean
 
+patternProperties:
+  "^channel@([0-7])$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel number.
+        minimum: 0
+        maximum: 7
+
+      diff-channels: true
+
+      bipolar: true
+
+    required:
+      - reg
+
 required:
   - compatible
   - reg
@@ -202,4 +225,44 @@ examples:
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7606c-18";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+
+            avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
+
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+
+            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+
+            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+            adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+
+            adi,sw-mode;
+
+            channel@1 {
+                reg = <1>;
+                diff-channel;
+            };
+
+            channel@3 {
+                reg = <3>;
+                bipolar;
+            };
+        };
+    };
 ...
-- 
2.46.0



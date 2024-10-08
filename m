Return-Path: <linux-iio+bounces-10337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832139953A8
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A649288D9B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EF1E1027;
	Tue,  8 Oct 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vNTnsTVW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DC1E0E0A
	for <linux-iio@vger.kernel.org>; Tue,  8 Oct 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402314; cv=none; b=P35jhwDR8Dt2/tqPrschZbr4l0Smrw1oMZq2UvWNKOXj1ftZdE5Mr4mrUbGvbPxB7nElernY8429cZ1avAfH9DB2gktZDlLo3TgnepXeD2WkQokpMuVVZ8uqOAJG31wuKbeVL62ztUPWt910KVk3eYhDVEdKRk3U7+gipE7YbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402314; c=relaxed/simple;
	bh=xr9RT2k9QB30sb+oaGsonM/FAlW2dbe848dhBDaxzS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oz525xPNv9gRzabp9cmYpUynB+nFxXdDuZ4Xyfk93UgToH/5WTDrAdG1XLsSB7uaX2hC4Gt+wWIqf/fufRe74c5weKH3RVsGT2loivhSV+1A3Z8jrj+2o+uduyirPH1TphPwGK9xSuyL1VYFgx/w5secFzCTHP9JNXshDT0JoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vNTnsTVW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so54289545e9.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2024 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728402310; x=1729007110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vJCKcpLZmA7NSQ3tA3IoAAJf8C6kAh4HvKXNcB6SgQ=;
        b=vNTnsTVWR/16MHIimZliqkWYzFeouDJY9iYC0fvvxEPSRNfIz1EZt/a0TUhl8L4keJ
         Dvo56tRjbm568YulM4zHLBDYZg5t+CBFLSVZH1yDEEkP39hQiIikmGmX3Sfl22cqPww6
         Fou6L/kZG+vgGSCgg4kiT+4BMRCTctGfOT2UvWSt5aMkheRkTYyVZrF3VF0ym8sTl/ak
         ovEFSbidtroo6SwloiGOhXhdhzWSZKVrFWjSj5pdrvkvsr39dHn/+0LsOBFVnL6BWRFk
         r56VB8jUp77Sfx01HPCVvxey/+394kwyznxTFQC0I3GGL3xO5J122nyTOcZoBJYLSYx/
         /g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402310; x=1729007110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vJCKcpLZmA7NSQ3tA3IoAAJf8C6kAh4HvKXNcB6SgQ=;
        b=JCY839Y/5gqTJrJjqoxhcjHpKjVQQpf8qPsNqOtptG0KUmftDC2tKUbugsNCvr/8IV
         OuWyBz7fxb92iI3iJRVkLudoXWcUydDmXvICqzQQfDAlzN9hBS9BVEgVCv5wNcPb2Gen
         CF0c4EeYWuW5RuE5Dp0wXfRLH/qUGwOGXaCVh1fW0fu2fBtE/jek6O4KyJXUWQBk4RQG
         id++ogPE6CEGoKM9z2jmsuK6dYpPdI8SleT5ABGH2vJJI8WjgYhCCj/ukYJmq595y2qy
         j3fQiTWOwWXCfSSDt9TiVEeZOKxcnW9i96Iayt/M/vqUugQ/3k+UPZ7YiLn1T8siqnY6
         dAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFDeQp59DU4vtheX43EHz1G4G0kq7qyBvKC7BQbG57jCPIvp7BZEwDpEhtA7LZ+nDtekzqdoJvAnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMyY9gLTSP/cFf+3dYoa133QkWgSxFe+3NrgNIAg6nw1POMA6
	fUGvvdeqp0/g+koZ27oNUx4D784+Px6H/lFBWqeHCVcT6aFrrHprQIJdMlUeQRo=
X-Google-Smtp-Source: AGHT+IElmKHV2ZMVatSxLm2Juf95+317ll2kN5INeBUtrdarC4Zrl69DER1EC5QubOVSWvdn4TvpPQ==
X-Received: by 2002:a5d:4286:0:b0:37c:cd1f:1ee9 with SMTP id ffacd0b85a97d-37d0e8de859mr8307884f8f.54.1728402309552;
        Tue, 08 Oct 2024 08:45:09 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d826sm129591215e9.26.2024.10.08.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:45:07 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Oct 2024 17:43:36 +0200
Subject: [PATCH v5 04/10] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dletchner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add a new compatible and related bindigns for the fpga-based
"ad3552r" AXI IP core, a variant of the generic AXI DAC IP.

The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
generic AXI "DAC" IP, intended to control ad3552r and similar chips,
mainly to reach high speed transfer rates using a QSPI DDR
(dobule-data-rate) interface.

The ad3552r device is defined as a child of the AXI DAC, that in
this case is acting as an SPI controller.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..2b7e16717219 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -19,11 +19,13 @@ description: |
   memory via DMA into the DAC.
 
   https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-dac-9.1.b
+      - adi,axi-ad3552r
 
   reg:
     maxItems: 1
@@ -36,7 +38,14 @@ properties:
       - const: tx
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: s_axi_aclk
+      - const: dac_clk
 
   '#io-backend-cells':
     const: 0
@@ -47,7 +56,16 @@ required:
   - reg
   - clocks
 
-additionalProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,axi-ad3552r
+    then:
+      $ref: /schemas/spi/spi-controller.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -57,6 +75,38 @@ examples:
         dmas = <&tx_dma 0>;
         dma-names = "tx";
         #io-backend-cells = <0>;
-        clocks = <&axi_clk>;
+        clocks = <&clkc 15>;
+        clock-names = "s_axi_aclk";
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    axi_dac: spi@44a70000 {
+        compatible = "adi,axi-ad3552r";
+        reg = <0x44a70000 0x1000>;
+        dmas = <&dac_tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        clocks = <&clkc 15>, <&ref_clk>;
+        clock-names = "s_axi_aclk", "dac_clk";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad3552r";
+            reg = <0>;
+            reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
+            io-backends = <&axi_dac>;
+            spi-max-frequency = <66000000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <(-10000000) (10000000)>;
+            };
+        };
     };
 ...

-- 
2.45.0.rc1



Return-Path: <linux-iio+bounces-15270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D309A2F2BB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB643A5149
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0A22500D4;
	Mon, 10 Feb 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BfCR18ZN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148724F5B4
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203972; cv=none; b=og8JK89GpZS6CTGZf4i3UGaJTmQdsiZfh+CBNtCOsnr3iFC/FDPCf4JIe09hFfK6/gGPKaLVNztV+cJ99zgz+L5Q3BtMAei6pOBIIBgEWNqYjtJ1ww2Fz6xyuwa5kTanckfg+duCu1LJ6VQdNzkdUa6osc4+l3w+dOwgzNL9gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203972; c=relaxed/simple;
	bh=kwXNLzhFPFgyK/MlGtAAE9ABab95SL1ZniFztnA4y0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAUg8yAesF6y+XbhQvN/2SQ3sRSzF3s4t7NzYllN5l25VyzloElg9fj3H1rI54j/fkEt6wMYZcu6p0o3d+5t9IjtYNNB/G83nBypBwslgGkZjdCTOp/YnFLRm6g8Mfj7F6+uNEtJu9EcAGJ/SdgzKCcARqDrdbYfYzxnMQWjE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BfCR18ZN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso45436485e9.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203967; x=1739808767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZV+Yf08/wUq3PiOCJhJtefxQLfQ45hPPGLK7YrRpA/4=;
        b=BfCR18ZN+/VahWFxZEkkPQ7vTz3nomWVCEmKo5x839hXSXPVGXug3glceg3q85fjp1
         AdoaG+PjVHD0T64PnowERzm5+962Hq2Wb2LMrwN+/dol3K7sa8GVrIv8JihPiwnl+3Gb
         S8MJ5N5j0OqP8X9N/y0/vHjpNtU6lXbKJwpWGe04RX4eTpP66ZSzUhL1FbB35Dv0gMJK
         iLuTMDS0fKTdnX31i0vUcn5kcSel2EHaL/rDAcBTIp1ff2f8NMmOFUh5l1McNCXhuVol
         Ib1EVxZn/OkdZQvJRcqE9eSdxa+6vrPVARagPU/n93KY0Rgomf4+Y60/YO3GY/Pypuh+
         2qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203967; x=1739808767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV+Yf08/wUq3PiOCJhJtefxQLfQ45hPPGLK7YrRpA/4=;
        b=AP0i/CxTqIHV/MQppbykXEowCMGsdAhwh+QLQDMv/DktthsnYiSqGeQTZdlm64yVK5
         ewHutB5VSnIwFmFIfb2SYMZRj1B/h0FV+761TRgD93CvnEeLq4N5D9OMxM1EGBGHiash
         pVtCZajW/qYbgNWcLpG1ujE+Ikoq7A2U6rvuYWuu+mA4oUWWIli0ftNbRzX5iD3v7N/p
         NHavtlWVKVAsDjlAuaUUfqCgxwSA6GbOklo2hFooA/bGMUqD/0xlkvmbghXbUlGMGhoC
         fMspW4OLgjJA6H8aGGIQn5gEAEnAse1GCv+RARVB+cwlKh8UWx+gsomAszSqZNid8aur
         VMzw==
X-Forwarded-Encrypted: i=1; AJvYcCWXNEofHAVZGl84wO5CQz4ihDSyISMlQ+Ze/3nPu3DbOjU2lTnMrj3m/SW/FlPUAqEZxYqE8jJU6bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd338aHAmj48Kp1bCub1gDZniJoZf2DKztsFnEkjKD4996A13P
	XprCspbf6zLTVIkcs8NpSL8+C97f67cQ/CFTt43QbZsfghYYpIb7izP32uxlM0A=
X-Gm-Gg: ASbGncsCCGihDN7HAfjDtRk+7F3QM3jM6RUY97cDtnHhlIkWiC1nZ2Ns48lrkOCILUt
	H6kfRpbNWIaXuKkSzFTBGe/oaTkfycD5lyN8+HSpNxbiBqtyLUqKuEj9fkfO1QL6PnK5xMGAryu
	RkgCzRFE5fYtH+qRnokyM+uTnhENzieOUMwBxdin7L+cyi9OAechp/wm+fpzYCTWaqS0jmAP4AK
	D30Tlx9DLdklWP8fnQQfz57f7y0sPevozcc5h/vu0Rv4TcNLeUGDTT4Nkxx7qLBcXFSzAaGv4Wx
	wX2vRIYrAhSXUFokuj5iB3jO5ndl8FLzNPcPzKU4VeD1jDunKvN52KQgmZNWdBw=
X-Google-Smtp-Source: AGHT+IGgyxX44rjF1KJGAip5mLP3aLFiEOhklfEJtIQ41ZzowIfjzJkIh5pN6a37Asl7/w2ldYJ5SA==
X-Received: by 2002:a05:600c:1e25:b0:436:17e4:ad4c with SMTP id 5b1f17b1804b1-43924972ce9mr111412145e9.6.1739203967218;
        Mon, 10 Feb 2025 08:12:47 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:46 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:51 +0100
Subject: [PATCH v4 1/9] dt-bindings: iio: dac: adi-axi-adc: add ad7606
 variant
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-1-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Guillaume Stols <gstols@baylibre.com>

A new compatible is added to reflect the specialized version of the HDL.
We use the parallel interface to write the ADC's registers, and
accessing this interface requires to use ADI_AXI_REG_CONFIG_RD,
ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL in a custom fashion.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 70 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e1f450b80db2..4fa82dcf6fc9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -17,13 +17,23 @@ description: |
   interface for the actual ADC, while this IP core will interface
   to the data-lines of the ADC and handle the streaming of data into
   memory via DMA.
+  In some cases, the AXI ADC interface is used to perform specialized
+  operation to a particular ADC, e.g access the physical bus through
+  specific registers to write ADC registers.
+  In this case, we use a different compatible which indicates the target
+  IP core's name.
+  The following IP is currently supported:
+    - AXI AD7606x: specialized version of the IP core for all the chips from
+      the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad7606x
 
   reg:
     maxItems: 1
@@ -47,17 +57,48 @@ properties:
   '#io-backend-cells':
     const: 0
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^adc@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+    additionalProperties: true
+    required:
+      - compatible
+      - reg
+
 required:
   - compatible
   - dmas
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: adi,axi-ad7606x
+    then:
+      properties:
+        '#address-cells': false
+        '#size-cells': false
+      patternProperties:
+        "^adc@[0-9a-f]+$": false
+
 additionalProperties: false
 
 examples:
   - |
-    axi-adc@44a00000 {
+    adc@44a00000 {
         compatible = "adi,axi-adc-10.0.a";
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
@@ -65,4 +106,31 @@ examples:
         clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    parallel_bus_controller@44a00000 {
+        compatible = "adi,axi-ad7606x";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&rx_dma 0>;
+        dma-names = "rx";
+        clocks = <&ext_clk>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7606b";
+            reg = <0>;
+            pwms = <&axi_pwm_gen 0 0>;
+            pwm-names = "convst1";
+            avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
+            reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+            adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
+                            &gpio0 87 GPIO_ACTIVE_HIGH
+                            &gpio0 86 GPIO_ACTIVE_HIGH>;
+            io-backends = <&parallel_bus_controller>;
+        };
+    };
 ...

-- 
2.47.0



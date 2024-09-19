Return-Path: <linux-iio+bounces-9641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DE97C6F1
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDD0B23B83
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE3719C55C;
	Thu, 19 Sep 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g92ThZbj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6C199FDC
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737703; cv=none; b=qPd43pvr3wtb5F+bswSuDq14rl7ptzZEr2GT2Gw3WN7HhrHBjkOraZuDr3yLTMRCX+JPpczPGGwHsPrFrw4mFWCCWa4gjKUeHBcKUbnRDqAQRKFPpWWSpKahtYxzE/EdW7DggcDKl1iY6Dw8WOtwGGXJB/S84lFQJn8WlSenZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737703; c=relaxed/simple;
	bh=jcHHpxuLtdpMqMa6vj9yuUj6cUdqApIRaj7aqS82BZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pntdX/0KEE9PFzqP/nq68TRjl7oQ2FmSRh+W6kCr1F5HaDzQ4YCjRNq2xmxVo9jks3riNNKkC/jwJW7Za8S4ytERBDGtL9qc7gdJc+4P7Gn5wQO8v9+DU3CLNJUqEN9FuVTzcwjB+pv/yaqNTHt5169/AkoyIi9DtwHgbqKjlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g92ThZbj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e5e758093so5169365e9.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737700; x=1727342500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as49kqRLaVJ2yNgnvKYi3cFO3j1mhGpPd7aIfEYa3yM=;
        b=g92ThZbjlKGnCY1JXRIeiJ73RFATexgcyYgmal0oWlScvd+JD5DLryT4dSOfz5DNMK
         sE1z6rxEfqFEKUJZef2m97qKBfnv7XHkcAlwmCwJFQhx7N02G9lTSNHhpdyIXswXy9n1
         KslL0zkrFaxtvt1XOytDwv4tqlZm7UaEjQXWv8LY7vv+TT7L0EDuWRv1rD1Lzf0O5hf8
         +4+DGW6iQBCgCIH6HRIBWaObqT8rWOEENI3PrUo17aoS4WAj3pmvgD3tPZyX1z/U5hjf
         s2FctNsHhYsWADKe2CXPLhZ+27KFH72bEbrUoQj8a2UlEDTv6Te31K0QF9WCXxfDnhnB
         S8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737700; x=1727342500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as49kqRLaVJ2yNgnvKYi3cFO3j1mhGpPd7aIfEYa3yM=;
        b=crqxMzCaY+nhCh7NoHRJHlq/46RV3wdKUnFUCGjSmuo1ryPS/Ejuo/xgJKlJLEnKg4
         BP1kbdWuS5/jp1j14WUclia7N+murC9wj4tU8cm0zH90lhbsWdvvMAmvCGEixFViaWZK
         jUm8jcByHOVAXVB8CEdTwkt57jO+ftakZY8bpkARelhnzaTIhWztzID2KI0Fn/Ye/2p2
         wdLvog1Iffxw6UsqK188E9SeJGpWhLk6daxeufWODj06WTU1st7VWyvv1aoJvuhf7koZ
         /kpIGsQ5DnOlKRvpGIWUfLAXM33b5M4CXyn/oxSd8h5dqC4asVcbY7P7ed2IaWsCy38v
         27GQ==
X-Gm-Message-State: AOJu0YzSPNIBgVYtCVrcBnSjLjYixcm5eLB69hRm079eGEuaGtutMl6T
	/o2iUfLWXqzEytEXl4+z2a2TWMMqCVGNh3jniJm/sM21TJzd5RIJK1pPgyIpRzs=
X-Google-Smtp-Source: AGHT+IGWRcc6/8EOmc1T0X5CvPpjxQ1v9/oDjpa2olx4CY/PvhMRizP7HegUuy58IIILTSIW2C88EQ==
X-Received: by 2002:a05:600c:4447:b0:42c:b63e:fe8f with SMTP id 5b1f17b1804b1-42d90817e87mr171803165e9.13.1726737699665;
        Thu, 19 Sep 2024 02:21:39 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:39 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:20:00 +0200
Subject: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version AXI DAC IP block (for FPGAs) that provides
a physical bus for AD3552R and similar chips, and acts as
an SPI controller.

For this case, the binding is modified to include some
additional properties.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 41fe00034742..aca4a41c2633 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,6 +60,18 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      An example backend can be found at
+        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
+    maxItems: 1
+
+  adi,synchronous-mode:
+    description: Enable waiting for external synchronization signal.
+      Some AXI IP configuration can implement a dual-IP layout, with internal
+      wirings for streaming synchronization.
+    type: boolean
+
   '#address-cells':
     const: 1
 
@@ -128,6 +140,7 @@ patternProperties:
           - custom-output-range-config
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -238,4 +251,33 @@ examples:
             };
         };
     };
+
+  - |
+    axi_dac: spi@44a70000 {
+        compatible = "adi,axi-ad3552r";
+        reg = <0x44a70000 0x1000>;
+        dmas = <&dac_tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        clocks = <&ref_clk>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad3552r";
+            reg = <0>;
+            reset-gpios = <&gpio0 92 0>;
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
+    };
 ...

-- 
2.45.0.rc1



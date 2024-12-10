Return-Path: <linux-iio+bounces-13307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CDE9EAE89
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DFD165907
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B74210F5E;
	Tue, 10 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QwIkiBXA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE962080CB
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827611; cv=none; b=niwRiFBZz/oSy05nZPtxvf64+NG94bNHKAUypqQ/r210WtTmg+xIyUZ+UO4BdDZW59vS8loMwOuErJP0xAlV2NkZrbWmaJxkrbdNNPfWDlq6GSQLppW8u+payApmfWymq0fhjgYSN657maxOsdyW+T03i1UdYbfqomV6d8T0hrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827611; c=relaxed/simple;
	bh=gjf0nQQoBWAGsVMcSFONNcDZNY/bgC7yz8ja/yiFY88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDJOY3qWQvwjgKISpNvc25LCz19X8+ew9VPOToojL+E60gmHh1ctk/GWYx93p06Jc7Jx6i95KABnKwJ0Y0gGCO5esHXkNEgyW+vUiqtLB75G7mxCFLpr6Io8vwtFZIOUXQRXdybD35zigYvJ55OqritwrdJyBwhXKEtO2wLWtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QwIkiBXA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3863494591bso1483345f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827606; x=1734432406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA58kKEUAeOZYlF3Ik612RJpFfgnSJ0uEeIZq93J8hA=;
        b=QwIkiBXA8tlKQobm7iZ67d4YXwiDGM7j2epvkN3N717Na7h2gWkCGJfeEGGs/jqYMV
         fC5YV4SQ1GP+ngszpVH7M+TJU3Yzf3E4XM2/OZYMcDHzbuTb4PMqJ4E7mqj8dO1ycEzH
         2AR+DNMcyNxVkPn5DsEntJpFoXiCoDysOsdQfSPWzKYK6Z8rPjppqBWgjP8Gj+SnrE26
         moSHrewRPzKqcrCxmqDtdF4GxlCpsOzbfq3fTo3lnjgkZCEaM8h678ePRD/eExYB1/lI
         IeAtYuH/Nyr9LRsyfjhkpaJENepjfWCZjz1BDMpUqJNW/TzN6AWZ4lhq39PozIuZIVYi
         nvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827606; x=1734432406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aA58kKEUAeOZYlF3Ik612RJpFfgnSJ0uEeIZq93J8hA=;
        b=mtHOhsX1DCzWeX/ef84Ms267/FtffH/Zea8xhCe1u/VqCg6jAoQYjI2ZEgNwR98TCd
         jD/c2LLTqjb2vDmVzMIKmbVFvBrqffLdBKjYBjSG+9bzDkfVrztCzdM9CDRCCX12hbTJ
         oM0weyctv4FxJprelN/SSj2dKShpxAHIELZD7Xi21JhhzTqVFqraIxyY9US16CvE8f2U
         JFJfq3WjBXrhG96+2opI6pERtJpnuD8ioHoZBzt3Lx9cbn04Ap+4TL/PDEeaKw9A0Zk0
         /YTPnmjZMfjoNnjfI6AxZjCaF6+5sZeBTuv5NAjrYgJQlGYhUGNYjKrWETVxk6lkJhn4
         ajog==
X-Forwarded-Encrypted: i=1; AJvYcCXdfX8qlnYeZgj/0somp5s7IA3duxJZ3Sc64/pOmE6cNk7nhYfProqUNgmIZAF6qHGXP1Ml1Cu4Fg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUtZlqf5X0nVVwGUjkXfxntJ3fhmm7eEvhQEkDrGQoHq6x3S4
	vjDglE4kr8vI5Na6SIXD5dfQXJHbb5ChzdLc0SR10A22qwYP3P6UnxxQTi3fPuQ=
X-Gm-Gg: ASbGnctjoPNxxq7S9FujBS+G+WunRRzYoUcYaznwtvVAUTkqE1F/yV4QCmg03Y+Ck0P
	HtC9qWLMubhVurAIkp9eFrGXLTnf03TPGtwjoMdk9qDzVCd8V9OTYgHgbIRhtzyVSFHbxBYH3Ac
	zUHVrZPmjGSwmQwC9wX+GaxjFXo+sXuwli3/eOv3wtpPOCMvcAwccgNGZmebYqgeiKNF6HqkZsX
	BMoM+3w/nek8FmfNbxLm822xL8jXOynM75SECvYV1/ASyzLEL7A7RxFbcXk88eF9Wr6RQ12ca9v
	Bw==
X-Google-Smtp-Source: AGHT+IFbIzvkH4+2cZziFJ30qgBDduGBy+bNg0rWxUHk427hgWQmxfn4FILheE5Ie3BWtki9K5yJ5g==
X-Received: by 2002:a5d:6487:0:b0:386:3357:b4ac with SMTP id ffacd0b85a97d-386453f67dbmr2885640f8f.42.1733827606145;
        Tue, 10 Dec 2024 02:46:46 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:45 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:42 +0000
Subject: [PATCH v2 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=3192;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=gjf0nQQoBWAGsVMcSFONNcDZNY/bgC7yz8ja/yiFY88=;
 b=U5uvH2PqBtYNE0NXZMnRmVR9BCGsUX1HsccQXBG+CS5RmDUX7t0FcSTM53m5/ppr2Tf/5cXZQ
 lyjeU6ik+XzAoMrbiP2qT/cNVFbV1lDDTGdghEznHJUVpMwzA5LW9SI
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

A new compatible is added to reflect the specialized version of the HDL.
We use the parallel interface to write the ADC's registers, and
accessing this interface requires to use
ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL
in a custom fashion.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e1f450b80db2..6c3fc44422cc 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -17,13 +17,22 @@ description: |
   interface for the actual ADC, while this IP core will interface
   to the data-lines of the ADC and handle the streaming of data into
   memory via DMA.
+  In some cases, the AXI ADC interface is used to perform specialized
+  operation to a particular ADC, e.g access the physical bus through
+  specific registers to write ADC registers.
+  In this case, we use a different compatible whch indicates the target
+  chip(s)'s name.
+  The following IP is currently supported:
+    -axi_ad7606X: Backend for all the chips from the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad7606x
 
   reg:
     maxItems: 1
@@ -53,6 +62,24 @@ required:
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,axi-ad7606x
+    then:
+      patternProperties:
+        "^adc@[0-9a-f]+$":
+          type: object
+          properties:
+            reg:
+              maxItems: 1
+          additionalProperties: true
+          required:
+            - compatible
+            - reg
+
 additionalProperties: false
 
 examples:
@@ -65,4 +92,30 @@ examples:
         clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    axi-adc@44a00000 {
+        compatible = "adi,axi-ad7606x";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&rx_dma 0>;
+        dma-names = "rx";
+        clocks = <&ext_clk>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adi_adc@0 {
+            compatible = "adi,ad7606b";
+            reg = <0>;
+            pwms = <&axi_pwm_gen 0 0>;
+            pwm-names = "cnvst_n";
+            avcc-supply = <&adc_vref>;
+            reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+            adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
+                            &gpio0 87 GPIO_ACTIVE_HIGH
+                            &gpio0 86 GPIO_ACTIVE_HIGH>;
+            io-backends = <&iio_backend>;
+        };
+    };
 ...

-- 
2.34.1



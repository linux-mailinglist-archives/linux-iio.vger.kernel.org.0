Return-Path: <linux-iio+bounces-26367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B00C7B07F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F33A2612
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0632D249B;
	Fri, 21 Nov 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBMSB7Wq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C2344035
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745402; cv=none; b=vBYwnjoMoo9chnEKFgzCPoUnEVc3IU6lxuFC40GxC81DJscJLBNSkrZ2V7xgReEoitlFd7Fvjv66zWqELsYMfismGTBZLoeLJVHOkz7ZyOwcaJTMlwurgPU6ObyePBoPjbvIECXwe7G3tKj1U9fUJSfonPc2e71HtGj3/3UrsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745402; c=relaxed/simple;
	bh=ehm4ws2yMf2rLsIV55CO1QANq8wV/IBX6JJ6WdGosVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Imjw5yVCAusSE3ymCmcgYEYRNe/q+56T2xq8YxPZvvwdiahUpSCD3FZfdm15dV4HDE+z3nI9efRAOe5Ckpsl71NuYOf+sjTmGSv7kIdz0ZRNKb0fjxdCK189ILkL+qMTZUTkXSWJRK5ahyQquNRi790kvAhwm80LBDqd1UbTrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBMSB7Wq; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dfaceec8deso1473234137.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763745399; x=1764350199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z6055fPh7kB7snV4QcgA3fj8wpQZDtBh6CugABtOxU=;
        b=XBMSB7Wq+dxTwxiW3EYO7SHxsN6/LPj8A9dHyWDhD0WL2mcnoWny/Womz/m+sVMADy
         5UAAh0Wr2jlTj8FnUu6ozXJaA04T66MjpHAGBZnewZmA6zCqcY23OWJ9lTR6oAq+1/jm
         /E6Br709AJTxVaG+fJkJR+BKaAGQA3oIJDTzKe8sV5SjCBSLtjommY28WJ8elJa7zFbg
         heLysnCTbRyGBn61is+WXFMvkvV4khULdfMwHeQDFAYAbAGecLAufTcJlEDAQ+yFbHf8
         Zdl/2qL3H0Yp0C96nFb0QQHOp95XBqI3kFnVpAKEK1q7L2VHZchXG/vIPIq2fQwT+8W8
         Utxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745399; x=1764350199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Z6055fPh7kB7snV4QcgA3fj8wpQZDtBh6CugABtOxU=;
        b=TxHpo4UbfVLEaEG9u3MN05nnw8QqAHRIZ3jG79xBGEW0JRvxdh8LsMLViI2sad4b7g
         jBRVk7c00CRxiOuARcfgOiRZUHD/p6akt9HAG1juDWIlRTi6iBDBJGudFWvgr0qvk+78
         MFjmmoCYRW/oLbTKixKQnHpLUVyLhz0ER87LjD7mrB6N6d4S+eC5nJMtG7tX/h3byfp5
         ZhXVbvYbkjbdsSqcj/rpAV0tsk+MovxwlZngl6uPPXdjjAPO8wuonwqnoO3HfGscuIiJ
         sgrWyzZJSHrz/ViPE8mAVAlS9NE1U7GrcqFCVTm9KxTg5WcLRVNzX6OHTaXgeyDD6KfV
         K7MA==
X-Forwarded-Encrypted: i=1; AJvYcCWW1SffkMCkROiM0RKiosk09TA9WeihjkpEiP4vk3nOlf9/pd56br9DCeuNWBl/Nct0V0g7pEwzyeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+quuK7huhQrz26My65Ddl9iD90cRBZQKQzzCK0/0/brU4aIg
	Wsi/Ho/T/XUCdOQ0YsZBDuIaSnfpk1Me03DBjysSUnSD8xEs9wwT2sqE
X-Gm-Gg: ASbGncs6Ga+2fZVtVisLsI8ejqjj3NBaSPiUBvWyrqT0aCkXNNOa4gLuoizYtVBO2xt
	MAi6tW+X2zg3IcLM+2g7C3SIxblBPhZrimHz5tIxGP6BbMwhDCCNEjZ7p5Py4N6qQnE21G3GVP8
	iVMTUu7lMyqgNLWUUy8waxdvXilgS7WlnLIynV2C0HOrZOgGK5Texr2V95mzD5ZGck3Oc7zcQ9C
	vKcvodBQBPtc67OZXQRyY5Mnh3AUqczG3gn4OLJpjgNfdOqaoeMvguJnYJrjpNAlhoHdVKKmxYL
	ZDuxPMazJpNQDiiNAd8t0FuAzdereqDpGnN5aIl7Rtxxwyhwp7wCrpEuTKAYQDxIgkiY0wBp/Ls
	DDVQ8iDGOJlmoN2IcKM0VygwN3uCM9LH3vSwTPntaMBqlsAs5QU1H22IzsyDg5AAL0MXJto6aFH
	ix51howbHLTxxK
X-Google-Smtp-Source: AGHT+IEfi8liiww2gOeL0LR2tzYWdsW6iCYd283+pkcr7skpg77hS2K2UbiAfPjBof34fVdlgv5H/g==
X-Received: by 2002:a05:6102:424b:b0:5dd:c53b:75cc with SMTP id ada2fe7eead31-5e1dcf41d12mr1343612137.13.1763745399592;
        Fri, 21 Nov 2025 09:16:39 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c562728fdsm2554368241.7.2025.11.21.09.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:16:39 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 21 Nov 2025 12:16:14 -0500
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
In-Reply-To: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ehm4ws2yMf2rLsIV55CO1QANq8wV/IBX6JJ6WdGosVY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkK84rZI985W77sTwyJeH1Fk7uSsyT7kHT21ZbWAo03S
 qYPlrl2lLIwiHExyIopsrQnLPr2KCrvrd+B0Pswc1iZQIYwcHEKwETE2RgZPta6G15OFc4+Krl/
 qo2Hu613n9Ab1zOzn/9T4N6zWqw3ieG/21u2H7PSeX41KJ7/xzR1rpWlcYXlqWmWxRe+nnrcqlP
 DBAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add documentation for Texas Instruments ADS1018 and ADS1118
analog-to-digital converters.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1118.yaml    | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml
new file mode 100644
index 000000000000..eb7228ed6ddb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1118.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1018/ADS1118 SPI analog to digital converter
+
+maintainers:
+  - Kurt Borja <kuurtb@gmail.com>
+
+description: |
+  The ADS1018/ADS1118 is a precision, low-power, 12-bit or 16-bit, noise-free,
+  analog-to-digital converter (ADC). It integrates a programmable gain amplifier
+  (PGA), voltage reference, oscillator and high-accuracy temperature sensor.
+
+  Datasheets:
+    - ADS1018: https://www.ti.com/lit/ds/symlink/ads1018.pdf
+    - ADS1118: https://www.ti.com/lit/ds/symlink/ads1118.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1018
+      - ti,ads1118
+
+  reg:
+    maxitems: 1
+
+  interrupts:
+    description: DOUT/DRDY (Data Out/Data Ready) line.
+    maxitems: 1
+
+  drdy-gpios:
+    description:
+      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
+      distinguishing between latched and real DRDY IRQs.
+    maxitems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#io-channel-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - drdy-gpios
+  - '#address-cells'
+  - '#size-cells'
+
+patternProperties:
+  "^channel@[0-7]$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Properties for a single ADC channel.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+        description: The channel index (0-7).
+
+      ti,gain:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 5
+        description:
+          Programmable gain amplifier configuration, as described in the PGA
+          Config Register Field description. If not present, the default is
+          used.
+
+      ti,datarate:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 7
+        description:
+          Data rate configuration, as described in the DR Config Register Field
+          description. If not present, the default is used.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+    properties:
+      compatible:
+        contains:
+          const: ti,ads1018
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            ti,datarate:
+              maximum: 6
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ads1118@0 {
+            compatible = "ti,ads1118";
+            reg = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+
+            interrupts-extended = <&gpio 14 IRQ_TYPE_EDGE_FALLING>;
+            drdy-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
+
+            channel@4 {
+                reg = <4>;
+                ti,gain = <0>;
+                ti,datarate = <7>;
+            };
+        };
+    };

-- 
2.52.0



Return-Path: <linux-iio+bounces-26767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A711FCA4E14
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39E33112493
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5136B06A;
	Thu,  4 Dec 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miP+N1fJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCA36B058
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871302; cv=none; b=UojapTVVIAmM4MamTtkAIRzP0W403qQJCRdKqy8oKDXJko66ZdTXhtFc8bapTDzio0rY7It91zsILbyz8UigPiw1LOLjnq24MT+rgbK8/u9sCwCXExReasi569TCdogssimQYkHo4iizFpWtdLI4vz1DlfWX8bTDh07LRXRg+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871302; c=relaxed/simple;
	bh=VsKMfePN7JjgmEwgQW457cXjo1Jn7sfHu3mU8ne1Azc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVsufIleowMfonTlXZtLBAAI2gRVJNZZsxt4WZ3x8chk50Us8gudo0hLKeHEvBNxDfKN8A023b6r/7hzTqmFcNyxUD0Ff2ygQd+/VTtvnB/Y8Mj2YumS5haR/9exx/bvhIyQOcMZFHqirxoiY7zZWWD7jnZaFoRLONSOntJ+wbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miP+N1fJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78c04f279c2so11321957b3.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871298; x=1765476098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuTJZHMKnIcIArrJzXvUtr+o32DOHjdpg8jFv9iZGuU=;
        b=miP+N1fJXwUkeWVAM4NCMqCTXvwwyXZZr9B7xcX74GcWVp7tYkOPogbKbUzBaaQli+
         CC8EPwhBpYuFaz5RVDoWndC4jrEWxEYBcth5fJofV0WVuSHppSdOjTgJVI0B/RcxqIbQ
         bN+wKC6txdMrDsV7qTZgkpSZ9QNvCdyfSEgDlgLWJzsOrTZhOrO0KiIMsecXIUxEpN4L
         0HQevOT4BCKV4L2IjXVWG43LdHNel/gvQPXOQ8K6i/Xea5gmwi9nCvUCkkCUguqWroZF
         aXTr7ev4Nqf8sq0+s/lz6UxzXmyaclMyLOm37+l+0bm0RG3JOIrkFaXMR+99y1zpSZKq
         yoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871298; x=1765476098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuTJZHMKnIcIArrJzXvUtr+o32DOHjdpg8jFv9iZGuU=;
        b=N85vTZaJFL2NI5TNo2kWM0Mm2hhOzjvsKmfaABuSio6xiXos0lhtOEXs8Zyb7fhDvl
         ISF9shXnuH0+RxVL9n8XHeMI6CZ4GCVYws51uJxmTkF54KwY/+jrtaqwxL9OeDvA9NUW
         Vf70CBS37VeE/fhuv03nVkt8lUv6ZFQEPb4A4DHi4NpkrWAa6GpnRd1sIfdZ53++znU/
         WEkSmgpw7oOuvT9zgASwIKSiUgufXQsG1XG5rRPOompOIHwBWxk2FxE9e0mEN83HI47U
         xcdcXzWXvWivat/23owFaQ1qUGXucbR2LUTCiPam/CqmKgeowy1R2usP5dqma8q0muvz
         AeIw==
X-Forwarded-Encrypted: i=1; AJvYcCUb7TIK+XTBAP6+Dh3xzvKHsYX71T/RuUlK17I22tSXKnKNyphwnNcYUSfP94bsMLGsZUlYyDYNCDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5YGBDKH9Y2De95anBZKr/tWAACA23O5SJqR0r+jR8D6vJQL/
	OG12gbHg4MghtbwiThOp3RMt8Je4fPaajY72pycYCyqEz1umsfStXTDl
X-Gm-Gg: ASbGncvSBaNcAS9QslmzmIp5UfZH+R/Eb/51tKvrTnfFRuDVyZFL6Xj5NbxA6PTHn9R
	zs0lNew9jTecopaease0dBm3H7u2MBuctOadb+rE4ssigaslN8WlEI4td8NMdj7fW6pApbohRWG
	RUCFuIfB9LDJD/CaolyPou2vIxtj5dw605uDMbCswEpAi0c01Ae+Vkz3jMzo/EDf06wei1CjRvI
	4tXL/GX1imDCnlIOxRlTafBb+pQUDViM7BLCdAOA1j1xtt0RQRMCck0UO1YDCxSGSuwlyYc6kOJ
	h2sMdLSQmI2oG/qX7AcaSFj/MbJ/JUroB8E+4xXBmeH/9SXuNDdWJmFtwBNWcVeXclwuUqoLETb
	1lRs8WzJqOIUV8gkxC8Ho9luZB1Xtkc9zdvW6PmP04ncEGjWjUgaWnTEV/yAU2l0ZoZH2i0Uy9G
	CKAHI08g9/kfrOTyA=
X-Google-Smtp-Source: AGHT+IFm5FVFFlpljB9a8R7V6ivQDxehmMjZAXg0OhksFr5SQgc3PgRzZ9s4Sbc184thuM27au1C0A==
X-Received: by 2002:a05:690c:3501:b0:787:e015:8561 with SMTP id 00721157ae682-78c188321demr31079687b3.20.1764871297449;
        Thu, 04 Dec 2025 10:01:37 -0800 (PST)
Received: from [192.168.100.61] ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e63bsm7704417b3.42.2025.12.04.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:01:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 04 Dec 2025 13:01:27 -0500
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-ads1x18-v6-1-2ae4a2f8e90c@gmail.com>
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
In-Reply-To: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=VsKMfePN7JjgmEwgQW457cXjo1Jn7sfHu3mU8ne1Azc=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJmGZ2oF5ief/dlvX+QRUhnUWJE0r+IA23urussyYjzmL
 L8c99R0lLIwiHExyIopsrQnLPr2KCrvrd+B0Pswc1iZQIYwcHEKwES2+zP8050/w3HWxIPzprzU
 eKUnzyR+4LJAW0gkZ7Prkalp9/dJ+TH8M7GxWJOmsHb/3Wk3D/oEie6sZv+ozKj1s3R97EbmNwv
 ZmQA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add documentation for Texas Instruments ADS1018 and ADS1118
analog-to-digital converters.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..93c9b2921a54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
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
+    maxItems: 1
+
+  vdd-supply: true
+
+  spi-max-frequency:
+    maximum: 4000000
+
+  spi-cpha: true
+
+  interrupts:
+    description: DOUT/DRDY (Data Out/Data Ready) line.
+    maxItems: 1
+
+  drdy-gpios:
+    description:
+      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
+      distinguishing between interrupts triggered by the data-ready signal and
+      interrupts triggered by an SPI transfer.
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1118";
+            reg = <0>;
+
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+
+            vdd-supply = <&vdd_3v3_reg>;
+
+            interrupts-extended = <&gpio 14 IRQ_TYPE_EDGE_FALLING>;
+            drdy-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 31d98efb1ad1..3d5295b5d6eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25646,6 +25646,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS1018 ADC DRIVER
+M:	Kurt Borja <kuurtb@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org

-- 
2.52.0



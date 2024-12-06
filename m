Return-Path: <linux-iio+bounces-13171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C89E776A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCF91888B38
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBA1FD7BF;
	Fri,  6 Dec 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AbuY3Rwd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472A2206BE
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506160; cv=none; b=DEFrcnggueVtvCimrghidX1WvlTOH6bsoiq/24AHIAdfqx7KcYl/y6WBffvcnuLsi13G/JpXvUMR9me69ipKFgplmBuUlBvP+W44az+5NpnfMCANXbk1ssHF2w0M0m78/dP9XxRtPLo/yXfWPq1dp1UrGza2e4PvloDiGozIMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506160; c=relaxed/simple;
	bh=OZ8D5DIA9c2z/ZNslS4oghsCp+4099Z8MVhbXa2hSOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6u8jNl5V+QQhmbvtnDD/+OYV1+OihItDx+GxDbCWRxQYDJqlafJ57l90NeOttb4BDJeJ0XOKN8k3C0Fo2teq7G2czD/cj/2nu7OGJtfu8dJvsn0pW8LKPwlINy7gzmbxaFYVuA8F9tRZOwSzUoq9sbKJdrsq4RDJSCc6jshTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AbuY3Rwd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de7321675so2989869e87.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506157; x=1734110957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+GEESuu+0dEHj+dcMwhu+qI8/+NJXPVoXvCKL+dhpA=;
        b=AbuY3RwdVOvk10UO976qTqgOARrYydiMdB4fiu0Hl1Zc6Dz6fAOjB6FC5A4Ebk3mQ5
         BiJaALkEWRrHV+9ByIZWOqlV4i56TMX/2fnGWrwU13TaHyRk0kQ9t+LC//Q0qudcNZwZ
         V3xtwcEbWNZ1eh1vwAbHBgCdYphT5OSRWBlYQT32lnw4xzC4DNmT2yIefMMq8vhjr8hk
         U2UsqRTCtf68ht21/iB79fqy7Wdm1iw+OZ3/8WQDGImGE5IANJVGbsz2OKqbNGZf7FdZ
         8BxsKhKbT+xmggVDpWhKqAI96t3VIYAPOBv2UP2yOheoWebx+3lUNun8wPh4fRiaddrr
         4WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506157; x=1734110957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+GEESuu+0dEHj+dcMwhu+qI8/+NJXPVoXvCKL+dhpA=;
        b=bHVQYtz3TRggFDItpTJ5eGToJMsBsOY3aVpBu1FdEZMJBY2Dk+UYeIN34aJYcausQR
         G+Jws9A0+9bOQVNEW12vIHrS/qn7Sdm2lEgBEYrXhjqdsmlBBjrQ7FnpAG3l29pljIS6
         +Sp5q5YCAoSHNRey7YvnjGJuw98sDhPoLYv9e7mzo2wcRRspb3aaDzIqWVaswseaEUAr
         tDa3KknwsqAEND2L3Live9TpMhjYpDTPh4gVjlEqnJpcNB/eVvfeSCKPGDwuWoErheMq
         3qMKQHfVDxAXm7K5iAnEOh3FQADP5lPYqPp5mh35n3ZUL/8cuvLrfIUv+fHLR27894Ss
         ETvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgu3+jClh7P6ud4T2qzIdRKSD+9innWu2KLb+l5xQdJYXr8FesSYlnMNSoikNb7VnqxSpHGJ3HA0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaFHBi2P577ow6oV0g6A1BSuP6FSypt/ib6Ij4/QL5ZnHXfms
	UTugjCTOhzxyLH5pEanMgLHY4Zrx5NOBjd41nIEVUcoOGqiCMhopaf1FxZaYW54=
X-Gm-Gg: ASbGncvRW9Mkz9xi7YcLs9d3Dg90nfykcPEJBiByv7E91uYmfhMes8KGnSe9nwDGugu
	gJAPvBLfMIjDAlwzCydx+g+eJs9RjOif3A3mYVg6GWMRIlHPVQl7XLSuPyla/qQklsmjdJc6U/2
	SldXQOfwo3KvLdSnMQlkaiXAi0BCq2AhSFH5QrqvczAf4cfH8VKSJmFMCtrHOLjApovEA+IEjrt
	xnk4IRwz/jM4/eEss+CMnSPCjfdeMbZZ4QiV5Xy4zl7/kSE1ajVBILSlnwxaBmTotl0qA25vvuW
	A1iU
X-Google-Smtp-Source: AGHT+IHoZ8rq3s6gUck8FQ/o0j4DgCtCQS7LWMHoxwIQnyL8SV29KxsHPw/mZXmwRlpTXXAxsGpUcw==
X-Received: by 2002:a05:6512:402a:b0:53e:39c2:f026 with SMTP id 2adb3069b0e04-53e39c2f11cmr571347e87.14.1733506156804;
        Fri, 06 Dec 2024 09:29:16 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6a07sm61383595e9.13.2024.12.06.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:15 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 03/10] dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications of a gpio for irq line
Date: Fri,  6 Dec 2024 18:28:35 +0100
Message-ID:  <7fc92a8539e55802d514332e70ee836a3ed08b66.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7014; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=OZ8D5DIA9c2z/ZNslS4oghsCp+4099Z8MVhbXa2hSOo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRgEy9HhQPy7z/3H4jRdG3lKcjY3ejzxuBu1/PL26M8C 3PEdk/pZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAih15yMMwUUuZL/vQ1+fp7 6fOiARn7zyzPfF9Us5hfXyZErbK1/wiXWPy3aau4lYSnJT05Hr7mB8vVA/8Com9zNO2PCKkVnGv qKvR+tfj9XG+JeW/Fxd1dP06zYwlqtJhpsNJLf+8q4ZXPJsroTm31/bv8UdfedMv0gG+RR+dnT9 tuKbv3uZXsq0MOkzVvCS39x86yb1aUhpCsmbYJq+Cq1Y9CS7JYJ/s1N8cyNZTmrSvstwx/Khjg4 Gd9z6zc5FAV+4zIauNlugmiXSVzZzEyPoxOOPB+SrXn51UzVS9Uy0jpbMhu2P+veJ+EbfuVEssE puiTk2eauOfFXDozX+CqX6G/Vr/rhz+/CvOZGqcm3zADAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For the AD7124 chip and some of its cousins the logical irq line (R̅D̅Y̅)
is physically on the same pin as the spi MISO output (DOUT) and so
reading a register might trigger an interrupt. For correct operation
it's critical that the actual state of the pin can be read to judge if
an interrupt event is a real one or just a spurious one triggered by
toggling the line in its MISO mode.

Allow specification of an "rdy-gpios" property that references a GPIO
that can be used for that purpose. While this is typically the same GPIO
also used (implicitly) as interrupt source, it is still supposed that
the interrupt is specified as before and usual.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml   | 13 +++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml   | 12 ++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml   | 15 +++++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml   | 11 +++++++++++
 4 files changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 35ed04350e28..7146a654ae38 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -37,6 +37,17 @@ properties:
     description: IRQ line for the ADC
     maxItems: 1
 
+  rdy-gpios:
+    description:
+      GPIO reading the R̅D̅Y̅ line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/R̅D̅Y̅ toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -111,6 +122,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -121,6 +133,7 @@ examples:
         spi-max-frequency = <5000000>;
         interrupts = <25 2>;
         interrupt-parent = <&gpio>;
+        rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
         clocks = <&ad7124_mclk>;
         clock-names = "mclk";
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index ad15cf9bc2ff..21ee319d4675 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -135,6 +135,17 @@ properties:
   '#clock-cells':
     const: 0
 
+  rdy-gpios:
+    description:
+      GPIO reading the R̅D̅Y̅ line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/R̅D̅Y̅ toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
 patternProperties:
   "^channel@[0-9a-f]$":
     type: object
@@ -443,6 +454,7 @@ examples:
         interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
         interrupt-names = "rdy";
         interrupt-parent = <&gpio>;
+        rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         spi-max-frequency = <5000000>;
         gpio-controller;
         #gpio-cells = <2>;
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 66dd1c549bd3..0bd2c6906c83 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -106,6 +106,17 @@ properties:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
+  rdy-gpios:
+    description:
+      GPIO reading the R̅D̅Y̅ line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/R̅D̅Y̅ toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
 patternProperties:
   "^channel@[0-9a-f]+$":
     type: object
@@ -181,6 +192,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -195,6 +207,7 @@ examples:
             clock-names = "mclk";
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
             aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
@@ -207,6 +220,7 @@ examples:
         };
     };
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -224,6 +238,7 @@ examples:
             #clock-cells = <0>;
             interrupts = <25 0x2>;
             interrupt-parent = <&gpio>;
+            rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
             aincom-supply = <&aincom>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
index be2616ff9af6..5c8df45bfab0 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
@@ -63,6 +63,17 @@ properties:
       marked GPIO_ACTIVE_LOW.
     maxItems: 1
 
+  rdy-gpios:
+    description:
+      GPIO reading the R̅D̅Y̅ line. Having such a GPIO is technically optional but
+      highly recommended because DOUT/R̅D̅Y̅ toggles during SPI transfers (in its
+      DOUT aka MISO role) and so usually triggers a spurious interrupt. The
+      distinction between such a spurious event and a real one can only be done
+      by reading such a GPIO. (There is a register telling the same
+      information, but accessing that one needs a SPI transfer which then
+      triggers another interrupt event.)
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.45.2



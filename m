Return-Path: <linux-iio+bounces-20804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4594AE25AD
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 00:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275554C08E8
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAAC2522A4;
	Fri, 20 Jun 2025 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fhN5byA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5224EABD
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458096; cv=none; b=sfQL7KM5/YIN4ntgF/twuSZ2bIlTnBPUvYdLJYeHlyXfyaO/p8UtrDe/GQACUvainCuCQz/4dZAsUr2jtsYdMbjBZUFxHxyqL3SWmQ6B0h8xYYhNfVBvKknnNW7etArlyAVCFeyu2Yb5pjHKD5GxT1SU5SNavxGygMSEFfuolAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458096; c=relaxed/simple;
	bh=MgpLRHOcZVJ/2tnDLCDfnuJFhe8jp/MxItvFSS0S1SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/FbgCNMqdB2I3z/47/xxkJYAKEeVmqeAhGybbtgd0tEMBnM9OtWSrI+QSECsAK6Fne1qjiAQH4QTxqbMmpG+7u1kSVf38GXUXQDhEw3WSAkRsxf+oZe8OyteQJ/GHOr9bXNE2Nyt74pUzmhkJvBVAV5or24gxKpJZvEzY7HaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fhN5byA0; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2e9a38d2a3aso1722330fac.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458093; x=1751062893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43WTYGtum1Th6RvZIB3bhmeCSu/8SL+mkbZemZWRqVA=;
        b=fhN5byA0C28AjQL3fh8RnnRMWN0zRs5QnfSVkRea38FpzHelfwB6jsXpo6cWpDQBBh
         4eGQQeRJb1HdpqhiXSm0o2cjyI76cTSsPT8WzRWJUSE+DaGmUlijPCcML7ehDoFrcFah
         LhnhWi82DzgF35R7IzCOeL/Z0BsszHSovMc00uxm10sMY0jVKhlWEAFgf8xmFzXqkmb6
         S7Eo2w6Q7+DGHb88JcKEhIy38TjdqSg3io50NQEZ29u5C6Xp+7CUVCHJPTJIL/JcKNVT
         19OTWmXqjqfoIisDV1kpAIEIIbyzxkAb0IpilRmt2tvBBynE7Lbya85YtfVkagSGrrw4
         8OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458093; x=1751062893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43WTYGtum1Th6RvZIB3bhmeCSu/8SL+mkbZemZWRqVA=;
        b=G42Zx0OV7WDz9vfLYId/QoQH5zSVe9GYdzj52zSEf7E9fmwo3MH/kZ76rW9wh+D7Co
         AulZphZNCqwytQGucod5esSCAnGBC/5ioV/MMWaVLDa9hxdaHMsUdDKUCZ+RdO0txH8x
         wpAZ+GkoPMy5umuXqDoMvrnF93//PmVPDljGbVPjyZNDNdiJQplrGmjHc2rP0dAmV81l
         PN6tShco5UBB8S8ID1kS1pXACvGA9CGLDHJWf16kwuzinGRhVrplzqvta+lv78U42zYm
         s81GdgpPzbBQTZLaVMu9An3BO+Tyhh3C3ABG+dJxZ0werJ5j7ZhKE2SynytVut8nr0v4
         rpYg==
X-Gm-Message-State: AOJu0YwIb7nxvDpTBlkwJVvEz3pZ6+M/kFefr/LkDxZzKKXX+06PTeZZ
	PubQSTv03SBV1kgbEv6KOOFF7isKOr1IgdoZqg+UD4A+m8j1gwkCPrS7QhR3B5NZHb4=
X-Gm-Gg: ASbGncv11wr9SmikvOQSBFofnkmzMncCP2vgfFIg3PEuIbvyqKrYIRu8FvIXv/KAxHf
	o7VyR8MXVHyIF+MWxFU0PVnHHmqGfj+UwLwvRtlMgpxCcyTi48upENgEalEg5zm1qZcmzawVGvb
	w4+xSYQffrGXs6Rv9Ix7BrygV06MVwXQ+OyUXreDDkoRzoXDZ/KvJsaOAESDQGDV2APQ40fdity
	fIfoCKlU1yA5PRBn2xtu1Gu+Fn2fl0QpB4qdCVF+se2H1waSYJ2hAh/1MkO26LgSt3w0l8gD8Sn
	sR50cpdarhOxvO0wn4rnLI2LEXQB9w3uhA5Xj/g8PAHlwLq7o20+fPIx2qQw5rKUYf/M
X-Google-Smtp-Source: AGHT+IEc2nVeyrSHlCquh9VuIExCHCGOiKwU4IsdwWSmCTWnlAcehYcksdKGdeerVAcrqyPXaPtWNg==
X-Received: by 2002:a05:6870:ff44:b0:2d5:4d2d:9525 with SMTP id 586e51a60fabf-2eeda55d669mr3193399fac.8.1750458093305;
        Fri, 20 Jun 2025 15:21:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:12 -0500
Subject: [PATCH 6/9] dt-bindings: trigger-source: add ADI Util Sigma-Delta
 SPI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-6-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MgpLRHOcZVJ/2tnDLCDfnuJFhe8jp/MxItvFSS0S1SM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd7DTso31Vwy+hQKXbz8lwu3sIYtN0jGDYgXh
 nrUKMbeR1+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXewwAKCRDCzCAB/wGP
 wP/VB/oDkOimP/alMgbmtPW6ZnvK1uwphrV/dFIVNUKNmM8LVl1+faMeJCcoNsaKXjws+C44L3A
 ynCz7tneQRgUhWlepFBndQis7h4urp5LNu+ppbuFWvI68VvQPeJkQhvFccrXyCkmOvVFJn0eu5W
 PAisSuvuGMaa2yDmldjiKoUuWWFMJ2Nvt7By5Hc7QfqOTnSBWef54lpiBnj6jeStWYCgQi14RtH
 B4KykktHNdrdl5EpXoNF2dLDcF2ogySUoFyeeQL4TarZbLw/5dF9/SIXGViHiNcfBWT9W/cEbw8
 Y0XUYnSHyhFrjqZ1V0k5YLCyhWkgGNWr9F1QfGWq/3+9UZwe
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new binding for the ADI Util Sigma-Delta SPI FPGA IP Core.

This is used to trigger a SPI offload based on a RDY signal from the
ADC while masking out other signals on the same line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../trigger-source/adi,util-sigma-delta-spi.yaml   | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml b/Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ea466179551cb0d8f8e1cf01f91101b88734da88
--- /dev/null
+++ b/Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2025 Analog Devices, Inc.
+# Copyright (c) 2025 BayLibre, SAS
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/trigger-source/adi,util-sigma-delta-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Util Sigma-Delta SPI IP Core
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+description:
+  The Util Sigma-Delta SPI is an FPGA IP core from Analog Devices that provides
+  a SPI offload trigger from the RDY signal of the combined DOUT/RDY pin of
+  the sigma-delta family of ADCs.
+  https://analogdevicesinc.github.io/hdl/library/util_sigma_delta_spi/index.html
+
+properties:
+  compatible:
+    const: adi,util-sigma-delta-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#trigger-source-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#trigger-source-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    trigger@40000 {
+        reg = <0x40000 0x1000>;
+        compatible = "adi,util-sigma-delta-spi";
+        clocks = <&clk 0>;
+        #trigger-source-cells = <0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ea082c6be8acd5081d95bbada99ae47793f206e5..60ba572be7f5b48c0ab1d0d9724e19e335e8761b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25176,6 +25176,11 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
+M:	David Lechner <dlechner@baylibre.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
+
 TRIGGER SOURCE - PWM
 M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained

-- 
2.43.0



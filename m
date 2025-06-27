Return-Path: <linux-iio+bounces-21023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F7AEC339
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB0D7A891D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF22BEFF6;
	Fri, 27 Jun 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2rxmRunW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C322D97B5
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067697; cv=none; b=BzzmS6doR3tABeCs5msnjMuTKSWeoqZispt8KiKv0AGQT7gx1+SgOKY+BK1ybf/xhYIFjfJniNF1YSUZB8/G56B1m8f4FDXvVDZ+AUvR2cVGHaFG3wkqz7QO6EQwz2LmwlNp//ng5wCHt/YuSLKU56zFp6HIGe8agLtFggxIXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067697; c=relaxed/simple;
	bh=J8Mp/XPieqvBImE5UKsEDCopSlfxADmRzvJ27VGC3to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elWSX03Rbn+8yrm/3fd/v7FykmxAXmSpGTjllwZWTQhonquBfQZ8xYeFeYsrKVfmeWBpVS0O7mi767tlGHi1JvckHjlx3F0FHD1GTtYYb+QBBZa3Qy3r1CNVyritGYkPuD1awrnQzxl6KlECYvlGC7Cc8aHEHzZD8VZ4iFFX7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2rxmRunW; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4079f80ff0fso2181547b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067694; x=1751672494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA48/5Xq3MiyH1lT5lzBGW2kqD0bctYSg21SbvtHeng=;
        b=2rxmRunWNGG3kfZdvCddRhpI3TpYvA3Zm7S9YwgZNjMsyLFIAZFS41EzLhjSS1urO4
         6Ks8rE2/yhfeFjKzzVHafN+f47bvnu+sJXn3NmS097qj5F6WvnL93uQajduawW7h0caV
         m3h6Vz6ImZ2hGmAheSjyMgw6obPaUjFNdpIM5dH2t18HOcsC1B5icyQuhkF3QR9fGZD6
         34LaZnKeQqbw3d0oRLD4YLeE37L0By9Z2/ADJOZmVu9oK0S/v7gfwG9wQWDfQ7yBi37M
         L2To7dU9qOGXHTGcwlvC8kfAmL11JSeTNIFYUrFJH2nFBQRXHud8wPIMdj19k25Zj16W
         ls7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067694; x=1751672494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA48/5Xq3MiyH1lT5lzBGW2kqD0bctYSg21SbvtHeng=;
        b=TrJMK96uJUYR3g6vqOyXSGajSLiSpcmEiJC7O41rLYjU59Rzm80IaPekhNRiVMK/0a
         e4CVCKqsgvflX6Hf207MGtg1JhXZU539YgPnKcRgpMjBo4mpQQl0hQ+Iy3g/DnqfPrTP
         z/E6TrXRtgLlHflzFMlHmLJvEUsF7vkips3UbtDlNB2jdI/U1YGfH9Bri8unNFdmfOfC
         CEEiNkVsjE9PwcOdC2/FijNrclRmSN4E3nAd7dWcbQTcdK2lJ5PFwGul6Z97eSRpzRp8
         RAU/6qWNnTLYwQwd2adlIgOoBgC0j0Y0cc7KyG5vJufrsrPMi3JIHfMU91Hb1roZSCHl
         oGMg==
X-Gm-Message-State: AOJu0YxMoZgNDc5HyH/YzOi+dzTxSJICzxksbvzw3Tdij+nFWnOtceJY
	aHxC1QUTcLbSnOq84P5/Z9YoD8y7s7KPXPzGIYKlR4yDEo3k2uPoA8YsttjEJ7mvDhc=
X-Gm-Gg: ASbGncv7ma4DGZvjW1i2KL4RYLobwZA7s0hNOJnd6mM/CgQltXoMQSy9jylfopMjrNP
	OxTK7fAGndZ67SQWhKpw71MpheVP+8wN+wHEKu8DWA/RKMO8S6ABFRDFhUWI/VFPPKKTrpzkfgU
	4wE3/tT+K7FBSuvCwztDbw8sqlRgYXnOSc35M/nm4itakox+TZg7J4s7lOT/mIn7OS9j1I+JydH
	OFCpRzR5DhbgNN6ftjaBWIbEOxvKFb+suaBaljlJSAmUYhObfcebDUrWDRYIX+VrquNXYdvG0vU
	+F42opO6nuVO89KnzVkn/75+aUWCCoWTSKFopwcTuFGFw3GFtgWccFUZdsLQHW3R4kk=
X-Google-Smtp-Source: AGHT+IHQEzLe1lfVwPkBflr70t7J1cOLVABPtWTzTb+CD1tZaGQ8r4sg4FM7MEjvnmQx8acA7dGhGg==
X-Received: by 2002:a05:6808:168c:b0:3f6:7677:5bef with SMTP id 5614622812f47-40b1c87aa1fmr7778548b6e.2.1751067693828;
        Fri, 27 Jun 2025 16:41:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:40:04 -0500
Subject: [PATCH v2 08/11] dt-bindings: trigger-source: add ADI Util
 Sigma-Delta SPI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-8-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=J8Mp/XPieqvBImE5UKsEDCopSlfxADmRzvJ27VGC3to=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXywH3Ih7yPZHUTX398WD9WVW4G/xwb27Eyohl
 kT4QqUHGHeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8sBwAKCRDCzCAB/wGP
 wHh4B/9ZlH/OBXHD6pF5dyewJNVojYstNad1fd756qMSKXcUqH2mjv6A0b2EbJCMzERN3ZQNVJg
 80DS1ThI0sxB1W0xfI9l0jm+Cs9nnykjHnPn+OXsg1akhPMeU3S7T/yOLPpaS0/YbePfphhirfD
 +0Ayna1XiR8i3kmvb+XhqecS2ce11Hc7rkzfX8DTVObtka7mP5DpRPNFXMyubz9BIIauh0TjO8o
 ynIfmJtPKwZOPvPzII483v2rHZhVGLV2st2aw3OFSdQG02DBld2JVZoDP2jtGeYmAn/bnFAqG2e
 dly7m4J7VGV4bQbNRYqpDgcalU/8gWuf2av5WGiOk/JDrp10
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new binding for the ADI Util Sigma-Delta SPI FPGA IP Core.

This is used to trigger a SPI offload based on a RDY signal from the
ADC while masking out other signals on the same line.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



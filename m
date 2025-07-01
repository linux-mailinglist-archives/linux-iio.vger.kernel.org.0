Return-Path: <linux-iio+bounces-21213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826FBAF05CD
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5044E29D0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F583093BA;
	Tue,  1 Jul 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RgDDy1pE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFB307AD4
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405982; cv=none; b=E6bSisOa1u/ZJvWYSVRWaCRxktXi0H5p9mF2A27whTGQUs07ks+X9G3/VGP3eredfD4tB0qdKqEDzMXR8sDOYQsMkdU578pYWhGNftpGQPuGNrEQZNwuVE716ukeD+Fw+I2lD0kgs5yl0U18okLhpAEqysge9HalLBuLzQPTdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405982; c=relaxed/simple;
	bh=J8Mp/XPieqvBImE5UKsEDCopSlfxADmRzvJ27VGC3to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZxTm7H4fiCO/bexf1KlRxxtN9+ee8ckyxJuTfuT9+vpQOvY+a+j8Ayywu/50mXbj+rdQhwZ7s+Z2ehNEagPhgqx1X5liraVQF4OKSqtJ6mXX7wSgilytQ2OyyEA1H/X0jup+VK79g2hdNKkdp+0jFcbx5M/wqw2S4DytXDaq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RgDDy1pE; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-404e580bf09so898651b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405980; x=1752010780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA48/5Xq3MiyH1lT5lzBGW2kqD0bctYSg21SbvtHeng=;
        b=RgDDy1pEA0/sNq5ETJ+u+fYABgwppk69wcTsTlvEOhHUluMXtY8paxy9oiAygi/n2R
         P4IOmzCX54u7MXtw9MT6UErxdoN+vzwatGy96xKC4fMrDe349Rg2dokr5NqcEP4zVIPj
         5DzQUSC9Stmjz4/pyAMObja1VGfKzEaVGNjPwkvghBDeozCRI2lpJf+yMzrVbYoY9fX9
         yW1x3DHaxpHKghbNEJQRZ9HtPLCWgTOUkQSPBYCQW3pBeg2N6qhzXlweKA/mLrHCz2Ij
         xXVKugiULLRWWP/fD9HZ96biTwgdf7jMPV8b554VTUnXXmQ6KcRrMKIuJ0FeM7hSVENu
         lU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405980; x=1752010780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA48/5Xq3MiyH1lT5lzBGW2kqD0bctYSg21SbvtHeng=;
        b=RnUUoQesQ1GOvNOASiwhAqWMRlHNBt0lFoxh9zZ16gXQT0N252rqeZ5cRomnGSjNKS
         CEfxTP7Gg3Trst08Xw4y7hg3yBB6JDKMrY1diYb3R6rb6h2yjRQE6MI6thRBHanTgUD3
         SqQV3isS2LMCmhWyOhUdpVVLyhiVnOleUaUvx1gKPVgHYC7YQvtJyBpsZmx3rfwon8c+
         C0+xbH/Spe79QlM8gA1iFPwSoI3a4Oo3XN25TiHj+4QsZXPf0NYQQqe4rkESNDJoF0Mc
         nbLKAHUiYZ7/A3ucmhoO2npRmG0+BbgFGBfMnx8QgnYIxzNTPKp4l3OSug/mqleQ1bCi
         J/9g==
X-Gm-Message-State: AOJu0YxhJi1vnYcc4ubst0FyUCt4uz7CXKHcUWREKFwmVfUHMaeBmoUc
	JVcc8PReOgMh3d4Ll+q+Wf1CKmizkkcHW8DGpOG/v1slYPFfPw3mye7vLnMxdbgNXfs=
X-Gm-Gg: ASbGncsHse3h8VYprI+rOfrMtV+mlTiEBKOAdtZH6fMUfaF5sdDN8DxBngvxTabJuNe
	DbSISALKuPh04jdXeUibQX+acW4yjbyRZ3NX8rgJShGeAm4SJUzys0n6RwZkzF/T0pSnFrnLk0X
	2OaO7W5JvYfPHrsaLN1MCAVRpvL7ny7VFjQK2gQR7YvrNhpYzaNQHrJEFboBGLl+WxEPB9YRfkg
	vqjmfNKxBcDFTs2XpsKwOdYKcxlHhOldUKy8Hn5AwlxwolsgvAq+Aa6P5EpfMvXTAPusucizG5G
	usaBqhoRpcO6KsIdRhCJ7zDX6ZLkBrqbtE0xat4YHc/svW2LDTscs05cKvf/LLULbxZB
X-Google-Smtp-Source: AGHT+IG0GdL5pmOi1RDALjt7tJvWKe7lV2Iel7oaQwpb/7DIn4IUOJRxmVkuDvZ98ZgmpO7wyZ5AbQ==
X-Received: by 2002:a05:6808:201e:b0:40b:4208:8602 with SMTP id 5614622812f47-40b8853f92bmr279298b6e.4.1751405979908;
        Tue, 01 Jul 2025 14:39:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:57 -0500
Subject: [PATCH v3 09/12] dt-bindings: trigger-source: add ADI Util
 Sigma-Delta SPI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-9-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
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
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFV2RAg9UrWh2byim6y6XgK83pSq+w/TiGjkQ
 V/GFAyMNmGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVdgAKCRDCzCAB/wGP
 wKCOB/9rEGilC2YevdybZ7IkreRYSNSwY+d1Z8BVD8GqtCz1NIQ5ptA04PMD5FN74ka2cAWiNXl
 YZM1UTFi/JjaOAOxXaUtOQtuj0yv0Ukzcj0pWmfJBUbmPwZvwoiMi5g3r3Wif9QTtZi371jLzFJ
 UgnUluQ1myrVGl8uxd9FFIh0EG5cytSoAyr3S2MI9B5T5Cd/3GMu5tosDRn6vL9NjYzZchYqgVL
 PScjjENLODQKiwDvz3RFc6bZ0bokJI/OYdIvzDLr2JeeboXbvCWeb0T/+5BqEY+ZhVAimfjU12+
 y+PYY7O8zNaCfkOm9hMHZ0kwLlTdEsbimaRuq9rCT4RACRat
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



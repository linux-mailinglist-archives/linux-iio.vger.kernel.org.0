Return-Path: <linux-iio+bounces-18552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E58A97CCE
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE891B612A9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B484256C6C;
	Wed, 23 Apr 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3ux//mR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD318BC2F;
	Wed, 23 Apr 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375408; cv=none; b=oiCl6KoLLLogm2q0l9K5csn/31QkJcYBggku1dbcJPdLX9RMjiwIBgF4a8zq1bhHpIS+wpo4GPfxMU0qrHQIysohLdnCaGm1MnCw4iYdnDfK95KmVJDeaBHmkPITZxxW5f7RbnDxJRFX/2a0uv8/GbLzE9NvwAbeGR/GSo7s47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375408; c=relaxed/simple;
	bh=XDxkUr+ssHQNn3jIF48lOngZODLhyYp3DPRvtwKKpcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukbTYL/eFvwMlXGVua9lJ9zJ9+Aucmb6ylNIHvw8XbiJkToxUy8ulBcSN4C6ZuGGttSI2oiwj0Igq50Kw2Me/9cRu1kMVyiLCI4vADW2pfAEUcHU02QX49HusVQOA74S56oxAszvKKYGy4P0l1rsr5m17E5ta7pEn9k7H8XcJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3ux//mR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so453807b3a.0;
        Tue, 22 Apr 2025 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745375406; x=1745980206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnGRwos1kNXoXjIQZlQQXvyLKcIMntw2floMjKdISNI=;
        b=j3ux//mRtjT+pkEL8mp9Ll8f2dsPpw9bdINvqEBwNOQWMRSWH88RFKJOx9mz6aabXE
         BaIkwFH5dZz3nFnPQV3lyCB8mtdSUo5OzJ1hkk2adOw4KDXa6agwKr+RY0ZZcQHlpi6Q
         /MaHzQw1hcM6iC/lPbeRpVCowuAuNeS4iQaY7LdgGKnsQRHGKnqGVLZx3Ql7oVB09l3r
         84DQVxbkf5PoqYybvdhhbzhy/rD/9bdrtuR4JS62aRtLhtfwtzCPnlW+nstYifW3tE5T
         7NHRygf098lNyZnsk9kQ5jzEVv/zvkfRmbTOcjk6h0KaOx3YXirFKOUsow6MU0zlqfmx
         /UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745375406; x=1745980206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnGRwos1kNXoXjIQZlQQXvyLKcIMntw2floMjKdISNI=;
        b=mOzeZR/ZjAnyhvstugeC8fbrK7W8e1C2pYckGOZHrdow4LwKnLgGh4b8FhQCfHYJGp
         GIWjT+KxrP2yjHodS7f0xCyMlveUXqyoYVJVSWirN/REJUtB3f+k2k90ZYANLZg9R6QW
         YEzZIUQlEl1qz9Xb/HehdvTra/p9u+15Q86EbPIxdaJFDKO0Eu7/g0ZgES1xSddo2u3Q
         ORQAl9Q5vj/ztIa0d7EIY0DfKjPO74MHUAXz1d5GdTT4TTxaAifDh2npU1IZD0U8KU2K
         23EdmHUcFHJsMjqJ2k2uxIBNmVE/r1jAcpF8oIRxb77Qd3p41rO8IkKWmM/qJ8XE+3EG
         4W8g==
X-Forwarded-Encrypted: i=1; AJvYcCVwVNXZ5zScU1m4P43vXJZvn930+luupQP8jGTwIEeaIrcaaJCzDjsPEAP4GEA63TVJmilsxnNJ+Uqa@vger.kernel.org, AJvYcCX2Q5PpdJVqMcbZdSgxdCiTiL7Fp7i7jFqITo5Ov6L6g6a8hDGJjUJIXUayzds64TwhWNd3BrzdQEhF@vger.kernel.org, AJvYcCXu1/SvJQ0U98b2DlXhkhwiFqLntpazytM3mGUcQ/1HCAsj8PlstXkjyZKo0FqWw0IEFV0VVnP7bxrpMw6C@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOklldG8gxtb+DLy+/TuTjLBFxl85jJp8URtaavYn/VEWzF6t
	LS3F7OJL0WNiNW/87p6jQs+DFAnvvh0ZyyrAnRa4/tyr4dX+nVRlC1GzjJc1
X-Gm-Gg: ASbGnctEW3jKxXc8Hm7A8jY3zfKMausFq21Ydzn1Sv3DhVIktP86J85ZOozJXNjxZta
	mj/P7yzTbNSKXuxVAJpUBpeBN+OTJHvkYC3PzF1DioSvK/GEVmoeqvBazCBJHzARmd4I8kACkdW
	DVlbXqlDP5A8xfj0Zjq72YFD4Nac/65xbTDH5pJ0MNUPddCUCQyNXDLf2PxJVvzLVnAgYiE1+DZ
	7balX8WgK4e0NsPng37JeFq2S2nYb84ShcQsZC86uVvJZEcxOF8uBUiDeRkh4dYFT/xAMqU0RO7
	UCMCgE2AtaTRAIC8WeSKbjRWg9rwpPWsFtY7qfQzp07jlpFnKaBYHSAP5pzYxbAhDCb4CZQs5g=
	=
X-Google-Smtp-Source: AGHT+IEBOclr1RnspJuoV6fs8E6iL8iXbeaGfwsO/n0jWA28CCk5Q8K9Jv3yosU0KwN4aTwn7YlEiQ==
X-Received: by 2002:a05:6a20:3d90:b0:1db:822f:36d8 with SMTP id adf61e73a8af0-2042e55c528mr1917476637.3.1745375405782;
        Tue, 22 Apr 2025 19:30:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db157eca9sm8007658a12.71.2025.04.22.19.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 19:30:05 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format conversion.
Date: Tue, 22 Apr 2025 23:14:23 -0300
Message-ID: <20250423022956.31218-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Straight forward conversion from spear-adc.txt into yaml format.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
After the conversion to yaml file, I was not sure about the
maintainers yaml field. It looks like the original driver author,
Stefan Roese, is not active contributing.
@Jonathan, I was not sure about it and I've added you on that field
as I've noticed at other yaml`s, but feel free to give any suggestions on that
or how to proceed in this case.

Also noticed that the driver was moved out of staging, but the .txt was not
in that time. Added the yaml in the proper path (out of staging as the driver).
Tks and best regards.
---
 .../bindings/iio/adc/st,spear600-adc.yaml     | 61 +++++++++++++++++++
 .../bindings/staging/iio/adc/spear-adc.txt    | 24 --------
 2 files changed, 61 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
new file mode 100644
index 000000000000..a858b3f3c494
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/st,spear600-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SPEAr ADC device driver
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Integrated ADC inside the ST SPEAr SoC, SPEAr600, supporting
+  10-bit resolution. Datasheet can be found here:
+  https://www.st.com/resource/en/datasheet/spear600.pdf
+
+properties:
+  compatible:
+    enum:
+      - st,spear600-adc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sampling-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Default sampling frequency of the ADC
+
+  vref-external:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      External voltage reference in milli-volts. If omitted
+      the internal voltage reference will be used.
+
+  average-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of samples to generate an average value. If
+      omitted, single data conversion will be used.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - sampling-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    adc: adc@d8200000 {
+        compatible = "st,spear600-adc";
+        reg = <0xd8200000 0x1000>;
+        interrupt-parent = <&vic1>;
+        interrupts = <6>;
+        sampling-frequency = <5000000>;
+        vref-external = <2500>;	/* 2.5V VRef */
+    };
diff --git a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
deleted file mode 100644
index 88bc94fe1f6d..000000000000
--- a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* ST SPEAr ADC device driver
-
-Required properties:
-- compatible: Should be "st,spear600-adc"
-- reg: Address and length of the register set for the device
-- interrupts: Should contain the ADC interrupt
-- sampling-frequency: Default sampling frequency
-
-Optional properties:
-- vref-external: External voltage reference in milli-volts. If omitted
-  the internal voltage reference will be used.
-- average-samples: Number of samples to generate an average value. If
-  omitted, single data conversion will be used.
-
-Examples:
-
-	adc: adc@d8200000 {
-		compatible = "st,spear600-adc";
-		reg = <0xd8200000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <6>;
-		sampling-frequency = <5000000>;
-		vref-external = <2500>;	/* 2.5V VRef */
-	};
-- 
2.47.0



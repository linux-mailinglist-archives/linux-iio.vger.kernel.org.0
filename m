Return-Path: <linux-iio+bounces-18890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C3AA40C5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 04:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E83B8C3F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF07F7FC;
	Wed, 30 Apr 2025 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGk/AOSr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBC2DC77E;
	Wed, 30 Apr 2025 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745978582; cv=none; b=sFs//f7AtFWRiVA6RTOppdu3BSL5kk93YXUkQfnp0oZstTV1e5OrmmkMVy1Y644S7lPyffpqh7NYIt/cLjBKPIDKiUGjBu5Fs+hHjq0oCFxp72C+tGBKLJtWlGJ3808o9ZvqIJkUDX7lexo0hgfNzj0LYRzUSu5NsmrtTyb7k1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745978582; c=relaxed/simple;
	bh=e25vsFQvM7K9a+NWv9Hv7JhvUfauCVFzCE5OgLo8MPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCVi/7oYzJS2B1JcWMhQhKLz53AI6ecQy0w0aXwcHJsOWJNbm8vlRtd/FrFe98/0IEZ2rxA+Gcg/pr1Gm24xvXnj0Wi7KXp270TDPL0MWlBq2mNZ0HZjJChfnZc0hirDgtXaxPY04HvxnYCg2YgudOsR5wfBEHGfvRa8n9tY4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGk/AOSr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736aaeed234so5607646b3a.0;
        Tue, 29 Apr 2025 19:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745978580; x=1746583380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PU2BMFTnVtPjOHXZX3MwYrwKdLPtw4QrVftiOXMGqpw=;
        b=FGk/AOSrTnV9qyh1ke1eNcAqxlCzMG+exCZjea13GF80FjCYWqdTT26VXc0PhorEUV
         u1hatA8IJJpZdXhvJC5g2JvCQRFPwMZEG8bixXNRNNw7xnq0XKXcJ5ckQ9nf8TJpvGXS
         MeXBLzRh0KfXajHM5G6xt+QnELIYXgJDMSzJQt2F4UPiGBw6KDTJ/gSSTWoloQuzM0mg
         M+JVssavY+4Ry6VDetJkYUW5/P8a3gVv0SHP+tkEBEIR3QMLmx6ArF05Wo5otUJ07X/5
         +hAzGWEC6gTdubd22alnfxtXFxFLFxMpnfAfVdfa9M0lYtmxsuOnRX1NPr/ff0P59qtq
         FJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745978580; x=1746583380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU2BMFTnVtPjOHXZX3MwYrwKdLPtw4QrVftiOXMGqpw=;
        b=GXeqBftWTXOAxEcyvTD+zTgRhXdmzF9GVc1rbbemIXDiDiHBp8U4SsPu9TnEsYB2IU
         ZlW8HFIQUk9L1SjRauigT/0GhSJrZtqvcqwNpX6R/P5sM17/oOKGQWVx+AtV0U7zZ8yP
         PXyiMAImUsh7yYApicNr8ui6HQa4pfdKzYxohRH4C4Jt1+ip0IeXTimMPe15yOw5AI55
         vIslJlNszaq1EphkHVI57dz0vqrTybVOZLtEMN5iRTgZwKF8MeMIufgMCVcy7g9epGRl
         fxkpLEzQpU4j2Vp6rS0x0EL5cuyYIDwH6Lh+JEcW0MrW0zzFNNTNynIO+grmnWxv0amg
         gxxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjkMMo6oPoVbrDzzKJPu97p2EO0UFCwlTFNi5JQkR/B+3bEtv0rm20zQ2NzdgqGDk80/0O3/JKlSmy2fY9@vger.kernel.org, AJvYcCXrzs8I0aymw36DOfL7Z2rlTcuQcplqZ85GpUzQj5LMyiKFEFbfAXxFO6JSts3L+K2MHyHxGlp8J2Nc@vger.kernel.org, AJvYcCXz5MtiZ4thstY2dSa+2q1kxFAizxU0FOmyM1Jvwxn2auxihga/3cHVcxoBMbR2aBhLsTa1abz/HgvD@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXw21ulULlNWa3rh0xY4l1Do77C7fH7B9DdrPcGj71Psdcl7e
	NpUNTojP1wc93AnVxqylNsuqcAmZhLplkAMOXOBqWXC6juvksV4tKpo+4adp
X-Gm-Gg: ASbGncsD2Tjew197u5eBXi48RfJ49aZtl3XR3og2tRvaaFb9S1woU3YULrXnqcfxsWA
	qjhrHKOZJVJIR1w2DI/TzAoH+XDNdXBdp1lXEIXur8D/obC1xICHrk74ewaFkPDgxRlvFn06awZ
	XZrtze9tbUREJwW2AC4fbJd6BGgws1oeI0tpqF8WIZMOEHKvkx1DdiBxOrSvNGLAcy/fYHOE5Yt
	k+ierOKRNWuAKyTeHT90Ja0vNFnRe5pAz2GCD2kuLEhKVyQQCMXj8lxaG7OXzn1NwJZBxLZPpJP
	rbrtIzIXYg4c9W+RB9A0l2HbkhilTgFWbzd+mtyf3lZ6avgYuI7NlqeIslAxfW8=
X-Google-Smtp-Source: AGHT+IHOaZdyKtUuNnxCkWkAIUmlGJeGdXdT+lkJ9XoblFjEg6+XQGjW6oJ2RUEHE2nQP+fbQuVjXA==
X-Received: by 2002:a05:6a20:c90c:b0:1f5:60fb:8d9 with SMTP id adf61e73a8af0-20a88f11293mr1875081637.33.1745978579802;
        Tue, 29 Apr 2025 19:02:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faee61e1sm9689735a12.78.2025.04.29.19.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 19:02:59 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format conversion.
Date: Tue, 29 Apr 2025 22:50:01 -0300
Message-ID: <20250430020248.26639-1-rodrigo.gobbi.7@gmail.com>
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
Some constraints were extracted from the driver (spear_adc.c) and the public datasheet
referenced at the yaml.

Changelog:
v2: add constraints over properties and remove a ref at MAINTAINERS file.
v1: https://lore.kernel.org/linux-devicetree/20250423022956.31218-1-rodrigo.gobbi.7@gmail.com/
---
 .../bindings/iio/adc/st,spear600-adc.yaml     | 69 +++++++++++++++++++
 .../bindings/staging/iio/adc/spear-adc.txt    | 24 -------
 MAINTAINERS                                   |  2 +-
 3 files changed, 70 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
new file mode 100644
index 000000000000..afce10eab1c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
@@ -0,0 +1,69 @@
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
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sampling-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2500000
+    maximum: 20000000
+    description:
+      Default sampling frequency of the ADC
+
+  vref-external:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1000
+    maximum: 2800
+    description:
+      External voltage reference in milli-volts. If omitted
+      the internal voltage reference will be used.
+
+  average-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 128
+    default: 0
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 906881b6c5cb..e923becb0633 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23213,7 +23213,7 @@ STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Odd Fixes
-F:	Documentation/devicetree/bindings/staging/iio/
+F:	Documentation/devicetree/bindings/iio/
 F:	drivers/staging/iio/
 
 STAGING - NVIDIA COMPLIANT EMBEDDED CONTROLLER INTERFACE (nvec)
-- 
2.47.0



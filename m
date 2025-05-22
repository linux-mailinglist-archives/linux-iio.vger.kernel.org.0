Return-Path: <linux-iio+bounces-19812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B6AC159B
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 22:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8831887818
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CF241697;
	Thu, 22 May 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsOfove4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41723E344;
	Thu, 22 May 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946502; cv=none; b=KscN7V4TRY7Hr2xWhtpwNzY/CdJBWEayg4F6GDKGCEpSmd8AwgeWDnI2Nu9+EPwUw37YpIuAPL9ofp20WNtzlD4QZdYiKz96aJpOOZpeLrp+EEv0WXJno4F9m9oiL9vdBD1gse8kbDsmSts+ci/uMTYWaKkzr224Vluyk4+npzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946502; c=relaxed/simple;
	bh=DY4mrB6YDD//Bfgcx9Eh8hKnn2LDA9Ci4LgBPodML5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kG6x2xntQ03KS6crkPvnMpYaz0gami34LY2TwiBvxPZy3BiJ2SGTiyg/6mEfTdzt/lbGAl8i51poBf73rXpIXmVHz+AaSPjHo7MvKRBFDg7h6FscnlYtwWMjwdI3yQkk5hCXbpLif5Rj8/vdDDHVtp98FZJ1SOjL0xQnLZI2po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsOfove4; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5242f137a1eso2627024e0c.1;
        Thu, 22 May 2025 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747946499; x=1748551299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOJ++JRwDLRv5kHakUABnXwxcqziSYlZ6Fbqfxdk8HU=;
        b=MsOfove4G3sp2Xxwh438a+A+h71/RLoaAmm7q9Z941hhu04/wA7/zuL7hls4Yrd86a
         RM/JB5KGDVJjd4jgEh/Dk0d3TFJ9vFGE6O9sX4/0kBMfzuqdbJ4pD9ilWVMkLGVwykOY
         m5s96J/cNOxxRETUufckgtvD1ZF98FXjr2f5s2YgGntk8h2CMIGgPbQXCYtw8BYHFTq4
         dShnUfWUpp+3HlGSpA95mkuxmniLMaUvTvdDafTZjKg9ZV52FY4lYAfKSauPVlz+wL9J
         lRDxSmivYZNWbK/hxXynjo/MUPAIOVZukErKO4q8XgITyxE/vO7emn3RzHGXsPB4Kpg2
         Kv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747946499; x=1748551299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOJ++JRwDLRv5kHakUABnXwxcqziSYlZ6Fbqfxdk8HU=;
        b=I44vs/wZaAfi0IO88ycHlDlX7nxfZtab6YvuefNJ6xcL6yJCgkDsseBe5dt1D9jmxt
         Ss4itZbn8UfihgJeqaNm4fzWWshqczN2yESU7E405tdXbOqM3FTnRVh+hcn0zBoVsoBJ
         Hy6Duq2t+Qw+gfPx7qsZ48VAQ+VcNDl1YCjMlkk7mUrmCX/iuAdzynLdabWa7aPM5/vC
         8gcQ1mhbClwDw1a7ypuiw3AfEBHeQPbp2kAm9kxzk3TF7VpG6GhKwK0KSCoPOkAq1KK/
         atQjXcYgXcgEXkykKR2xGgefN+SR/m6+VD7FdCZdms7Vdwj4PnfmvQ29JSW1MbzHqx5i
         MTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+zmgubuoSQLPavcVwQ/smzG5M9Fh0ktw7c4AhMGg1LgimSyf07HJfV+BwalPry3Gkqe31G6YdIsm@vger.kernel.org, AJvYcCUzFNQG6G/tlCw+NqoRIe6zWJxCGrWy7kNP04fE/8FMD/S1DBDUCQe3/4J7+YlXimXGE6Wa600UvPiOl6xS@vger.kernel.org, AJvYcCWdwQZf8xuMqhiiqjDLHPnWuuS3DLteKT5vJpr1BOXPaF3fYFP+jWQcp7mw9I3I/lugodwztj9FWr1y@vger.kernel.org
X-Gm-Message-State: AOJu0YxNE86biQ4ZrK6kPaNmB1QP5YS89AQE153eWv/TZl7W8iSrHGaQ
	TLeNXLqSCQ6TuLUtHHQqFM/E0Aj+NPVxYjzBrCNhLabaarZMaKgXCNnF
X-Gm-Gg: ASbGnctigaXXXWQlZPThgOu3vLKW2UraDgkocHOR+wOdoM846gLmQXV2gUH61dU9Kic
	kkoVGtUWoTwJiGSPu1td98Yj8kgZJWsFzjZFGYiYUTJVx3asFAvXmlHsrrV2XYmM0rRIR07R+ES
	JZXpr7/8QZW5aGMayXr+vnhrGe5jPIKsHvsFqVi2NIOH3b713FwTANUmQWKXEnQ0WKV9k9xaYpz
	3DXVwUr/7Vkf8Do2oH6/BcuslAH5d89RS2dFkskUgH+eaPrwaIUsWsfCmQ/8pGgD4bz1TGi17Oa
	MebnMjGRqRPzxTv7pcF2SfFCOUyuoAiZgBP2vExBO3T10FnQbfgAGD+AqTXOXfwuHDpH2EEBrYY
	=
X-Google-Smtp-Source: AGHT+IEPTYGwYNGHl1Brz2nJoKhimJ3nW2UXmVoXuR/6aFxu/hxMQ1+VbCl8CocBg5N5v8SR2crwhg==
X-Received: by 2002:a05:6122:792:b0:529:2644:9118 with SMTP id 71dfb90a1353d-52dbcde8621mr23702729e0c.9.1747946499031;
        Thu, 22 May 2025 13:41:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba94000esm12435697e0c.12.2025.05.22.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 13:41:38 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: adc: st,spear600-adc: txt to yaml format conversion.
Date: Thu, 22 May 2025 17:37:16 -0300
Message-ID: <20250522204130.21604-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Changelog:
v3: some yaml style, constraints and units pointed at v2.
    also, remove duplicated ref at MAINTAINERS file
v2: https://lore.kernel.org/linux-devicetree/20250430020248.26639-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/linux-devicetree/20250423022956.31218-1-rodrigo.gobbi.7@gmail.com/
---
 .../bindings/iio/adc/st,spear600-adc.yaml     | 69 +++++++++++++++++++
 .../bindings/staging/iio/adc/spear-adc.txt    | 24 -------
 MAINTAINERS                                   |  1 -
 3 files changed, 69 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
new file mode 100644
index 000000000000..dd9ec3038703
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
+      Default sampling frequency of the ADC in Hz.
+
+  vref-external:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1000
+    maximum: 2800
+    description:
+      External voltage reference in milli-volts. If omitted the internal voltage
+      reference will be used.
+
+  average-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    default: 0
+    description:
+      Number of samples to generate an average value. If omitted, single data
+      conversion will be used.
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
+    adc@d8200000 {
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
index 906881b6c5cb..96760a05a5c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23213,7 +23213,6 @@ STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Odd Fixes
-F:	Documentation/devicetree/bindings/staging/iio/
 F:	drivers/staging/iio/
 
 STAGING - NVIDIA COMPLIANT EMBEDDED CONTROLLER INTERFACE (nvec)
-- 
2.49.0



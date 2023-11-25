Return-Path: <linux-iio+bounces-326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC57F89EC
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 11:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B271C20C1D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09EBCA62;
	Sat, 25 Nov 2023 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKTsJ8gm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A935D62;
	Sat, 25 Nov 2023 02:28:06 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cfbda041f3so5295ad.2;
        Sat, 25 Nov 2023 02:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700908086; x=1701512886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAV4tVxcNFojD9/BtYOJoIk/zozBAPmZV1L3DQjmB38=;
        b=WKTsJ8gm6k6UZ84VSDyfQsX9MZu1putgOwukKZFMVHGGQXAY6gp86nSgN9I/rN0kZv
         S7/W0hEOB2eoaBeeicsPeRblGv/Glp4n5AahdHjg9waA24mMakbqMXkPL/tpJJYCwdh4
         zNGJ3DD5AzZTf0tsjipPIGGr84wB2YAhDsh9Jzcogl8aeOWspAacem8VJ+3uPkt3gcuA
         6bUXmkBooB1xLVPauuyxecxcqqMTwf9MfM0kPcuM8JJ7R9Y6xejimVmaW0O633bTvQfF
         k9X4y9TS8Upb0itO4N/9r/bV3yrjpawMk8uYrqtmadwrgekne7Y0sv04/MtxJhiyfJ2g
         gyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700908086; x=1701512886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAV4tVxcNFojD9/BtYOJoIk/zozBAPmZV1L3DQjmB38=;
        b=K6gaz8SUAzDUmLYQIuOCQHlriepnNXHurhLu8vFcoAWHSsfyfCM/bL4Q/1SjPGMi0M
         UAJ1WYM1DOFMd1xKx+wQlIEAxO8eYz1lci8oQ6QJxGBWZReC+fiizzMcAPVGljydM0rr
         mEXa4dpXlKJcGK63IFtbrAsL2ATnqBfNwnZ0INBYbceiuNRY7J2ZpII6U1FYkuNbHHuM
         eufDKLGlfayFhwL4LNbqaFqzzr6+IGC2+FFhNJ2qoXcVVxRtJUYZwiICk6DaiONdF08r
         fM5Jd8KWIQ2ZB/wQJ/Ty48SOUjCYXQycXOD2ZpreRqNb6KQguOIC2+5kNOMov5CaV5TE
         B8SA==
X-Gm-Message-State: AOJu0YwJZYL/ksseSY64+vSqAgKH5KBqpjMH4Mw+fK2bvfE518c/4a2R
	8O/kUj1isUJNl3rG0KZZpMc=
X-Google-Smtp-Source: AGHT+IFBJfqfjn1eqCuv5cfFXSQy2mbmvn5yAGubGF+D+tmvX3rn83NkcLjKl17V1vph5qf5zF7oBQ==
X-Received: by 2002:a17:902:eacb:b0:1c0:cbaf:6930 with SMTP id p11-20020a170902eacb00b001c0cbaf6930mr7590926pld.54.1700908085804;
        Sat, 25 Nov 2023 02:28:05 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.109.30])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001b9da42cd7dsm4629405plb.279.2023.11.25.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 02:28:05 -0800 (PST)
From: 579lpy@gmail.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: humidity: Add TI HDC302x support
Date: Sat, 25 Nov 2023 18:27:49 +0800
Message-Id: <20231125102749.2876-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125102221.2795-1-579lpy@gmail.com>
References: <20231125102221.2795-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li peiyu <579lpy@gmail.com>

Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
temperature sensors.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
changes for v3:
- Use a fallback compatible
changes for v2:
- change the maintainers to me.
- hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
- change the node name to humidity-sensor.

 .../bindings/iio/humidity/ti,hdc3020.yaml     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
new file mode 100644
index 000000000000..08080bb9cd75
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
+
+maintainers:
+  - Li peiyu <579lpy@gmail.com>
+
+description:
+  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+
+  The HDC302x is an integrated capacitive based relative humidity (RH)
+  and temperature sensor.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,hdc3021
+              - ti,hdc3022
+          - const: ti,hdc3020
+      - items:
+          - const: ti,hdc3020
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        humidity-sensor@47 {
+            compatible = "ti,hdc3020";
+            reg = <0x47>;
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        humidity-sensor@47 {
+            compatible = "ti,hdc3021", "ti,hdc3020";
+            reg = <0x47>;
+        };
+    };
-- 
2.34.1



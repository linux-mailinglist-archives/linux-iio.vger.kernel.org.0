Return-Path: <linux-iio+bounces-209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19BE7F2994
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2564BB219B3
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B93C6A5;
	Tue, 21 Nov 2023 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6439B/C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64F116;
	Tue, 21 Nov 2023 01:59:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce675e45f9so19058825ad.3;
        Tue, 21 Nov 2023 01:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700560792; x=1701165592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrfj6UPeZoHczBeA8a/k7Z115LACW+cZYO5wipNfSf8=;
        b=e6439B/Cm/ZRuoIod0aNOseLBwpZ6+eQx4lfcq1+QgQJHdhFIrw1ycVzMuzR0xWMfe
         9Yq8+jjGC0uKj+yjy/3m6YR6icEGzCrfUMe3Dy2UwtwO1eSsyVsSAYshsHJU0+twjMZN
         yQT5cG5IboOdh9LsbKQ1JLrPrtlJLdc9x+NvrVq9DbZWDd/3qGDAoEnZQyRBXd5jB2Nk
         tH5qfe0bAqN2K7HrdyNMMh27jtKymVnNo6h0L6VcGTxOwm8FzKU0mxteNfXF4e3ENK5w
         l1NJnxpS3lRiFHW4uOejOZ3Z3hAK+EWUIf7fzcXtvN4e8iJ5hmYlLmKUBtcObGKraaJj
         Te/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560792; x=1701165592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrfj6UPeZoHczBeA8a/k7Z115LACW+cZYO5wipNfSf8=;
        b=Kkkp7fdpjlTMrp/jAKF0pe1LZs2ztPcXwcgy29IKOVCpSWNOBj5SACnTIngYusdMVp
         AJBlejHWuqimmlbnom8jaGkPlahp/oKKj3tb7uZiejknSKyqju9uvH3n/SjozcuNWDHb
         vnTYtosrjMLVtUVYZV5xl0a4PTHeyK6xz0C5cuUadXlyv1XxVcInkUuiFeRteaU3rs2p
         N11zT/xOrrvGXwZ/T8OJHVz4BJSFMoNM6wotO3oL3vsSY73/BnUIdoZHsX2zdXJ/bGWA
         XJ08T5ph/bC2BwQ6xP751dyEPKPBEy+ETzW06/g3VtzmNjN346UajJK4MQ8mmAUEaIaZ
         Ujug==
X-Gm-Message-State: AOJu0YzIOwrkaxGuFfviH19xoEjJRLP9HD0pe5WZvGdbU+I9AT+HPU3u
	oinYC2/KlhC9sfM8D7PyEfALr/IhTYsN9g==
X-Google-Smtp-Source: AGHT+IEIXF6IuanJX0SypgcM5AVpesNrRUzidirxQpdqMDXPyYBNQbC9KJM8rDNJ7vJgaeOWUm3EFA==
X-Received: by 2002:a17:902:ce81:b0:1cc:6d2c:fb59 with SMTP id f1-20020a170902ce8100b001cc6d2cfb59mr9790531plg.28.1700560791815;
        Tue, 21 Nov 2023 01:59:51 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b001cf68e1c5a1sm2047415plh.4.2023.11.21.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:59:51 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: iio: chemical: add aosong,ags02ma
Date: Tue, 21 Nov 2023 15:27:58 +0530
Message-ID: <20231121095800.2180870-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121095800.2180870-1-anshulusr@gmail.com>
References: <20231121095800.2180870-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Aosong AGS02MA TVOC sensor.

The sensor communicates over i2c with the default address 0x1a.
TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.

Datasheet:
  https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
Product-Page:
  http://www.aosong.com/m/en/products-33.html

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v3:
- Fixed commit message
- Removed "asair,ags02ma" compatible

v2: https://lore.kernel.org/lkml/20231115125810.1394854-2-anshulusr@gmail.com/

Changes for v2:
- Removed device from trivial-devices
- Added standalone binding with vdd-supply property

v1: https://lore.kernel.org/lkml/20231107173100.62715-2-anshulusr@gmail.com/
---
 .../bindings/iio/chemical/aosong,ags02ma.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
new file mode 100644
index 000000000000..38ba3614ae8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aosong AGS02MA VOC Sensor
+
+description: |
+  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with default
+  address of 0x1a.
+
+  Datasheet:
+    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - aosong,ags02ma
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@1a {
+            compatible = "aosong,ags02ma";
+            reg = <0x1a>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.42.1



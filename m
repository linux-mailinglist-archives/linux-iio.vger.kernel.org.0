Return-Path: <linux-iio+bounces-323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F77F89D8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 11:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB6F1C20CFE
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8442CA4E;
	Sat, 25 Nov 2023 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y66qCK8T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B4410D8;
	Sat, 25 Nov 2023 02:03:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2004342a12.3;
        Sat, 25 Nov 2023 02:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700906619; x=1701511419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iz62r/C3lhJIiAyG0rSIQht5mTyspTFd+aVvpYLeNXc=;
        b=Y66qCK8TAmiyN+eGq09qIqwlXaUuZnJv6cadlwK+VfIbTyKJtX2hQBkFuB3ATKGo34
         xKV81TMOY+Pw1RCHY1S6jg0JvPO+Ef9eDiaG8POC290tuctDQQOjP4cWnCy9K5Vqi/u1
         eFqMG+OS3s9jk0Q9bwXdJYNLsHlGCcT0g+oTEir5tDRHe3IgPtjMDtgxuowjU6Lmvqsp
         E2Bq9TFw0IrXVf8APr0vs+6yZqpIqtb2z1n8eehsrO3VVhoTMx9J72byVrMwgyYzbQdW
         VitYV5j8L1iq5qg3mmcrPLTo8Iiur02toLwUpzgQPXrkMzF3jBCNYaLyZ2z4kXm2Fwpm
         dssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700906619; x=1701511419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz62r/C3lhJIiAyG0rSIQht5mTyspTFd+aVvpYLeNXc=;
        b=L6e8W49USYhi2fUmXwyjDGpdCNcCCgywAKNFkazJTUHuhjLttgg//81DiGBZh0QzYD
         MibWmbTL4JHP7RoLf5XNQ0GVlde+wfD5EHHf7Ae1VdAeGujxDvL+q+dqbdxXKuiMAHFR
         67Q/TjMxSfyCYjrRj9/YvU8IJzcFZW9sHxfRj5q9ff0+AznMDeI+oWIPVkeyELOv/lsl
         HUFTFWAbD+yukqKaAg4IyAsITx+5xXUXiMLXAw6WdEMF0vhjJYQV6oZt3rdgIC8LurpR
         O+7wQ/+fjmJA0UXaFox5ofz+e/j3XYUJBPVz8eIetRusA/o+wqKXE676b6zX0I9Jq8Ev
         3C1w==
X-Gm-Message-State: AOJu0Yzg84lJGvwJnxdX/wB8LzqdtTLgIYfSwi2SAHypW+ZEWGjVOwQq
	0XsmVFJTcMKxyrA+8tWghIXQYexz7QvBcsBO
X-Google-Smtp-Source: AGHT+IHVDWJ2l5HKfO1SlHDnf7mSIMRmvTPrTYzdySKCDbInF9TRNcAvUc5/x0B5tf7JUfHaPUl4ew==
X-Received: by 2002:a17:90b:1c8b:b0:27c:f309:f381 with SMTP id oo11-20020a17090b1c8b00b0027cf309f381mr5819834pjb.6.1700906618700;
        Sat, 25 Nov 2023 02:03:38 -0800 (PST)
Received: from archlinux.srmist.edu.in ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090adb9800b0028593e9eaadsm2049035pjv.31.2023.11.25.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 02:03:38 -0800 (PST)
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
Subject: [PATCH v4 2/3] dt-bindings: iio: chemical: add aosong,ags02ma
Date: Sat, 25 Nov 2023 15:31:37 +0530
Message-ID: <20231125100139.193584-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231125100139.193584-1-anshulusr@gmail.com>
References: <20231125100139.193584-1-anshulusr@gmail.com>
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

Changes for v4:
- Changed node name from 'light-sensor' to 'voc-sensor'

v3: https://lore.kernel.org/lkml/20231121095800.2180870-2-anshulusr@gmail.com/

Changes for v3:
- Fixed commit message
- Removed "asair,ags02ma" compatible

v2: https://lore.kernel.org/lkml/20231115125810.1394854-2-anshulusr@gmail.com/

Changes for v2:
- Removed device from trivial-devices
- Added standalone binding with vdd-supply property

v1: https://lore.kernel.org/lkml/20231107173100.62715-2-anshulusr@gmail.com/
---
 .../bindings/iio/chemical/aosong,ags02ma.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
new file mode 100644
index 000000000000..c176a6e102ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
@@ -0,0 +1,46 @@
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        voc-sensor@1a {
+            compatible = "aosong,ags02ma";
+            reg = <0x1a>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.42.1



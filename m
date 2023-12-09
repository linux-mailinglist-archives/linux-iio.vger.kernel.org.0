Return-Path: <linux-iio+bounces-777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC81F80B3DB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 11:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AC2B20B7B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E782413ADF;
	Sat,  9 Dec 2023 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9xpJtaP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432CD1;
	Sat,  9 Dec 2023 02:59:38 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-35d3846fac9so9867995ab.2;
        Sat, 09 Dec 2023 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702119577; x=1702724377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm+D5jKJ17HuWeeaSzfoieBbBFG7aIweWno7P45cPZU=;
        b=T9xpJtaPB+sqe1hG/rSgrzkixG5NOwD96/3hGsvTOul4XeaohRsUk57KkVTwdo2v+s
         qSYcyVDgAP+fPtmrk7sOA/Ih00NIPFGljWjtzH3vYPKd8jYecJ1SkKww6q2nkM8/hSEV
         KfxUZadQ4oWG/EoLTFriF7pg+aODTHnlzExWPzmeezqzYuCgZRZfb079zASbyetHUPfR
         vBbW3IwSTLLjUjod0ZHfnbEqH1yr1q401aCkZqzuwprCsz53bZAMSkZrRMUmI+wNd5kd
         9x35Onn5nWwPbd0CsJaMomk+6myiTGkj5/nwnpEDuz6S5S1dW5otKmOKzdlADCOCZFX1
         WgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119577; x=1702724377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm+D5jKJ17HuWeeaSzfoieBbBFG7aIweWno7P45cPZU=;
        b=ZChbZgSoDqXelWCwTFLykhTR0CM0cQW+FeNkf7U48P/jJ9qDEqof8u6Gn59LSTx7o5
         IYaoAJClqoqdn88n+S+9eUpSWs9J0uwYbpfpgebiA3K/Cf9Bdh8cBVWEB66zs8fMp40M
         HOQemfDsAw9ba2lJX/A1TwbkZTNx0gNgG/+iuKTQZEKs5Fx7S8SZDCIHOE4HsqvHlmFx
         e8LUfA46+pbqjGUPbyHcGxcstJn4Fyo1M8QhGTUTmtRd/0s0iK8k1ZUXngDZbsOVP1VH
         KTiWwcgMB7zfzsmZQRd8CwgKaj0ql67TzeUjfzmIto0PqLMTKk3HCJlyje9mof6XBMmv
         g83A==
X-Gm-Message-State: AOJu0Yy8AXp+w2gCWQVqz4HefTyIxEO12cjG+dHXX1MmljqNYCBvIHsu
	FiKELeBeyT+xRNw8sIsy9pQ=
X-Google-Smtp-Source: AGHT+IE9oQ66Nh55WRvLQOeBudMCb8IxqZPeNB6jqOGah/nj66T++A18Lc6pG5a326EEdM9rZV+sfQ==
X-Received: by 2002:a05:6e02:194b:b0:35d:720a:7eaf with SMTP id x11-20020a056e02194b00b0035d720a7eafmr2534435ilu.6.1702119577279;
        Sat, 09 Dec 2023 02:59:37 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.111.112])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001cfc1b931a9sm3166912plh.249.2023.12.09.02.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:59:36 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH v5 4/4] dt-bindings: iio: humidity: Add TI HDC302x support
Date: Sat,  9 Dec 2023 18:59:26 +0800
Message-Id: <20231209105926.3965-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209105217.3630-1-579lpy@gmail.com>
References: <20231209105217.3630-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
temperature sensors.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 .../bindings/iio/humidity/ti,hdc3020.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
new file mode 100644
index 000000000000..f04b09fdca5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -0,0 +1,55 @@
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
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
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
+            compatible = "ti,hdc3021", "ti,hdc3020";
+            reg = <0x47>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
-- 
2.34.1



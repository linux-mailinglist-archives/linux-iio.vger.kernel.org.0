Return-Path: <linux-iio+bounces-439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3967FA817
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 18:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E539C1F20E38
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C493A8C8;
	Mon, 27 Nov 2023 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fubl2nJ9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379A5A5;
	Mon, 27 Nov 2023 09:34:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50baa7cdf6dso2890685e87.0;
        Mon, 27 Nov 2023 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701106473; x=1701711273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1Ag/lZU/J4RpOQ38mivV2pu7u0AqFf+zI3E7pbs5ts=;
        b=fubl2nJ9MwOViATUBcf+TazAASXDm6Y7LpilEyvQj3nLC8Eoa8DpLzJKe/RNrcdoJ4
         LDXde3Ny1wsxmCEG/qcwKCulac3TbKDZsjYMWI2fsqEITx7a1M/2a+mSLiBxf3nUhy0j
         W4goBfBdF0bYqvLKG3HM/hEjCzyxB6DOvpMgev+nMVItDGU0xPsyKBGqZpIHiuyRAE9O
         WY3eqCgZaKQy0huLnA9TPq7gdNxKcmpAQ1kyMKYyZn6jrGf68BCGU082Ir8oCyJoSOMt
         7pr3Hh4E+zhxWYD+xDNLdqMETi1HOY52NqE6eQSltEqMIKwIQE4r+y/qunFzHvJ5VGd+
         jhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106473; x=1701711273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1Ag/lZU/J4RpOQ38mivV2pu7u0AqFf+zI3E7pbs5ts=;
        b=MEWXg9hjWDl7YcI/VE//3RYoGHtjnoT1KH/CQjKMZcTiAk092n4EwmG1Dzoha0ywk+
         +sf+hys0sJrSpUoFxs93qAh8XISB4yAM/X+fp0gOwxyXq37NC0H2Ry4wU9kuRKifPm5J
         P8Zs0hb48optFGyztfYS04FqDoHT/i9zl+lqng5f43P8Nm9IV6rKs+zhXxbhyhJqwUMh
         AvyfeI1bwb+8NFhMwd4J9EYxW2R32yM84BP/8WoPla0Yj8hEWEhJCD/7fHKWxbR+x/x1
         ZZcFT+d23QEnzjE0WHWKtE9lvBbOv+b+Y5YKzQb267qf0ReNdHqqMNT+V2aiv7XaPYfQ
         rihw==
X-Gm-Message-State: AOJu0YzF2HCiq+S/idRsAvHZFTT39XDV/mVa8Um8YppNFzhs0GsWVZv2
	sTCIlzvfLANUFcPaHu62PV4=
X-Google-Smtp-Source: AGHT+IGsoWel81nYC299MCeGiI+9tACwWaWht3qVZBSFqOcLv3vQseWOo9B3KCsPncBRSdtNUIc2kQ==
X-Received: by 2002:a05:6512:310a:b0:509:47ba:3160 with SMTP id n10-20020a056512310a00b0050947ba3160mr8025819lfb.56.1701106473159;
        Mon, 27 Nov 2023 09:34:33 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-aa01-5533-a7bc-788c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:aa01:5533:a7bc:788c])
        by smtp.gmail.com with ESMTPSA id je19-20020a05600c1f9300b004083729fc14sm15139626wmb.20.2023.11.27.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:34:32 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 27 Nov 2023 18:34:29 +0100
Subject: [PATCH v3 2/3] dt-bindings: iio: light: add support for Vishay
 VEML6075
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-veml6075-v3-2-6ee46775b422@gmail.com>
References: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
In-Reply-To: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701106468; l=1496;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=GoptkDW+HIGQ2dT3QJEQVbxlzN3cg47vkmL+uaSlZDo=;
 b=nxbEvrSO/HzmhHlYuw+m5fLZXzvfLHkFU6rxezIGRHKi1yYcXrt2U74MkPPem23Fke2LiGsh3
 YE560oz1/P7CpKQIF0SFxWEOgzK0RIRHcP+sTefoGx54Hw3+13PgMNH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The Vishay VEML6075 is a 16-bit digital UVA and UVB sensor with I2C
interface.

Add bindings and an example for the Vishay VEML6075.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/light/vishay,veml6075.yaml        | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
new file mode 100644
index 000000000000..abee04cd126e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,veml6075.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vishay VEML6075 UVA and UVB sensor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: vishay,veml6075
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
+        uv-sensor@10 {
+            compatible = "vishay,veml6075";
+            reg = <0x10>;
+            vdd-supply = <&vdd_reg>;
+        };
+    };
+...

-- 
2.39.2



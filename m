Return-Path: <linux-iio+bounces-108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675ED7EE13B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 14:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EAF2810AC
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6B630676;
	Thu, 16 Nov 2023 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/+/7PBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84415D4B;
	Thu, 16 Nov 2023 05:14:28 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6bee11456baso703116b3a.1;
        Thu, 16 Nov 2023 05:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700140468; x=1700745268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EV2x8sNIePE4OMEQeslKV0/7KlyOI4zsqd0GErjPWY=;
        b=h/+/7PBp6ovXQ5tb6UASbJJVWVmr0unisGsEYfIeYFXHeoegylepUDB4q4gvGm21y7
         jISJ+ncFmvNJV3faF0S5UeTA/SW5TtpVlyOQvltDM6o/+qTfzbFrmV4SapK37dVoa5pm
         3mkuJoRLzlIy/IQPrFtP5272WrA/wRi8/V3aN2E6Kjs8W28lLLCmkpuj61UK628n8HEG
         U27QeXLUMQ7O3aPLZtHq9gJoMdej3kW3cNz2hXO5lbUNfo6WRstQVERtoo7Eki4UQ/M/
         3Ompy2zDN9KEKau7wJKZl7vCaz8KlI1A+udr4E4lksRx0GWKGq380Hy9aAKHZOz+SfMC
         jSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140468; x=1700745268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EV2x8sNIePE4OMEQeslKV0/7KlyOI4zsqd0GErjPWY=;
        b=wK7SaBEd3IKovp1HfhDMg4yjmvWvI2dGEaDn7IzTaQOoJFqSO+m2Lp6S/YdZaEXlv2
         8jyrXiO2Y9m1zqVIlQzLyA1gSRejtbjz+UkNpx/TFB+a79WAti+LNppxOCXr9LaD0dYo
         0HBGVxq8l44o/p89aAHlp6UbmA+V4TEjn7kQE+sNH+LlVSFCa1DfcK5DaMO6ChpkMnm7
         XMpNiW6fSXdtml0mZ2y7t3TSqvc1dIl/qK3BJq8jA5REn2uGGUiwPEiAmkj7vpMb1RBd
         3hp8+H4RsKG1g1PHGMaPyS76TfXUofTvwY8je29eq+BpHhDy5uFJPI/co6XCwqvvuhz4
         gAzg==
X-Gm-Message-State: AOJu0YwEuza+BQYBC6SBoPUMCJT+2LlwTR8tqsfNTQO5cinUwBvp19s8
	N+wOoiCSp53aO52UZH2kia4PNa16h8zyPCpO
X-Google-Smtp-Source: AGHT+IEbi1zP354LWGJe1WQvgZ9VU2GyW4rh37etIuIodA171tXdE8H2BOsNzOLp93wY88/X2ybk5Q==
X-Received: by 2002:a05:6a20:daa0:b0:186:bd68:fa95 with SMTP id iy32-20020a056a20daa000b00186bd68fa95mr12835516pzb.22.1700140465723;
        Thu, 16 Nov 2023 05:14:25 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.111.40])
        by smtp.gmail.com with ESMTPSA id o18-20020a056a001b5200b006b2e07a6235sm4440540pfv.136.2023.11.16.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:14:25 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH [2/2]] dt-bindings: iio: humidity: Add TI HDC302x support
Date: Thu, 16 Nov 2023 21:14:07 +0800
Message-Id: <20231116131407.13860-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116125433.13285-1-579lpy@gmail.com>
References: <20231116125433.13285-1-579lpy@gmail.com>
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
 .../bindings/iio/humidity/ti,hdc3020.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
new file mode 100644
index 000000000000..8015c4bb5b2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  The HDC302x is an integrated capacitive based relative humidity (RH)
+  and temperature sensor.
+
+  datasheet is available:
+    https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,hdc3020
+      - ti,hdc3021
+      - ti,hdc3022
+
+  interrupts:
+    maxItems: 1
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
+        humidity@47 {
+            compatible = "ti,hdc3020";
+            reg = <0x47>;
+        };
+    };
-- 
2.34.1



Return-Path: <linux-iio+bounces-19973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F0AC5BC4
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7C4A523C
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39120E334;
	Tue, 27 May 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpxbUeO5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9574420;
	Tue, 27 May 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379801; cv=none; b=W+8cffkfza7hJUmyRtIAyx0am/4ruHYyyiJ4ib5uht6NxTpvAA6aDzLgCH2HsG4h/bg7fsFSeRssQVkPZ4VPharo4uET70znz4cBAbsJfJp3qt9BwwIDxks+4avnlGG3RLEjEZTP+G/JwvzY7V1DLJIzVdvM/RdOzNrdG13YN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379801; c=relaxed/simple;
	bh=nEZFWJNF43/IBAqa8ZBZ+u1owD13TSpA7O97SW6e3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecCBhwwdtiTfyNtgxGTrq8RgnXmpBRHojY7oEoT/ZgQ3qyCNCJ6vMiGoOQLVI2fXJNt9ZRR+AN8wbo9YAnO+WPf3RJQne65dXbvJWhGDUslNGA7LaQXnVfduvfAM1nvH8JU4L0VJs9r4o//jphyy2e9f93yOxAKvQhC72Z7/31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpxbUeO5; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso159301241.0;
        Tue, 27 May 2025 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748379798; x=1748984598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+tfX241W26Uivk8mErspfbe2VUCMhSXcBryN6E4qnU=;
        b=EpxbUeO5FVYAb7s99XgdqNuKUzwmaPK4Pn27V8/y+ORqoian/CtNBFFzVY+siKcUyd
         1aOLnbLTB0SOE5kywd4+6h/NI9IUHBZAoRJYZjFxX4Z41nH3IjCGbR8jLcEDKEcJylJt
         5JrSCpYycORsrUAKas+pacT9406cHhJ5pWxaY+pclQhf/sEmY/AM3N5LJimNY3X2a6/n
         r04WV/OHT31ETg74FfkioTXrECuZk7SheGux2rRBkoW88D3An5zOa1xbSjgQHXhmcy3B
         bNaiSy8pAClRW91+9Ep1JWM4j2EDM7qwkX7MvyMNFJEUtcA0DH97hNwFHTKWYl8fuPv2
         xjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748379798; x=1748984598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+tfX241W26Uivk8mErspfbe2VUCMhSXcBryN6E4qnU=;
        b=n7FyKEMUkBBi6iEcevtSxA8x0Raosd9CgN80CnsGwdYqzqho/5hHjQpGC15TyVyaYR
         e7ihUFO3WvjmmkXRre2Put34JJ5a3o5WaF8scW8yzOh0uL9oJ8kwRkIqKR0hyNK3plmK
         ALlpZz1YqfFS+uKbCsObyPn88Qwt1c8m232P/KSVLmgcHILG8txpuedDHl4kX3B5WSLu
         7xStYjKAKjSHfAqd8zMFo4jegSmgBpXvSDtGYF1MVR5iu1Nc7/qsc+fRTQdhtdYm3Lbs
         NvM5HwSqGDZ7dCucHqhwrAOV1gqLixjFnsXCEJeF+7b1s6vjODAJQHeBpuat/XIkZJfA
         VSIA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NRdt+BOl+7aWpXVpd/ZKM2gP66zh5e1Yf6w3nbG6m3886mTX25kAOYn6RbtaEYYtWvRZUjdpG1uS@vger.kernel.org, AJvYcCUr0uDSX/UprXID5pVpWsi5mcN7kBjiUZGAKx8ZDPRpykVfTm6HpfpCbgo7ZGpQ/kIiNeDJRh4wxLS54H9X@vger.kernel.org, AJvYcCVXRWEJIs1VtzzVhWUIinTvFXVzIPAs2v8/fPB0SWB69lkbR9aNwamPyU5gCBTbiITQXfosnfboRsk4@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4Uz9L5KZuiK75BW072koeqC5aeUYw+jZaGqVDCgRGr+opaEZ
	qduRz6MTEPUcn4CYUNHyHK2KQjpi/+dDIP2Fk4jwTOJZZ3RgICP/Lr9l
X-Gm-Gg: ASbGncuwsp8DR8ghL3L9yc8aOAl3i3RdCnLilQ+5C8Bcmy+TYmPFFCMNNtA/P9TIlko
	XsM55Lt0ihO5Xf9J4JaaPLBYuuu1r3V+qcCbuwZJo0vWHjn9ieyOM2cPaJVQ+vzhCo9m6rOxHyA
	4mJcHBhtYfjXUETKGJDn+uDao4KUzOROY+ERYI7jNLQxAitXR+ShMAobrlKPZswOwh4BBuQAuqe
	wJYbYa4EjQEf9ICmOpalQW9fC0EtVXWHCTVtm6cLvWWdZBhzKOhyCFSJA1ZsMMeFzKU+PLRnesa
	TMMezHaz7qq2XWXQLbKmVM9EUXNcBzCqDCIqpFJMU3zMj7dpjj52T2ZzrbzRdCkE79JGwhfOfp9
	vdTSuisfdlA==
X-Google-Smtp-Source: AGHT+IGahsV9cN1gLjmLmKKBxKssribhKdWt6xqIIDfYJ+6Xkj8fLEQKGmWCdlAv0G5Zzu0vS7jWrA==
X-Received: by 2002:a05:6122:cd:b0:52d:beeb:c6a3 with SMTP id 71dfb90a1353d-5305fcdfe92mr1861095e0c.1.1748379798477;
        Tue, 27 May 2025 14:03:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e59cea6ee0sm205800137.2.2025.05.27.14.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:03:18 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	manuel.stahl@iis.fraunhofer.de
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: gyroscope: invensense,itg3200: add binding
Date: Tue, 27 May 2025 17:55:28 -0300
Message-ID: <20250527210308.4693-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no txt file for it, add yaml for invensense,itg3200 gyroscope.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Originally I`ve added @Jonathan as the binding maintainer due another thread
but @Krzysztof mentioned at v1: "...this should be someone interested in the hardware".
I`m not sure who might be this person in this case, a reasonable choice would be
the original author of the driver, but looks like his last patch is from a
long time ago [2] but I`ll ping here.

Dear @Manuel Stahl, I`ve noticed that since the driver was added,
there was no binding doc for it and this is what this patch is addressing.
In this case, a maintainer ref is required inside the .yaml file and I would
like to ask if I can add you in this case. 
I would appreciate your comment or suggestion over this topic.

Tks all and regards.

Changelog:
v2: 
    - removed the register map link; there is no datasheet available at public ref. At [1],
    it is just a product overview, so we can`t use it;
    - add supplies and external clocks (I`ve used as ref iio/gyroscope/invensense,mpu3050.yaml);
    - add the author of the driver as the maintainer of this file but I`m CC him in
    order to get his opinion about it;
    - adding some CC missing at v1;

v1: https://lore.kernel.org/linux-devicetree/20250515002817.81863-1-rodrigo.gobbi.7@gmail.com/

[1] https://invensense.tdk.com/products/motion-tracking/3-axis/itg-3200/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Manuel+Stahl
---
 .../iio/gyroscope/invensense,itg3200.yaml     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml b/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
new file mode 100644
index 000000000000..4b2f9a57c6ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/gyroscope/invensense,itg3200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Invensense ITG-3200 Gyroscope
+
+maintainers:
+  - Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+
+description: |
+  Triple-axis, digital output gyroscope with a three 16-bit analog-to-digital
+  converters (ADCs) for digitizing the gyro outputs, a user-selectable internal
+  low-pass filter bandwidth, and a Fast-Mode I2C.
+
+properties:
+  compatible:
+    const: invensense,itg3200
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vlogic-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ext_clock
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
+        gyroscope@68 {
+            compatible = "invensense,itg3200";
+            reg = <0x68>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.49.0



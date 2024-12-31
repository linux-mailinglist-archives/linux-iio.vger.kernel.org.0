Return-Path: <linux-iio+bounces-13868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52079FEFB9
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 14:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC42118833CD
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145C19F424;
	Tue, 31 Dec 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5OlZ07E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A09196D90;
	Tue, 31 Dec 2024 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651548; cv=none; b=LtND3GJ3kjMosNnrBVlLT8IdMh6sUK9oe1kobK4+ez5BqHd20vXPjwRPpy7izxJPTi5bmiUQaQl6CxDBbMkxo4ecMXoVq2isapF33FGZ1uFttycRQ8+rmfxLrdUVRp0ziy66Fu0x05iCTy7pW/jcB0yrqg+AmPths8Q4c61QZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651548; c=relaxed/simple;
	bh=PzDFyKwqmZxhEm4hcDnT3Ff0rCTjnwMbqzVoC5D2k9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJaULpTl1/+h3lezsFtoqtk3M8inlkxlAIJEjZWLuYbMhqHr0P5WtAH6wLzLHt08elt4jxmkfk6BGs7Cz6n4hcN7Kgr6HQHXxiMpTze5gzY7EkN8EhNnaEU6v0qlBoQowwNoJwxLzyIRr6fKN/92cmA6XGVZC8a0QHANAw8JvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5OlZ07E; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa696d3901bso1037556666b.1;
        Tue, 31 Dec 2024 05:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735651545; x=1736256345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMIO6v+ImE1WY79lZg8ocrV5vA+/4c3+TLNqxntvvYs=;
        b=W5OlZ07Es9v44U/KZVzXyLEOcE5l1y9GPoro9KtXScgaRRsllKw6TQNGkGzBUz9TRL
         MFK5eK56aX5kEoVXRUaiVLrmW4lpARscmrGKwCOVSRDxgv1NXEy0dvn37ay3IiLU2uDo
         pazt4MkH9gySmA63aaeI+3W+woLvj9fs7cJEkgI4azOiZe24NVdE+1oEjzF75Ye9fk9T
         a8JKVPlam2yiexrrK274HRn81XmrEeBDzEdDR22HUSVIiBI9wBKwM8Ag644Ts8uVDlxq
         t1uDGziTei9dc835oYrwBWuaMuosF+cqZdMuvG38QcM/uc0chAnpXSsyS3gb71XU5MdH
         VBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735651545; x=1736256345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMIO6v+ImE1WY79lZg8ocrV5vA+/4c3+TLNqxntvvYs=;
        b=hJVQKaXPGyF/Qr/MgjZUh6zTmzdox+m21r/DyPp+HoqltY4wjgNiCafVFqdIwHb1xD
         45FxXCVkCN1AwkRhliLp7nLOn5viTp4Ah+XSBfRdSILWWdv+9EEzo8c2RkywYfxiOQYU
         HASQ0bz3zY7uK+IA5Lv0uHiJ0n2cRjKiB3+vM0RKURzNAIkTm5T0a7U5vKju0uu8f5lU
         gYWmu7xYPHaJ1erDr9xqgZuMpXJXo3hMyBHiyim3O5l2k04bq95mqjabrWsCjdA4L0Je
         AF89suETly/sCVVxsmYFMWZRBL/m5Pkgj93LTYq8OCVfxYyRbKJzquO1jK5yArJQfAmC
         +xjA==
X-Forwarded-Encrypted: i=1; AJvYcCUg8KMreeiez4rTFo+mGVUx8naZ3xhKAsd1eZRO7rxQlRASW8wqwaw3eFmsBFgI+TCzAZBevzAM8wt6@vger.kernel.org, AJvYcCX1QhWVnSH1xWgusUJIXlwSqKsztZXuS3nvq65XJoD7B5OakD9UhKV/75wkYPK5eU4mkERs3Lf/TuMMb11t@vger.kernel.org
X-Gm-Message-State: AOJu0YxECYFz3jIJEaFo5GELgKXScPj/K//TDn0TXchZaeCHMcjlGQ7i
	KvU9qBggsSKJgpOFLpl/sdryoApfYRg9gSTYRxtvoV7Wavvbkz/Y
X-Gm-Gg: ASbGnctmZ3jH6vpXX6O/vf7SwvBLXIEDIYdB0okfvMTl31RvvsJ/a4Yok0bUCv+DNEN
	KbtnSYRFRjtW4QOxma0r6YiDnvM+GvCFNYBIXkmDgBeFfjiO2546om7izXfDTiZZTRlWHlnvhZ9
	J+Mj2SWx9jW532bc/4Vh+3eFaWRL8AtV+8+YoaI79oBw4EMPOBXwpZLLgXpDQG1umRTgvpBihkY
	0co63vwp5d0rmbnjub6Dkpu8PQY98nyTzGC93sUCUDl5njc6gZ44LY+6PRQBMTYMW6mWCUNYkY=
X-Google-Smtp-Source: AGHT+IF3lTD7DoCNeZAf/h18sCy3bdfx1nBN829VRfCkTjeLZBIDboir9xMC2NRe7GjdTEsFpSTW0A==
X-Received: by 2002:a17:907:3e9b:b0:aae:8be7:ba07 with SMTP id a640c23a62f3a-aae8be7bb31mr3775374066b.17.1735651544837;
        Tue, 31 Dec 2024 05:25:44 -0800 (PST)
Received: from localhost.localdomain ([90.156.117.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae71desm1569345766b.89.2024.12.31.05.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:25:43 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	krzysztof.kozlowski@linaro.org,
	lars@metafoo.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org,
	danila@jiaxyga.com,
	icenowy@aosc.io,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org,
	megi@xff.cz
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: magnetometer: add binding for Si7210
Date: Tue, 31 Dec 2024 14:25:12 +0100
Message-ID: <20241231132513.6944-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241231132513.6944-1-apokusinski01@gmail.com>
References: <20241231132513.6944-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silicon Labs Si7210 is an I2C Hall effect magnetic position
and temperature sensor.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../iio/magnetometer/silabs,si7210.yaml       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
new file mode 100644
index 000000000000..ef29d12811e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/silabs,si7210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Si7210 magnetic position and temperature sensor
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  Silabs Si7210 I2C Hall effect magnetic position and temperature sensor.
+  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
+
+properties:
+  compatible:
+    const: silabs,si7210
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        magnetometer@30 {
+            compatible = "silabs,si7210";
+            reg = <0x30>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.45.2



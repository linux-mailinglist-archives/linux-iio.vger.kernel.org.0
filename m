Return-Path: <linux-iio+bounces-16309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E40A4CF8B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 00:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBF71889411
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0C1F417A;
	Mon,  3 Mar 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb4BMwjL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29DF9E6;
	Mon,  3 Mar 2025 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046380; cv=none; b=Z1tUFaLLa7W1ZMrjp3Id/L/sFyz66zQ7rJgKXxeGPa6EYMZRrPlrcA8GR/ziTtiKtDhyNt52h98u6zDkA+wDjlLtZELdHyYIT2fksYoCeyxOwVPPtd/E6u0DAtBAlKOE+4qg2DT4pT3Px867Xr3ujflA6daY8UsB1KN9ue7Jc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046380; c=relaxed/simple;
	bh=04bpoOcPW4nahyQoGffhYfeUl/7cvNwek56IxXN5nLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZOJQnHDOlOhGV9QeE1uKD7UCn4dLjPDEwmkwAkS1AFPR0/d+R2iMhymtt/3NKgaoN+TWN2nBwuN2JQUOoMdEfSYBhTsuLX6pB3N1FqsD2VkzwJuMPVmxO53mOzLjw6VhbTMQkW8P57fXbGRuUUR3UkWR5F+A0fqREu4yOY4qd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb4BMwjL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239aa5da08so33309705ad.3;
        Mon, 03 Mar 2025 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741046378; x=1741651178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Nl5k4lX8ykAjaBSh+OFtZkq9yFs9ZO8ZZS3/cchBXs=;
        b=Eb4BMwjLNVgxGLZxkvHkNoIp0NdzIsYMeH0xT4a4aApjEPMVBM1HYzX8pKRoMkaJRQ
         Af80Pv+i0WL8lxpr7EwIYVg6hIa1JaaEAXzTV4UVL7nPNIQiRNEs8zH3yHaBx86uPtr0
         G37EDMVlrhOXMx2SZWLzqTRPPSDHrJSziLZuu+7oyf7/v4cEkoPF4T9PL2Es6wqEIS9Q
         NBfXkaONCft1aDPTt37CCHzrcjYJzMy0L2nlw3yFwpMZdjUm0qcYRX5iGDt62PTXaBAm
         F5dgB03vPr6WcvP/keuxHDamJQQEOCp0Q4rAm1kL49psc+rpTTgJLUbY0dj7cQodQK3w
         sC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741046378; x=1741651178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Nl5k4lX8ykAjaBSh+OFtZkq9yFs9ZO8ZZS3/cchBXs=;
        b=T72s71oiL89FOGswB3aKhXZ5ZFyhVQGDpM7z0Sqr85eJB06TyGSvne2J5vmqCxBnPq
         yIJQxq+d/DRfaZXpsjS/M66B5sH4pLY1lLZVXWb0xP5ZtcMt5fZDLfkDprUlXy78svDM
         kDqG3EO3d3vss/4tbddCZT2ScaN8h0pYdvMRmecMuGDv6F3D8IDDEYar6ShdxxlIrKcc
         9fReFXwmWjCwL2xGZhyk4OaZ5TAFzIuaJKvweSHBI7fza4xuuEnmb22mciZ/gSYsYjGB
         EgPFWvij/q+pNcgKiFpbq0P2K3xdQFP1etKpozzKNnXIYJcyFjF2ouZUI9DXQpBEUI+f
         ppBw==
X-Forwarded-Encrypted: i=1; AJvYcCUU03s1U68wOjAfeH6QXLZ2P6DbmK/vFl2hBNHzOL1nHP8BjQgmG1dV36DvPgw6ZB2q8RmdWaVzuPMF@vger.kernel.org, AJvYcCUWzPLGNU8xVMS3196Q9qiYIu9ulGaO7GxHA2RYxKJmPoZNHz40BCtT9ci8y7XzMJIiySLUzzj9m68G@vger.kernel.org, AJvYcCUuQMXTdoYNgCMEt7XCvcbOAr3Q+YHdFOz6e6Fo1m2pinzFm7a2R2VFSo0e5xnwprm1go2qwTs3ZIPJX+9F@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFPin54UOk7AP/GxDPpK25ehZJFgzv7q70ISGJqm6sfq5gsia
	sI2Jk5UxCr4sxO+ZJgfjuCh3VXvSZx2khQAPQn/tD4bfSG09wVoY
X-Gm-Gg: ASbGnctB3eAmQy8JNRpvysWFETF8vjDlpobkuU8CyjNoj3CguoFl7LDDwSMX0FGr1lk
	8mpKKE/+xCLCp0J1ROmASsWOuGf17KujpyrMxIY6hqhffkr9psEy/rff2S+Qn6xS4QPNrDmTlOX
	n7yZHLrEirbtKT25NFYdNorA3yLtBY4fNEHZm4AWl1YONJmJbRhR/Sulz6TWqqswJU6w+LS8Yb+
	S2S6BB29GtE1kp8RuIrpuIAVk6YYmC64HXplyoGlQMq+BAYzRZBDHQNuZJZdnDfg5jWCq4GJu+E
	9CAURcOtt5KGm1tzX9gyfMbzT+Me8ywwKBo3RFe9KLy08ZK+dig9KU3xWqL7skBHv6UG
X-Google-Smtp-Source: AGHT+IGk+zORULG18C0l/CqE4lIgOVZvq9u81/ReypCKT4mvBK1lYyGlpNr3ONZlH2rHl5CMFl/KhA==
X-Received: by 2002:a17:902:ce91:b0:223:64bb:f657 with SMTP id d9443c01a7336-2236922352bmr222799545ad.46.1741046377894;
        Mon, 03 Mar 2025 15:59:37 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350531e1asm83591775ad.240.2025.03.03.15.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:59:37 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	21cnbao@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v2] dt-bindings: iio: accel: add binding documentation for ADIS16203
Date: Tue,  4 Mar 2025 05:29:30 +0530
Message-Id: <20250303235930.68731-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add device tree binding documentation for ADIS16203.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
Changes:
V1 - V2: change compatible property from enum to const

 .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
new file mode 100644
index 000000000000..64370f13e1dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer
+
+maintainers:
+  - Barry Song <21cnbao@gmail.com>
+
+description: |
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adis16203.pdf
+
+properties:
+  compatible:
+    const:
+      - adi,adis16203
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@0 {
+            compatible = "adi,adis16203";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.34.1



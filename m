Return-Path: <linux-iio+bounces-18594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4EA9A5E1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 10:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6AC7AE4D0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71E21323C;
	Thu, 24 Apr 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODkzOIWi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD220FA81;
	Thu, 24 Apr 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483417; cv=none; b=c6OyEl6trxexkxW+ew3choCfphz97N3JWM7g7Ebrn64ds3fbFUgDwxAJtrZ4FHi7UpTxEQyG7oL7TAfJsQW+K5UH0X+l0P0JB1Z9/n0FFJ7rZkj4ltgFgjBFJ1tdeZJ+/oN3/MehCBHkXZGorgLegpTvUrGH+yqfaF4xgispw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483417; c=relaxed/simple;
	bh=+BoV+7aVSiLbb40uYq252W/Ucu/b+RTrY6Cz9MymMYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnDOhe5TkxTupGNqFQ/pX/8GTlsKQpIspA7nlR6G81HZ9xEWnJLGBijPp5HdgIHv8Hfd8NwkYR0d9jZYQCWxH/RXPA9xUszB1PmyLqrx7C2d7nxiu7g2jsEhepAIG36hrOQly0z3X9QvVnWi6vqqlbX5CHCmw81q51nCUhR+KPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODkzOIWi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22438c356c8so7535705ad.1;
        Thu, 24 Apr 2025 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745483415; x=1746088215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx+cx9RMqSy9Wmfi3jcZ+uRLokQR1sSxKDlFIB41LHs=;
        b=ODkzOIWi5YmdMpfHmLH5C2e2hlt/q2fBNzhDFgDk7Lno+SU4EEMMy7I5PuEe3IcNvZ
         RzT4jM/HdxJ38VMrv8gqrRJPpnVxlczzkSvG5tNnYkXgxzTFBBVVGrdQFIW2wcVDwngF
         HNEfsL6awSy4nXxlmlDEl11AyK3wlNeOh2Q9B2pc81gTYyUk9Q3P4cd7q6fv8FLM8/mS
         R0jMKVWvUeWiWdR5hvzAifaYqqOuWxTvPIod4KthlqHizIrRGVboAoMM8P9VKbiNJwNj
         XlOTS1otyj5xbjTLdk1oCyxNuSej7mWYREQf/d1AxCu2GY9CZLjWmLeo2tMgq/3V6d4e
         cKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483415; x=1746088215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gx+cx9RMqSy9Wmfi3jcZ+uRLokQR1sSxKDlFIB41LHs=;
        b=AvUsOhOjgUtulQwymAlYWHIDvlRJ7FzdlsH2WZYrUHPIzkZYI1qnJob3GRKKTjnF1T
         xRGoqK231FeEc+lcE6ADP5Hq+FuCdTT+LCMgR4rTIkyHk72wWHnCCO4Wi3DnirmrZrGa
         xPz1ufWgM09a09qdCxmDpQDN4/RSeaW1KcgrvuRffZYKxNkEcD/D6K3zHkjT9pxcpZtP
         HKKrBrmU18kh4lZ7umFoeqnvJ87NZpsdf4+pNsRwuDRAgA34/zR5eL9wh+jYIntx/zPc
         ucNfHcD30phhkwEnxqZ1xbtnXckU7x0ZgS6ykyED3kUoDZOQQ8P0j24zijpj327zN0y3
         PEKw==
X-Forwarded-Encrypted: i=1; AJvYcCULeX6C6Hhd3ZQrJGtJ+Dd8W2uhD8xt6kNjVHfl3LnyCtRXECCsA1R/+SGuLOVHkEbp1ctF3xHaa4ggng6w@vger.kernel.org, AJvYcCVfzQD3sSt8UFXbNswPI3TAQzyiqu/u67+dNhTmHdortVOwnh1/gcRGjj70rO2WSHwjijIC1TgQY+Qm@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXvwKnUE9pq+6dupAQLnulNC2uPqRgDDHroNytl5zZ+ibXbIr
	1zuqBOAO1TiAndJtFzWL6J5gbh3wjuwbjExvoKzlhI1PP29LIEUs
X-Gm-Gg: ASbGnct/TEcKxXmHALmfiaTJuaFK7yzN1roDJ7pzILQv9muJ5qOITnQnmdnmWlptnSx
	sHoK99pcL4wT2wXBPbr3rNp2n7nLlU29GFtmxwOj5no4o0DExfbdL8Hm/YV2U6RUkd8pvAHJP1n
	/uD2m3nJSxwIMjjJvDBfzOR/JCMnLtQYVENSitpEtRRToxRq4tIFsf3c0U5QbgZ7zKMTaE8dWrf
	IOi66+lgnHMvpRLT7sL7iWacVITSKzK1kHI8qvYCYpVVEPnJ+xs93Tn4ylxWbGbX5/1KVoMc1rk
	IHIfrNgQnVx03MRCzPfjfgdyinPaqBgsHP2Fkp3rMnzukca/JLcYnf88aKO5MzqpFAeUETeN
X-Google-Smtp-Source: AGHT+IHEA8tmej4ajXd/txejjcoCFCtVWQOrdw/ku3XVC0PQcp584DwNV5t+EqZWLNWLo7pXm/6bfQ==
X-Received: by 2002:a17:902:da88:b0:220:d257:cdbd with SMTP id d9443c01a7336-22db3ddc045mr25262155ad.48.1745483414924;
        Thu, 24 Apr 2025 01:30:14 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221600sm7525505ad.213.2025.04.24.01.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:30:14 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	gstols@baylibre.com,
	olivier.moysan@foss.st.com,
	alisadariana@gmail.com,
	tgamblin@baylibre.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	joao.goncalves@toradex.com,
	ramona.gradinariu@analog.com,
	marcelo.schmitt@analog.com,
	matteomartelli3@gmail.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Date: Thu, 24 Apr 2025 16:29:59 +0800
Message-Id: <20250424083000.908113-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424083000.908113-1-j2anfernee@gmail.com>
References: <20250424083000.908113-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding specification for the Nuvoton NCT7201/NCT7202 up to 12-bit
ADCs with I2C interface.

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk+dt@kernel.org>
---
 .../bindings/iio/adc/nuvoton,nct7201.yaml     | 70 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
new file mode 100644
index 000000000000..8ce7d415d956
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton nct7201 and similar ADCs
+
+maintainers:
+  - Eason Yang <j2anfernee@gmail.com>
+
+description: |
+  The NCT7201/NCT7202 is a Nuvoton Hardware Monitor IC, contains up to 12
+  voltage monitoring channels, with SMBus interface, and up to 4 sets SMBus
+  address selection by ADDR connection. It also provides ALERT# signal for
+  event notification and reset input RSTIN# to recover it from a fault
+  condition.
+
+  NCT7201 contains 8 voltage monitor inputs (VIN1~VIN8).
+  NCT7202 contains 12 voltage monitor inputs (VIN1~VIN12).
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7201
+      - nuvoton,nct7202
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      A 3.3V to supply that powers the chip.
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage.
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
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
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1d {
+            compatible = "nuvoton,nct7202";
+            reg = <0x1d>;
+            vdd-supply = <&vdd>;
+            vref-supply = <&vref>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..f599cfc18075 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17358,6 +17358,12 @@ F:	drivers/nubus/
 F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
+NUVOTON NCT7201 IIO DRIVER
+M:	Eason Yang <j2anfernee@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
+
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.34.1



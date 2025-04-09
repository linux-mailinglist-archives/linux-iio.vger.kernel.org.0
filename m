Return-Path: <linux-iio+bounces-17842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91BA81A75
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 03:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258B17AB85B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF0187554;
	Wed,  9 Apr 2025 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv2Nhdlu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921117A309;
	Wed,  9 Apr 2025 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161855; cv=none; b=hsWoDHtmpigieSo/DtX/5JkzfozF3WiJI+lQHYPnXcGBG28qSW+g0Mea4yMiJr3Rc9TobJM+VtaA0NqnaYGNvot17/kmxlW+eeJgeKTWOm48O2j/wYYJdM4tYiBHVvNmcWQ30YsTClWokv0RMW2WXr03nwkapAIPSnfwT1nrlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161855; c=relaxed/simple;
	bh=RVtMJm5RpM3iSqaloarvv9IDgNfZLMX7HLP0+DBjTHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyQ9shXRWU4qwwD61mgKoWsQb1n4wKKyn1oY+YwvpPYn2DviFTgiGXqIZ0SYTRtFFstPwgdtKhF82BGkbn+di7/890wMZgWFfNUiTZu09/kazFpvUzgBCfVUTkO/3Gn0nUjg6wbmcVqbxiyP8ncG75PqYaHfmFjDhHmPhH8J8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv2Nhdlu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so87920525ad.3;
        Tue, 08 Apr 2025 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744161853; x=1744766653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqBbPKtz9iyJ+24Z8YiWVVIJ6GpHv9vLqNPAxq03rhw=;
        b=Tv2NhdlukKsCFwEa1SBDtt4+17htnn4LPb7O6yDI0OV//dcAM021fICPVZ+bzSe5nd
         A9x+vn4MPAvYSM7tyhiy6DqHmxcxx5QildDSIcs7acOfJb6c8xbZw0FGttjYrGnwdqpO
         45prTUama+IHmLxqUn6foJ2H3qR/MeudCIvkzNFMifkjY2tE3h1CMUE+13sV9hKJLbto
         9Aw3di9tA8wuXt18ezWIxr6HagHRO18GG1p1RKVbba8UAflrJDSnB531HlXAm80h7ah0
         AOby/EVh4nR6ImQ3K8GJk9xSFnuwSepCB+O85HM65eIaVYzTG7lPKRgrFhb+z6kXe03s
         +Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744161853; x=1744766653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqBbPKtz9iyJ+24Z8YiWVVIJ6GpHv9vLqNPAxq03rhw=;
        b=B27Cks++HMFVPJHTf1zhy26NjixBp7JJPSG0Trzyw/JtzccExn+CkDsoaAJlg4RJh7
         NF8cTSRhACu60GVk9Qo1sgr0GGPQE2cSNGbq9XyhaBKAT2KF6gne/fWsHOApQ5d7qaVG
         OVTehtwuciLbY5DRRZGGjWY9pK6wA+DyAFFUD3ZDS2N9julmACAT34iQZTMWfqSpbDdL
         HwG5V5FGF/LBrD+DJnHwBj2RRC2L3tft9XubMdtE1iUcXFEIXHkgHpAeKM5ZdP1/x/m2
         VRrSPs5n1OmD7YEPdmw9vAdHh1r8k+HdfEZJVlZYbgOJcntPCWOx6lUjM67aiip6wPMh
         fSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3tziuGhiuEeHRve+ywANKYD/kHUAqQ1DFyB9n5QNuMZcrSfERCBVwzbX3jhTBfWIGmTdd8foYsB90@vger.kernel.org, AJvYcCVuQGU/kYbnuOfdR8cTmArPoHTv02LiD5L9LiWo9zxILfrbw1en6p47rkPPo/CZ4yKFdBk47wZvbpe1vnWf@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvQRtyb3+wou68n2lgzhePnzLRjIgbgINGjkHm5sLCxdtf8Yp
	Bx/9VnqDtgbr7nJM8wEzMu4MxK661CFsVyifjPPKMd2K8w+ghyOE
X-Gm-Gg: ASbGncvTutI+ZAuxM9XU6VgLQkckd8vah2fMVNN209CKgSw4UzphgUpEiSKyyQH8a0d
	C1Rn+ND2pcSiJSBRpU+BJbm42qBxDQiR9YQcYTJNfsXeNz55LRnQxssy2bNzx8WKLa4qGO5fNlp
	StETPjjQm2rz5tExacwjDT9IZR20WNwbgmVF4jngxtkZXkIkyykDFv1+aOhIlajl9oHq+5HhGBi
	zQ51XvGM65JJ2LTWJNVTY4X2F3pm/dpt7nai95wIglwk6UDh3IBB37MgVPPncVt1jNediwVVYaF
	5xAuBaPVIczkzk0ACnlDlfcWGvIBmRU86ZILXfYvW6SbiHb/bGHZ0tT96Bqelg/YrPCtVuixkaa
	E
X-Google-Smtp-Source: AGHT+IFB7H/N+RF7JYSsf+ytVMBWPjpch8Ju/GqxY4KMljFZspeoM8bVH8T445rR2GsFLgwuwS0C7g==
X-Received: by 2002:a17:902:db09:b0:21f:f3d:d533 with SMTP id d9443c01a7336-22ac3f2de23mr11757135ad.2.1744161852818;
        Tue, 08 Apr 2025 18:24:12 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6288asm20865ad.9.2025.04.08.18.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:24:12 -0700 (PDT)
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
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	jstephan@baylibre.com,
	matteomartelli3@gmail.com,
	angelogioacchino.delregno@collabora.com,
	herve.codina@bootlin.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Date: Wed,  9 Apr 2025 09:23:50 +0800
Message-Id: <20250409012351.2543450-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409012351.2543450-1-j2anfernee@gmail.com>
References: <20250409012351.2543450-1-j2anfernee@gmail.com>
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
---
 .../bindings/iio/adc/nuvoton,nct7201.yaml     | 71 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
new file mode 100644
index 000000000000..773e0cfd9f36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
@@ -0,0 +1,71 @@
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
+
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
index 96b827049501..f9ec68d4d8b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17302,6 +17302,12 @@ F:	drivers/nubus/
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



Return-Path: <linux-iio+bounces-18160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C1A8B344
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DFE1904C4A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA2230BD8;
	Wed, 16 Apr 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkF/m4iN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57948230BCC;
	Wed, 16 Apr 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791474; cv=none; b=Ys2kHKtejrFfq1c3V+hqS+/grFEbrekdt8ncqlvlwkyBUp/niwKTOdcE+z+Ui3zKBIeoAuEwfjqry7mmQenMD9C5sH4bF4ipUPoW1xDYe3ZPR/+9azb0IMcN3RaZ7DSUH4zC2QK9A7j18MOtymX9ZURi05KdtZFXpV5GXJFF0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791474; c=relaxed/simple;
	bh=8VSlsR+dEGEqqCw+N5fCTarinmQQxzEAm0/svwzJmxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3rKdc1jq9a07up4FuLSDG1AItqS7LzMRouIgUhEF01KnCsSNIrw1yVZ69m2yUNG2BmBVIaHnG7IqoDW9gmXGmlQfkmTUNVNvQCPXBTaXnSz6IecuNXnYKJP17V8YsrqEe+mROZHmIzY6dANy1d9PWzg9cpyJmSla3cCH3Ti6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkF/m4iN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so91320035ad.3;
        Wed, 16 Apr 2025 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744791472; x=1745396272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMJdc5JAbslzJhWPAOYx6VFuZBWTA/C+CzNNFpYwiFI=;
        b=NkF/m4iNEShsYMY/xdWQzAJUx++QX/qU2s74bRSKAgpVhKNfc9ILMAxULuFXv8ysXv
         Ur1SmfMMVt0vzjyJ5NcuxrRIXei+cQoNmajRVuLBHJrH1jvYEiV/fIVxZv59B9eCXCbF
         Kw5532Ya+eY9HXF2O6bvsZSLOhzYvvSCC1JBRyJyF3ACUAh5reQhuJVG86yqrR/kVRQf
         hbt8vTOsELZvGpY6nsYkI5D8GP54cs/5NbChlhrhHA5oYGv8hd3xe7qwXoxanT+TISup
         rlqILdI1CxPp6V2e/JnjBDye5yWdtc45Cx/bOit2YPJndwT9U0U7fw/4cvLcvdjEyndy
         Mipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791472; x=1745396272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMJdc5JAbslzJhWPAOYx6VFuZBWTA/C+CzNNFpYwiFI=;
        b=eDmSzdnxHh/K70d1mSDxJgJquB014+WzHFy6aY3WR7WEKRFyfaT20g16pxxvVaLCf5
         FID6HVGCHXvfqAbilaRDtbLppf5NSq0JrRz+2h6wsVWPQoaAg9kzUM0DdVvb5OE1bB6M
         TkvzGjUzeO3Fgs7shhNobgyap3Xh6FPCnu2JI9/UbJH0juRmJpCgDby8+YzXYYTfTGUY
         DckwmJ4dpXmIGfHVHQCjuLzJnj/NmjdTk2GKkB3vvLYzWh++L+UK8k8CFJFPXyW5LYPP
         uYRJtk7MNBKGq29Oj4SzKqTmrU5AUDi7KFnvlUVSgnMUdBtYL7Rf7AXuYte+exPPLLnt
         Qtqg==
X-Forwarded-Encrypted: i=1; AJvYcCURxOuoQaTcvQm0R1O819JwGn8wWi++2Zr8/YlVL+e4EpEM6aNLD1gu1iQVZFxxFiixWEqp9fpfVD/k@vger.kernel.org, AJvYcCViCSmnmATivYZ+RL/Bkt5m5Sjb/xtIWSHIRNLra/mjO0EEA8EtLQ1XKFhYSVi6IOAkX+Z/u995Zog+zq9s@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+V7NglO69iXsWo5lvueBRQn/7l649CLykQLkQAuWQ4Ktqz2h
	CeIzx7jFCnnaOBOXXzXcAvt/+xbDTumgCqNMWZpbHs2z2Ir3vZi3
X-Gm-Gg: ASbGncuOCilY2IIxFo5E/GhiUYds5Lxa8uU9g+ETE6p0aLtYC6RxOsVanvTEO5rNEu0
	/B5d4iEyqv0v3BD2Vi1FTNUqqam4q2HTZcG2Nohcxrr1BxKxv2uD863LROKMVXjXXdaP+jmI1ag
	ZuEUyGO9JWq+hERunlNsGXcIBKvpozlGajBtj/cONvsOXCWRwyYqEXUufkOMGIGpVehP6Li6xiE
	xN6TfyMgHdZb8Nt7M7EZdLBCRIWEeFTKJR5LwN1GqrZ/ZEJXM2mAlV8lZlPTMUvwAeTmedlPPMF
	Rm+BNc6iUq0we8J9UnHZWQ2BXfK+RloW4utlmwZ/QL5XOL+c48RG9RabX5xn9hXx5E2K/MIq
X-Google-Smtp-Source: AGHT+IEeCXr6vvEo7v1Q1up7mu+T/uR2KyR3MzzkpCa+8PxooH2+7GRqnI028Sr9v7aP9UO66PeVdw==
X-Received: by 2002:a17:902:e94f:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22c359a39ccmr16362315ad.49.1744791472435;
        Wed, 16 Apr 2025 01:17:52 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33faac6fsm8190925ad.124.2025.04.16.01.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:17:51 -0700 (PDT)
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
	alisadariana@gmail.com,
	tgamblin@baylibre.com,
	olivier.moysan@foss.st.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	joao.goncalves@toradex.com,
	tobias.sperling@softing.com,
	marcelo.schmitt@analog.com,
	angelogioacchino.delregno@collabora.com,
	thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Date: Wed, 16 Apr 2025 16:17:33 +0800
Message-Id: <20250416081734.563111-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416081734.563111-1-j2anfernee@gmail.com>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
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
index c59316109e3f..cc0dd650c447 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17304,6 +17304,12 @@ F:	drivers/nubus/
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



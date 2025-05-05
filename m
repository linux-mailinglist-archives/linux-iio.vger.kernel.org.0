Return-Path: <linux-iio+bounces-19084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F317AA8F78
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5013AB440
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5541F91F6;
	Mon,  5 May 2025 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdDskr8l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300D1F8EFA;
	Mon,  5 May 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437176; cv=none; b=aNbMLVSaXLRIgC0TqioROaWMjYzwG1nn01M4mbwlKtnL9jGwmtgzVZrWm5MVaZKDCfsTArSnOBTHUZXEZgdPDwH5Q84XDj02IekEolPT8+YfsF+X/QwRblb+F6IybE2+AxLwfcoX9Pzc31sXxQc7P1SuNWjeqhyPZT665RFwHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437176; c=relaxed/simple;
	bh=VcxrNFNvV5qkzN/vdC9DutWce0TlEARCPSacWBiEjIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5OGRL+kLvsWwpvvagUv4F5KORB/C+rKB+x1TWTYFxBRRFleRA0/XsOuKLUbxCn/Jhj2f02xbPAIUaFz8hHIPv2IRAFYrSBTps3iAX20Ac+b5uoNic8Eryg+RHfs4kMuPiODlUfobD0atvMi09trkor7D1paH6rVv0Y4PuTbBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdDskr8l; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c3e7b390so4635288b3a.2;
        Mon, 05 May 2025 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746437174; x=1747041974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLGuD3xRhpiNjbF9lD28o0yTJb2ESY0QZYYAMoZGQLc=;
        b=HdDskr8lWFY91DoNgwy7qyCqjI9infmzYlM3OqA2LCATvXJX+snles/rxv2yeh3UxM
         9lHvhjxY8iA8cIWjNijmuP0Eqg3FZkts96KiULO+BpGobDVAsdj6SNkyKvJ/m3tFdPOg
         wu7vX/kXfIOgEQXcV5MZYe1RRrfTm80VtXSm2AThq6grJtT755jcVaBnEWTpIMN3ke/T
         R8QInYrhSOKAk/wcCu4Erf9jnBx1GkkyaNys3k/yRsfQgAH9gpIUIqXRwArlfkB6MiTi
         CZoyD0Hw5j9uasY/AnI0mPvUJz12MyzLvEamtd5c0B9abmYGguI7lJ0IYrTELgAe9TnH
         5Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746437174; x=1747041974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLGuD3xRhpiNjbF9lD28o0yTJb2ESY0QZYYAMoZGQLc=;
        b=OI2t7dATIbIUEIyTN+nRjP14SUGNlC61aMIABC73Bh/BPinVu7berYJo6t8gGxnCqM
         GtD7UjQD7AMwB2mw6nuAoYs44/gSiGBVE1LUHGsWgZfL6cvcv9gd2UuMQ9ovQpwqNpJW
         MKJr3W4gsj7xLSPEFmlMzYtHsdiY7LqihH81G+/dpiiIaTLG3s5keXt8t7xEJ5W3Faoc
         AP+DjelMoBAtEZdGH6m3/XuBZwfHOac82SRQuScb9rp59c97q40rX11fKblZODglz1nN
         I/cpauU0d4BhqRSsKH7vCnOhYnmFwlVYrL3e5F/tcN1/XoyIB4IXYMNTujXfQMKXQcNI
         RthA==
X-Forwarded-Encrypted: i=1; AJvYcCV3yCwM9nz6OBjmFFNvLPVeaGfLUb4qp8Lr+tUdanopVZdWpkX18a9F6OLKAGhlAOe4RV+q4EYXq2luzbgj@vger.kernel.org, AJvYcCVE3s1oNo/In3tHkOyJFNUaPpbINNf4IxTuoMpwtYGu4eCSXVWcspL0XHcTaIBEopksB3wvqUtwRlMe@vger.kernel.org
X-Gm-Message-State: AOJu0YyfsaU0JlejKciioWRFOwIhMyXr8sqfZmUbBzWitC5c2kmayJBf
	OqTFGaoIXf7UX1qHAdK9b3HU04kodCSzn2XlyjeCPy0+DBY6FDLo
X-Gm-Gg: ASbGncvhlbwM5N+Y2OSoRh2EGW8oEC5HbKGmuLAccUmYN8HoxIe4wOVPPAay+JYqm6d
	jZKyyxlUINgMRpN6C4YQgj8EJIAMs9naAcJa1OFwTCtVUEzsqlMuNbVh8kV8rsocMO/3EotHWkd
	RZK65KK77ZFQV6t/EU5nhoMp5ElsGEnpJH3NC2mYxN1zSqEnFEwOKVAyDpypakmNGX8yg26RcdC
	CnsvXcuBByLm+yroz3nO/j5Grcgzu/v9Ptmx/PBVZh2tVisaq+Elya/jxJhOdIY5q82Iu1fVTev
	QrMJexSyXIga0i5PV31xoRTzqENg1Cds5OyUBaOpvnXZ54PFjZ2bglBKT+wFTglwsfuj2cZ+
X-Google-Smtp-Source: AGHT+IFxQpvSEmSqpcGYUGW3Me/lHf7Yaq2JWQSrw+dnvf3a/IO/7+aAFj1v7bzMF9hjdbbZVyzozA==
X-Received: by 2002:a05:6a00:6c90:b0:73f:ff25:90b3 with SMTP id d2e1a72fcca58-7406f1b08b6mr10857175b3a.24.1746437174451;
        Mon, 05 May 2025 02:26:14 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058df2a6csm6288000b3a.81.2025.05.05.02.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:26:13 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	alisadariana@gmail.com,
	olivier.moysan@foss.st.com,
	tgamblin@baylibre.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	gstols@baylibre.com,
	ramona.nechita@analog.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Date: Mon,  5 May 2025 17:25:59 +0800
Message-Id: <20250505092600.962675-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505092600.962675-1-j2anfernee@gmail.com>
References: <20250505092600.962675-1-j2anfernee@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index 69511c3b2b76..85b031ad7082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17373,6 +17373,12 @@ F:	drivers/nubus/
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



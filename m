Return-Path: <linux-iio+bounces-15907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107DBA3EFA6
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CC242381F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB93202F68;
	Fri, 21 Feb 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpP2unx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B8201012;
	Fri, 21 Feb 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128987; cv=none; b=cB1FSC7FdUzAxla8skhekqbIecbcvJUy24FbD270R0eBT9AhJwvApIPbLRY8iCb6JYoRhkJVVDrCdIt18XKXXK6jNb5fknZPLzB2Gaa/5T6C4KlCfYJrndMJI363zdk71gzYYvKsm0A/E/wrQy38TegPhCGSgYZB1UhxCic5uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128987; c=relaxed/simple;
	bh=NY1a5Y4quAKQozWoxLmdxi9huZxXWCu4myVHWpeAUEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvjCeJ5dAofDS6NDRoPkE6djKV+eOkMKlwP8hTH2bEepSdYSuIokrvaimdOAQ3HOFoS+ax+l2l6hLPqGSgy7tr6+csmmQwz+kUiLmcuF7CXdRjeWVQM53/EKSDx7F3uiSoTmG4etGuuQQPx1XogrvCQ8pj0TeuBh/KQIeZU/+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpP2unx4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c92c857aso33015965ad.0;
        Fri, 21 Feb 2025 01:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740128985; x=1740733785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rl2b+0CyoddVI2sskryUayI+99HYF7eeBGTGtW0UpQ=;
        b=FpP2unx45OHa3WB7ESsSvxZstVWXSMaCZ7PJftY2ViYL3eZpN0TRsN+bT/QQ9Kx6Cn
         WvFIr8B6WrC6xqZgaRHZiPPA/ZdqDba78waKPZ1rau5Xi8Wh4RSSZp3OXvDXDzOqlW2t
         TfCLxRWsQ39Vz5rQWJ37AMlua2Xtj/VW6zicAypDTb0LdTqUaXe86dwrw+u5qEY8gd5Z
         fws3dSBMlAgEp0gJXtYsV3hFl7ZdfnrK9lta3KRvj79OZ/jgw27Zx/RO2R0XFub4uHbq
         ZgCVrzdOxy/JBoQsJjq23o+texXyNH/dGIEkY6mt9Ei0QIVnCilfag7euO+72+MW7fZZ
         MSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740128985; x=1740733785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Rl2b+0CyoddVI2sskryUayI+99HYF7eeBGTGtW0UpQ=;
        b=Jsfkb+fSh9Qh8+ZFx4UF1vwzaLgb5IjsWatVUAHWpSNmwbCTKYCuxDUI2D4N1CAYFH
         izH2aGGUI+onueBv5GN76AhWozbVbWovtw83n+KXW/sBxe55vc7V7vKtXGYUo3f21Hxu
         U0w4+C3fxcF011rzToUW/0An2tM7nfpomiwqQmza5wAwEaiiBRyYxo/G2Q45VhUzLJRp
         OHfbyLHMVTlq819NhULbh/Vi95Wb6dk7n046Mm9W6426qOP3uu9gs4dkJhp88gBFtDVW
         sQdGWRkb2E1/LqXF0v6SvSkzF0aGjnYOlKCOQxEgjYHPKD85MTy0tKG6Sbmt8CZ0wx5/
         K9UA==
X-Forwarded-Encrypted: i=1; AJvYcCVRuYca85kAZHGwyY2q0woIQteiX1IdmGYz2wbZNRCmIj7fpT9ZMByFgg/k+8gynMkBFEWTmX6Oj7VZ4kKQ@vger.kernel.org, AJvYcCWop0TE7tfYk3D2w4uG11pUBR53LE58bsYWDydOd6QtaEpZq5FmIqcbJGKo5/zYs7vvJyXSWeI0fwKj@vger.kernel.org, AJvYcCXQwn7K/05ur7Ie2BijlkPJXn4NLNcLGnskcmMSNIU5Gv6Xt5IpgpX0LCn7Dp+5/hZLyvnxhngztJG3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SnYLSpRVZ8FmVWXxOn6zwtpZ02fYrMgvI812IU5bt7gyX9v0
	JL45dIAAJ0Zq/DxhkV9OhxExnbHimqQZ1MTv0DkAg0RMf7ltEfeN
X-Gm-Gg: ASbGncups8x2q8pFmnU/Y12/tx2oQH7Tbx6ucOyLl3jmLutw1hcUYUXZZHpAj8MCJTd
	YCX3vQBa++4RrW8LwGLVV4EhMTfwsmj9Lhv0mmQn2Y9zdH02Py7ZMz7YrhIlL/Q7AS47bjJNhRC
	QJgBCyRg8m0xbpFOcKEB8RLCSqDgKn3UyVAuFtz8EQlzgxsxaT59T1/QYyFCuQV2IgqEXDEhSzg
	x6SLSJYqX00ncNYNeTP82+A5+JNX38qGej72W0dc2pGjtsMU9FqRywWslx/iQ5sXeBRprsaIPJT
	2hJUI+RAICI51p6w0/NJZddoI2Sf4B/DkMR7t39LhevnaceVXkFAiwWu0g==
X-Google-Smtp-Source: AGHT+IHDsW3Xj/DETZDc6NPh5e45wPtsrGpGMwUb/3q7UOPQpO42p7qg2sNikNlkW+FcjO3beSLwGw==
X-Received: by 2002:a17:902:ea05:b0:215:9eac:1857 with SMTP id d9443c01a7336-2218c3d080amr103699315ad.5.1740128984756;
        Fri, 21 Feb 2025 01:09:44 -0800 (PST)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5367e8csm133593115ad.67.2025.02.21.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:09:44 -0800 (PST)
From: Eason Yang <j2anfernee@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	andriy.shevchenko@linux.intel.com,
	gstols@baylibre.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	alisadariana@gmail.com,
	joao.goncalves@toradex.com,
	thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Date: Fri, 21 Feb 2025 17:09:17 +0800
Message-Id: <20250221090918.1487689-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221090918.1487689-1-j2anfernee@gmail.com>
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
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
 .../bindings/iio/adc/nuvoton,nct7201.yaml     | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
new file mode 100644
index 000000000000..830c37fd9f22
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
@@ -0,0 +1,57 @@
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
+  The NCT7201/NCT7202 is a Nuvoton Hardware Monitor IC, contains up to 12 voltage
+  monitoring channels, with SMBus interface, and up to 4 sets SMBus address
+  selection by ADDR connection. It also provides ALERT# signal for event
+  notification and reset input RSTIN# to recover it from a fault condition.
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
+            interrupt-parent = <&gpio3>;
+            interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3864d473f52f..fdc4aa5c7eff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2831,6 +2831,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1



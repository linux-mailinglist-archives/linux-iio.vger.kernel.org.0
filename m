Return-Path: <linux-iio+bounces-13806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C79FC8BB
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 06:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042867A149E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93244170A30;
	Thu, 26 Dec 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJOZJWtP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAB15CD79;
	Thu, 26 Dec 2024 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735192414; cv=none; b=OJiz5LIa2vnLkEEN3uIeiTHwFnbgRuyVnCx+fsc+2kQOsPaO5DEYRyTnj9PV/vpNWmEkleiVcHvD2r1hAYsrr15T7RiOduuhwtoU418GcfmKaDPdgkMZQOtafRzDkId9hdFHiCRn2ATRrYeyCO9Wrq0fuIA83HYSbeIDJwIxovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735192414; c=relaxed/simple;
	bh=q8OU+QqWPzNWyA7thmL2MFWE1CZWMYCdu7Dkv1/m07I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pD0ddkgk6S/MbFP0AAfWeBTAx9px1V3OnZLxNGLTO+/SKYifQqjoWIl67QeKwnYRZOldBUv1LlLA0SaGp+lX2gJSLm1i3Dp5CVImPcoyelNX/jFkxSatvJi9myxwSRgAjlf33fNyCkcJ0cHvGREBmAIK7OewkoLc2RwrOa+o+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJOZJWtP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216426b0865so68293275ad.0;
        Wed, 25 Dec 2024 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735192412; x=1735797212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOo9O7i3pifrDkAxCCGrjFOGpEifuhFneEpCHK2pNtI=;
        b=aJOZJWtPIu/C34wNVIuI+1aoPRejyQLAj8P8g7zDsc6ATwl+MOOEJ1Cxujz0Bxp3kn
         dYtF8xKUnKZzq5ejAAiz0lBJ+0CyHCzniGPxv5KExHw4Hbg67nLbCu1jQ7jCag42AR+3
         UEYFEkNLwLdMoUxogV7cpNpDmYiudd5xxM28OBabQc0COcx4kaUc62bYTYjS/byxa4QP
         K1Zw+SwPyVyEqEtu9QpmWsvD7Ir044RLUiw/eAklZ6u+NAtY1DIYg1d4+9jgPxjk6s34
         850l1RbeycNnft8vb1Ncy386CGt11PoKEW6KnK6sJT3OZLP3KexqDstZZUB4nUBZL5wD
         vAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735192412; x=1735797212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOo9O7i3pifrDkAxCCGrjFOGpEifuhFneEpCHK2pNtI=;
        b=JG0gMx6PU7wdtT0IsYXe22hSD6IMuL3MtXNU8sUtVHDkbIp2E4ACDOH3OPp7IK07pC
         jpM0N6v6yLSt6O2puqGTpwr6yVaMOO/lJ3n/lu/lbZXfQpc9Fxqis8PJ2oa9ufxMMzIF
         6skySfNFfwH7MxfdVKdSXf5qodAu0K6CnWlKVpjqh2/klzzzZLTHthncGLf+NCznwM3R
         g7WjbMj/+Bz8eo1nDMv16OkmirSh2V0zkECGz8Y/kFnFp3dbA9ZaE6Hcp/LXNWo75vWL
         WdPUAmKRrpiG1IWqoftuYZ+BYKiPjVAW1V3vRqrU4jFU9bD2SadDvS/zQgFLKC1RGbEs
         VaUg==
X-Forwarded-Encrypted: i=1; AJvYcCUVTg3tluN8+QjJ1a6CfAyyDnCQ+HRPsZ0Ym0fm2nqgx/bZKcQ7Yj4bvpn1ZBil9/DNPU6DnC7pddONkXOp@vger.kernel.org, AJvYcCV2izuOAvvNpw4dnBftSGaMFKMPOjTj/yUF8aqh8hyqf+or5XncV+fpEtQBJCErxOxn9DRaergthCq9@vger.kernel.org, AJvYcCXcMUmpdjsKI1+K88jrIzMiOsKZX4wauFdzPgIjuWxnuCLXH+E9qrg1LaY2kXNPcU7cbocaRkMoO2x/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9byKaH9GMjpkWYsh8ynUrHWpSxKzOLZjZ/ygTFpAAF1H/+Ml4
	IGVYavBZHoT5RBx5eyqnuF7DCpDiPAVbfqFCWJpKnhB24X1SCHm4
X-Gm-Gg: ASbGncugDvpeAM0CfJXcUm8wPhktMW+k3D3hPLfeoRd6Onqj3M+OWfcT33bopQveSjX
	DuCGJJCZ2tTeRqk5p2+TPU5gUqKdFe5+/TYYxMzUp6QTqmIo+UYrm6FuLdxTT3ExYTV5ygJavHv
	bV9cYysNYte5mhBf0A6y8jcrST2Ym2SGGZOHYWZmGmrLyc73yJtEbGR4NYtN4/UBDFXBzYTWsDp
	rO/vm+mbwRtG8JrMw2iji9fSL3Ohr6RAoDjuolimbCCT5AOSettxq8+7FxmpxFCu2k+AgAldfMb
	req6a4/TDkPIMFBl6AGbsQ==
X-Google-Smtp-Source: AGHT+IGm/BBsP03b1aKdoWcgXBsxuBVem3iqHVaWYoRFxJS7sp6Tcctf76oFtBfBvIGSm1EhK+Rotw==
X-Received: by 2002:a17:902:ccc3:b0:208:d856:dbb7 with SMTP id d9443c01a7336-219e6f14586mr317900465ad.39.1735192412078;
        Wed, 25 Dec 2024 21:53:32 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96312asm112679455ad.21.2024.12.25.21.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 21:53:31 -0800 (PST)
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
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add binding for Nuvoton NCT720x ADCs
Date: Thu, 26 Dec 2024 13:53:12 +0800
Message-Id: <20241226055313.2841977-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226055313.2841977-1-j2anfernee@gmail.com>
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a binding specification for the Nuvoton NCT7201/NCT7202

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
---
 .../bindings/iio/adc/nuvoton,nct7201.yaml     | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
new file mode 100644
index 000000000000..08b52258e4af
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
@@ -0,0 +1,49 @@
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
+   Family of ADCs with i2c interface.
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
+    description:
+      Reset pin for the device.
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
+        adc@1d {
+            compatible = "nuvoton,nct7202";
+            reg = <0x1d>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a..9c5328cbef17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2792,6 +2792,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1



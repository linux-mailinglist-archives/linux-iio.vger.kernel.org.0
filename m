Return-Path: <linux-iio+bounces-11932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516639BDD1B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 03:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754071C231C0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC518FDAF;
	Wed,  6 Nov 2024 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxx+cRJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F321106;
	Wed,  6 Nov 2024 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860783; cv=none; b=RcIBWHxsrsFRQWpbz58NGM7AYHC+Ol2mJ0+Wh8M+jACD9GKfS9odj1DDFl43zO1DXIBuUi8ssWN3o2bOGtyIDCG3NY2uHjf+sUYcLIJ7o57M5YMORpekUM64bF0LFA54MGu71hH+vS/pTb8dSNhpdgFspbcj0ebpy8cxK37aL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860783; c=relaxed/simple;
	bh=tnAgrlycxy3SRf0vZaLpfq3088NYwRLXka7ghXj9G68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4T81moyLwFdfvHI+XWTcM6i8t0YwEd6J7tbhZPDFj+dG+qbdLNXAtmSgA3YV3Y3B8E1nRnYVokobdobZIsKDbyXhiuQLNnNFAui7r1OPQANA95wB/nulhsD0uN/TVsLZARLAV4QAiXZjOnW9z76McNUp+kb8kmLYDIfZwrEyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxx+cRJk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720be27db27so5013748b3a.2;
        Tue, 05 Nov 2024 18:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730860781; x=1731465581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHS3Y8b/Fo+tfKbUb9aeyhX4djXRjn2LjQvdEaB1Y7E=;
        b=gxx+cRJk7vu/n+jJOiCb3xT/FBmIIYKo57mOWBfdrRJoZpQZDEAgyXnTtl9UgilPQe
         Bv5TgaOXrPaeAjqZU2tOQI+Chi5nloicHESudSQR8jCKionamvxyIfPTEWMg4BnTw8OP
         KugFAEtJgqtZ2sPhUJfhZ8rc43maGcmv0kJg3jYnrZioSPv2lhti2O/YU3kzaUFy8KC/
         0DYVuLXEnIR7hpUjKvPZzEp9UdajOvQmbp/m+gq91lGSWC8S4nm2+qYr7DyIqUDsNRp8
         NepSDklF87EkjGXxQ2gdxXC4+kFdkMt94Kf+UNdO7p2c9yDOR2F8PkIQSEYRNGR0/TDa
         DDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860781; x=1731465581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHS3Y8b/Fo+tfKbUb9aeyhX4djXRjn2LjQvdEaB1Y7E=;
        b=QpYDiWwUpxKWTeZBegV5VYQMu0HYUY1nUWMcSkV2yIDZof3SKD6wd47d1851Q8Ig6v
         TRb+5AIbI7Ck7hSM/qK2tROnJ0ol3rLsJ5aSTmGu96s9q9vU/RiwO96fsNDQViX9cqmh
         oLnLoR0+jHyAuryDPqZixO30AUpbwO1LkZDDiMkMCAUqmFSOn+2/mIONhz59H1wbmL4N
         Hryt2P2WxazL+CaY787OkhtuZ1VJXhcbh7vshlj9sUaFMJAoBsvgCnzZskbR12EQ61DR
         2AbCj6Sfb48jPt8iyzmh/ldNkMtgdaHkg/uPWTBeIPskNA+w4KOJ4/B8gk9thXQgHmhH
         dedg==
X-Forwarded-Encrypted: i=1; AJvYcCUWT+sJke5RIGjIBy3By/ai2QyiEJuDf3r7a/V9ibE80BWpx+HzKptcPPlYe9D5E1i4fDhVds13A95t26OJ@vger.kernel.org, AJvYcCX0SVLO7BPjFsgAu8q0vQv/F6/ydArQIl2MCf2RADTzzCWkX36ERAETpFHafe/F6NcRKBa5lKhJCodT@vger.kernel.org, AJvYcCXYngRr2nZuHwFwTo0oBkjFvWpk50GfnHB4U0VeUP9kmWEZQu4YPNDaDcN8QRZ6A44uyFmc79BF28Br@vger.kernel.org
X-Gm-Message-State: AOJu0YzNj3kc33Pd+E0sdQsC+QOz2qhWM+rjp17pzJJw8suVotlZ+5fm
	hsf40RjedYQtpFwrOtiuLymzLM1jvxaryUaeLQsXSV69saiAbMyc
X-Google-Smtp-Source: AGHT+IHwEasur5W2BzFXhkyHmzfpBWvqNKBDJ7DTJOZ+oe/ng648CAcTEkZDXo/hKeBLtP6R2cO3Vw==
X-Received: by 2002:a05:6a00:4644:b0:71e:7636:3323 with SMTP id d2e1a72fcca58-720ab3babdemr33084062b3a.7.1730860780789;
        Tue, 05 Nov 2024 18:39:40 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c39acsm10382484b3a.137.2024.11.05.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:39:40 -0800 (PST)
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
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	joao.goncalves@toradex.com,
	marius.cristea@microchip.com,
	mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton NCT720x ADCs
Date: Wed,  6 Nov 2024 10:39:15 +0800
Message-Id: <20241106023916.440767-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106023916.440767-1-j2anfernee@gmail.com>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a binding specification for the Nuvoton NCT7201/NCT7202
family of ADCs.

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
---
 .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
new file mode 100644
index 000000000000..3052039af10e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton nct7202 and similar ADCs
+
+maintainers:
+  - Eason Yang <yhyang2@nuvoton.com>
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
+  read-vin-data-size:
+    description: number of data bits per read vin
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16]
+
+required:
+  - compatible
+  - reg
+  - read-vin-data-size
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nct7202@1d {
+            compatible = "nuvoton,nct7202";
+            reg = <0x1d>;
+            read-vin-data-size = <8>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 91d0609db61b..68570c58e7aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2746,6 +2746,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1



Return-Path: <linux-iio+bounces-26475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D550DC87EAF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 04:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32A4535403B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9D30C629;
	Wed, 26 Nov 2025 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgvjoXGp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A41A9F9F
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127093; cv=none; b=th5AFtH4Peu2z4yu65x+oZEFYDcq4DzjDekgzhSsZ2LaplrHl2taZFBzYUKpWbj+6OgiFa6eM9sKYCRerrkd2hTRyLQmt2E9j/Zdg/8OdzBmFDfzozFiiIKuV9DAE/06urUl85xtaTU3GsqrCimyvUXxaqJ0e4hqIaOnZLVii4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127093; c=relaxed/simple;
	bh=mFGAf05gZ2JpMz8sAbnQz9cmri70ARBRr6x45PxpHvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGeati4Y2KS1R2za0EIaxfeLGc3qRJcw6H/XWVACzINHFHYq+OrjVJ2908rnla4qMA2EY2Snkn5l7ucQ7QOhN5NCNfbPcmM14MA2cLJwCSJOj5Ix+ZUC11YRK27y9bIkr+5ppBYaVML92/AY3kOVMzIfIu91DM2Z5Y8uAz8LANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgvjoXGp; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so4192588a91.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 19:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127091; x=1764731891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ7IKj64Qr0OZ0iruuUqcxkX7/QCGnNK4nFSticAN6I=;
        b=dgvjoXGpLfKN29V0UYDxR8nsUL7kliwfTG4HubLHnSVwqsEqa06rp9ASIu8wuCgPvt
         KEGNxsmEqsm+qAvZAu/lim0+jg4J/bX4ElYLsoo3OgvousPzPhN80DE2g03pa3FcAJoX
         jaraBmJ853zJ3hqq4kGYIHONm6bTc4sMfPBiNoYtnjx9AUFWzKU3vibsVjKDMwniJ1iX
         w8/o/iS6gscMy2RY2Y83k9j1RQG9LYC9sD1FeUzuKu2l/+yZdWZqOEt1TnYQQ/brkpjS
         YElZzmaT0YUV9jlvspBaDROSzr0Ufa/0Fzr/j/xiGRQUNJA/UVWEKgTSdcWcRnCdL199
         XDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127091; x=1764731891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ7IKj64Qr0OZ0iruuUqcxkX7/QCGnNK4nFSticAN6I=;
        b=aQyxPOS4XDjER3GUe5N0TLUfLLOdOK2CTLV9EELrn8ocgsv+ECnE1RCYkZZjgudoQ2
         V5pcUoYRUzCtM3bXqO/aLIpb3sePeROBHgpoGhCssS0z+0ptiONAOK+9hFzal2Iem0js
         2VOxJ99Mn2gwZOu7Bsr0SeDcSUqho7oqKwUD1Dug5TBui92e2+W1+glYczF1/VI5M7Jd
         QDCjliE+U05X9LeMBCpA9DhR8fZk6OlmTF4LDqSZNEpgnR5vVruSjbmXIeeHRZ3cAfxd
         LLj2xbfYvmDzm78bCPS+IW+M9bjyPxieTww39XONskGMbD/P1ZOMIYbWHYQ2mnBb6BiB
         NSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgBj+6zFkNswmRj6cki7hNnD73q7ILxa9yL+RPBqRfqED75ZMNroFLMB034BGkgoSTAMSHLJcQIv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjXlBeZUC3USm+bgP9dj5syX4dKLG3ZKBOuLODzbbDhfcbGzr
	u5gDsf4kIMy6PCwYwexeDeKKKeUahG35WqWWEWd2AaU+cXVarJvM1wIH
X-Gm-Gg: ASbGnctSXfEkH41uvJHNrKMi25JggxUN3blsii5+tI1pH7Q/ZOV9X5w0U6iG2mMQ40E
	ZtTiRT1PhNgo1uGg+bt0j1cQ6/3OE7Bh66kYgEdZn3E+zWpcURbCNLHOm8ah1+3loteGf0qqMGL
	fX9bpLAvj8kuztmgRx1yjDHeDdG7EaWXeDwHAzjkp8mwTpXzdX+kDR/j/oeV5L245BhOPxX2kBH
	QfCqq0B4PVOv182P031YKxzo3ZlmxMm2rkoo8iOCseyTT1gZrHXG1KZQTNc5fxnqnfL7DYvV/bf
	iFIs1OfZo1QThIAKLGdv5LFhNbhaNTKcDkpJhNclu/T29/mHwbd1C0lHqFUIPpONMCVXtSpdGWx
	yH2q3777lRBI28g3VPRQshTNU49LcutXmZtnp1RpiJ6GAtAgpjFGnHw1dJR0qbDnfvW+RFsLNmU
	Dy7Ocy5sSHck1fzhyAascXbcbk
X-Google-Smtp-Source: AGHT+IGa1FJoKpUswR5UD+dOiC7H4W7Ds1tZvtbxBdOuvihTQsXPDXj1wGT1F6VG0QJz4aBP57V84A==
X-Received: by 2002:a17:90b:384c:b0:33e:2934:6e11 with SMTP id 98e67ed59e1d1-3475ebf9acamr4279517a91.11.1764127090901;
        Tue, 25 Nov 2025 19:18:10 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm17935713a12.26.2025.11.25.19.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:18:10 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: proximity: Add YAML binding for RFD77402 ToF sensor
Date: Wed, 26 Nov 2025 08:44:38 +0530
Message-ID: <20251126031440.30065-2-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126031440.30065-1-raskar.shree97@gmail.com>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RFD77402 driver has existed without a formal device tree binding
description. With the recent addition of Device Tree support and
interrupt handling in the driver, it is now necessary to document
the DT properties used for configuring the device.

Since the binding introduces the compatible string "rfdigital,rfd77402",
the "rfdigital" vendor prefix is also added to vendor-prefixes.yaml.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 .../iio/proximity/rfdigital,rfd77402.yaml     | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
new file mode 100644
index 000000000000..93deaa4e8b7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/rfdigital,rfd77402.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RF Digital RFD77402 ToF sensor
+
+maintainers:
+  - Shrikant Raskar <raskar.shree97@gmail.com>
+
+description: |
+  The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
+  sensor providing up to 200 mm range measurement over an I2C interface.
+
+properties:
+  compatible:
+    const: rfdigital,rfd77402
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Generated by the device to announce that a new
+      measurement data is ready in result register.
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator providing I/O interface voltage
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
+
+        proximity@4c {
+            compatible = "rfdigital,rfd77402";
+            reg = <0x4c>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..a2e113e29e37 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1341,6 +1341,8 @@ patternProperties:
     description: Revolution Robotics, Inc. (Revotics)
   "^rex,.*":
     description: iMX6 Rex Project
+  "^rfdigital,.*":
+    description: RF Digital Corporation
   "^richtek,.*":
     description: Richtek Technology Corporation
   "^ricoh,.*":
-- 
2.43.0



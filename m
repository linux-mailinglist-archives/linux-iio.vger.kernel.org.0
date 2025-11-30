Return-Path: <linux-iio+bounces-26568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26436C951A0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62613A27B5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D07283FC9;
	Sun, 30 Nov 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0MONkbB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC827B358
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764517062; cv=none; b=GcPL6BWzMj12rcT9G9UG9ybMg5fSFVYSBgfbmAY9PsHONU8VXcJJE/fhD+4GCj42aLG4pqUD2Xn19iiDH6szO0mR7XORa4EatV5WoM+EcPbVP3ME7TvhuoCIHwoFP/g7WJm6MV+TiGqyKgmg2VP3fKrrZWsFnGlhwXC8uHooNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764517062; c=relaxed/simple;
	bh=G0YIGRsDpPedWL2cCWGmsi9Q3PeTt4HNQgJGL63479s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6taoA0U4mIk5QQZKLjPlyIv250FgB8Y5G47URS1oPG0ndb9CdoeQFusyPh81xgbrryV3mW74yIJeXImQyLt8dTVU1ig9KnIJ9bb+lwuPA+vnVZ9D9v1TKTv6vEXe8RxKt2NU5GkfkDdY/b5GSonRr4TSqlaj0oa00VHBQi8jk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0MONkbB; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so2598273a91.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764517059; x=1765121859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytEQ00i/TMHvBavCd0XAKg4W0iSw68Wk4M6ee2yW4Ug=;
        b=Q0MONkbBcL/qhgiYMy2yuGJ8BxO+yOGbeftSwMYTZzuH+rA/VAwr+vtTD7QXSnOdbH
         4cyUQYxHRQB4d2/V7SAB5Jq1ZEiSZVD5Iyu2/0YuMaF6TrVu6EdMejKST5CDOVKFPMm5
         q27xRCW6pHsLq3nARd9t82OeieoWiyG9C3Wr95tyrPEXhu2e9PM45boe5N3tVstuWh9x
         UtqY6Ph836MDP4RQ+UhqG/wtalLQ9qS2rlML0CjjOkTS0LNHcTiDb96Mu1ONUDkaBWWI
         jo5BPAbf0t8YDaaMOjm2PCjM5X5/Yy1pUKdK6/aYrZ6VBV7WmNbA8zV5FZYwgUfBp4sG
         8aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764517059; x=1765121859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytEQ00i/TMHvBavCd0XAKg4W0iSw68Wk4M6ee2yW4Ug=;
        b=qp14mf3sZCrmGOvZgTt20KbsUFPssfnwMKdEUZdopPO/VB+LH4W7YFUpXJxLOVpLU6
         FhtRrRB7ZdkY5RocyEpBoQ9yPbzLWRdlsHRizKNm7/v/rv8TM7Abm1LicxliwXibE+n4
         hSN5Qe2ZOgjxQ9beS+CXr2NO/X0PEuCrGUOPvRxAqj+TT3UvIgtIU1/kBG2FGsQFWee3
         tqj03KnrF0MV6zUssCRn/VIV+mhkGvJ0Zc2uzheCwSNpO0ATOrf8Ex5aERW6SpQfv54B
         0l7ASC2VyOtgfzn+pcl+MN4gK1C2MpQgwCEox20a7ZIxJ631FoiEthEUyVbah3fRFjUM
         8cBA==
X-Forwarded-Encrypted: i=1; AJvYcCVGjSL8llSoZ82LrTNgEa2ymiICm7tTttiWT8lwE1s5O8Dgmr312t7gERq5kWmf6mzcmq6Br9so3ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFilWaNV3QVRVmoY08F3yA9FAWNrBf8GOnkkM2ML1ZUKP9PaW
	ixCkSjJcY8b04mTG5Nv94TR9mih24oqv53/SdfrDbePd41QP4BwW52sV
X-Gm-Gg: ASbGnctpWlxza3R2X9E10p5pYzikSFkDn8IkH9uyfLPWEfFjWqirUIJfxovxsXsCqYH
	lE2wuL/fbr2U77EIaqqzyBa0sWYP84OFZeA9w7/hqrbUiCN8zDJJrvGyU575f+LI6i2DgtGdmIg
	g6L+FiTptEDb0zDMltc/75wVaibYLFqJmFy5IWWX89dHZ1Huww9e+xLiktFGnS5DagJBqXp8bkE
	wmZsnYriXzPDKBQ09RuqDo9sK45nJ1kCFTXkJFDeDUirFc9MeSaNpfxcaDfzswgCoCq19Pbahhn
	svh38JhHPfh8bZpTVfE6meDLMuv2nur/fKyQ4wjjeyQk2j0yIgOE5T+4vOUIG8P7kV7rQibT/Pu
	4Z+nYuyV9GOjBtvIRzk4RfPYL7iXeU9cFUSbGd+2yPFrx7DGLWR3lE06CuRjrXpOvrXhEgoPCJ1
	JDLvcrRFQhdAkl/A==
X-Google-Smtp-Source: AGHT+IGYZ2XIEIFkqAFPXdgR+1MSGZPaK8va2ILn3afSqIBRdFR82Kwd5Lp/WzIk/98JbY976CizqA==
X-Received: by 2002:a17:90b:3b48:b0:341:c964:125b with SMTP id 98e67ed59e1d1-34733f4ab3fmr37554583a91.31.1764517058924;
        Sun, 30 Nov 2025 07:37:38 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm6903483a91.1.2025.11.30.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:37:38 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
Date: Sun, 30 Nov 2025 21:07:09 +0530
Message-ID: <20251130153712.6792-2-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130153712.6792-1-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
sensor that provides absolute and highly accurate distance measurements
from 100 mm up to 2000 mm over an I²C interface. It includes an optional
interrupt pin that signals when new measurement data is ready.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Changelog:
Changes since v1:
- Fix patch heading
- Fix commit message
- Remove '|' from description
- Update interrupt description
- Add 'vdd-supply' to required
- Add 'vdd-supply' to example

Link to v1:https://lore.kernel.org/all/20251126031440.30065-2-raskar.shree97@gmail.com/
---
 .../iio/proximity/rfdigital,rfd77402.yaml     | 53 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
new file mode 100644
index 000000000000..1ef6326b209e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
@@ -0,0 +1,53 @@
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
+description:
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
+    description:
+      Interrupt asserted when a new distance measurement is available.
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
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
+            vdd-supply = <&vdd_3v3>;
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



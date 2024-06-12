Return-Path: <linux-iio+bounces-6204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166EB905488
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CFF2894AF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2617F514;
	Wed, 12 Jun 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NixvRDtd"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA217E465;
	Wed, 12 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200594; cv=none; b=BGG8gTkRZm6Ie0D3wNyFKMFLqkMmalloVE6KqSq4pBpKJYupsUHQK0OlFgYgUaCTcLOzoaWGZf60gVDDUKEsYKopivJ1l1Z40r2Qtg1FKPhijaWbuOScWo8PjxkWstpV+mKKBVszbP1A5TosLUKex/7ZLxktHbWazUh0cO0jwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200594; c=relaxed/simple;
	bh=i1RSskPrqQ5S+ibCRVmYVEjX0QH4mqlY7e7eJFiuNgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWYoKt9I68dn8Z+VGlH12p/ys4vZ04SJC4LcPFIuui9P7gkjjRmiwfxRerp1z1TNOsPQZzb940HGs7IBi5Eh+GVnCqfzfZ5wr1g4KpwrdLYTym258LgMASQfu6hDRP7ep2tuJC42RKMUxc2/tat/q0NEaAzCaEf5H5YDwVb1D4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NixvRDtd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtdcm064415;
	Wed, 12 Jun 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718200539;
	bh=126ZtFYaMHYmbGdUfsKX3JgoUwUCIZwyFhQhtdCdOW8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NixvRDtdAnsPdSia9V0RJhz64NAwHmroWvbcvCokI9uSb7es0qPq9bJCy52qajgrW
	 HT18ngXCAcFKleB2itwfvfFGF3ugVWdorobqX97XZkbm9F5D0ZD0x/BKTiVuNZVxnm
	 zIz0W2E+K2Tf4MiKIoCD0d0huOwQtfKXWANKp1Qg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDtdY4112378
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:55:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:55:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:55:39 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtclQ092708;
	Wed, 12 Jun 2024 08:55:38 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <wbg@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        David
 Lechner <david@lechnology.com>
Subject: [PATCH v5 1/8] dt-bindings: counter: Add new ti,am62-eqep compatible
Date: Wed, 12 Jun 2024 08:55:31 -0500
Message-ID: <20240612135538.2447938-2-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612135538.2447938-1-jm@ti.com>
References: <20240612135538.2447938-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add new compatible ti,am62-eqep for TI K3 devices. If a device
uses this compatible, require power-domains property.

Since there is only one functional and interface clock for eqep,
clock-names is not really required, so removed from required
section, make it optional for ti,am3352-eqep compatible, and
update the example.

The clock-name also changed for TI K3 SoCs so do not allow
clock-names property for the new compatible.

Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v4:
- Drop the new example from binding
---
 .../devicetree/bindings/counter/ti-eqep.yaml  | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
index 85f1ff83afe72..c882ab5fcf1f2 100644
--- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
+++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: ti,am3352-eqep
+    enum:
+      - ti,am3352-eqep
+      - ti,am62-eqep
 
   reg:
     maxItems: 1
@@ -21,19 +23,35 @@ properties:
     maxItems: 1
 
   clocks:
-    description: The clock that determines the SYSCLKOUT rate for the eQEP
-      peripheral.
+    description: The functional and interface clock that determines the clock
+      rate for the eQEP peripheral.
     maxItems: 1
 
   clock-names:
     const: sysclkout
 
+  power-domains:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am62-eqep
+    then:
+      properties:
+        clock-names: false
+
+      required:
+        - power-domains
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
-  - clock-names
 
 additionalProperties: false
 
@@ -43,7 +61,6 @@ examples:
         compatible = "ti,am3352-eqep";
         reg = <0x180 0x80>;
         clocks = <&l4ls_gclk>;
-        clock-names = "sysclkout";
         interrupts = <79>;
     };
 
-- 
2.45.1



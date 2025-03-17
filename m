Return-Path: <linux-iio+bounces-16939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1CA646A1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8753D3AFCF6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E25221714;
	Mon, 17 Mar 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nkewxkqN"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC6221723;
	Mon, 17 Mar 2025 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202530; cv=none; b=SUPLheFSsuZJfBNds/biOUvU3gCoazUV35mQjE4aDGKrGjD5d4ZD8WQKl9hIJmi5V+cLpwKjjKopP2tt5onWJ4OqkSVTBY4YUhrkQ51wLiympczr6YbV5Ah/hcn07tvzzZVotnhU5l4GjYjJZIuzRmU+BcMYoj/drEuHkc3J7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202530; c=relaxed/simple;
	bh=2IdpvPNjQNwnZuHOi7OKL6lEw24s0uLrzfxo6z4OLH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcBVCtZjn+KmJeVdwr5rgB5nZKTlk53JGUWssG4CSQtiaHrkZF5svFlglHHQYJL3Zvgmb9iNOUeYfvo8BQEM/mTzK2X1bstYW9V1AZdbBl2eQEVMrYN5r6e33Ln3YBhwQBtz7+FE1VBepmHN07ejF7mXYZa4mNk/2ZwqmIKrJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nkewxkqN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742202528; x=1773738528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2IdpvPNjQNwnZuHOi7OKL6lEw24s0uLrzfxo6z4OLH0=;
  b=nkewxkqNMHHzjb0MUwJwzqs08Tgp+U0hLi/038wqkVqpktQpdAfdV2Bm
   Bqgc+6a4XnT4h1E/N2fmH+9uyO+y5dfJu1hgyXEsUS7E33q8kYgLwozhN
   E5NicXtqRqLSCGLrq/u4jFV+2XwglDl+MnnqKI8q5ZkDDDINyyk9/CZ4S
   bhW1xrD7YEeJ02WlxM9QoTb99nCFgeQg8BbhN8NiKtygc8VQn+LJt7QWq
   349PBdZIDCEAuHAZgkccQ9cxFPDuwYv/34ghA2Gnm+RcYqU5+eJM907su
   SkoIhE51nuQlgEsjr7VUVO6D4yJYmnMgq0JoZnC/z/THdNH8+KZJJshRp
   A==;
X-CSE-ConnectionGUID: cdV/yO62T2+o2ggmCIuq7A==
X-CSE-MsgGUID: Uxqxpf4mThqr3LHhvQyatw==
X-IronPort-AV: E=Sophos;i="6.14,253,1736838000"; 
   d="scan'208";a="43507979"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2025 02:08:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 02:08:15 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 17 Mar 2025 02:08:12 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <oskar.andero@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: adding support for PAC194X
Date: Mon, 17 Mar 2025 11:08:02 +0200
Message-ID: <20250317090803.30003-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317090803.30003-1-marius.cristea@microchip.com>
References: <20250317090803.30003-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for Microchip PAC194X and
PAC195X series of Power Monitors with Accumulator.
The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
32V Full-Scale Range.
There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices are
for high-side current sensing and the PAC194X/5X-2 devices are for
low-side current sensing or floating VBUS applications.
The PAC194X/5X-1 is named shortly PAC194X/5X.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1944.yaml   | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
new file mode 100644
index 000000000000..1997e889e3f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
@@ -0,0 +1,195 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1944.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1944 and PAC1954 Power Monitors with Accumulator
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with
+  Accumulator. The datasheet for PAC1941-1, PAC1941-1, PAC1942-1, PAC1942-2,
+  PAC1943-1 and PAC1944-1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
+  The datasheet for PAC1951-1, PAC1951-1, PAC1952-1, PAC1952-2, PAC1953-1 and
+  PAC1954-1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1941
+      - microchip,pac19412
+      - microchip,pac1942
+      - microchip,pac19422
+      - microchip,pac1943
+      - microchip,pac1944
+      - microchip,pac1951
+      - microchip,pac19512
+      - microchip,pac1952
+      - microchip,pac19522
+      - microchip,pac1953
+      - microchip,pac1954
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    maxItems: 2
+    items:
+      enum:
+        - alert1
+        - alert2
+
+patternProperties:
+  "^channel@[1-4]+$":
+    type: object
+    $ref: adc.yaml
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description:
+          Value in micro Ohms of the shunt resistor connected between
+          the SENSE+ and SENSE- inputs, across which the current is measured.
+          Value is needed to compute the scaling of the measured current.
+
+      microchip,vbus-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          In order to increase measurement resolution and keeping the same
+          number the of bits the device has a configurable VBUS full range
+          scale (FSR). The range should be set by hardware design and it should
+          not be changed during runtime. The bipolar capability for VBUS enables
+          accurate offset measurement and correction.
+          The VBUS could be configured into the following full scale range
+            <0>  -  VBUS has unipolar +32V to 0V FSR (default) for PAC195X
+                    or +9V to 0V (default) for PAC194X
+            <1>  -  VBUS has bipolar +32V to -32V FSR for PAC195X
+                    or +9V to -9V for PAC194X. The actual range is limited to
+                    about -200 mV due to the impact of the ESD structures.
+            <2>  -  VBUS has bipolar +16V to -16V FSR for PAC195X
+                    or +4.5V to -4.5V for PAC194X. The actual range is limited
+                    to about -200 mV due to the impact of the ESD structures.
+        maximum: 2
+
+      microchip,vsense-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          In order to decrease the power dissipation on the shunt resistor and
+          in the same time to increase measurement resolution by keeping the
+          same number the of bits the device has a configurable VSENSE full
+          range scale (FSR). The range should be set by hardware design and it
+          should not be changed during runtime. 
+          The VSENSE could be configured into the following full scale range
+            <0>  -  VSENSE has unipolar +100 mV to 0V FSR (default)
+            <1>  -  VSENSE has bipolar +100 mV to -100 mV FSR
+            <2>  -  VSENSE has bipolar +50 mV to -50 mV FSR
+        maximum: 2
+
+      microchip,accumulation-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The Hardware Accumulator may be used to accumulate VPOWER, VSENSE or
+          VBUS values for any channel. By setting the accumulator for a channel
+          to accumulate the VPOWER values gives a measure of accumulated power
+          into a time period, which is equivalent to energy. Setting the
+          accumulator for a channel to accumulate VSENSE values gives a measure
+          of accumulated current, which is equivalent to charge. This allows the
+          accumulator to be used as a coulomb counter. For either VSENSE or
+          VBUS, many samples may be accumulated on chip and the result collected
+          by the host and divided by the accumulator counter count value to
+          yield an average value with a very long integration time to reduce
+          noise. This feature is also very useful for system calibration,
+          allowing many averages to be accumulated for fast averaging/noise
+          reduction.
+          This functionality needs to be setup once and must not be changed
+          during the runtime, just in case the user wants to measure the charge
+          or the energy consumed from board power up till the user has control
+          or during a reboot of the system.          
+          The Hardware Accumulator could be configured to accumulate
+          VPOWER, VSENSE or VBUS
+            <0>  -  Accumulator accumulates VPOWER (default)
+            <1>  -  Accumulator accumulates VSENSE
+            <2>  -  Accumulator accumulates VBUS
+        maximum: 2
+
+    required:
+      - reg
+      - shunt-resistor-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@10 {
+            compatible = "microchip,pac1954";
+            reg = <0x10>;
+            vdd-supply = <&vdd>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <24900>;
+                label = "CPU";
+                microchip,vbus-mode = <0>;
+                microchip,vsense-mode = <0>;
+                microchip,accumulation-mode = <0>;
+            };
+
+            channel@3 {
+                reg = <0x3>;
+                shunt-resistor-micro-ohms = <75000>;
+                label = "MEM";
+                microchip,vbus-mode = <0>;
+                microchip,vsense-mode = <0>;
+                microchip,accumulation-mode = <0>;
+            };
+
+            channel@4 {
+                reg = <0x4>;
+                shunt-resistor-micro-ohms = <100000>;
+                label = "NET";
+                microchip,vbus-mode = <0>;
+                microchip,vsense-mode = <0>;
+                microchip,accumulation-mode = <0>;
+            };
+        };
+    };
+
+...
-- 
2.45.2



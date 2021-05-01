Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B9370863
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhEAScb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 14:32:31 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:34802 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhEASca (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 14:32:30 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2021 14:32:30 EDT
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 8E79B123F6F;
        Sat,  1 May 2021 20:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1619893555;
        bh=qTRWs0MU8ud+smZK2st9yKNYtpQS+ibBbiEpu91vyhc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=S/KvMUUclPHJpP9gDC3IvdRLpYKzo6u+s7ELmD3zxxpzXrBO8ZsSCTJVi3rr+ztYt
         3sT1FDkAqBCQMS8T/31jl2bdFjrwJ43LZl+CSNKEKO1e+mWAVfllI+aJEcfwe6S0MK
         yqRp1uK0TqJeQUk5h0pnbqH/u5TUAXtk9RddoACoc3hTfmYZ5A4NJul2TJPv2KG/FO
         1KzRUe7DtKPMs/0t6LlkbdopDCkOnLV/wQPsU0rGESg1KqC5SN4jnYm85OuaziMOF3
         qg9MY+G9Od9mDev4jU/pbXPJy+w2vBLZOg/52zoFPBWvrBwniI0tjCsQ4HS8MXjmaf
         7ou0kAb3q68lQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AYlxnAuENFIg; Sat,  1 May 2021 20:25:21 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 1388A123F6D;
        Sat,  1 May 2021 20:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1619893521;
        bh=qTRWs0MU8ud+smZK2st9yKNYtpQS+ibBbiEpu91vyhc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kTsILt4NnNwpDBrO+6vK9cMMzhYHYvVoBw9vt+v1BwI4Q3GLxvgK5qW30SkRtqwpR
         LHgcCLG5IJa49X2fqHL6o/Wp48K7oAcLHQHY0P3VYRDrrrsSWzGtADrm6K0BpHVh0j
         XMiQH0sG7012OzXCICMZBR/+cL4502BT4gu6iQ0zlGMUIx6xWwXavgmjVWJoWJ66Za
         4FiqKj0dpXB31zy8ZMi9yNqbC5yGp5gg3RrQGknVGba8LnPY5zwworHsLD5BiCB6D3
         A29TUjgrD/1JJ+mVkv8gawhQqrSS25G4i54hLoS3wGNhqC5XwTF57okXzzRaXkMAYm
         FVwOdbVdhYAPQ==
Date:   Sat, 1 May 2021 18:25:18 +0000
From:   Jozsef Horvath <info@ministro.hu>
To:     Jozsef Horvath <info@ministro.hu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: adc: devicetree bindings for texas
 instruments ads7142 iio driver
Message-ID: <69205d4de46dd21c82b31ca1c35cbf12fbce629b.1619892171.git.info@ministro.hu>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a device tree schema for iio driver for
 Texas Instruments ADS7142 dual-channel, programmable sensor monitor.

Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf

Signed-off-by: Jozsef Horvath <info@ministro.hu>
---
---
 .../bindings/iio/adc/ti,ads7142.yaml          | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
new file mode 100644
index 000000000000..b4e752160156
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/adc/ti,ads7142.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments ADS7142 adc driver device tree bindings
+
+maintainers:
+  - József Horváth <info@ministro.hu>
+
+description: |
+  This document is for describing the required device tree parameters
+   for ads7142 adc driver.
+  The required parameters for proper operation are described below.
+
+  Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
+
+  Operation modes supportedby the driver:
+    When the 'ti,monitoring-mode' property is not present
+      in the devicetree node definition, the driver initiates a single
+      conversion in the device for each read request
+      (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
+      This is a one-shot conversion, and it is called
+      "Manual Mode" in the datasheet.
+
+    When the 'ti,monitoring-mode' property is present
+      in the devicetree node definition, the driver configures
+      the device's digital window comparator and sets the device's
+      data buffer operation mode to pre alert data mode.
+      The driver reads the conversion result when the BUSY/RDY interrupt
+      fires, and keeps the value until the next BUSY/RDY interrupt
+      or the first read request
+      (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
+      The digital window comparator and hysteresis parameters
+      can be controlled by:
+        - the devicetree definition of channel node
+        - iio sysfs interfaces
+      This is event driven conversion, and is called
+      "Autonomous Mode with Pre Alert Data" in the datasheet.
+      This mode can be used to wake up the system with the ALERT pin,
+      in case when the monitored voltage level is out of the configured range.
+
+properties:
+  compatible:
+    const: ti,ads7142
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The BUSY/PDY pin is used as interrupt line in autonomous monitoring mode.
+    maxItems: 1
+
+  vref-supply:
+    description: Regulator for the reference voltage
+
+  power-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+  ti,osc-sel:
+    description: |
+      If present, the driver selects the high speed oscillator.
+      See chapter 7.3.5 Oscillator and Timing Control in datasheet.
+    type: boolean
+
+  ti,n-clk:
+    description: |
+      nCLK is number of clocks in one conversion cycle.
+      See chapter 7.3.5 Oscillator and Timing Control in datasheet.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    minimum: 0
+
+  ti,monitoring-mode:
+    description: |
+      If present, the driver selects the autonomous monitoring mode with pre alert data.
+      See chapter 7.4 Device Functional Modes in datasheet.
+    type: boolean
+
+patternProperties:
+  "^channel@[0-1]$":
+    $ref: "adc.yaml"
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+    properties:
+      reg:
+        description: |
+          The channel number.
+        items:
+          minimum: 0
+          maximum: 1
+      "ti,threshold-falling":
+        description: The low threshold for channel
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 4095
+        minimum: 0
+      "ti,threshold-rising":
+        description: The high threshold for channel
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 4095
+        minimum: 0
+      "ti,hysteresis":
+        description: The hysteresis for both comparators for channel
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 63
+        minimum: 0
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+allOf:
+  - if:
+      required:
+        - ti,monitoring-mode
+    then:
+      required:
+        - interrupts
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adc@18 {
+        compatible = "ti,ads7142";
+        reg = <0x18>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+
+        vref-supply = <&vdd_3v3_reg>;
+        power-supply = <&vdd_1v8_reg>;
+
+        channel@0 {
+          reg = <0>;
+        };
+
+        channel@1 {
+          reg = <1>;
+        };
+      };
+    };
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adc@1f {
+        compatible = "ti,ads7142";
+        reg = <0x1f>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        #io-channel-cells = <1>;
+
+        vref-supply = <&vdd_3v3_reg>;
+        power-supply = <&vdd_1v8_reg>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <7 2>;
+
+        ti,monitoring-mode;
+
+        channel@0 {
+          reg = <0>;
+          ti,threshold-falling = <1000>;
+          ti,threshold-rising = <2000>;
+          ti,hysteresis = <20>;
+        };
+
+        channel@1 {
+          reg = <1>;
+          ti,threshold-falling = <100>;
+          ti,threshold-rising = <2500>;
+          ti,hysteresis = <0>;
+        };
+      };
+    };
+...
+
-- 
2.17.1


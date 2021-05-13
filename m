Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A622D37FCDD
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEMRx6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:53:58 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:34102 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhEMRx4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 13:53:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 270EF123FA3;
        Thu, 13 May 2021 19:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1620928363;
        bh=TdTIa7yziCVaTex9roLeZmpCMHy6bRXGu5aF2UJOI7Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kysXDc8v7duDJV7iYTbYCEdCFn7tqcDg97YPNIu8JujUiNFGdB5Me7AhadH1GMskI
         5n1au3SUMMoO0hb2TdBxx9bupj3jTKhImquQSCIu3px5tYXtVvzp1g8HHCdmBtw4p/
         toJ0SnWlUPZf4F0AvdB3QUBSj9n6vAE601ggx3vRD7JWgszWTMwXxAnvKmxppu15zQ
         dzIf5MMiLXyW7WXVXAVofzY12UAOxr5Bqd6DhtXQ7znxOPhEPROK2Sz42I/ZPu3qo8
         4yGy+s7TUG60CdDAMlcVHCCHn9rGu4G3wSnQWlEOxc8zxoggpuise5mulUycF/lUX/
         05dJoyttpgIoA==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F20WVs3WoxVF; Thu, 13 May 2021 19:52:04 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 796E4123F56;
        Thu, 13 May 2021 19:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1620928324;
        bh=TdTIa7yziCVaTex9roLeZmpCMHy6bRXGu5aF2UJOI7Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=OGcSpDyAtSEGlUm6hGcOtoQ7G8Rb3PHI3N1iWkKqZmUrNaSGsmzS6rq7y9uIfY/Xm
         JBMp2Lb5MK+P2L7Djh4WkHdgPeS4plrEBoKhS+wAaA+IsYiyrItXedjrZxqJs8uTcQ
         apn744rt3fJ2w+F1CWcB/FTuIfjp7QOBQyLIylEjaN3XcXMalfAqdJgSIv56He89pG
         n5qayafIshxb/dlUOe30jartLMM2HjL/utt9CjdfkGIMpsz58Q9O+pN4xXhKwFVZvp
         3qeQqNmpvgPFe1BV7ZVA53nNW05m9Sc115IwmJTNAP/U0ZJhrq5/8s0rxsLY07ClKj
         Rw32CC80tTRRg==
Date:   Thu, 13 May 2021 17:52:01 +0000
From:   Jozsef Horvath <info@ministro.hu>
To:     Jozsef Horvath <info@ministro.hu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: iio: adc: devicetree bindings for texas
 instruments ads7142 iio driver
Message-ID: <3f94f31f0cd5732f90d66ea507e6b9ff03a7024f.1620926923.git.info@ministro.hu>
References: <a50bce9fd6d28fa2aa0171ba406da0dd6714fcc3.1620926923.git.info@ministro.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a50bce9fd6d28fa2aa0171ba406da0dd6714fcc3.1620926923.git.info@ministro.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a device tree schema for iio driver for
 Texas Instruments ADS7142 dual-channel, programmable sensor monitor.

Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf

Signed-off-by: Jozsef Horvath <info@ministro.hu>
---

changes v1
  - Redundant parameters (ti,threshold-rising, etc.)
    are removed
  - Supply name changed(vref -> avdd)
  - Added dvdd supply
  - All the properties are removed with prefix "ti,"
---
 .../bindings/iio/adc/ti,ads7142.yaml          | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
new file mode 100644
index 000000000000..e4d701d1b2c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
@@ -0,0 +1,99 @@
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
+   for ads7142 adc
+  The required parameters for proper operation are described below.
+
+  Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
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
+  avdd-supply:
+    description: Regulator for the reference voltage
+
+  dvdd-supply: true
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
+
+    required:
+      - reg
+
+    additionalProperties: false
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
+      adc@1f {
+        compatible = "ti,ads7142";
+        reg = <0x1f>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        #io-channel-cells = <1>;
+
+        avdd-supply = <&vdd_3v3_reg>;
+        dvdd-supply = <&vdd_1v8_reg>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <7 2>;
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
+...
+
-- 
2.17.1


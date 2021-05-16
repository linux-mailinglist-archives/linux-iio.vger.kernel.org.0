Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593BD381D44
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhEPHcv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 03:32:51 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:46566 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhEPHcv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 03:32:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 71586123FAE;
        Sun, 16 May 2021 09:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1621150295;
        bh=7NwlV05YdzR13HidRHzmzgxX7TdkAsfQOZLDklOTycc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=iUQu6wd6yd81KX5E/0dMhEpq0YsmSJ0lS/JYP2PsrGWEGJaV3rvXwWW9dYlXRzMS8
         Kj55T+5t8D+Zt8215W/r/xB4n6NDCHexr0smoCJu3UxzRM/fWaJNV4wJ/9dPUms1Gq
         c+zBzEH40zHJSWkwuwvCmaggw6iLSMdOl2NxEywKGt5+N2a4LD7VxpQHToU4xmjKlT
         AwDRuuN/gUY13Jadrlcr5jXTSW8ti+fF2ogbSS1EfoHkQP0XbFnt29Dm63qCxthX3G
         o+lTfTPiwBmeJv+Is13K0RQdt9tWvjN3Gjt6pZNVn/G+fSsmXKZ/DFnO8vxod5d0fR
         7jJI3WAgl1YOQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UCOGd6HNy7Q8; Sun, 16 May 2021 09:31:08 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 31BEB123FAC;
        Sun, 16 May 2021 09:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1621150268;
        bh=7NwlV05YdzR13HidRHzmzgxX7TdkAsfQOZLDklOTycc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=quP+NfGPJw4OjzRHo/awxwtnZiLgvVCVfBcI6uxqAPZwfO8zcyp1/F+Q4f0PqhOY5
         AUV9dCVds3KwG6/BdhAp0mSqM5XRLD55u6a3e8UzuKhCoFhD6cmlZGBg4l/O3Ea0+k
         S8oMsWKMZ4JgcV0qis8xpEq4gYlEeL2R+5XgxZV+8OacVut148e6P08o1hxwIvv5BO
         kDROhvo26RVAz19MdwSNx0/HZbU68+OTrbbmmTaIv/XQ8oaZz176LynlqexWkQGxdb
         a9LF0CvLjOsATcNVDjGm3izzlC8D8r2aIqNHyRDfvkeLABrUs3qipNFVkb1ZM7x8TS
         5rY3DatfEZATg==
Date:   Sun, 16 May 2021 07:31:05 +0000
From:   Jozsef Horvath <info@ministro.hu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jozsef Horvath <info@ministro.hu>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Gene Chen <gene_chen@richtek.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: devicetree bindings for texas
 instruments ads7142
Message-ID: <a8200f9ce6a4b3fdf5a9b1e61bbc7c4ced8361b6.1621105931.git.info@ministro.hu>
References: <9f9c64ca70f80d8a024ea66e3963350e35f27c1d.1621105931.git.info@ministro.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f9c64ca70f80d8a024ea66e3963350e35f27c1d.1621105931.git.info@ministro.hu>
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
changes v2
  - "ti,prealert-count" parameter added, just for completeness.
---
 .../bindings/iio/adc/ti,ads7142.yaml          | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
new file mode 100644
index 000000000000..6e52079c68f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
@@ -0,0 +1,110 @@
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
+      The BUSY/PDY pin is used as interrupt line
+       in autonomous monitoring mode.
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
+  ti,prealert-count:
+    description: |
+      Sets the Pre-Alert Event Count for both,
+       high and low comparators, for both the channels.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    minimum: 0
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
+        ti,prealert-count = <4>;
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7563B5441
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhF0QdH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0QdH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ECFE61A2D;
        Sun, 27 Jun 2021 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811443;
        bh=PKZiWZrL67AoGNS72wk1iWGHrdyCelWkrNOmmL2JyZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEYmZK9Fs2OXco0U7CS30fOxEzZ8gQwPfJpJFGu/vGS66mJZRDYDSi3YfQ/t9FTK7
         Ggudc6Coavof6ZnvSUfCvg7hzW5eE1MedmR5ZLzIU4yOUemHIaSvd0b5+PpUy5VV8D
         yrJ0thh7cNwOI9S4UnhVCrgMO8Jro4pVHTDAWvPzJcBMseuAiQix4QdrISojo4gqYE
         uTpferjSBQB95JIVtofIovSkEiMRFy4JUpxdNJ2k1OfVovRXb2Hf61mQVsZH3bGtci
         GubseYuni+eImItL5Kgggf3c4D1MGojBhCTVpGX+ynj2rH6/AKKADHlC5kJsA2g/aN
         mSX5Ae5jXSwlg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/15] dt-bindings: iio: dac: ad5380: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:33 +0100
Message-Id: <20210627163244.1090296-5-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A simple binding for this particular DAC familly.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5380.yaml          | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
new file mode 100644
index 000000000000..d599b418a020
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5380.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5380 and similar DACs
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  DAC devices supporting both SPI and I2C interfaces.
+properties:
+  compatible:
+    enum:
+      - adi,ad5380-3
+      - adi,ad5380-5
+      - adi,ad5381-3
+      - adi,ad5381-5
+      - adi,ad5382-3
+      - adi,ad5382-5
+      - adi,ad5383-3
+      - adi,ad5383-5
+      - adi,ad5384-3
+      - adi,ad5384-5
+      - adi,ad5390-3
+      - adi,ad5390-5
+      - adi,ad5391-3
+      - adi,ad5391-5
+      - adi,ad5392-3
+      - adi,ad5392-5
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      If not supplied devices will use internal regulators.
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+           reg = <0>;
+           compatible = "adi,ad5390-5";
+           vref-supply = <&dacvref>;
+        };
+    };
+  - |
+    i2c {
+       #address-cells = <1>;
+       #size-cells = <0>;
+       dac@42 {
+          reg = <0x42>;
+          compatible = "adi,ad5380-3";
+       };
+    };
+...
-- 
2.32.0


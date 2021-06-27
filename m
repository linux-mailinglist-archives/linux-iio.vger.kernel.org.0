Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7475D3B5453
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhF0Qd1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhF0Qd1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8419619EE;
        Sun, 27 Jun 2021 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811463;
        bh=e0lfQMQ98H7nPRXlX+QiaZAYOsdTAbkWcxvEJVVK3Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+g+ItZm/viYynCwdaonkswGZRcGVmiKp+MVXach+UeodcbX8vbP3JAplEfPthHqG
         MDloAwKnWPQERq31lo/lcmftAYUIP0oHxNAeX/jzZZE4zgo/CRUwrX6+VAj4HtOLfq
         046PC59N6Y3UgRKPq3Eq7SRaicNzBq0AU47SIc4puwLAEaKr2XArqQNngdV+ruBIDd
         WtnHXqfmQxe6fAV83fmgdg+SYExKVEuVO3HRVf7btyxXd9BopkrBNhNV7JDN3bE4DC
         B6FWHILYIA9IX5VifHDG7TXBvwBAowtNXgDuE2t3i01BoNZlYDGJwNCu1hG70d+vhK
         XhQcX00T1FbCA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/15] dt-bindings: iio: dac: adi,ad5764: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:41 +0100
Message-Id: <20210627163244.1090296-13-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding covers the ad5744, ad5744r, ad5764 and ad5764r DACs.
Note that the driver currently assumes the internal reference is used for
the r parts. The binding as defined relaxes this constraint.

There is no support in the binding or driver for the two digital IO
signals.  I do not propose to add that until we have a means to
test any such binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5764.yaml          | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
new file mode 100644
index 000000000000..8e893d52bfb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5764.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5744 and AD5764 DAC families
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+
+  compatible:
+    enum:
+      - adi,ad5744
+      - adi,ad5744r
+      - adi,ad5764
+      - adi,ad5764r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vrefAB-supply: true
+  vrefCD-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5744
+              - adi,ad5764
+    then:
+      required:
+        - vrefAB-supply
+        - vrefCD-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5744";
+            reg = <0>;
+            vrefAB-supply = <&dac_vref>;
+            vrefCD-supply = <&dac_vref>;
+        };
+    };
+...
-- 
2.32.0


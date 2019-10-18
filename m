Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87C2DBD03
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 07:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbfJRF3F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Oct 2019 01:29:05 -0400
Received: from sender4-op-o19.zoho.com ([136.143.188.19]:17905 "EHLO
        sender4-op-o19.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfJRF3F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 01:29:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571370212; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=kbAtEvTx8j677Jh3CDpgwDgzcmgvqS0LPM28Mv1oyoCNcv4QI587ONMf2RGEn4tb6tKGwlXnGUGIMsOF4Mhto2GnYYFzD7W1WEJQHAdoQQhmqr1xjZsgKPS7G+udQW7oRBiwXeMSEWesetIZdgaAdUSgy+vba1uxrI0aFzwVsJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571370212; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0M608GbAEJ9tM/ZcceqJxrV2lLBxBGooik+pYAv+CVU=; 
        b=UXve6fXAJA6R0D03WQobADYB1lMiPgVuwUvKMiFrth6H1b7xHRU3iOXZKsQCuJGBrC15OuIVgMUQyU8BRZTL5thfeL4xV4fWIMHK/qrETAHnItgHidQTd8Vhr8yyvj8PDNCAV4xZ4i2G+zlJp4gBJ6qkbmtJq+yG4Xjzabm9t24=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1571370211739228.7610384308789; Thu, 17 Oct 2019 20:43:31 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191018031848.18538-2-dan@dlrobertson.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: accel: bma400: add bindings
Date:   Fri, 18 Oct 2019 03:18:47 +0000
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018031848.18538-1-dan@dlrobertson.com>
References: <20191018031848.18538-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
accelerometer sensor.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 .../devicetree/bindings/iio/accel/bma400.yaml | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bma400.yaml
new file mode 100644
index 000000000000..e0a85dc7bf34
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bma400.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bma400.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMA400 triaxial acceleration sensor
+
+maintainers:
+  - Dan Robertson <dan@dlrobertson.com>
+
+description: |
+  Acceleration and temerature iio sensors with an i2c interface
+
+  Specifications about the sensor can be found at:
+    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
+
+properties:
+  compatible:
+    enum:
+      - bosch,bma400
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      bma400@14 {
+        compatible = "bosch,bma400";
+        reg = <0x14>;
+      };
+    };



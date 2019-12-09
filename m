Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83BA1164E5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 03:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLICAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Dec 2019 21:00:16 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17891 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfLICAQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Dec 2019 21:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575856792; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gCbLQGOC0pcxXKispo2ZpUU9efZvZfuWflRexL/8UXfY71UoBkBi14Ls0lDelwQXbLp0HIl+Y/YBEhSWo5Jd+yHEx3XjohHZo2jgBynjNoqp3b12m2kmTNsoD4BYGZy2t9CSGZHz7xTeNldSF+VQ7XCjWVHKSFlSfxXC2qP6Bc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575856792; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=lVmHve7IaGJq1mAmCV0uHiy0RloySQLIlcKn39Lv3RE=; 
        b=neM6sfDN5tANzkInQM97CSKUuvKhf5ciE0CjXj++bxLz0KDkpQs9+cPMZpD5Vz/G5GblBq7+rfWw/MdOx5POJMx0eCGRnnHwq6hWW/9aOcd6LIRhN3R3CCbGNW/D3ymuIeimvWcvTvwxekcss3Jih6Xcy8YOAtFD6tclDLCQoDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1575856790869543.3252030071949; Sun, 8 Dec 2019 17:59:50 -0800 (PST)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191209014320.13149-2-dan@dlrobertson.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: accel: bma400: add bindings
Date:   Mon,  9 Dec 2019 01:43:19 +0000
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209014320.13149-1-dan@dlrobertson.com>
References: <20191209014320.13149-1-dan@dlrobertson.com>
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
 .../bindings/iio/accel/bosch,bma400.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
new file mode 100644
index 000000000000..03b7ad345523
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      accelerometer@14 {
+        compatible = "bosch,bma400";
+        reg = <0x14>;
+      };
+    };



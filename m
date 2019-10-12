Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD93D523F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfJLTks convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 12 Oct 2019 15:40:48 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17426 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfJLTkr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 15:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570909229; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=d2qxWsYQ+O1dKJkLv/wHtLwaxO4vxOlg91RCsOTis1j//yru1gwsiv8SHfOFeBpDz1xSARsSUYCwtlZp+85BCfv25PBygjfyh0ykVj2BH1nq0pNoZtRpI6ZGjZp87CnNtnXZFJXXzzglK+nN6mVAF2psHdBcLMYNvGHVtf4XNg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570909229; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=uDjKLFmXeaiCdTVGDWmDMsfYtR/+iKDP9dyckoixuuo=; 
        b=ldLAL0G+sK0NPeLoCT1ht3eW5hOoc1lNBOQQFmnTEk5szgZu0DI/0dXEEjp9CYfKCRSir7fWec2m3wJMeHTHXkZo4RrjdY3EsIZKAZIzH+1Fx4up/09nqjS8muGgf4Yx8E4KnMh5cHlyBOzDTdaw5AuaAjVpFyuwQORAvsnZEm0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1570909228368785.2018748211628; Sat, 12 Oct 2019 12:40:28 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191012192525.21040-2-dan@dlrobertson.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: accel: bma400: add bindings
Date:   Sat, 12 Oct 2019 19:25:24 +0000
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012192525.21040-1-dan@dlrobertson.com>
References: <20191012192525.21040-1-dan@dlrobertson.com>
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
index 000000000000..31dceac89ace
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
+      #size-cells = <1>;
+      bma400@14 {
+        compatible = "bosch,bma400";
+        reg = <0x14>;
+      };
+    };
-- 
2.23.0




Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC8263578
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIISFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIISEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:04:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAD3221E8;
        Wed,  9 Sep 2020 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674558;
        bh=LXwmjBNNxQhHZ1OQIxynrn4oVDZJ0D7lt0BpKadQpOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs1iOxfYBCVpDSSNKsFnVn5FLjhDNnlMR5Zdf/vaBWqGdFvT3k9YHTNNPyB0IuQUt
         yoDDRNw88cGOHru5QKmPA6d8Ln7HQKve+7zQe1IDbt/ARup/+XweMrfBHQ3CL2NTKA
         K3jvPQIraXICGZ9BvK49cD14i4BHEDjNv4HFDAKM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 12/20] dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion
Date:   Wed,  9 Sep 2020 18:59:38 +0100
Message-Id: <20200909175946.395313-13-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909175946.395313-1-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a small part of an MFD so perhaps ultimately it makes more
sense to document it with that MFD binding rather than separately.

In the meantime it's a straightforward conversion from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 .../bindings/iio/adc/da9150-gpadc.txt         | 16 ---------
 .../bindings/iio/adc/dlg,da9150-gpadc.yaml    | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
deleted file mode 100644
index c07228da92ac..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Dialog Semiconductor DA9150 IIO GPADC bindings
-
-Required properties:
-- compatible: "dlg,da9150-gpadc" for DA9150 IIO GPADC
-- #io-channel-cells: Should be set to <1>
-  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
-
-For further information on GPADC channels, see device datasheet.
-
-
-Example:
-
-	gpadc: da9150-gpadc {
-		compatible = "dlg,da9150-gpadc";
-		#io-channel-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
new file mode 100644
index 000000000000..15c51d337108
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/dlg,da9150-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9150 IIO GPADC
+
+maintainers:
+  - Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+
+description:
+  This patch adds support for general purpose ADC within the
+  DA9150 Charger & Fuel-Gauge IC.
+
+properties:
+  compatible:
+    const: dlg,da9150-gpadc
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+examples:
+  - |
+    adc {
+        compatible = "dlg,da9150-gpadc";
+        #io-channel-cells = <1>;
+    };
+...
-- 
2.28.0


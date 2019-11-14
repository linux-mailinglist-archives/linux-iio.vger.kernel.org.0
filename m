Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB23FC4B7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNKwh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 05:52:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKwh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 05:52:37 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVCjL-0005Hm-CQ; Thu, 14 Nov 2019 11:52:03 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVCjJ-0003zq-Fd; Thu, 14 Nov 2019 11:52:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [RFC PATCH v2 1/3] iio: adc: ltc2496: provide device tree binding document
Date:   Thu, 14 Nov 2019 11:51:57 +0100
Message-Id: <20191114105159.14195-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
References: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC only requires the standard stuff for spi devices and a reference
voltage.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't say anything about stuff like spi-max-frequency, spi-cpha etc
and even reg because I wonder if there is something I can write into the
document to just reference the generic spi device binding. So I marked
as RFC.

Best regards
Uwe
 .../bindings/iio/adc/lltc,ltc2496.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
new file mode 100644
index 000000000000..e8acab5f04ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2496.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology / Analog Devices LTC2496 ADC
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc2496
+
+  vref-supply:
+    description: phandle to an external regulator providing the reference voltage
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - vref-supply
+
+examples:
+  - |
+	adc@0 {
+		compatible = "lltc,ltc2496";
+		reg = <0>;
+		vref-supply = <&ltc249x_reg>;
+		spi-max-frequency = <2000000>;
+	};
-- 
2.24.0


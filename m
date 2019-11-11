Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF86F82A6
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKV6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 16:58:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47437 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKKV6o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 16:58:44 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUHQN-0005Bm-42; Mon, 11 Nov 2019 22:40:39 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUHQL-0004mO-48; Mon, 11 Nov 2019 22:40:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     kernel@pengutronix.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding document
Date:   Mon, 11 Nov 2019 22:40:23 +0100
Message-Id: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
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
 .../devicetree/bindings/iio/adc/ltc2496.txt       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ltc2496.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ltc2496.txt b/Documentation/devicetree/bindings/iio/adc/ltc2496.txt
new file mode 100644
index 000000000000..d44ab45b26ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ltc2496.txt
@@ -0,0 +1,15 @@
+* Linear Technology / Analog Devices LTC2496 ADC
+
+Required properties:
+ - compatible: Must be "lltc,ltc2496"
+ - vref-supply: The regulator supply for ADC reference voltage
+ - further properties required for spi device nodes according to
+   Documentation/devicetree/bindings/spi/spi-controller.yaml
+
+Example:
+	ltc2497: adc@76 {
+		compatible = "lltc,ltc2496";
+		reg = <0>;
+		vref-supply = <&ltc249x_reg>;
+		spi-max-frequency = <2000000>;
+	};
-- 
2.24.0.rc1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519C85C29F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2019 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGASId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jul 2019 14:08:33 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:38152 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfGASId (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jul 2019 14:08:33 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jul 2019 14:08:32 EDT
Received: from localhost.localdomain (pD95EF93B.dip0.t-ipconnect.de [217.94.249.59])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 77604290042;
        Mon,  1 Jul 2019 17:59:10 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/2] device-tree: iio: add bindings documentation for NXP PCT2075
Date:   Mon,  1 Jul 2019 20:01:57 +0200
Message-Id: <20190701180158.9463-1-daniel@zonque.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This documentens the bindings for the NXP PCT2075 temperature sensor
driver.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/iio/temperature/pct2075.txt      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/pct2075.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/pct2075.txt b/Documentation/devicetree/bindings/iio/temperature/pct2075.txt
new file mode 100644
index 000000000000..dc5d3e991ab0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/pct2075.txt
@@ -0,0 +1,60 @@
+* NXP PCT2075 - I2C connected digital temperature sensor
+
+Link to datasheet: https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
+
+Required properties:
+
+ - compatible:	Should be "nxp,pct2075"
+ - reg:		The I2C address of the sensor
+		(controllable via A[0,1,2] pins)
+
+Addressing pins can be tied high, low or left floating, allowing for up to
+27 different I2C addresses, depending on the package.
+
+Optional properties:
+
+ - vcc-supply:		A regulator node that is connected to the Vcc pin
+			(2.7V - 5.5V). If specified, the regulator will be
+			enabled at probe time and disabled when the driver
+			is removed.
+
+ - nxp,os-fault-queue:	Specifies the number of faults that must occur
+			consecutively to activate the OS output pin.
+			Valid numbers are 1 (default), 2, 4 and 6.
+
+ - nxp,os-active-high:	Specifies that the OS pin should be in active-high
+			mode. By default, it is active-low.
+
+ - nxp,os-mode-interrupt: Configures the device to operate the OS pin
+			  as an interrupt rather than a comparator. Please
+			  refer to the datasheet for information about the
+			  differences.
+
+ - nxp,sample-period-ms: Configures the sample period of the device in
+			 milliseconds. Valid values are multiples of 100
+			 up to 3100.
+
+ - nxp,overtemperature-shutdown-millicelsius:
+			Configures the temperature threshold at which the
+			device shuts down, in milli-celcius.
+			Values are given as signed integer and are valid
+			in the range from -55000 up to +125000.
+
+ - nxp,hysteresis-millicelsius:
+			Configures the temperature threshold for OS pin
+			operation, in milli-celcius.
+			Values are given as signed integer and are valid
+			in the range from -55000 up to +125000.
+
+Example:
+
+pct2075@48 {
+	compatible = "nxp,pct2075";
+	reg = <0x48>; /* A0, A1, A2 = low */
+	nxp,os-active-high;
+	nxp,os-mode-interrupt;
+	nxp,sample-period-ms = <1000>;
+	nxp,overtemperature-shutdown-millicelsius = <110000>;
+	nxp,hysteresis-millicelsius = <(-10000)>;
+};
+
-- 
2.21.0


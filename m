Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B052186542
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgCPGw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 02:52:29 -0400
Received: from jax4mhob16.registeredsite.com ([64.69.218.104]:39176 "EHLO
        jax4mhob16.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729319AbgCPGw3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 02:52:29 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by jax4mhob16.registeredsite.com (8.14.4/8.14.4) with ESMTP id 02G6qRUP135828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2020 02:52:27 -0400
Received: (qmail 21017 invoked by uid 0); 16 Mar 2020 06:52:27 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 16 Mar 2020 06:52:27 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Mon, 16 Mar 2020 07:52:18 +0100
Message-Id: <20200316065218.4103-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
the accelerometer part.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../devicetree/bindings/iio/accel/bmi088.txt  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bmi088.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/bmi088.txt b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
new file mode 100644
index 000000000000..691a47726dbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
@@ -0,0 +1,23 @@
+* Bosch BMI088 IMU combining accelerometer and gyroscope
+
+https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
+
+Required properties:
+
+  - compatible : should be "bosch,bmi088_accel"
+  - reg : the I2C address of the sensor or the SPI chip select number
+
+Optional properties:
+
+  - interrupts : interrupt mapping for GPIO IRQ, it should be configured with
+		 IRQ_TYPE_EDGE_RISING
+
+Example:
+
+bmi088_accel@1 {
+	compatible = "bosch,bmi088_accel";
+	reg = <1>;
+	spi-max-frequency = <10000000>;
+	interrupt-parent = <&gpio>;
+	interrupts = <90 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.17.1


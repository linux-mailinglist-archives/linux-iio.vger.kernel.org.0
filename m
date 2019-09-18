Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74918B5957
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 03:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfIRBfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 21:35:33 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:42470
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728164AbfIRBfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 21:35:33 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 60FBC1A4AC86; Tue, 17 Sep 2019 18:29:21 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Date:   Tue, 17 Sep 2019 18:28:55 -0700
Message-Id: <20190918012856.18963-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20190918012856.18963-1-rjones@gateworks.com>
References: <20190918012856.18963-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
device-tree bindings.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/iio/imu/fxos8700.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.txt

diff --git a/Documentation/devicetree/bindings/iio/imu/fxos8700.txt b/Documentation/devicetree/bindings/iio/imu/fxos8700.txt
new file mode 100644
index 0000000..770605d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/fxos8700.txt
@@ -0,0 +1,15 @@
+Freescale FXOS8700 - Inertial Measurement Unit with Accelerometer and Magnetometer
+
+https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
+
+Required properties:
+ - compatible : must be "fsl,fxos8700"
+ - reg : the I2C address or SPI chip select number of the device
+ - spi-max-frequency : set maximum clock frequency (only for SPI)
+
+Example:
+
+bmi160@1e {
+	compatible = "fsl,fxos8700";
+	reg = <0x1e>;
+};
-- 
2.9.2


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBB28A858
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgJKRKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRKG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4B02222E;
        Sun, 11 Oct 2020 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436205;
        bh=0gbw3Ce6OLQkHJijlMnNam+e05/EOGr9TlIv/aQTwcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UN8KArOjDEcinuKbxJIWGdR2oMq8wOUlJaPyuT42I1aF60LXMfMIJXxqmaD7Lek2B
         wBgPgCQcBLWShFDdw4dgKspgrc8t78jvbC81UyKks7ndjCefQiKOGBQ3E77nftx2OC
         Gch4q+PCreCakFdUcsW0JEVkoeuwSMma89uPpTU4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 05/29] dt-bindings:iio:pressure:ms5637 Drop separate doc + add to trivial-devices
Date:   Sun, 11 Oct 2020 18:07:25 +0100
Message-Id: <20201011170749.243680-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding for this i2c device with no properties beyond
reg and compatible.  Hence doesn't need it's own document.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: William Markezana <william.markezana@meas-spec.com>
Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 .../devicetree/bindings/iio/pressure/ms5637.txt | 17 -----------------
 .../devicetree/bindings/trivial-devices.yaml    |  8 ++++++++
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5637.txt b/Documentation/devicetree/bindings/iio/pressure/ms5637.txt
deleted file mode 100644
index 1f43ffa068ac..000000000000
--- a/Documentation/devicetree/bindings/iio/pressure/ms5637.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* MS5637 - Measurement-Specialties MS5637, MS5805, MS5837 and MS8607 pressure & temperature sensor
-
-Required properties:
-
-	-compatible: should be one of the following
-		meas,ms5637
-		meas,ms5805
-		meas,ms5837
-		meas,ms8607-temppressure
-	-reg: I2C address of the sensor
-
-Example:
-
-ms5637@76 {
-	compatible = "meas,ms5637";
-	reg = <0x76>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 49c67a6a1332..a8db256c2a93 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -130,8 +130,16 @@ properties:
           - memsic,mxc6225
             # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu21
+            # Measurement Specialities I2C pressure and temperature sensor
+          - meas,ms5637
+            # Measurement Specialities I2C pressure and temperature sensor
+          - meas,ms5805
+            # Measurement Specialities I2C pressure and temperature sensor
+          - meas,ms5837
             # Measurement Specialities temp and humidity part of ms8607 device
           - meas,ms8607-humidity
+            # Measurement Specialities temp and pressure part of ms8607 device
+          - meas,ms8607-temppressure
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.28.0


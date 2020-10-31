Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89A12A1999
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgJaSbd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084CF20720;
        Sat, 31 Oct 2020 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169092;
        bh=nxkaGkEl4Sf+oLUDwTGLTfu4Z2XG94NCrdXtQy38iQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxEyTuD58KFyGJhSHJ+1a8baHxeHFAOOxZ7kWJ2u13oakpAsHjHm6jwZraPF/pAy8
         IZjIyx9VmripOKJDa0KAcehCzxDNEXE4mzOrx4Yu2EMimbp6I+Xk0bt/ubC6JG4um8
         jYgxTKKHMQCEt6/XxK4D2d9XdPfAQmY5ziJno20c=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH 1/7] dt-bindings:iio:chemical:sensirion,sgp30: Move to trivial-bindings.yaml
Date:   Sat, 31 Oct 2020 18:29:16 +0000
Message-Id: <20201031182922.743153-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The binding for this device and the sgpc3 is very simple so lets
not maintain a seperate document for this one.  Of course we can
always add a document again if the binding becomes more complex in
future.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 .../bindings/iio/chemical/sensirion,sgp30.txt     | 15 ---------------
 .../devicetree/bindings/trivial-devices.yaml      |  4 ++++
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
deleted file mode 100644
index 5844ed58173c..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* Sensirion SGP30/SGPC3 multi-pixel Gas Sensor
-
-Required properties:
-
-  - compatible: must be one of
-    "sensirion,sgp30"
-    "sensirion,sgpc3"
-  - reg: the I2C address of the sensor
-
-Example:
-
-gas@58 {
-	compatible = "sensirion,sgp30";
-	reg = <0x58>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 185e09e61e16..642502761106 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -212,6 +212,10 @@ properties:
           - pulsedlight,lidar-lite-v2
             # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
+            # Sensirion low power multi-pixel gas sensor with I2C interface
+          - sensirion,sgpc3
+            # Sensirion multi-pixel gas sensor with I2C interface
+          - sensirion,sgp30
             # SGX Sensortech VZ89X Sensors
           - sgx,vz89x
             # Relative Humidity and Temperature Sensors
-- 
2.28.0


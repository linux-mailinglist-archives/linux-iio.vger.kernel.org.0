Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82A2A17B9
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgJaNnr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgJaNno (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D9720756;
        Sat, 31 Oct 2020 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151823;
        bh=zLBM80q81oAj3l/N7gt12bUAvzlrHfrBh4PcWowdvCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TWsF9B1zP0BiqW721sHmfytT+5t4WD0mk/o9inaYs+9RCtLB4St40Cm3v5aQbRxh
         a7XNEBzvb8xE22q2kE2N1z+VKefOuXDMGhz4elSnHgMu05bJnXFL12grm5oBT0+8lm
         QA93xEv2vMgGlZCx1clYCnoxe67/eQYZTqEfpIZM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/29] dt-bindings:iio:humidity:htu21 Drop separate doc + add to trivial-devices
Date:   Sat, 31 Oct 2020 13:40:43 +0000
Message-Id: <20201031134110.724233-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding for this i2c device with no properties beyond
reg and compatible.  Hence doesn't need it's own document.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/humidity/htu21.txt      | 13 -------------
 .../devicetree/bindings/trivial-devices.yaml        |  4 ++++
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/htu21.txt b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
deleted file mode 100644
index 97d79636f7ae..000000000000
--- a/Documentation/devicetree/bindings/iio/humidity/htu21.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-*HTU21 - Measurement-Specialties htu21 temperature & humidity sensor and humidity part of MS8607 sensor
-
-Required properties:
-
-	- compatible: should be "meas,htu21" or "meas,ms8607-humidity"
-	- reg: I2C address of the sensor
-
-Example:
-
-htu21@40 {
-	compatible = "meas,htu21";
-	reg = <0x40>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index d37f757e6bd1..43febb3057b6 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -132,6 +132,10 @@ properties:
           - mcube,mc3230
             # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6225
+            # Measurement Specialities I2C temperature and humidity sensor
+          - meas,htu21
+            # Measurement Specialities temp and humidity part of ms8607 device
+          - meas,ms8607-humidity
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.28.0


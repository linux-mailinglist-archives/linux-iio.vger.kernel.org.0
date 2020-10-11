Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87328A855
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgJKRKB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRKB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4DB22222A;
        Sun, 11 Oct 2020 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436200;
        bh=VBulIK4LHmlnLKNN0xlDLvUCl4hry0PL8Eszrlytr+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYavmNoulpTtRLrO6yOH9tGQ+UOPcwrnKS7xx5skw53SFJTtLvi/U96k8u+X5Ren5
         uIgFRsYmV8M18D9k6l7jxLGO6tNDrg6YKCsLrUU0VZ9OZFx9oYjT8eL7Cct/LoNPkX
         3SBgwXU1wC7880aa1dBjFImwWbFpEVAL0dkhdGk0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 02/29] dt-bindings:iio:humidity:htu21 Drop separate doc + add to trivial-devices
Date:   Sun, 11 Oct 2020 18:07:22 +0100
Message-Id: <20201011170749.243680-3-jic23@kernel.org>
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
index 9f8531d4d33e..49c67a6a1332 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -128,6 +128,10 @@ properties:
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


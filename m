Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2528A854
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgJKRJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRJ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:09:59 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498142222C;
        Sun, 11 Oct 2020 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436199;
        bh=XHzi1sFg6y12KCom9UbucvKN76ES59BRfxnZN+0znmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xgt9EaJA1TogeG7LufF0R1+uV+waCfNj7eZzpo09ptS64djpTbv7HWCYEVO8OdpcI
         NS54jX80tcbskweng2O9KAf9GuqHUGTIzKNHasKoZDD2QHH6vcPeArb0f2B5qWRkLG
         GS6i27x3VhICASKVLpJZdMtcTSCDaCwn707QGQP4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 01/29] dt-bindings:iio:humidity:hdc100x Drop separate doc + add to trivial-devices
Date:   Sun, 11 Oct 2020 18:07:21 +0100
Message-Id: <20201011170749.243680-2-jic23@kernel.org>
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
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../bindings/iio/humidity/hdc100x.txt           | 17 -----------------
 .../devicetree/bindings/trivial-devices.yaml    | 10 ++++++++++
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
deleted file mode 100644
index c52333bdfd19..000000000000
--- a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* HDC100x temperature + humidity sensors
-
-Required properties:
-  - compatible: Should contain one of the following:
-	ti,hdc1000
-	ti,hdc1008
-	ti,hdc1010
-	ti,hdc1050
-	ti,hdc1080
-  - reg: i2c address of the sensor
-
-Example:
-
-hdc100x@40 {
-	compatible = "ti,hdc1000";
-	reg = <0x40>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 25cfcc904240..9f8531d4d33e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -352,6 +352,16 @@ properties:
           - ti,ads7830
             # Temperature Monitoring and Fan Control
           - ti,amc6821
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1000
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1008
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1010
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1050
+            # Temperature and humidity sensor with i2c interface
+          - ti,hdc1080
             # Temperature sensor with 2-wire interface
           - ti,lm73
             # Temperature sensor with integrated fan control
-- 
2.28.0


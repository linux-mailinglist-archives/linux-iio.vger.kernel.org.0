Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49922A199B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgJaSbe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C83F2071A;
        Sat, 31 Oct 2020 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169093;
        bh=k4JPkpV36ENPtPE2AyB0tinJaMT3wFejSdzxJgCJhpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pln/8lIIkY0d2aoi/NB1FJ2EJqfnqKaNlneFhMJjKgNsOVetBRvbL+STSChKYJzpv
         l8a/bMiz1bmW2nonrq0t99LahhPrzFda/3Extlh1tx0+3HOUYhE6n3Um13xc0n7S6e
         ZlCZCXAZvyWmg215BumxsJhgqpc1Z6tfs9AC9s6g=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 2/7] dt-bindings:iio:chemical:bosch,bme180: Move to trivial devices
Date:   Sat, 31 Oct 2020 18:29:17 +0000
Message-Id: <20201031182922.743153-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding so no need to maintain a separate file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>
---
 .../devicetree/bindings/iio/chemical/bme680.txt       | 11 -----------
 .../devicetree/bindings/trivial-devices.yaml          |  2 ++
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
deleted file mode 100644
index 7f3827cfb2ff..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/bme680.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
-
-Required properties:
-- compatible: must be "bosch,bme680"
-
-Example:
-
-bme680@76 {
-          compatible = "bosch,bme680";
-          reg = <0x76>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 642502761106..10f0afd44684 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -44,6 +44,8 @@ properties:
           - atmel,atsha204a
             # i2c h/w elliptic curve crypto module
           - atmel,atecc508a
+            # Bosch Sensortec preassure, temperature, humididty and VOC sensor
+          - bosch,bme680
             # CM32181: Ambient Light Sensor
           - capella,cm32181
             # CM3232: Ambient Light Sensor
-- 
2.28.0


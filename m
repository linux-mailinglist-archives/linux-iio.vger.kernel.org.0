Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6628A86D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbgJKRKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:38 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2829622261;
        Sun, 11 Oct 2020 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436238;
        bh=kRhR4t6dWs26fwAtmzeIO3RLuTNhz3NNkjHGFBo0Wns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13DE3zEH649Eib5dcq7Feg2waHBh7Dd0G7GZZeBLdNeLmN5Xg6AYev9wnb3h6/oJj
         4aEnn7PmBw5r/xo9yJ+zU+PmNxdvRSi1dc8dZRqEHLQoxFyghI3wonvosLyQOfbX/4
         bjT9qWIdQQT7yiJVUVOAvZENjut2KWo1NNYuR2e4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 26/29] dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
Date:   Sun, 11 Oct 2020 18:07:46 +0100
Message-Id: <20201011170749.243680-27-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The existing binding description brings little value and the similar
meas,* parts are in trivial-devices.yaml so move this one there
to join them.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/iio/temperature/tsys01.txt       | 19 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt b/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
deleted file mode 100644
index 0d5cc5595d0c..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* TSYS01 - Measurement Specialties temperature sensor
-
-Required properties:
-
-	- compatible: should be "meas,tsys01"
-	- reg: I2C address of the sensor (changeable via CSB pin)
-
-		------------------------
-		| CSB | Device Address |
-		------------------------
-		   1         0x76
-		   0	     0x77
-
-Example:
-
-tsys01@76 {
-	compatible = "meas,tsys01";
-	reg = <0x76>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a8db256c2a93..6410fc0df435 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -140,6 +140,8 @@ properties:
           - meas,ms8607-humidity
             # Measurement Specialities temp and pressure part of ms8607 device
           - meas,ms8607-temppressure
+            # Measurement Specialties temperature sensor
+          - meas,tsys01
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.28.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F89351988
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhDARyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236466AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 180D1611ED;
        Thu,  1 Apr 2021 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298995;
        bh=M8jALQnqCGJzphUULs3bm0t87GVhkS81ocqnfHlOgXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhn+jdeD0sPPL/7ZjkICVkP7Q5VMXFnPMeVwS84k3XiSMmhN857lrqMvCYwE84vj3
         OUKUWhbJ1sctg+mNayn0tKUIxsjtSd9w6f7BuIR1kN1vpWB1q+x4ClZjju/RSFhncF
         wVhtVbd543j76zUGeqoyiBgF2ZBOnegtHV96FG/NAsXiGTlBx27Eo7g5SYSMnNI2yA
         L56R0lMQBEz2KvrrQIufRExj8g3OwBqoF066649Khkvib8oN9pQEnjXG+NI3wHpQfq
         RDVORfKq46i11Z7QSbK1dMBPHAhho7SGofx7hjOykEqOw7l/98c09gUpCIvqa/llu5
         ieCfkFD/dbekQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/6] dt-bindings:trivial-devices: Add memsic,mxc4005/mxc6255/mxc6655 entries
Date:   Thu,  1 Apr 2021 18:41:10 +0100
Message-Id: <20210401174112.320497-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401174112.320497-1-jic23@kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple devices with I2C interface and single interrupt line so
entries in trivial devices are sufficient.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a327130d1faa..c7d49a720afa 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -166,8 +166,14 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis accelerometer
+          - memsic,mx4005
             # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6225
+            # MEMSIC 2-axis 8-bit digital accelerometer
+          - memsic,mxc6255
+            # MEMSIC 3-axis accelerometer
+          - memsic,mxc6655
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.31.1


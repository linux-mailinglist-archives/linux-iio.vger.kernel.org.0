Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477752CBA6B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 11:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgLBKSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 05:18:30 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:21040 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgLBKS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 05:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606904137;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=pQwF0XlDrZ1v6d/R4tbafkv+xiSIHcA0rqHQNV/ICKM=;
        b=ePGlPrWX2vXnFS7ls7tyTgIKL21Oher6mkaavPGWhT9kK5XxcR6QFlIOb1avkS9mN1
        BJtotA2G5jaTNJQSE3Dhu2Hr/LPZ5jfS6bUxiNcEopyS68yDmlkEH8oNrSYjRnf7qvQp
        pxnhsThZTXh2Y0U8eIhUUKwiXgz6tu3B4YgVAUskt7h4BnF2zBYOa7bzhcMrxSU75juX
        7PpN0rC1lJ6SFZjx8OYFVJkp/agqbFDXtZ4SnGC+esF0WF4Hs/4YByShRl3Q7drJGudp
        DP/aQ8MyOxzp4UKVF7RcOP1JLu2MuHDJKM+3rLCG5+/fRhAeAevXuUKumOJAojRwKrpX
        JaPg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB2AFTWXZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 11:15:29 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document invensense,mpu6880
Date:   Wed,  2 Dec 2020 11:13:54 +0100
Message-Id: <20201202101355.87112-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MPU-6880 seems to be very similar to MPU-6500 / MPU-6050 and it works
fine with some minor additions for the mpu6050 driver.
Add a compatible for it to the binding documentation.

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Note: This applies only on top of the patch for the YAML conversion:
https://lore.kernel.org/linux-iio/20201128173343.390165-3-jic23@kernel.org/
I guess that one will be applied very soon so I think this is easier :)
---
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 9268b6ca2afe..edbc2921aabd 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -25,6 +25,7 @@ properties:
       - invensense,mpu6050
       - invensense,mpu6500
       - invensense,mpu6515
+      - invensense,mpu6880
       - invensense,mpu9150
       - invensense,mpu9250
       - invensense,mpu9255
-- 
2.29.2


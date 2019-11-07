Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023DEF377A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKGSqN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 13:46:13 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:26241 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfKGSqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 13:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573152371;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=SDECKhmd73C0X3Kn9A0XZ2VAWfazh3EPYkxFWbR6MLI=;
        b=pepMGwXWHGIhElN345CTFsKH+sWtchlylPn24bEjSVXrcHyflt3CqbuctaZRGbHvRR
        zKGKJf7MW4FSW7dZ+jaIqm3eYyfBweDEdtbNmJkpDQQUYoK8xPREEbGgP1gRucQdONPt
        IhYYlIamYkW68UaR5QNQWGKYOJ7kew9tn/Cqq/fBw8xYNi69+wu5nLWPS5eSownx7tud
        mi/HXVheicihh3XqtBOVdBmskXcwf00EVAbtWnGRykL1ijdokRqfNAZxg5b1gbOIWESO
        stAEwQ72MSYW5S691mS54m+mFS9mj/8dtYv5RKPJkrhtQGmqYtnKf4+HEM54x+Za6ioT
        vQeg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMnvtxdYcg=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA7Ik9oQq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 19:46:09 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
Date:   Thu,  7 Nov 2019 19:43:41 +0100
Message-Id: <20191107184342.20361-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

inv_mpu6050 now supports an additional vdd-supply; document it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Add Reviewed-by from Linus Walleij

v1: https://lore.kernel.org/linux-iio/20191106183536.123070-1-stephan@gerhold.net/
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index 268bf7568e19..c5ee8a20af9f 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -21,6 +21,7 @@ Required properties:
   bindings.
 
 Optional properties:
+ - vdd-supply: regulator phandle for VDD supply
  - vddio-supply: regulator phandle for VDDIO supply
  - mount-matrix: an optional 3x3 mounting rotation matrix
  - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
-- 
2.23.0


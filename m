Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0BC4E520D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiCWMUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbiCWMUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 08:20:21 -0400
Received: from mxd2.seznam.cz (mxd2.seznam.cz [IPv6:2a02:598:2::210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F153B46;
        Wed, 23 Mar 2022 05:18:51 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc15b.ng.seznam.cz (email-smtpc15b.ng.seznam.cz [10.23.14.195])
        id 104155f54b4f019c11e899ab;
        Wed, 23 Mar 2022 13:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1648037896; bh=WIjrcjEAOH3RC9G0YPcUKU+305TBgze9uCo3H5UFxqM=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:X-szn-frgn:
         X-szn-frgc;
        b=DRbaiD7kIshNTLKeqppHGCcmcrc5ezaF+81pQ9KhATE8jLNuyQJz7SGo5hk/givFq
         Hw6C7/AsDHjR1emLsNleET5AQSTgwhLtOsrxr9KvZUQ6eaKgQq1D+pTdo2CxtpV6Hr
         xMUvgPYld6Ccne4rxB8lb3t46H9BqqhLAwMvI+D0=
Received: from localhost.localdomain (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay19.ng.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Wed, 23 Mar 2022 13:18:11 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Srba <Michael.Srba@seznam.cz>
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
Date:   Wed, 23 Mar 2022 13:15:49 +0100
Message-Id: <20220323121550.16096-2-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323121550.16096-1-michael.srba@seznam.cz>
References: <20220323121550.16096-1-michael.srba@seznam.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-szn-frgn: <08f6a04d-8558-42bc-9ffe-b7288f70385f>
X-szn-frgc: <0>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Srba <Michael.Srba@seznam.cz>

ICM-20608-D differs from the other ICM-20608 variants by having
a DMP (Digital Motion Processor) core tacked on.
Despite having a different WHOAMI register, this variant is
completely interchangeable with the other ICM-20608 variants
by simply pretending the DMP core doesn't exist.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
changelog:
 - v2: require specifying "invensense,icm20608" as a fallback
       compatible
 - v3: fix indentation
---
 .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index d69595a524c1..3ebc6526d82d 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -14,21 +14,25 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - invensense,iam20680
-      - invensense,icm20608
-      - invensense,icm20609
-      - invensense,icm20689
-      - invensense,icm20602
-      - invensense,icm20690
-      - invensense,mpu6000
-      - invensense,mpu6050
-      - invensense,mpu6500
-      - invensense,mpu6515
-      - invensense,mpu6880
-      - invensense,mpu9150
-      - invensense,mpu9250
-      - invensense,mpu9255
+    oneOf:
+      - enum:
+          - invensense,iam20680
+          - invensense,icm20608
+          - invensense,icm20609
+          - invensense,icm20689
+          - invensense,icm20602
+          - invensense,icm20690
+          - invensense,mpu6000
+          - invensense,mpu6050
+          - invensense,mpu6500
+          - invensense,mpu6515
+          - invensense,mpu6880
+          - invensense,mpu9150
+          - invensense,mpu9250
+          - invensense,mpu9255
+      - items:
+          - const: invensense,icm20608d
+          - const: invensense,icm20608
 
   reg:
     maxItems: 1
-- 
2.35.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFB45DAB8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 14:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354954AbhKYNKL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 08:10:11 -0500
Received: from box.trvn.ru ([194.87.146.52]:39733 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351738AbhKYNIK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Nov 2021 08:08:10 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Nov 2021 08:08:10 EST
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 503574014F;
        Thu, 25 Nov 2021 17:57:08 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1637845031; bh=vYw1cwfzx1ruPR428roA/t6gciJ6FkFZH0oCqf2RY5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=m58h3MFDvHfel4DC8gxVX2oQt3zqekbPySRMDP0RX8xwgHnT5XfM+nAG6kN9hJCVT
         CgcBLUz3DHhl8enonfdTuSmC09WqN3U37F8Wu2CxDUHqmI6J6Oe5HUZ5MSgl4tk2t+
         BdCEzIkuJFhv0l+c5RgWcnYvRHQjbX7kmfEL44j2FoMYCwHC19j2wt3JihftK2MC3w
         brkWlglWQp5236pwZehCbNGWC8SddDbL2D9012xjs0cyjqLwT4gZu7icvYrL1/s/La
         koxeX1FCflz4esaRFllDpt0VADnRUBI8TVKuHJOfk6guFWY9DCttWZRpNqYpzf0j3d
         Zus4pMJkZjwvQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/2] dt-bindings: iio: light: ltr501: Add proximity-near-level
Date:   Thu, 25 Nov 2021 17:56:45 +0500
Message-Id: <20211125125646.54831-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This value inidcates the proximity level that should be considered
"close".

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../devicetree/bindings/iio/light/liteon,ltr501.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index db0407bc9209..c8074f180a79 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -9,6 +9,9 @@ title: LiteON LTR501 I2C Proximity and Light sensor
 maintainers:
   - Nikita Travkin <nikita@trvn.ru>
 
+allOf:
+  - $ref: ../common.yaml#
+
 properties:
   compatible:
     enum:
@@ -25,6 +28,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  proximity-near-level: true
+
 additionalProperties: false
 
 required:
@@ -42,6 +47,8 @@ examples:
         light-sensor@23 {
             compatible = "liteon,ltr559";
             reg = <0x23>;
+            proximity-near-level = <75>;
+
             vdd-supply = <&pm8916_l17>;
             vddio-supply = <&pm8916_l6>;
 
-- 
2.30.2


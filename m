Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D82B6AA2
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgKQQrh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgKQQrh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 11:47:37 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B0DC221FC;
        Tue, 17 Nov 2020 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605631656;
        bh=IIUeQbnFA32zqrTbZkrGZ4imC9l33ASXc2wLsJ0SkyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+S1n8XSPvFOeDnNkJOAikaDGD8aSYu0z1eLkd0hEu3O2a2Olz/vURMqdbgofL/YG
         1ddDkZ4huqb20Tp7pf2bsR7rTrOsRdH+ZjT127PZs3+w1NJ3SdGgLH5gXhAPWwIeOo
         um1zG0ywVkigGReBuvzL5rZrHBasgxNGVQMogKuQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: st_lsm6dsx: introduce vdd-vddio regulators bindings
Date:   Tue, 17 Nov 2020 17:47:26 +0100
Message-Id: <ae812b48528c48555a753c081acf1c9bb6376cc6.1605631305.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605631305.git.lorenzo@kernel.org>
References: <cover.1605631305.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 49d0687e0c06..fc545a130b30 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -42,6 +42,12 @@ properties:
 
   spi-max-frequency: true
 
+  vdd-supply:
+    description: if defined provides VDD power to the sensor.
+
+  vddio-supply:
+    description: if defined provides VDD IO power to the sensor.
+
   st,drdy-int-pin:
     $ref: '/schemas/types.yaml#/definitions/uint32'
     description: |
-- 
2.26.2


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4044744F3E9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhKMP0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 10:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235945AbhKMP0f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 10:26:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0134A61152;
        Sat, 13 Nov 2021 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636817023;
        bh=Zr/+TRuhBCTVlFPXo508fLB62lAwfVC+qlp87/vU5rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrdPUxQzsH7t2gEfw161Y68XKqD1cHUsf3FcC7E09ynko9UmnK7qr+yj1W8gt7kHq
         lJOOfhlCizJsJgn1WE86WeLMEWUQyiSX4vVVgLhohXUJXStCtnMWs0yAem2t476+Er
         j6X2WWIROn9JGEFKUURShLnxBrtcw4FF4qsTkIpD1CfkMsOmO/8TNc1a+241Qzgr+W
         Mc3MGFzL370hYQIH8lR3ewm06y1PtQoheMpswMq1Jn3Bu2OOZvfb9pX0efciP+CU9z
         EozV0091jAYvSE+NRhPHm2z2iYMKGhqQDRaVer1UK5pN77LMSjP/rYLy9fntXNaE+K
         m6trbeJ0apBqA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation: dt: iio: st_lsm6dsx: add disable-sensor-hub property
Date:   Sat, 13 Nov 2021 16:23:15 +0100
Message-Id: <54287a93922ac839501b776d288cc368aa81f0ab.1636816719.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636816719.git.lorenzo@kernel.org>
References: <cover.1636816719.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable/disable internal i2c controller slave autoprobing at bootstrap.
Disable sensor-hub is useful if i2c controller clock/data lines are
connected through a pull-up with other chip lines (e.g. SDO/SA0).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index d9b3213318fb..0750f700a143 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -61,6 +61,13 @@ properties:
     type: boolean
     description: enable/disable internal i2c controller pullup resistors.
 
+  st,disable-sensor-hub:
+    type: boolean
+    description:
+      Enable/disable internal i2c controller slave autoprobing at bootstrap.
+      Disable sensor-hub is useful if i2c controller clock/data lines are
+      connected through a pull-up with other chip lines (e.g. SDO/SA0).
+
   drive-open-drain:
     type: boolean
     description:
-- 
2.31.1


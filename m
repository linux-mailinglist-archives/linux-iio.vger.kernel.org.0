Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A041A1D41
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgDHIPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 04:15:52 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:41314 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDHIPv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 04:15:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id E2E412008E88;
        Wed,  8 Apr 2020 16:10:30 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D8T_60G7NNbU; Wed,  8 Apr 2020 16:10:30 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id CA1132008987;
        Wed,  8 Apr 2020 16:10:30 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id C5E58C01F8A;
        Wed,  8 Apr 2020 16:10:30 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id BF63D201602; Wed,  8 Apr 2020 16:10:30 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio/dac: ltc2632.txt
Date:   Wed,  8 Apr 2020 16:10:24 +0800
Message-Id: <20200408081029.11167-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add support for Analog Devices (Linear Technology)
LTC26234 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
Update ltc2632.txt with the expansions for it.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
index 338c3220f01a..1ab9570cf219 100644
--- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
@@ -1,4 +1,4 @@
-Linear Technology LTC2632/2636 DAC
+Linear Technology LTC2632/2634/2636 DAC
 
 Required properties:
  - compatible: Has to contain one of the following:
@@ -8,6 +8,12 @@ Required properties:
 	lltc,ltc2632-h12
 	lltc,ltc2632-h10
 	lltc,ltc2632-h8
+	lltc,ltc2634-l12
+	lltc,ltc2634-l10
+	lltc,ltc2634-l8
+	lltc,ltc2634-h12
+	lltc,ltc2634-h10
+	lltc,ltc2634-h8
 	lltc,ltc2636-l12
 	lltc,ltc2636-l10
 	lltc,ltc2636-l8
-- 
2.20.1


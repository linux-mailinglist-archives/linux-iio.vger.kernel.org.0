Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D94B8DDA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiBPQXy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 11:23:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiBPQXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 11:23:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106322219C
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 08:23:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1nKN5Z-00018P-6l; Wed, 16 Feb 2022 17:23:33 +0100
Received: from jlu by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1nKN5Y-00014N-Gk; Wed, 16 Feb 2022 17:23:32 +0100
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: adc: microchip,mcp3201: fix interface type (I2C -> SPI)
Date:   Wed, 16 Feb 2022 17:23:12 +0100
Message-Id: <20220216162312.4064-1-jlu@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This family of ADCs uses SPI, not I2C.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 .../devicetree/bindings/iio/adc/microchip,mcp3201.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
index cbbac4ce56d6..fcc1ba53b20d 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Oskar Andero <oskar.andero@gmail.com>
 
 description: |
-   Family of simple ADCs with an I2C inteface.
+   Family of simple ADCs with a SPI interface.
 
 properties:
   compatible:
-- 
2.30.2


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B676A5514
	for <lists+linux-iio@lfdr.de>; Tue, 28 Feb 2023 10:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjB1JFd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Feb 2023 04:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjB1JFc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2023 04:05:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223514EB1
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2023 01:05:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvF-0002sB-Lk; Tue, 28 Feb 2023 10:05:21 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvE-000poL-Mz; Tue, 28 Feb 2023 10:05:20 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvD-002DrI-EA; Tue, 28 Feb 2023 10:05:19 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 1/5] dt-bindings: iio: ti,tmp117: fix documentation link
Date:   Tue, 28 Feb 2023 10:05:14 +0100
Message-Id: <20230228090518.529811-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228090518.529811-1-m.felsch@pengutronix.de>
References: <20230228090518.529811-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the broken link to point to the correct homepage.

Fixes: 5e713b25d137 ("dt-bindings: iio: temperature: Add DT bindings for TMP117")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v6:
- no changes
v5:
- no changes
v4:
- no changes
v3:
- no changes
v2:
- added Krzysztof ack

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 347bc16a4671b..8d1ec4d39b28c 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -9,7 +9,7 @@ title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
 description: |
     TI TMP117 - Digital temperature sensor with integrated NV memory that supports
     I2C interface.
-      https://www.ti.com/lit/gpn/tmp1
+      https://www.ti.com/lit/gpn/tmp117
 
 maintainers:
   - Puranjay Mohan <puranjay12@gmail.com>
-- 
2.30.2


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7B6FDB90
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjEJKXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEJKX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 06:23:29 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5194203;
        Wed, 10 May 2023 03:23:26 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A40428479E;
        Wed, 10 May 2023 12:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714205;
        bh=JDdGs3t5XylpTLWoLiYpR5h7wss+vk7lYzPeTgq+E6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHUovePtdLA/cpRVpqes4ac1Er0obTUYPLVtL5EWnunldJzItEcwXbg0c9vvJMfID
         AlVf4qTfPQ0BapDqffBtXhyILC9zOkjWcFPy6GBBfAX0lxTUdia7IPvNNr3OJD6Vo5
         BWOSyyVJ7Hrn7SIRh40CofNb7xGcEUnNyntW3IknE9VcnsaT1HhoW54/vY/q2lSXCO
         KPcWmsBhDfDRToPXDmyK1Twnm1ZeAzZV8YnyEJB+y+q8NVjFxMZarOTx+q7ouZRy9p
         kGRf3cvWFARhkWbb3d2xLtQzQTCzQQ3yFDGCAsACY8QbmgXTV2PkA7xDLNN2tp/gJZ
         k4TnK2XqnJ2Dw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 3/6] iio: mlx90614: Drop unused register macros
Date:   Wed, 10 May 2023 12:22:48 +0200
Message-Id: <20230510102251.10118-3-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510102251.10118-1-marex@denx.de>
References: <20230510102251.10118-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To simplify addition of support for new parts, drop unused register macros.
No functional change.

Acked-by: Crt Mori <cmo@melexis.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V2: New patch
V3: Add AB from Crt
---
 drivers/iio/temperature/mlx90614.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index bd92b24918253..b0f69a7b05abc 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -35,8 +35,6 @@
 #define MLX90614_OP_SLEEP	0xff
 
 /* RAM offsets with 16-bit data, MSB first */
-#define MLX90614_RAW1	(MLX90614_OP_RAM | 0x04) /* raw data IR channel 1 */
-#define MLX90614_RAW2	(MLX90614_OP_RAM | 0x05) /* raw data IR channel 2 */
 #define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
 #define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
 #define MLX90614_TOBJ2	(MLX90614_OP_RAM | 0x08) /* object 2 temperature */
@@ -52,8 +50,6 @@
 #define MLX90614_CONFIG_DUAL_MASK (1 << MLX90614_CONFIG_DUAL_SHIFT)
 #define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
 #define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
-#define MLX90614_CONFIG_GAIN_SHIFT 11 /* gain */
-#define MLX90614_CONFIG_GAIN_MASK (0x7 << MLX90614_CONFIG_GAIN_SHIFT)
 
 /* Timings (in ms) */
 #define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
-- 
2.39.2


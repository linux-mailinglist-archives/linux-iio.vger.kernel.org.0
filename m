Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC36F9B00
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGSrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEGSrK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 14:47:10 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA6611563;
        Sun,  7 May 2023 11:47:08 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1313B82156;
        Sun,  7 May 2023 20:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683485227;
        bh=SU7vJL8GrMT4anYZQY3VoC0fg1V/E+ltS/kcsV6J/Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpt4X3itPyx+FOLwn85i3gFucLTVoAdp8mRmJQv9GhkxJDEQGmo9naYCdEQRqVIlG
         TdroGOy5yiPNyhUMu2YUrr6I5ctN1Y76NAj8V8FsFqRJpBosQMxiltYX+h6Gxc00Nl
         vNK7qktLfBroZlNhMU4N7d8P8VGcIAXHe1ujBmUx3yzKcUrF/+7i00oM7oD2V+ss0N
         YiVnhS+CMV5wJRF10q9bcWV+eh32cZtthTn2nxYFmaCiym64aWy8KkttAXzfC3xA8u
         lo+HxP/pE9rr4HJY6lNxw21253qtjXPDtty39tT9LEizaONotFWDIx7T1K+lDQaEhT
         tHkvLm+XXJbwA==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] iio: mlx90614: Drop unused register macros
Date:   Sun,  7 May 2023 20:46:47 +0200
Message-Id: <20230507184649.39290-3-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507184649.39290-1-marex@denx.de>
References: <20230507184649.39290-1-marex@denx.de>
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


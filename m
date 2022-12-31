Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190B865A4EF
	for <lists+linux-iio@lfdr.de>; Sat, 31 Dec 2022 15:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiLaO2b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Dec 2022 09:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiLaO2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2022 09:28:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3EDEA5
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2022 06:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0DAFB8074C
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2022 14:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F921C433D2;
        Sat, 31 Dec 2022 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672496896;
        bh=1QkZrx7Aa7eDln4sYRts/qjFGicgXfSgJ1zUaVqQfhE=;
        h=From:To:Cc:Subject:Date:From;
        b=U9R1FFMocQLfIBiVK/u/70b8WmiIutNYYHaHRlkeeLKkchpbFXDG9XtOPhGOkHjFn
         NOzlRqcwZARTB4c73Dfh0Dv+1OwHNjxNCcz+rQM0h2OR5QjYseQSmNgDBgeZyLiw1T
         DD5+u80qEu8KERQpsLNCZv2iyW+MjGDS++LEJ45lcdJ4A7JjaeEbP6FKoiNRG2gA9/
         emqlGji8S7hjYgh97VKUVm6j/kLOVok4eF2ofaXNHIVTR5WUL23v1TUDagovg8igki
         IH2Z2KHGBkq5u0Ggtvowy1J4scUceH4xnMxUwBh2S4xMHkMatC3AVgP1pE230lKT3H
         vCxszousXeTpQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH] iio: adc: ep93xx: Enable wider build testing with COMPILE_TEST
Date:   Sat, 31 Dec 2022 14:41:28 +0000
Message-Id: <20221231144128.489810-1-jic23@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It is useful to be able to build this driver without needing
to build support for ARCH_EP93XX.

Also add an explicit dependency on HAS_IOMEM so we have
devm_platform_ioremap_resource() etc available.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
---
 drivers/iio/adc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 46c4fc2fc534..7d6e74189a2d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -441,7 +441,8 @@ config ENVELOPE_DETECTOR
 
 config EP93XX_ADC
 	tristate "Cirrus Logic EP93XX ADC driver"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Driver for the ADC module on the EP93XX series of SoC from Cirrus Logic.
 	  It's recommended to switch on CONFIG_HIGH_RES_TIMERS option, in this
-- 
2.39.0


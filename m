Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A56FDB8F
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjEJKXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjEJKX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 06:23:28 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329830D1;
        Wed, 10 May 2023 03:23:26 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 316BA84794;
        Wed, 10 May 2023 12:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714204;
        bh=KoH2z3gH1ar77Cmo4B6mEPvdWPpNne6NVMsge0K75L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LervrOqOcLn3zgggri7YKROgu/Axn74Ow+5tNt+ubO6yjN5bbjQe58yAJt6/t1qkz
         lMMaiHt25plfpGHIOigYhFR1J7EWIS9GCRl6y7gxTLmlXjx4eVuLhyEO1B9YM0wl9K
         nEaiOOlWFE6kMW6aofddboiJSLljRLo3bv76/jpXN3Z8czgl6fHZ7/ub+68zpLZdWQ
         cmMwlMeU/6p6iC8n62rcI0+hMoIb8cNViZ8t6meMyGU8eVSyMhMWFfqUQuNTuoTvI5
         UZVrO5NBL0s7VmEtB79GVFYaMRMeYDORSKp6SGNLP2TWkJ8euqLKYGDo2te9/6yr+x
         Nsz8pocQb0VFg==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 2/6] iio: mlx90614: Sort headers
Date:   Wed, 10 May 2023 12:22:47 +0200
Message-Id: <20230510102251.10118-2-marex@denx.de>
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

Sort the headers alphabetically. No functional change.

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
 drivers/iio/temperature/mlx90614.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 909fadb623491..bd92b24918253 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -19,12 +19,12 @@
  * the "wakeup" GPIO is not given, power management will be disabled.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/jiffies.h>
-#include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/iio/iio.h>
-- 
2.39.2


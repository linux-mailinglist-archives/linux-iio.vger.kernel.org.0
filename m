Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC176F9AFB
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEGSrL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEGSrK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 14:47:10 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768111559;
        Sun,  7 May 2023 11:47:08 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 901758214D;
        Sun,  7 May 2023 20:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683485226;
        bh=GCRKoa2++/RqvdPzk51SBf+p+Y15cT//ZipLZHhFTlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svtbIjb0jADa+0VEBBllSBQMDgWjDmYhLIzkpdDMXWoaVKnFCyKO4hvUx07XlFDzB
         CSz2YVGo12wxTI79gI0hV/FCdWc67BOwCuKY+BGudnBkcomBWLdd1LQNNh8obkBtbn
         KWdPtTDwLilF6v79n1chlbLMoBYxn+HhPBhyJDvZiHC3UVZwuRp48jp6XRtp7TPJGh
         UHn/anvaR7sk+5Gl7g0CCYP4X/jnDXqUGo2tpHlZfqwEI3Qzs6Y4jecdHzyyRgExaQ
         U+yY7+RrgHsoCrzmdUgJpL/I+B6zw84Tj5mkuPxKZjupkfMWUjk5fxtwM+V+RChayG
         DuBnApf/GZOGw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] iio: mlx90614: Sort headers
Date:   Sun,  7 May 2023 20:46:46 +0200
Message-Id: <20230507184649.39290-2-marex@denx.de>
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

Sort the headers alphabetically. No functional change.

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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000C44BD075
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiBTRp1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:45:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBTRp0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:45:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7874C43A
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1856060B87
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA856C340EB;
        Sun, 20 Feb 2022 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645379104;
        bh=OEWu8NT4+40KGN8kvAutLAcYmnhevGWaxdTDvNwf9U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4bWrSsmK6TUWZpVBtpJBTQp8KFgVg949wPNXobphgTg0UefkIJ9NNF7QNSVBFDUf
         8plf77Zdx+rGcsPl94iwrV/LcrdxGdLHzgdPfohzy7UAXx8+V9D/PoUBqbTOAtVGKj
         7W6KnOozLIdhGylrFIhA0dB/KQJZkdKXwBN/Z7GKNe98bBhmzQgZ6mM5ogaS3GgOtk
         QFKjEE60tEPit2n7QO0Mz2h8ZcYBdSdnXI08LR3m7Q5ZDiycdOeNpPkQS98XR/0RRn
         SZhTwpZYyzRJ7a6G26qD9NqRe3GH3E87tJfGRNehm9YtqXJBny+A457tLzmKa1mzrY
         tCczMjBAuouUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: gyro: mpu3050: Drop unused symbol exports.
Date:   Sun, 20 Feb 2022 17:51:48 +0000
Message-Id: <20220220175149.503495-2-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220175149.503495-1-jic23@kernel.org>
References: <20220220175149.503495-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver is built as a single module.  There is an note in the makefile
about SPI support being a reason to split the build in future. That
support has never arrived so drop these symbol exports.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ea387efab62d..8486261beb90 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1261,7 +1261,6 @@ int mpu3050_common_probe(struct device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(mpu3050_common_probe);
 
 int mpu3050_common_remove(struct device *dev)
 {
@@ -1279,7 +1278,6 @@ int mpu3050_common_remove(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(mpu3050_common_remove);
 
 #ifdef CONFIG_PM
 static int mpu3050_runtime_suspend(struct device *dev)
@@ -1299,7 +1297,6 @@ const struct dev_pm_ops mpu3050_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(mpu3050_runtime_suspend,
 			   mpu3050_runtime_resume, NULL)
 };
-EXPORT_SYMBOL(mpu3050_dev_pm_ops);
 
 MODULE_AUTHOR("Linus Walleij");
 MODULE_DESCRIPTION("MPU3050 gyroscope driver");
-- 
2.35.1


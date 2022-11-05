Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9862561DA78
	for <lists+linux-iio@lfdr.de>; Sat,  5 Nov 2022 13:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKEMv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Nov 2022 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2022 08:51:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1926130
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 05:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60DBCB81CC0
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 12:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC2AC433C1;
        Sat,  5 Nov 2022 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667652682;
        bh=z3bakntnLpwk0wf1kbFb07a/JsroO2LkBq8WCH3O7+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv8P5mNVuPoX2EId/CIxGQpZ/A93NWxaejHdiNp2Eln06Sn4tHXUCRbKdp/IgtUFy
         JkNyxaJJ0DB045xEg5VobFYspKi0F5Vs+NWHcHtCX2naqJMEMFDjamtZ6GM37++4tj
         RGlD6Xay0QFj2unNFscECUAuNb9bVFhCgUcPjbffvbKrdYwomnHA1R9lAkkKBJSTjp
         uEm1h4Pnb0Rd/gPMLAejUkLcootHR1NAUQOjXOyolIMJUAS/Ck85/AQk/pxGzgVD47
         1H1vrennt87ZGpzmt6tOPTlZeOrvtjau4c359FUIv4kZxaZX/gIk5u+bu7syS6nAVP
         TUXywO0IZN1vg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Cc:     coverity-bot <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: [PATCH 1/2] iio: temperature: mlx90632: Add error handling for devm_pm_runtime_enable()
Date:   Sat,  5 Nov 2022 12:51:07 +0000
Message-Id: <20221105125108.383193-2-jic23@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221105125108.383193-1-jic23@kernel.org>
References: <20221105125108.383193-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This call can fail so handling is necessary even if it is very unlikely.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527134 ("Error handling issues")
Fixes: c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/mlx90632.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index a17fe5f4967a..7572ae3f8432 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1267,7 +1267,10 @@ static int mlx90632_probe(struct i2c_client *client,
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_set_active(&client->dev);
 
-	devm_pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 	pm_runtime_put_autosuspend(&client->dev);
-- 
2.38.1


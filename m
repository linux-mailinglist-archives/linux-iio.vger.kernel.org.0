Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED061DA79
	for <lists+linux-iio@lfdr.de>; Sat,  5 Nov 2022 13:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKEMv2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Nov 2022 08:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2022 08:51:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CE226130
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 05:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8FB1ECE0B88
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 12:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87543C433D7;
        Sat,  5 Nov 2022 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667652683;
        bh=X8zARHHEFGL++JOLXrJ9/ZpJfEgsTUHSU0HOyaDXJdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccM9KSP8M1Wwk7B0wqkL1S9vKzgErWOPThIFdio3tV2eXHa3gEcqtnqKjLiNuZuuJ
         7jRCAHmzpP+vGenGrdyL9Cp0vepm89hk1iBDBZxYUEkcHYKbbM2wtZEpbi94UobvKw
         qWvZjOvha7BQ04gVecI4zSZK7wRGtRpCBL2hWtyXjrpFfW6J5hLxJxEwV4+TifX/Dp
         DTyKSYaLbz3y94IcbM7hz73IKB8EDTHVX/UHUu8DiZOdf0I/soSDSerrT2Kxqzw+8g
         n1hGuWossYaqziQrOHaED/h4ndENnzUcwF9wDLUdx9/Bu7i8zB8u58hLY5R8+CrlDC
         DpRHDwZ9do6Sw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Cc:     coverity-bot <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: temperature: mlx90632: Add missing static marking on devm_pm_ops
Date:   Sat,  5 Nov 2022 12:51:08 +0000
Message-Id: <20221105125108.383193-3-jic23@kernel.org>
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

Only used within this file, so should be marked static.

Fixes: c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/mlx90632.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 7572ae3f8432..f1f5ebc145b1 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1326,7 +1326,7 @@ static int mlx90632_pm_runtime_suspend(struct device *dev)
 	return mlx90632_pwr_set_sleep_step(data->regmap);
 }
 
-const struct dev_pm_ops mlx90632_pm_ops = {
+static const struct dev_pm_ops mlx90632_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
 	RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend, NULL, NULL)
 };
-- 
2.38.1


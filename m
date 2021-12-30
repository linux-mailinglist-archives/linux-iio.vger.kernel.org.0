Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657CE481EB7
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbhL3RoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28295C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:44:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDDB6173B
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F36C36AEB;
        Thu, 30 Dec 2021 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886254;
        bh=Ifd4Ce35sAzJ1B66274VbKqgP2IboGm+AwhlRu7Zzo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4vpE/oCS5p5qpVhZTMl9dD+Syo3LqCHbj/IUHfbNW18tyNBz1c4rJbkT2rchOqrc
         52s2vCref+xh605uP1DMufj1+xR/8gy+fyKyIjyTul0b0zS4Jq2gUR9ue/n9v02sJg
         OkR9V9bN/x1p3Fq4G0ZGCvbADdHye3DcRgzkeQcPXXBdd9uk9c3tAZZ6e3AGYoV4rq
         EY48yWtBqmqOWkJoTYwSouOHzZhB5BR/2yyO3jxZ66DKrU090/O3FjNalmSkP8nTje
         i5DyGmLDrFvUqwdlwBfD/J4zoDOq5zxMkvieDFZ8xjXZrVqi5kKKSXJhDAasNEP7Cc
         SC8TjHbEtVsEA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>
Subject: [PATCH 11/16] iio:adc:mt6577_auxadc: Tidy up white space around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:06 +0000
Message-Id: <20211230174911.78291-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously inconsistent with space after { and not before }.
Tidy that up to avoid providing a bad example to copy into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Hui Liu <hui.liu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index d4fccd52ef08..327fff96c6c8 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -330,11 +330,11 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
 			 mt6577_auxadc_resume);
 
 static const struct of_device_id mt6577_auxadc_of_match[] = {
-	{ .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat},
-	{ .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat},
-	{ .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat},
-	{ .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat},
-	{ .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat},
+	{ .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat },
+	{ .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat },
+	{ .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat },
+	{ .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat },
+	{ .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
-- 
2.34.1


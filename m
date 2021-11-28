Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF59460805
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbhK1R1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358649AbhK1RZI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:25:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F5C061758
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 09:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9226C61040
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80121C53FC7;
        Sun, 28 Nov 2021 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120004;
        bh=0WmxHwWc6/P0y6tPIztENG7TSJrfTZbvp7ABdU3fgUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqdIPJw+b4b3S2rAykCKto78try+2hjoZFq8d0db2jiaXtLKFGk+eo7kAF3E9R2Rk
         9KBoxZxEWcDl9HMGJTJYMwJuUjRArNEw5aFCdwZ4vJn5I7/Nw3ZMv2clpXZ1lgts8d
         IValmVef68YSF1T5em21/6nQDk4W+rzwnjLbWwTXPoGBrb4ye5MmPsZhz2QersYxNx
         mIbAOBEd86jCgyzq/GFMHTrHgBIb7+VVTgoSMdKl3ojZ/TfdLv1k7b/TmyZMuNEOrn
         7nHs+SLoUPhfE30hBdJeOMMyBBXxDUvWhB/4+0oDcjdTzHldlb1o0DSWzA8oPA47rc
         gaBLDyJsxJSWg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 05/12] iio:amplifiers:hmc425a: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:38 +0000
Message-Id: <20211128172445.2616166-6-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cast to a uintptr_t rather than directly to the enum.

As per the discussion in below linked media patch.

Link: https://lore.kernel.org/linux-media/CAK8P3a2ez6nEw4d+Mqa3XXAz0RFTZHunqqRj6sCt7Y_Eqqs0rw@mail.gmail.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/iio/amplifiers/hmc425a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 9efa692151f0..16c0a77f6a1c 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -192,7 +192,7 @@ static int hmc425a_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->type = (enum hmc425a_type)of_device_get_match_data(&pdev->dev);
+	st->type = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	st->chip_info = &hmc425a_chip_info_tbl[st->type];
 	indio_dev->num_channels = st->chip_info->num_channels;
-- 
2.34.1


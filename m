Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7F36B771
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhDZRFC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235072AbhDZRE7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:04:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 560C2613A9;
        Mon, 26 Apr 2021 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456657;
        bh=MKCN78y5X5pxozMKNglCOiIWKwUXvCCmulsbqPzyek8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9NdLga7vl766LbuwJyguG83JpYUQKl56Hu7jHuYyw8vC+fdfvIv9k2wUi4eHzI90
         eVjAktXh9p2ILrgRkT6lnBB7uJEQcthPvZvdXarThoy52jE0+1gnMCdRZsT3GCQJfi
         P5Pkz19+fuZTj5GvF2RgiOe5olKWyw5hOWn5HMNyw2wufT38ICWVFlWYGS/dKwS2f4
         74OkWVD+9UJeXjUwtrXvSbR66cntxGM/veQd3xJu5EHiSMJ+izdnYCDVqh/QMoJc6I
         lhdAerz+mOE51Pvm1Axagzh7qP2S3w9xPFsp+JNPF5JpiMSG8jvsJRJHA+wgF89eJX
         kx4VHmME6NjbQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gene Chen <gene_chen@richtek.com>
Subject: [PATCH 4/8] iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:47 +0100
Message-Id: <20210426170251.351957-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Already set to the same value in devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gene Chen <gene_chen@richtek.com>
---
 drivers/iio/adc/mt6360-adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 6b39a139ce28..07c0e6768391 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -337,7 +337,6 @@ static int mt6360_adc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &mt6360_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mt6360_adc_channels;
-- 
2.31.1


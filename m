Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE4352F6E
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhDBSsB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235984AbhDBSsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:48:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A439610F7;
        Fri,  2 Apr 2021 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389279;
        bh=LO3OK5SaKTZNyAqTbR8Q2YS2+sAo08q4vqxQkYNhS8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1UMKctfk1fBs1za06fBw/D22ob+3RoqfiA68/3zmf/UVaVH0oxw9Hy5JC8zuu7Se
         hLdT2FEvY6IiDGhSUqlABYJOV8vaKGqoC9ix/+Dcey6gnVIPs68Poh+kZoa9FlW/j/
         xjwZdgd5owrsl8jYeeyyV5VW3p6iQ4dWlxKtjOzNMb+vD5Z4PyXQ70NE0XXpwbzgxB
         Vd+LGRINIbIW/NYFw6BYevCuPuYEEX3r0i15elpLls5/g7KBPOGutS9MzVrVrcagWe
         UZEtScBD91BpDrJObb/+vmFmjurGyVskxdkrbUN1DPO29xoigXItHf1BJIscGp1YGj
         nWBohCm3B6gQA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 7/7] iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than request and disable
Date:   Fri,  2 Apr 2021 19:45:44 +0100
Message-Id: <20210402184544.488862-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These devices are not able to mask the signal used as a data ready
interrupt.  As such they previously requested the irq then immediately
disabled it.  Now we can avoid the potential of a spurious interrupt
by avoiding the irq being auto enabled in the first place.

I'm not sure how this code could have been called with the irq already
disabled, so I believe the conditional would always have been true and
have removed it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 9289812c0a94..e777ec718973 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -485,18 +485,15 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 	sigma_delta->trig->ops = &ad_sd_trigger_ops;
 	init_completion(&sigma_delta->completion);
 
+	sigma_delta->irq_dis = true;
 	ret = request_irq(sigma_delta->spi->irq,
 			  ad_sd_data_rdy_trig_poll,
-			  sigma_delta->info->irq_flags,
+			  sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
 			  indio_dev->name,
 			  sigma_delta);
 	if (ret)
 		goto error_free_trig;
 
-	if (!sigma_delta->irq_dis) {
-		sigma_delta->irq_dis = true;
-		disable_irq_nosync(sigma_delta->spi->irq);
-	}
 	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
 
 	ret = iio_trigger_register(sigma_delta->trig);
-- 
2.31.1


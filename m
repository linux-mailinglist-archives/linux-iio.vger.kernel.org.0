Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38B6377679
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEILnZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhEILnZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:43:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED2C86128C;
        Sun,  9 May 2021 11:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560542;
        bh=U0s+p5WV13iA2iaJd8cYUx5HB1MBxeE5PINOZVEifZM=;
        h=From:To:Cc:Subject:Date:From;
        b=CqNmNV/225GD+0NLqf2sSC4r+wsYKcFlitvI3UDLOJ34Ymo7DPpJUnibvjgRUeEqT
         HMAd8CnifI+IUQwKkhOfcV0Dv7Pejt2WPogziC/o4jL1is2oRT8iPglfzU2iYVr/R4
         icKYuEukd4WhwimVGL/vlxrKF65pPXb3ePTsSpiOAvE1F/9ICeONIxRkcKEBGZFmVk
         5KtAVqJcubmZ6wA0zPdwgriVw5WQwK2jW07kS3HW6pu4jRZhuiuykldItu5er/z3WF
         fW4gYN1z9Sij4M7qi5zfE1DlwoysgLAFY+3/AO0Vhe1qPsED24849N8b1bX/DsN91C
         TNshCTqPQ/S1w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Sun,  9 May 2021 12:41:18 +0100
Message-Id: <20210509114118.660422-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found by inspection.

If the internal clock source is being used, the driver doesn't
call clk_prepare_enable() and as such we should not call
clk_disable_unprepare()

Use the same condition to protect the disable path as is used
on the enable one.  Note this will all get simplified when
the driver moves over to a full devm_ flow, but that would make
backporting the fix harder.

Fix obviously predates move out of staging, but backporting will
become more complex (and is unlikely to happen), hence that patch
is given in the fixes tag.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/adc/ad7192.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2ed580521d81..d3be67aa0522 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1014,7 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
 	return 0;
 
 error_disable_clk:
-	clk_disable_unprepare(st->mclk);
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
+		clk_disable_unprepare(st->mclk);
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_dvdd:
@@ -1031,7 +1033,9 @@ static int ad7192_remove(struct spi_device *spi)
 	struct ad7192_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->mclk);
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
+		clk_disable_unprepare(st->mclk);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
 	regulator_disable(st->dvdd);
-- 
2.31.1


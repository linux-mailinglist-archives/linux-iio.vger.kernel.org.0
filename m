Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C83A5959
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhFMPXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhFMPXT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 956436135A;
        Sun, 13 Jun 2021 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597677;
        bh=2YrdloDFiGofABSM2biMcXE1AyP4jOJacY4rXJGqyQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ak+sx10dZOgY+D3kyx4pmFITqq6k/9Jy3GuURq5v8TsxnU8f2gSejp4o4/oTnp4q4
         iVh3490d/ectTWCQw12biWY18g9NMUoi3v/X8JHIBDf6UHIzZt9XfrH+Ig+p6Ar1Ma
         67SAQwgOhkESXCAqPv9nB7l//qR5AWGliE/PLy0PtUPqZ0pbJE2zojTP8SGfVwMljy
         zXC7RwwIAgztry7xks8kxLo44q5OCkTgAyizPcgp9DMCl87UlKabNdLapuNcx4/nuY
         CfDj5+byh0l4zj9Sf7G9ecZdqek8DvW8GYbc6O8OuIYTrYQBWtbiHLXaybkQ0iV6Av
         MciJNsVF9/Nlw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH RESEND 4/8] iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:22:57 +0100
Message-Id: <20210613152301.571002-5-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613152301.571002-1-jic23@kernel.org>
References: <20210613152301.571002-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Fixes: f214ff521fb1 ("iio: ti-ads8688: Update buffer allocation for timestamps")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads8688.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 16bcb37eebb7..79c803537dc4 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -383,7 +383,8 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
+	/* Ensure naturally aligned timestamp */
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
-- 
2.32.0


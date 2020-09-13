Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FF267F60
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgIMLun (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 07:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgIMLth (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 07:49:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1C42158C;
        Sun, 13 Sep 2020 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599997776;
        bh=WlaW1TTHR2edtshPhX7yWJzq2XnCWFTUr564mPCfk2U=;
        h=From:To:Cc:Subject:Date:From;
        b=vCyVWC68EVvBEGpkHC1eSRkJRnoxwhweO9F9M/cvFvZFO4ee05T3OAHE81FNg8Led
         kDv3wKe9jdw2Rbkg+Ckam5u9ztEbVutnft/2VK1WIqD7AJnnHnV20EX0YSmj7WQXOo
         heyBN1Xe975C20svAZXfpi+BhMqDh5pOUlZo6+wM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio:dac:ad5592r: Fix use of true where iio_shared_by enum required
Date:   Sun, 13 Sep 2020 12:47:31 +0100
Message-Id: <20200913114731.739478-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given true evaluates to 1, this should IIO_SHARED_BY_TYPE.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index cc4875660a69..456bf5292c44 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -488,7 +488,7 @@ static const struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
 	{
 	 .name = "scale_available",
 	 .read = ad5592r_show_scale_available,
-	 .shared = true,
+	 .shared = IIO_SHARED_BY_TYPE,
 	 },
 	{},
 };
-- 
2.28.0


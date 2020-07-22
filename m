Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A042229A0F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGVO1V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 10:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVO1V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 10:27:21 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4306520709;
        Wed, 22 Jul 2020 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595428041;
        bh=e560MqlIQGcpW0NfXP4fAg4UJM5sPDo2h8FDhCmQB+k=;
        h=From:To:Cc:Subject:Date:From;
        b=xQKyBt6ASYhVYWztO3mX3JFRLfOLtgFVBXcBBC4cUGSGbccPFQ0C/0tSEASq/CNQF
         sASzvFwbD+X3WnxjAJu6QiSxiePSGdTejKmpJboaqrtsrbnQoQFhYhsZ/LHi5daPTQ
         ZWy63DRjME9hIoGqWEqR1snh4rM1Jblg5HkZ80LQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio:dac:ad5592r: Fix use of true for IIO_SHARED_BY_TYPE
Date:   Wed, 22 Jul 2020 15:25:15 +0100
Message-Id: <20200722142515.897378-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

struct iio_chan_spec_ext_info shared element is of type
enum iio_shared_by, not boolean.   It's like the enum value
will for IIO_SHARED_BY_TYPE == 1 == true, hence no actual
problem has been observed.

  CC [M]  drivers/iio/dac/ad5592r-base.o
drivers/iio/dac/ad5592r-base.c:491:13: warning: implicit conversion from ‘enum <anonymous>’ to ‘enum iio_shared_by’ [-Wenum-conversion]
  491 |   .shared = true,
      |
Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
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
2.27.0


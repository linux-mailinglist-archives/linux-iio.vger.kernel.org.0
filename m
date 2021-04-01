Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCF351860
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhDARpq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhDARiV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 512D3613C9;
        Thu,  1 Apr 2021 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617297606;
        bh=ppFkbyhE1z8HEc1Vjh/sVhlr9mfGa9Nh8NUjxIGBCr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8IqReJrPDBe28rX9SpHJnVzragn++d0qpzhAmvdxvmFW1CVtSQwL2XX2tZjVr76f
         itxUNu0C7yvskWFvFHhBJpJ79KOQjYxqFeB8Cmi1gcpcI213MUsi6+xLTPBf8gsK56
         KYIF+KUdCS2D4nTwkNE3EU4g1J055EWzwEE0SGBWi/DwyO2bE4iXvtlr0/lTqwVCfP
         Mu9dL7/vspVMjqlehguS98RUhWz3HZSRqSu80IyEeICZb5rvCJx7PDo8nyo/xOOW8+
         1A5ilHPpiVmqQDTCr6Pyey/ZH7u72NTCpPgylrHkCLVS6ShK/gAnRb+yIybQvpRRKq
         ixpSU5JKnRbrw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/3] iio:adc:ad7476: Fix remove handling
Date:   Thu,  1 Apr 2021 18:17:57 +0100
Message-Id: <20210401171759.318140-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401171759.318140-1-jic23@kernel.org>
References: <20210401171759.318140-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver was in an odd half way state between devm based cleanup
and manual cleanup (most of which was missing).
I would guess something went wrong with a rebase or similar.
Anyhow, this basially finishes the job as a precusor to improving
the regulator handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 4bb2b8f94ace3 ("iio: adc: ad7476: implement devm_add_action_or_reset")
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/adc/ad7476.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 17402714b387..9e9ff07cf972 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -321,25 +321,15 @@ static int ad7476_probe(struct spi_device *spi)
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			&ad7476_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      &ad7476_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	if (st->chip_info->reset)
 		st->chip_info->reset(st);
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_ring_unregister;
-	return 0;
-
-error_ring_unregister:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7476_id[] = {
-- 
2.31.1


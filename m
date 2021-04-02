Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30B5352F68
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBSrq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDBSrq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42BCF61163;
        Fri,  2 Apr 2021 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389264;
        bh=F5DJLUEddjefE0vfPGumnLhU2dCP5adrDt+DWAnO6WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5pqJSLuFH0XcuaGdgaz6CNMgw2IqYWEqzMqrhZp6mAbBnXQbXMthegnBbySLXifP
         cDNdb/LyOrdlFLK2dytoD5iW76wCl4xZezSDrQkbEcjMRSwhh6kLCgXgWQk06aZhEn
         FD5oihX9ReYvaL+3fbLZ7cpRFEI01YHFQHWa/gn4IIac5umUO4iqNUays12HrITeak
         OiurqtlmjMYySx6vjHvs+4msR3hEwc4QloOoJAG6felSDUOESXW9l+25Bf+ByE5lMG
         cAr2bw3sU/+3kuWazLNQiz6r/Mpuo0ch/w3Glwx6luCa2VfTSKp2YDhXL996Gds1nN
         b7hWwY21GvY0Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce boilerplate
Date:   Fri,  2 Apr 2021 19:45:38 +0100
Message-Id: <20210402184544.488862-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As iio_poll_trigger() is safe against spurious interrupts when the
trigger is not enabled, this is not a fix despite looking like
a race.  It is nice to simplify the code however so the interrupt
is never enabled in the first place.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7766.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 829a3426f235..1e41759f3ee5 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -255,18 +255,17 @@ static int ad7766_probe(struct spi_device *spi)
 		ad7766->trig->ops = &ad7766_trigger_ops;
 		iio_trigger_set_drvdata(ad7766->trig, ad7766);
 
-		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
-			IRQF_TRIGGER_FALLING, dev_name(&spi->dev),
-			ad7766->trig);
-		if (ret < 0)
-			return ret;
-
 		/*
 		 * The device generates interrupts as long as it is powered up.
 		 * Some platforms might not allow the option to power it down so
-		 * disable the interrupt to avoid extra load on the system
+		 * don't enable the interrupt to avoid extra load on the system
 		 */
-		disable_irq(spi->irq);
+		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
+				       dev_name(&spi->dev),
+				       ad7766->trig);
+		if (ret < 0)
+			return ret;
 
 		ret = devm_iio_trigger_register(&spi->dev, ad7766->trig);
 		if (ret)
-- 
2.31.1


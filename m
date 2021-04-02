Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162BD352F6D
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBSr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235984AbhDBSr5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E121F61165;
        Fri,  2 Apr 2021 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389276;
        bh=CFKEc8jc9gcci7Nas4wpWCdX7cSyWVcn93Il6hm6K88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK7qJiTPFAk2kpcexFfXngYtyBBOJG6v10y/44wX9wIWlKEzM+k3oaqjA2mHLZfbm
         zHkjTBtbX7YQIClD1khvKLuDclHYkPWG5KOJdr1zR59s5OkL9CmltlRvQgC5HIKucs
         FLl1ne/1aaX9qfOWi0u01Sj8qbRc3OjJDeXESqsQN5XOTvGS2cBIZ6wXvQq4CLueBO
         L/HsAf+sHmvZdO/+iF5j+htOkumWdPotCoNtcr8NLH4FOWY39UcWCqI3+JXBpc+3lE
         r845cAuma7FiAwCwEkNZJfeE10WHFmMS6IfC9dvNsgyfICVKNp5rPKeePYAro1L3Ne
         Aac2J41ZJa9mA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable
Date:   Fri,  2 Apr 2021 19:45:43 +0100
Message-Id: <20210402184544.488862-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a bit involved as the adis library code already has some
sanity checking of the flags of the requested irq that we need
to ensure is happy to pass through the IRQF_NO_AUTOEN flag untouched.

Using this flag avoids us autoenabling the irq in the adis16460 and
adis16475 drivers which cover parts that don't have any means of
masking the interrupt on the device end.

Note, compile tested only!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Cc: Nuno Sa <Nuno.Sa@analog.com>
---
 drivers/iio/imu/adis16460.c    |  4 ++--
 drivers/iio/imu/adis16475.c    |  5 +++--
 drivers/iio/imu/adis_trigger.c | 11 ++++++-----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 74a161e39733..73bf45e859b8 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -403,12 +403,12 @@ static int adis16460_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/* We cannot mask the interrupt, so ensure it isn't auto enabled */
+	st->adis.irq_flag |= IRQF_NO_AUTOEN;
 	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
 
-	adis16460_enable_irq(&st->adis, 0);
-
 	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 8f6bea4b6608..1de62fc79e0f 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1258,6 +1258,9 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 		return -EINVAL;
 	}
 
+	/* We cannot mask the interrupt so ensure it's not enabled at request */
+	st->adis.irq_flag |= IRQF_NO_AUTOEN;
+
 	val = ADIS16475_MSG_CTRL_DR_POL(polarity);
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
 				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
@@ -1362,8 +1365,6 @@ static int adis16475_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	adis16475_enable_irq(&st->adis, false);
-
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 0f29e56200af..39b50d6fdb6a 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -29,18 +29,19 @@ static const struct iio_trigger_ops adis_trigger_ops = {
 
 static int adis_validate_irq_flag(struct adis *adis)
 {
+	unsigned long direction = adis->irq_flag & IRQF_TRIGGER_MASK;
 	/*
 	 * Typically this devices have data ready either on the rising edge or
 	 * on the falling edge of the data ready pin. This checks enforces that
 	 * one of those is set in the drivers... It defaults to
-	 * IRQF_TRIGGER_RISING for backward compatibility wiht devices that
+	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
 	 * don't support changing the pin polarity.
 	 */
-	if (!adis->irq_flag) {
-		adis->irq_flag = IRQF_TRIGGER_RISING;
+	if (!direction) {
+		adis->irq_flag |= IRQF_TRIGGER_RISING;
 		return 0;
-	} else if (adis->irq_flag != IRQF_TRIGGER_RISING &&
-		   adis->irq_flag != IRQF_TRIGGER_FALLING) {
+	} else if (direction != IRQF_TRIGGER_RISING &&
+		   direction != IRQF_TRIGGER_FALLING) {
 		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
 			adis->irq_flag);
 		return -EINVAL;
-- 
2.31.1


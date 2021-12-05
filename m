Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88409468D37
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbhLEU0F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:26:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38760 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhLEU0E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:26:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427526114C
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AE0C341C4;
        Sun,  5 Dec 2021 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735756;
        bh=EPR/+ItTrYfx5i7FUwVb0DNwhGltgJGgJ7e4hO2bvK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewJojDrnAYs5gtegYLpU2s1eMtaFPoR7T2QrckhzYH8PM+UcPy7yQbDHsgiW7lIjc
         a+wdp3LwiCmwx/nrPz/Fwqep25DK3mm2c53ulV7c/h61aRuf9/1yqN2+BfkrjDOvyx
         mS+HYbjHnzwQHx3lXJfj3E8dYW3LJ/ZHdGX8PoycJBKeyv0FFvwa0k1beW+eWNOOYg
         b0S7mBw7C4kHqCGU9w7ux3WQy58o6PspeRP8QA8CVbZRfOBxV578b4kWtZiovr8GJI
         s3F+RvNgKGFdyTzKejZKAyA6mEKEB/BkrhP4z9Ont7yQKiTdlfJmE2RnE1O6oCa64I
         xbPdE+tFzf7PA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 13/17] staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
Date:   Sun,  5 Dec 2021 20:27:06 +0000
Message-Id: <20211205202710.2847005-14-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We use this a few times already and it is about to get worse, so
introduce a local variable to simplify things.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b4ba6da07af9..acaae1b33986 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -940,11 +940,12 @@ static const struct ad7280_platform_data ad7793_default_pdata = {
 static int ad7280_probe(struct spi_device *spi)
 {
 	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
 	struct ad7280_state *st;
 	int ret;
 	struct iio_dev *indio_dev;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -976,7 +977,7 @@ static int ad7280_probe(struct spi_device *spi)
 	st->aux_threshhigh = 0xFF;
 	st->acquisition_time = pdata->acquisition_time;
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
+	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
 	if (ret)
 		return ret;
 
@@ -1005,7 +1006,7 @@ static int ad7280_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+		ret = devm_request_threaded_irq(dev, spi->irq,
 						NULL,
 						ad7280_event_handler,
 						IRQF_TRIGGER_FALLING |
@@ -1020,7 +1021,7 @@ static int ad7280_probe(struct spi_device *spi)
 		indio_dev->info = &ad7280_info_no_irq;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7280_id[] = {
-- 
2.34.1


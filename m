Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662BF3A65BB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhFNLmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234688AbhFNLhb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7400B613D3;
        Mon, 14 Jun 2021 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670431;
        bh=DdhD+UYIptRwCAyJgGEgxEJPQ7/pKpn2YAzl6dapdBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSDPCMMsUOJx4CEI3SFkJHoGP8nI6Y/p06EvcRp4xKSADg9Dm7e1Z5cPbXmyn+MeC
         NOr2jD+vi/jkgl7kiOh6dsrmGN72NilxV7ZIVzzfZvNzGW5enYXDpT7lA5rAITqEiI
         xj9POHobUC/sKW9rkWAMT0RPbcsymVDmLai7IzTq05yFYKbyjvxD2Olmm4lnlrgJsg
         /u/AjcfAj7jAtBYY5hYJWj5G0zdIKLIKNS7Ih+uUxaQ17vKmHYctu5WXvB0Ebczdmy
         yWgMBEgjZYr0xsodzymmmfTY01XcOW1Wfux8EVbVw5dM4wnizOA00fXW2pIffw4T9B
         6AmGfkc2AWcYg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/17] staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
Date:   Mon, 14 Jun 2021 12:35:03 +0100
Message-Id: <20210614113507.897732-14-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
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
2.32.0


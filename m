Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5123F3A3C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Aug 2021 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhHUKiH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Aug 2021 06:38:07 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:24768 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229968AbhHUKiG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Aug 2021 06:38:06 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d73 with ME
        id kAdR250043riaq203AdR54; Sat, 21 Aug 2021 12:37:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 12:37:26 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        angelo.compagnucci@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: adc128s052: Fix the error handling path of 'adc128_probe()'
Date:   Sat, 21 Aug 2021 12:37:24 +0200
Message-Id: <85189f1cfcf6f5f7b42d8730966f2a074b07b5f5.1629542160.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A successful 'regulator_enable()' call should be balanced by a
corresponding 'regulator_disable()' call in the error handling path of the
probe, as already done in the remove function.

Update the error handling path accordingly.

Fixes: 913b86468674 ("iio: adc: Add TI ADC128S052")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/ti-adc128s052.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 3143f35a6509..83c1ae07b3e9 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -171,7 +171,13 @@ static int adc128_probe(struct spi_device *spi)
 	mutex_init(&adc->lock);
 
 	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_disable_regulator;
 
+	return 0;
+
+err_disable_regulator:
+	regulator_disable(adc->reg);
 	return ret;
 }
 
-- 
2.30.2


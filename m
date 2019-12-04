Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D8112308
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 07:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfLDGpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 01:45:40 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:25687 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDGpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 01:45:40 -0500
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d51 with ME
        id Zilc210093xPcdm03ilcDj; Wed, 04 Dec 2019 07:45:38 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 04 Dec 2019 07:45:38 +0100
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, justinpopo6@gmail.com, linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: adc: ti-ads7950: Fix a typo in an error message
Date:   Wed,  4 Dec 2019 07:45:35 +0100
Message-Id: <20191204064535.13025-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix a typo:
   s/get get/to get/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 2e66e4d586ff..f9edc1207f75 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -602,7 +602,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 
 	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(st->reg)) {
-		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
+		dev_err(&spi->dev, "Failed to get regulator \"vref\"\n");
 		ret = PTR_ERR(st->reg);
 		goto error_destroy_mutex;
 	}
-- 
2.20.1


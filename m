Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69A3918D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2019 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfFGQFJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 12:05:09 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40382 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbfFGQFJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2019 12:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559923508; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=hNMNkjEA3+4rNF+yp5nWqqoJfF6+ddjC2q7b5Wtp9Vo=;
        b=UDg/xRtWKDpep/pPM+s7gBNeP1FLR4eKwaUveYyy0cPx688uODdZ+9JeBTZP8cjJ3A8weK
        ZScRPGwxuoWkuZ2hNwzGj/K1Ot7ezBKiHyhpmZh2at/IZe9JCM2F6AX781iV7+i/lEnOkm
        h3sjWnPoneAoss7qB8zXKqoVNB7UjN0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>, od@zcrc.me,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] iio: ingenic-adc: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:05:01 +0200
Message-Id: <20190607160501.16369-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/ingenic-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 92b1d5037ac9..027f710df843 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -279,7 +279,7 @@ static const struct iio_chan_spec ingenic_channels[] = {
 	},
 };
 
-static int ingenic_adc_probe(struct platform_device *pdev)
+static int __init_or_module ingenic_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iio_dev *iio_dev;
-- 
2.21.0.593.g511ec345e18


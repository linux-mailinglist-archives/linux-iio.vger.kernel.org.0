Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBFF440ED0
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhJaOY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:57544 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ruVHB659mhcGzeiGKWvxI8ixOd980ICZrhUgFXELi0Y=; b=eCc5Cu68rEs5OPfFF+r1Xd2x21
        pV08X1NiwGCrEjEYFEg1PAkbJ5mh9DrUcdI7sq2G3mMfQHOmBB8e5ltv4OXBFz7M1WEkN7sMh9yrE
        sS8SCHGdKNriHIj1g/mL5GS6Z/BP5iaoHQHGHcb8klA9XsKAWglY/jJcrzyS2LXfoq8kx0tJkfQRP
        x5OJPPw/wbfDT1+RYJSU3fFk1T7jcGXXJMwBA8HiRxHPcoiWxeSo3AvihfFywm0vm18WeD5Z8gwUx
        kU3t+Yd/9IFxMZqmzTIzSVRMpLzlCcK4Mw75UBvVoCsh3ZJqOz9FXogCig9ObSgdP9L3sy1iegSO4
        jOh05R1g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000696-5h; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBib-000F2T-VO; Sun, 31 Oct 2021 15:21:53 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/9] iio: ad_sigma_delta: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:24 +0100
Message-Id: <20211031142130.20791-3-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211031142130.20791-1-lars@metafoo.de>
References: <20211031142130.20791-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26339/Sun Oct 31 09:18:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO core handles a trigger ops with all NULL callbacks the
same as if the trigger ops itself was NULL.

Remove the empty trigger ops from the interrupt trigger driver to slightly
reduce the boilerplate code. Object size of the driver module is also
slightly reduced.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad_sigma_delta.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 1d652d9b2f5c..cd418bd8bd87 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -467,9 +467,6 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
 }
 EXPORT_SYMBOL_GPL(ad_sd_validate_trigger);
 
-static const struct iio_trigger_ops ad_sd_trigger_ops = {
-};
-
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
@@ -486,7 +483,6 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	if (sigma_delta->trig == NULL)
 		return -ENOMEM;
 
-	sigma_delta->trig->ops = &ad_sd_trigger_ops;
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
-- 
2.20.1


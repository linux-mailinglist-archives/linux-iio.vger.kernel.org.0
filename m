Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE2434777
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTJAV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 05:00:21 -0400
Received: from www381.your-server.de ([78.46.137.84]:34520 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTJAV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 05:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=G+QUqrP73yDjsmwjIZXZw584eAIDjnoLRFHwM2FaSZ8=; b=cxYvfMBzgQIEFF2fhfqyY4GSME
        DVaEs8By1fzSfiStMf53tHjzwXdW8cptFzMlsbAoqllpJ2EGGSXdqmSmBKk4bKa8Ca5nbikPr1f1i
        XQQIOFfi7dd5A4Fv8Dcjy7fV+Gamm7+xcfX2Rtpu/yxqZvxtf8raVgOjwIEqX1e87S21dlE2Cc+5O
        XSAJcbhCAz6B1zi2GT8Ooh092XR1ykfrBezV8vBzO5BVKtrrGGq5wjZR0TZK+SXL9ISptIdqe1gnE
        6kNX/gdad/NHVTRP3IH9P8LGv2drb9T0CxXUiffmMMBwEpT7yTwrjtYgtV/HFcnMJs8omREgIyHBH
        3EbJH27A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1md7QE-000BDE-H2; Wed, 20 Oct 2021 10:58:06 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1md7QE-000RNp-Cl; Wed, 20 Oct 2021 10:58:06 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: imx7d_adc: Don't pass IIO device to imx7d_adc_{enable,disable}()
Date:   Wed, 20 Oct 2021 10:57:54 +0200
Message-Id: <20211020085754.16654-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26327/Tue Oct 19 13:35:20 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `imx7d_adc_enable()` and `imx7d_adc_disable()` functions are used as
the suspend and resume callbacks for the device. When called as
suspend/resume functions they are called with the platform_device's device
as their parameter.

In addition the functions are called on device probe and remove. In this
case they are passed the struct device of the IIO device that the driver
registers.

This works because in the `imx7d_adc_{enable,disable}()` functions the
passed struct device is only ever used as a parameter to `dev_get_drvdata()`
and `dev_get_drvdata()` returns the same value for the platform device and
the IIO device.

But for consistency we should pass the same struct device to the
`imx7d_adc_{enable,disable}()` in all cases. This will avoid accidental
breakage if the device is ever used for something more than
`dev_get_drvdata()`.

Another motivation is that `dev_get_drvdata()` on the IIO device relies on
the IIO core calling `dev_set_drvdata()`. Something we want to remove.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/imx7d_adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 4969a5f941e3..7abf0ad526a3 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -528,12 +528,11 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	imx7d_adc_feature_config(info);
 
-	ret = imx7d_adc_enable(&indio_dev->dev);
+	ret = imx7d_adc_enable(dev);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, __imx7d_adc_disable,
-				       &indio_dev->dev);
+	ret = devm_add_action_or_reset(dev, __imx7d_adc_disable, dev);
 	if (ret)
 		return ret;
 
-- 
2.20.1


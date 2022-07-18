Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E612578B1F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiGRTnK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGRTnK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 15:43:10 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E9313B8
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description; bh=IuS0+muwBjCKA4YU8k0P+du/8OKLFdqbKcdx4holZlI=; b=TqHX
        iuD1qgbmz2xCVlO3kCsr7M6x4JAGtrj//yC8SdO7UT2qwPOO51UXwuwI8NZhx99DCm80PE+ZrJDHr
        VY3g0xGNyNszIrcSaCsamvsGFDQ2FTKHFR8Nccn8qOCFic76vUNJMoCE6xMvb9sMJ5sViJJ6ufTYp
        SLS3OZTo5VhsS2n7dFmccU8V/UbQ6aZwME56sB44bbzJm2Oe6W75pIRiCibVxf8zc9KXkNcwim10Q
        KHZyPzJmC2dwr/qgkSjfOLcnZQjjRmCBIEguPOi40Q7B+LbWXgpqQFsvKJVSzHJMquzAtZF2eT/M3
        J8SaMs97sbq6v0kUb4nzMgRIApb5Eg==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1oDWe0-0000p5-Dh; Mon, 18 Jul 2022 19:43:04 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH v2 2/3] iio: humidity: dht11: Emit error messages for probe failures
Date:   Mon, 18 Jul 2022 21:42:57 +0200
Message-Id: <20220718194258.181738-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718194258.181738-1-ukleinek@debian.org>
References: <20220718194258.181738-1-ukleinek@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; h=from:subject; bh=qC4JFxOH3CD2NVD6lCY30RK7h3MvO/hDqMWI6pVSsc8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1be6XuyY1UxDyQchCGVz1xYITu4kY3pyT4CzR4je fEq70jWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtW3ugAKCRDB/BR4rcrsCbNzCA CSu+VGChtclfRgofUbk74UlA8xMOoizZbQSHAnDW1DZi+RBYh9abb/fhMD5QbAiwz+j9uzbPUxAM0g wQgZDTB0eJAAv2vorxlB8JPLk04m1JahgLAwKZCWtlRA7+F+HsKDUk5FfyNw0hP+syObnEGr1TyfmX zp8Pjw2FChRoXOJViDge7mFffBtCTdrQMLJcRCnFv3O0ZepIGnD2ZUCo7b8P6srMvSqEUEITWKxhPZ cAiTmjTqpmjgl9ruqtp3z/1fj4VYDYKgzKe7mtQ6okZ0uo7HteDkyxOeZ+0l2NGoAzuGGIDnL4RokN NDRMyvlMgv1H/R4guZgqsLi4QKErY3
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are two exit points in the driver's probe function that fail
silently. From a user perspective this is unsatisfactory because the
device is unusable but there is no hint in the kernel log about the
actual problem which makes it unnecessarily hard to fix the problem.

Make use of dev_err_probe() to emit a problem indication which also does
the right thing if requesting the gpio return -EPROBE_DEFER.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
Changes since (implicit) v1:

 - Make it actually compile. (It helps quite a lot to have the driver to
   be tested enabled in the config when doing compile tests *sigh*)
 - Fix a typo I added when manually splitting the original patch

 drivers/iio/humidity/dht11.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 891b6bf0b4ca..0db4f7471319 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -293,6 +293,7 @@ static int dht11_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dht11 *dht11;
 	struct iio_dev *iio;
+	int ret;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
 	if (!iio)
@@ -302,7 +303,8 @@ static int dht11_probe(struct platform_device *pdev)
 	dht11->dev = dev;
 	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
 	if (IS_ERR(dht11->gpiod))
-		return PTR_ERR(dht11->gpiod);
+		return dev_err_probe(dev, PTR_ERR(dht11->gpiod),
+				     "Failed to acquire GPIO\n");
 
 	dht11->irq = gpiod_to_irq(dht11->gpiod);
 	if (dht11->irq < 0) {
@@ -323,7 +325,11 @@ static int dht11_probe(struct platform_device *pdev)
 	iio->channels = dht11_chan_spec;
 	iio->num_channels = ARRAY_SIZE(dht11_chan_spec);
 
-	return devm_iio_device_register(dev, iio);
+	ret = devm_iio_device_register(dev, iio);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
+
+	return 0;
 }
 
 static struct platform_driver dht11_driver = {
-- 
2.36.1


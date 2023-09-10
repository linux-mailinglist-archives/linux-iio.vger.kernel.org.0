Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFF799E9E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Sep 2023 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbjIJOJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Sep 2023 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIJOJo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Sep 2023 10:09:44 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AD9CC5
        for <linux-iio@vger.kernel.org>; Sun, 10 Sep 2023 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=p1JWTqoQvTarQF3f8e9vwT/2tJ5LzNNh5EYA3VIYc0I=; b=OTk9zsihtSIVQxx75uYzyd2nM3
        VuggNi1CtkYPy4z0qW6sBhbYYANP5O2tx9j9jXZ1Ow57ni8egFaHReAV//AN3PL8CQQP95bOx4KKD
        QGAwFbW5dmsE1WgG7+BlRthoUS4ukhSciDtz3zkfO/ka94ibAAv0ljADO+9A59IiX3cnDU8PtoVmi
        IPUruxLUiLDL28mtQXlKJJ43yjRMMZRwo2633YnwHKjEnCYpMa30mLCW61yoB7ja91aopyRmEJCCt
        RBMeDzPt5TsWS18/DjisaKjJXUhewtuECMDuKphgI3m5B+9G331D0BlTRC+6jb1WvoxW0V7FBlMET
        y1j8ykAA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qfL7y-000O6N-VN; Sun, 10 Sep 2023 16:09:31 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qfL7y-000GyK-Ft; Sun, 10 Sep 2023 16:09:30 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad4310: Replace devm_clk_register() with devm_clk_hw_register()
Date:   Sun, 10 Sep 2023 07:09:03 -0700
Message-Id: <20230910140903.551081-1-lars@metafoo.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/27027/Sun Sep 10 09:37:07 2023)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_register() is deprecated and devm_clk_hw_register() should be
used as a replacement.

Switching to the clk_hw interface also allows to use the built-in device
managed version of registering the clock provider. The non-clk_hw interface
does not have a device managed version.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad4130.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 5a5dd5e87ffc..feb86fe6c422 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1817,18 +1817,12 @@ static const struct clk_ops ad4130_int_clk_ops = {
 	.unprepare = ad4130_int_clk_unprepare,
 };
 
-static void ad4130_clk_del_provider(void *of_node)
-{
-	of_clk_del_provider(of_node);
-}
-
 static int ad4130_setup_int_clk(struct ad4130_state *st)
 {
 	struct device *dev = &st->spi->dev;
 	struct device_node *of_node = dev_of_node(dev);
 	struct clk_init_data init;
 	const char *clk_name;
-	struct clk *clk;
 	int ret;
 
 	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
@@ -1845,15 +1839,12 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	init.ops = &ad4130_int_clk_ops;
 
 	st->int_clk_hw.init = &init;
-	clk = devm_clk_register(dev, &st->int_clk_hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
 	if (ret)
 		return ret;
 
-	return devm_add_action_or_reset(dev, ad4130_clk_del_provider, of_node);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &st->int_clk_hw);
 }
 
 static int ad4130_setup(struct iio_dev *indio_dev)
-- 
2.39.2


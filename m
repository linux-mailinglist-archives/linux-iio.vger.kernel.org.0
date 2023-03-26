Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F36C9517
	for <lists+linux-iio@lfdr.de>; Sun, 26 Mar 2023 16:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjCZOVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Mar 2023 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCZOVP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2023 10:21:15 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5BB5FD2
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2023 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=8u+iHaBEg53BrEmbue4kwEy3IaBPaAxN1gUtPBW3Wks=; b=EQamS/v3Wfjmcs0umAmUWTI5F/
        f8iEfcTxso8SuTiF3mH1WYJHUC4MbyQzQsfbfY7YoloU3REoRYdHb2U6R+42qm+ku8kYh55Mv9Ifk
        2OU6xgWLzBQQJSsQjVtwe+Mfh0DYDdSjgyXzt18hm4h2TJUQlkULboK3OtxZKyi4LKtsmPpOIhbXb
        IDdAVlFs0QipG9bIh3x/Ui+mvayMeSm2c4EY1PfNR0SoNaW4uy2r/6w0hdaaz5QTp7te5YjaVOYq6
        WRWUsPsYPtbZvxSiaroM6mrYnE/522Gv1p3Jl1kwnsXIgYS5Qo3WImLPtlcZzgXr9+y4PTOaC3Fr/
        q/7fBbtQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pgRF4-00084b-N2; Sun, 26 Mar 2023 16:21:06 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b] (helo=lars-desktop.lan)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pgRF4-000OAo-5t; Sun, 26 Mar 2023 16:21:06 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad4310: Replace devm_clk_register() with devm_clk_hw_register()
Date:   Sun, 26 Mar 2023 07:20:46 -0700
Message-Id: <20230326142046.422314-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26855/Sun Mar 26 09:23:02 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_register() is deprecated and devm_clk_hw_register() should be
used as a replacement.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad4130.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 38394341fd6e..f23b7808e996 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1823,7 +1823,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	struct device_node *of_node = dev_of_node(dev);
 	struct clk_init_data init;
 	const char *clk_name;
-	struct clk *clk;
+	int ret;
 
 	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
 	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
@@ -1839,11 +1839,12 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	init.ops = &ad4130_int_clk_ops;
 
 	st->int_clk_hw.init = &init;
-	clk = devm_clk_register(dev, &st->int_clk_hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
+	if (ret)
+		return ret;
 
-	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+	return of_clk_add_hw_provider(of_node, of_clk_hw_simple_get,
+				      &st->int_clk_hw);
 }
 
 static int ad4130_setup(struct iio_dev *indio_dev)
-- 
2.30.2


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCD6E266C
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNPHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDNPHS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 11:07:18 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED11FF3
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=0WD94/TrGURKvXo4uYrwKDxIhNbUhb5QPEpJ4GiZG3w=; b=KfHGEb526ZA4R8Nt356YT5PPVi
        Pr2pxabo0JMf9KoCRFr5SCpeK83wHindm/QYj6vnI7764gPjs2oHw17gJrhzrlenNG7BG9V7xit7L
        dhPMO037ZzcSIzybxHWeijGB6qHe0Z/Bn/yakcKC9lP1JE02fEi3CN4+li8VLhCGSRpGy+/dG4oyQ
        qF6jsEnB6sHg6bLGjpkN5iKzFuBfMsX4fzoX4nzkDo7o+TggwpRwKuYzLnNfSOTjs0fWmHOvTWYrf
        +g8n7ryzhnv0rBPDeZymNGS75MJkPjtEUUKoWiRfguBhTi9rLE7MKYc4SF1WOBlUPyfJ6PUmsGfLj
        N1Rjktbg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pnL16-000MO8-PM; Fri, 14 Apr 2023 17:07:12 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pnL16-000PR8-9T; Fri, 14 Apr 2023 17:07:12 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad4130: Make sure clock provider gets removed
Date:   Fri, 14 Apr 2023 08:07:02 -0700
Message-Id: <20230414150702.518441-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26875/Fri Apr 14 09:23:27 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ad4130 driver registers a clock provider, but never removes it. This
leaves a stale clock provider behind that references freed clocks when the
device is unbound.

Register a managed action to remove the clock provider when the device is
removed.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad4130.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 38394341fd6e..5a5dd5e87ffc 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1817,6 +1817,11 @@ static const struct clk_ops ad4130_int_clk_ops = {
 	.unprepare = ad4130_int_clk_unprepare,
 };
 
+static void ad4130_clk_del_provider(void *of_node)
+{
+	of_clk_del_provider(of_node);
+}
+
 static int ad4130_setup_int_clk(struct ad4130_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1824,6 +1829,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	struct clk_init_data init;
 	const char *clk_name;
 	struct clk *clk;
+	int ret;
 
 	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
 	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
@@ -1843,7 +1849,11 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+	ret = of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad4130_clk_del_provider, of_node);
 }
 
 static int ad4130_setup(struct iio_dev *indio_dev)
-- 
2.30.2


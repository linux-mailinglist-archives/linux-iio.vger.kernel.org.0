Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38725656A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgH2GtI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 02:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgH2GtF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:49:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B3820E65;
        Sat, 29 Aug 2020 06:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683744;
        bh=4Lu3EJuJBkPkkhNm8cEkffiFcH6Q42bc9rp03XpBrfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2q5UJCJTz4MbOA8HJ/KI2YbH8ixBYNWTU5cscPWHOwBazmyqOMEXvAJA/TxjhKgCc
         dcJSIcEFEFv2wOtJLH1DrUOpfmGGfdCCzR7rTAP/4bqEVf4iq8xpZCegelD2iVSsM7
         wejsuCcOP7LOR8iIyXVxYXrH/DNE/16YWdxioG8c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 18/18] iio: multiplexer: iio-mux: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:26 +0200
Message-Id: <20200829064726.26268-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829064726.26268-1-krzk@kernel.org>
References: <20200829064726.26268-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changes since v2:
1. Wrap dev_err_probe() lines at 80 character
---
 drivers/iio/multiplexer/iio-mux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 6910218fdb00..d54ae5cbe51b 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -354,11 +354,9 @@ static int mux_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	parent = devm_iio_channel_get(dev, "parent");
-	if (IS_ERR(parent)) {
-		if (PTR_ERR(parent) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get parent channel\n");
-		return PTR_ERR(parent);
-	}
+	if (IS_ERR(parent))
+		return dev_err_probe(dev, PTR_ERR(parent),
+				     "failed to get parent channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(parent);
 	if (sizeof_ext_info) {
-- 
2.17.1


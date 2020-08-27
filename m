Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F456254E5F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH0T20 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0T2Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 15:28:24 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BFA22B4D;
        Thu, 27 Aug 2020 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598556503;
        bh=3+33wDqccjLt1IW1JITAEzv6bEHTJjyXXG+OssmK9rQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=0+G/pIC3rpLk7+CqejrJwWKzVKKXn8om7yQs2W/uP1slHC9vF3UjVQJlzIgWYG0lS
         XCn7bzmnVki6A3zYbqI5fAbm9f+4jfcfKUT6XDRfORWIKEuIxcaIvTwPHFr1nZb63a
         GiPwwSq+YYgD57ttqO6BDbETNhatSlgSCrfuBgzs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 21:26:33 +0200
Message-Id: <20200827192642.1725-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827192642.1725-1-krzk@kernel.org>
References: <20200827192642.1725-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Wrap dev_err_probe() lines at 100 character
---
 drivers/iio/afe/iio-rescale.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 69c0f277ada0..8cd9645c50e8 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -276,11 +276,8 @@ static int rescale_probe(struct platform_device *pdev)
 	int ret;
 
 	source = devm_iio_channel_get(dev, NULL);
-	if (IS_ERR(source)) {
-		if (PTR_ERR(source) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get source channel\n");
-		return PTR_ERR(source);
-	}
+	if (IS_ERR(source))
+		return dev_err_probe(dev, PTR_ERR(source), "failed to get source channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(source);
 	if (sizeof_ext_info) {
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAD254E66
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH0T2b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH0T2a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 15:28:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8AAA207CD;
        Thu, 27 Aug 2020 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598556510;
        bh=JDW+si4kpBNxVKzKilmgyZMG73ode2zg5DMZD3yhgec=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ox3ATot+EWc0ejxtrSSuOXWOBfPNHIY48U6UZqrsszLrWw2grNY5Ca0wTT0ZHuYIU
         PynzLstLMlDwxkT6dMacAIYEjrsGcxd7+HRuK/ZlBlJZEF3S5z5DNTmWpqMPFH0xs8
         CZsFrlTBBAwzKmqUzPKYyBoFTMIz2SxrvzqkJ/kE=
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
Subject: [PATCH v2 10/18] iio: amplifiers: hmc425a: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 21:26:34 +0200
Message-Id: <20200827192642.1725-10-krzk@kernel.org>
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
 drivers/iio/amplifiers/hmc425a.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 582708924e4f..bde11df4bb9e 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -201,12 +201,8 @@ static int hmc425a_probe(struct platform_device *pdev)
 	st->gain = st->chip_info->default_gain;
 
 	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpios)) {
-		ret = PTR_ERR(st->gpios);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get gpios\n");
-		return ret;
-	}
+	if (IS_ERR(st->gpios))
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->gpios), "failed to get gpios\n");
 
 	if (st->gpios->ndescs != st->chip_info->num_gpios) {
 		dev_err(&pdev->dev, "%d GPIOs needed to operate\n",
-- 
2.17.1


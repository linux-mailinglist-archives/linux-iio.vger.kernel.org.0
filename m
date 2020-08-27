Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB5254E7E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgH0T3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH0T3Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 15:29:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6488207DF;
        Thu, 27 Aug 2020 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598556556;
        bh=IwI1yLwibpqLSvKtz6KPbHm1WiYgsAWbmgv2aJsQJOw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vtbotEUI+bvibX2D43FsTLH26PlKZEy7m0cG1phXdOGdBCIGjdY1KJ4y4lcaKSOtI
         Ci3M4WhVLHIqI9iQISXKSVhPBVS9GAg8rncntyQQrE6aznu7Zk3Yrjk8CU/AiQReJm
         exZY8KUhxGicwDLMwoIAOWIjnRmdHNy2y4bnx9rs=
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
Subject: [PATCH v2 16/18] iio: magnetometer: ak8974: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 21:26:40 +0200
Message-Id: <20200827192642.1725-16-krzk@kernel.org>
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
 drivers/iio/magnetometer/ak8974.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index cbb44e401c0a..548c686e29d6 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -843,15 +843,8 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ret = devm_regulator_bulk_get(&i2c->dev,
 				      ARRAY_SIZE(ak8974->regs),
 				      ak8974->regs);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
-		else
-			dev_dbg(&i2c->dev,
-				"regulators unavailable, deferring probe\n");
-
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&i2c->dev, ret, "cannot get regulators\n");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
 	if (ret < 0) {
-- 
2.17.1


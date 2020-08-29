Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22A2256563
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgH2GtA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 02:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbgH2Gs6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBE62137B;
        Sat, 29 Aug 2020 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683738;
        bh=zDEOh28j1k9ooHq5oLnJJrrHuUEXD3pzgG6ksnmhBno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzDaOD7LNRHAx6yJjcZh1Xxc1AKFlf12Mp55ONcza0ar/ZMRpjNaC2rqQePU2mIsa
         wMXlYjVNXBxlVBgBqs78cGqmPxCRWQ3QiRwkRwvUCwVMvNqF6bexUGu23CvUgM9wnH
         N/Fim3hNQuFlzzArgUI/4CF6NyVF5kxuEETMDABI=
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
Subject: [PATCH v3 16/18] iio: magnetometer: ak8974: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:24 +0200
Message-Id: <20200829064726.26268-16-krzk@kernel.org>
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
Acked-by: Linus Walleij <linus.walleij@linaro.org>

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


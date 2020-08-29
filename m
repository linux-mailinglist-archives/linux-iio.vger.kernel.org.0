Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9D256550
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgH2Gsk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 02:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgH2Gsd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635092137B;
        Sat, 29 Aug 2020 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683713;
        bh=q8HI6Zm7rrRPqVe1eb6PzsXiCtitXv9sgq9WQhNoADo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlJiwlmJ/eHlpJIJJ9BSxU4PqYPRgC3cKYkPTHh9d/+Dr0YvNtCy1juaWK4MMAtnF
         8fUFw+f+34uf7wphW0zsJk1jSYOwaaSQOwQgqSCr4L4Pl6ZFxu2FZMmL/l/7mUB1fn
         1gKGAHQhVbDCxwsjBFe2HDqSHZ8MAl+DJ1UJU2tc=
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
Subject: [PATCH v3 09/18] iio: afe: iio-rescale: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:17 +0200
Message-Id: <20200829064726.26268-9-krzk@kernel.org>
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

Changes since v1:
1. Wrap dev_err_probe() lines at 100 character
---
 drivers/iio/afe/iio-rescale.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 69c0f277ada0..e42ea2b1707d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -276,11 +276,9 @@ static int rescale_probe(struct platform_device *pdev)
 	int ret;
 
 	source = devm_iio_channel_get(dev, NULL);
-	if (IS_ERR(source)) {
-		if (PTR_ERR(source) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get source channel\n");
-		return PTR_ERR(source);
-	}
+	if (IS_ERR(source))
+		return dev_err_probe(dev, PTR_ERR(source),
+				     "failed to get source channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(source);
 	if (sizeof_ext_info) {
-- 
2.17.1


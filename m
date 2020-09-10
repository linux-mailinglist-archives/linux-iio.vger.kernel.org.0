Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87B026408D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIJIwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 04:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgIJIwV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 04:52:21 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13E02078B;
        Thu, 10 Sep 2020 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599727940;
        bh=pKJBC1J8nO1JEn2di9prUMv7XinIJkYYcTXmoZZ2/b4=;
        h=From:To:Cc:Subject:Date:From;
        b=ADmQP41qeWq2CTNwYYPujfGLaqoHNF418+olBQVBGZIKE4kER5nR8Zk4YrhHM155I
         u+FhKUiqNCdL8l+5umFN5vVzQ7+/Kq64246MGKMj5xLeaBLH3RZdI/qe9EJTKgFPWa
         1MmA+vIZFHPHUVxvj5Kirz2dkF4AnMOrCn1t0CyE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Subject: [PATCH] iio: adc: stm32: Fix missing return in booster error path
Date:   Thu, 10 Sep 2020 10:52:07 +0200
Message-Id: <1599727927-7776-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Conversion of error paths to dev_err_probe() dropped one return
statement.  The driver will continue to probe if getting booster
regulator fails.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: ce30eeb613cb ("iio: adc: stm32: Simplify with dev_err_probe()")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Commit sha from linux-next.
---
 drivers/iio/adc/stm32-adc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 3f27b4817a42..6a0338d33bd8 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -595,7 +595,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 		if (IS_ERR(priv->booster)) {
 			ret = PTR_ERR(priv->booster);
 			if (ret != -ENODEV)
-				dev_err_probe(dev, ret, "can't get booster\n");
+				return dev_err_probe(dev, ret, "can't get booster\n");
 
 			priv->booster = NULL;
 		}
-- 
2.7.4


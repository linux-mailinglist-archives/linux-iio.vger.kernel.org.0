Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD1256554
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgH2Gsn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 02:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgH2Gsl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:41 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBCF214D8;
        Sat, 29 Aug 2020 06:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683720;
        bh=ZelpFQ0282/QvKyDJRVrg0JcM6UJUGrhhAA87ejo8k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYy1Zk1iYCDKzFrBSi2C3ND3V1n6vGPXAg7QK3taHdYEchQmiQU+vbsGs1kVqphQE
         zEEEyvQBpdQB9NdoY20HEaHc6MvVk7FNVQcANMxwDHSJbMsZpDtwOgifakZJuv/Ctj
         6ohXnR3ClgeEw0PjuYD3JQp/PlB5HF2AvPaXEUGg=
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
Subject: [PATCH v3 11/18] iio: chemical: scd30: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:19 +0200
Message-Id: <20200829064726.26268-11-krzk@kernel.org>
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
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changes since v1:
1. Wrap dev_err_probe() lines at 100 character
2. Add Ack
---
 drivers/iio/chemical/scd30_core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index eac76972f83e..4d0d798c7cd3 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -705,13 +705,8 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	indio_dev->available_scan_masks = scd30_scan_masks;
 
 	state->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(state->vdd)) {
-		if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(dev, "failed to get regulator\n");
-		return PTR_ERR(state->vdd);
-	}
+	if (IS_ERR(state->vdd))
+		return dev_err_probe(dev, PTR_ERR(state->vdd), "failed to get regulator\n");
 
 	ret = regulator_enable(state->vdd);
 	if (ret)
-- 
2.17.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC137F782
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhEMMKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhEMMJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5833C06174A
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a25so6570155edr.12
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy3IcRDvRV5+tK+ZRLaGDhqpXCfFka7PQKuph7JiP4Y=;
        b=Y2Qg773FvUVyXUSZo0qA0Ufrbs2J17MmauND0QOgH96B1yBC5SPhl2XgSASxQtaC/x
         USkdibM6EdiFNEOwsXEFFc+F838k8y40MTBQQJ7QnN/ysrUQJhMSeqKGG/dBKISBvkzn
         hTmjJ04JHpLmOWU8YEk1SJJg1fZeLx47oddDMlkTkoaTaAf8hUDhBXczFwYTix23wJPP
         hvKg8kBt/VzwOO0yyJ4jO8Qv33CStQWervRwa7WAjT5rLFtQesRxNzKEtnTfR+R4mi6P
         Ew8AilIUcoIDiqlMn3REaLvz431U4Kzqn48Hy8qr3i/sEleVhNVTBVmPC2NSnvfwsQvm
         aiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy3IcRDvRV5+tK+ZRLaGDhqpXCfFka7PQKuph7JiP4Y=;
        b=pgGKFik17fhEFzaxl0Y0K8dF9NDC4ew1IgYLC4ohYylmuO+/80Q1Iad6nwr1t55YiR
         HkX3YV03QuF3LyAtGZJp65AXXgT1kzI/XSSXjb9Zx3XvZaiERRVdk2R94elQpM6plk5w
         R0eoy1V8BtruFX4OQtiZJqRUl00xjCrFPqozSWUavHIJSnAJbX++wjP9ooiHnj0SyajR
         H83CBnTyakoB1rqW8bLmuH3U0AMSb7Xw7dOgvGD4lmyum/O6QAg7763rgzrnZn7PFtp+
         X901UhD8JDiy3ptKl5Be6whzj5ClZl/DQmwLobxR3SV3J+dj3sPEcudyGJCToOaVUYMA
         saXg==
X-Gm-Message-State: AOAM531o2ikSDchucEeCyYk5QzFuLFXUB8fH2Lu9N9cYLutbo29IRfQC
        xpyiFXPHse8FdnyK9bamvSsPsF6gMPCrcw==
X-Google-Smtp-Source: ABdhPJzgUPJMDuolRPi8aBMo2dNDP6Rq3oicyRvMxnIN5hd/q4y6rnZR8nVCND4j3vBEIXWyWbAoAw==
X-Received: by 2002:aa7:cd46:: with SMTP id v6mr48645873edw.16.1620907688231;
        Thu, 13 May 2021 05:08:08 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:07 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 09/12] iio: adc: ad7192: use devm_clk_get_optional() for mclk
Date:   Thu, 13 May 2021 15:07:49 +0300
Message-Id: <20210513120752.90074-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_get_optional() helper returns NULL when devm_clk_get() returns
-ENOENT.
This makes things slightly cleaner. The added benefit is mostly cosmetic.

Also, a minor detail with this call, is that the reference for the parent
device is taken as `spi->dev` instead of `&st->sd.spi->dev` (which looks a
little quirky).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1141cc13a124..523cf3bc955b 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -326,7 +326,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
-	if (PTR_ERR(st->mclk) == -ENOENT) {
+	if (st->mclk) {
 		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
@@ -978,8 +978,8 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->mclk = devm_clk_get(&st->sd.spi->dev, "mclk");
-	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
+	st->mclk = devm_clk_get_optional(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk)) {
 		ret = PTR_ERR(st->mclk);
 		goto error_remove_trigger;
 	}
-- 
2.31.1


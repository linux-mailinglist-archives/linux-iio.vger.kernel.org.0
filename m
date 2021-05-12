Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A046C37D373
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbhELSWP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350904AbhELRwi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:52:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3749EC06134F
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t4so36323140ejo.0
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBvo4n1b1lpFvoXyiJXHa/MxZkZ+cVEgHQDwczdnQoM=;
        b=KeUHS+sM1e7FnHAfkAJ7Aol2WcEZSwD8dAOWuCv5Qvd6OzIRoGIRKTn8gqDF0uDisi
         bPd0RIbn+h1yOn7ceieEkaop7mFgy478fbu6zPFO6KOFBa5d0RkUH6eTBb5BIyXWSGpz
         +7/g/2PvfIvNb6kH0/kv5ONgD5oS8UnYRoVOjIgas7m28TfoGkvwsQWi0oH0r9PBkgSh
         51WKUnD2amNa/ATxdUfAaZr1wP+nBbYOnxry6jKDGOXQJu4fCtDChSPKy4QFWxVi3INZ
         7fGtyvLH0aQd+2jabyC9ZfHcnpTYw/50fcvrrJZdCLx5ricC7WAnxZ50AJh2Ffsw6fZq
         8M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBvo4n1b1lpFvoXyiJXHa/MxZkZ+cVEgHQDwczdnQoM=;
        b=F0mPiGJofrK48Yir2gpKL2lhEtanZDYfGA//ZPIenjhxo10v1aaufPmian1NabLYV8
         4i+V4BwxdMeF7dAaJEOnMlch9pQK5ixbvAgugqscCHeRtES8+LylqYRYQsTeqvYFvq+4
         Ca2xIpHQkBeMuOIR14zZXtDk2b56HbQyLb9ITSFqsJ8s0gaYeEvW+XtuhwdL2FaGdCeI
         KhWJZhxUNJmUoLFxKwayc4vnSNOAr05X4bDyFAnfd2ZlORgoXOu2aIf3uXWg7rWZr/mn
         Ykq2pF7KzjJEIqCBaufwOJOGGxohY6BCqRGtw4F/4couifc4loxAhEChTr6CuEI9cZ3r
         HCAg==
X-Gm-Message-State: AOAM5313uEvtFaawhlADmt+Tjz+iAk7iIsXnywtfk7hUoVmAE17FRfiX
        IZBfCcq3TdlH4TXKtfsw3fiSypgNluYbgQ==
X-Google-Smtp-Source: ABdhPJydkg/jTMyUOet8s5ERY+J4yag6wbwgnKkuWVtiHkJnqAlKM5TCo+BFuBhkjoO7RE9j+lsnBQ==
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr31620660ejc.132.1620841805716;
        Wed, 12 May 2021 10:50:05 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:05 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 09/12] iio: adc: ad7192: use devm_clk_get_optional() for mclk
Date:   Wed, 12 May 2021 20:49:11 +0300
Message-Id: <20210512174914.10549-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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
index 9da394ad3868..c3442e9aa9fd 100644
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
@@ -981,8 +981,8 @@ static int ad7192_probe(struct spi_device *spi)
 
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


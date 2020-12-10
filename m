Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D72D6902
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgLJUnk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLJUnk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:40 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5230C06179C
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:30 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so5226284pfu.13
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjB3r8SZqFV5P65K6NFvrSaUGRWdy0OJ/fgRJixjirs=;
        b=LYZHS+GDpzMpUjAK/mnDLYbzuOH1UbPLTxyNCqCRuijJYkevsB2rQ5+6+SGbyOUx/Z
         lDERdJWQEXlIzpLW5N3g2Lw5tulUAldOhBAOKL7OHwJop1LcUIP/sw8jIiWSDGSIrB05
         KJNG5IpuLvLQ1SVkiADTQJyDfDPv9KJkoFuRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjB3r8SZqFV5P65K6NFvrSaUGRWdy0OJ/fgRJixjirs=;
        b=cIBKt4d1CIEn3LmOEges7iL93ATHx6KL2pMr6nNNwGaraU8gsqugR/doVHOi4gKmpc
         JiLFxIMj/b8rDeiWK1B1jqBubG7sR2EXlNiU1Yiv6F25ugznjIE3I06d6elm4TIgf5Li
         tHmVtk5rb4ye7KcxfRAS8M0MlODJWal43gr2ZILUYreWlF0fw7v2/aUpVf/9+DY8sQbL
         D7uFXKXbjNNejkvo/0UmtHk9PtySdt3OYkCxKouzaSt/unbdQGgNTHq42H0gEnQPn/L7
         ai0uCkAMVYx1oZFjD3niFUiAHSTojVG2hbjUSHc47eGnGV3TFf2pjYo1PWe1oEggEJGv
         +O6A==
X-Gm-Message-State: AOAM530KFDgLoc0CaSHjl993M3Mo9BFOM//yQbUzwo5tuh1EQzBuVChm
        cFGxJiyDnWsFQojGGtEDnV0Mmzu9MDEuzg==
X-Google-Smtp-Source: ABdhPJzAAcSymOU9jc5ky75MzZJV5juIwCZYjsWrT1wBYrxGlXkDVbZqsJ4iY1VahKqsbfjmeaIq8w==
X-Received: by 2002:a63:f910:: with SMTP id h16mr1569785pgi.77.1607632950311;
        Thu, 10 Dec 2020 12:42:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id w2sm7653388pfb.104.2020.12.10.12.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:29 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 5/7] iio: lmp91000: Remove code to set trigger parent
Date:   Thu, 10 Dec 2020 12:42:09 -0800
Message-Id: <20201210204211.967018-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204211.967018-1-gwendal@chromium.org>
References: <20201210204211.967018-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/potentiostat/lmp91000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index f34ca769dc20..8a9c576616ee 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -322,7 +322,7 @@ static int lmp91000_probe(struct i2c_client *client,
 		return PTR_ERR(data->regmap);
 	}
 
-	data->trig = devm_iio_trigger_alloc(data->dev, "%s-mux%d",
+	data->trig = devm_iio_trigger_alloc(dev, "%s-mux%d",
 					    indio_dev->name, indio_dev->id);
 	if (!data->trig) {
 		dev_err(dev, "cannot allocate iio trigger.\n");
@@ -330,7 +330,6 @@ static int lmp91000_probe(struct i2c_client *client,
 	}
 
 	data->trig->ops = &lmp91000_trigger_ops;
-	data->trig->dev.parent = dev;
 	init_completion(&data->completion);
 
 	ret = lmp91000_read_config(data);
-- 
2.29.2.576.ga3fc446d84-goog


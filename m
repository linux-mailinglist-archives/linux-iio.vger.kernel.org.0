Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E950B331C3E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCIBSw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCIBSi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A2C061760
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so4214057pjv.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNtTp10XogOWqVI8jmeciHEAA3OfLobGe+BQNpjU/PM=;
        b=WpDqB12CDouPl1NdmR5oBBFpSTI3pVViQ+tLkHwmg48E1BDane84FBNzwKPHvoOuX5
         +mIx746+ZJQ0IuSWOg4q4MUYJwVXqLOsMwKq93NyX4kblJE6/oT0swN68Ti7VzB6+6Rs
         4lAcWY2UpBzed4kIZRhdpJOjQmo4QJxsO2DpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNtTp10XogOWqVI8jmeciHEAA3OfLobGe+BQNpjU/PM=;
        b=p2NFiuFvzSubnhMpdNxr4VQ3wnbV91Kw2XwXYVCo0VQVDAUuAKauEPagocMEgA90rb
         Jt4ZAYHlUlbfzKuBoGFh6ojM1XHAMYMVeVBtzdJaoqqsUxhtjfGx8NZkJQtXOArZBmxV
         A4E1AtMFtBeZgdB1Cj2Bb8lF+iYnioR3XSABbRqfYDaA14YQBdABcJ0wc3PjeKi3Twt4
         TvwBGUWeF817PEXHI8QH/Eh61TZJoDXO3pIqsYq3ygjw8VfCsQYuBh829Ax049w5Ucvd
         MbIcc5MCzKVpJvfgRLMaEN/w3KuvG8bCw1zG+FKB/6p5WB/914Oym4GCWWmoZWmVAx9G
         1XGg==
X-Gm-Message-State: AOAM531znLWv2zZu9qyqcJdAbaa2/9Ku+0/CqJ7UuPCBhr91et22/2KM
        wXl9J6tHLjsGVXJtOAIctlk0Qg==
X-Google-Smtp-Source: ABdhPJyZaV1zRN6CRKr6RpR2IZ+5V+ll3zsmn8jKf3s2AK7oQCglAdHqmZ2wFBWVHbeCFh/p+aJCgA==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr1816537pju.11.1615252717591;
        Mon, 08 Mar 2021 17:18:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id v134sm11265264pfc.182.2021.03.08.17.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:37 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 7/8] iio: as3935: Remove code to set trigger parent
Date:   Mon,  8 Mar 2021 17:18:15 -0800
Message-Id: <20210309011816.2024099-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309011816.2024099-1-gwendal@chromium.org>
References: <20210309011816.2024099-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes since v2.

 drivers/iio/proximity/as3935.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index b79ada839e012..edc4a35ae66d1 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -411,7 +411,6 @@ static int as3935_probe(struct spi_device *spi)
 
 	st->trig = trig;
 	st->noise_tripped = jiffies - HZ;
-	trig->dev.parent = indio_dev->dev.parent;
 	iio_trigger_set_drvdata(trig, indio_dev);
 	trig->ops = &iio_interrupt_trigger_ops;
 
-- 
2.30.1.766.gb4fecdf3b7-goog


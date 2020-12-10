Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6A2D6904
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLJUnk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLJUnk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:40 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4FC0617A6
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:32 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so5266640pfu.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkXWsgyMza+MJug/X7o6qOcfZ33JOJqqhO1OwPTe9hI=;
        b=cI66jCZFpuG3hg/+UMOYUZmemA4dljtf6aOEegtXH2flt9GJUDkMXfyvHQVpksDfhj
         chs0aVb+vlQSTIUrV34GkOwpuSh3uKIVCHAgtHWz5nYVwZ/cde/2wxnKzGzhwSfq0nEV
         Y/ezNhERfas/G02/FJWWU1uDTadsjZPCZepcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkXWsgyMza+MJug/X7o6qOcfZ33JOJqqhO1OwPTe9hI=;
        b=Nd8lNqgH8bU7vKslA8Qh6ciHLZL8Xw0M03hH7jJTm56vyjqJ9eOxhttYgVdtlvuFRm
         rMvxg+JAaJW8CCbYWFduTiza+tq7flYzzpVwMZ8LXexaGfmMD2wtuu5jrgPUjpbi/22e
         BjZx5xNUSrLcakSGQmq9x6yTWFsA8EHe/6PPITKp5Nrgq6SjUEarlI42iYklPXO/aYL6
         WW5F7WLGmAs//SEAtfjm/2EdD1KC7+r0YEnryDLK4nov6yxz3T3YxBd4GVNu0t4QG9Fs
         qcrU8uzYxFjOyYbFakmMib1YWnUhuvl1ACrtxyZ1Y3aW9hWK8XxSzzWrFxRzNagFATtz
         8J7w==
X-Gm-Message-State: AOAM532hNR6xCtgQkjssFXSgj6+uQsyb9wMG+/AzZVQuu/lQral5jB2c
        2UrzhrEIlefIbRnnHsc13BGqfw==
X-Google-Smtp-Source: ABdhPJzyoKJmGh/hE+AxC2wB6TgcGbI+vAiBcWG9WgEaLEZFBTE3mMmLYrz+iORxLbP65wsNysygWw==
X-Received: by 2002:a17:90a:c085:: with SMTP id o5mr4888874pjs.210.1607632951951;
        Thu, 10 Dec 2020 12:42:31 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id o2sm7145128pgi.60.2020.12.10.12.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:31 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 6/7] iio: chemical: atlas: Remove code to set trigger parent
Date:   Thu, 10 Dec 2020 12:42:10 -0800
Message-Id: <20201210204211.967018-7-gwendal@chromium.org>
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
 drivers/iio/chemical/atlas-sensor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index cdab9d04dedd..56ba6c82b501 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -649,7 +649,6 @@ static int atlas_probe(struct i2c_client *client,
 	data->client = client;
 	data->trig = trig;
 	data->chip = chip;
-	trig->dev.parent = indio_dev->dev.parent;
 	trig->ops = &atlas_interrupt_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
-- 
2.29.2.576.ga3fc446d84-goog


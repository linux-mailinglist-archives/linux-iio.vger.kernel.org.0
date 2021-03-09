Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2B332F19
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhCITgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhCITgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F5C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:31 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a188so10139499pfb.4
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdbsouXmU8lnNp6kF3Ta+/6l6FMB/BbivCKXQ+iO/NY=;
        b=hfmdOmBWPQa89vcNGN6q5mhCfrLW6DZ+3vFd+nKWoWnlwTqGpIn6OI6XXfx5s+KNGq
         h+H2LwUTWwc22d3C+Ikkehi8p7ADsAGbSp1BvS1puorXKRtwVhx1s9hhDeQ0nXqg3PEn
         Y/CZ4crO4eld5CLwZU20GU+TJvcgUzsJVksRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdbsouXmU8lnNp6kF3Ta+/6l6FMB/BbivCKXQ+iO/NY=;
        b=nYEmEyw8akpLX2rjGA+iCxSCFlq9ZbyPz6TaNDXi2W+FpUCx7e2RBRxUUZERd8Aa7N
         ki3uSK/9pDe++Tk0QArQJ7zQmmvl3eNGZLQh4sV7E2cUCKNzJIrCUon3uaHgwPPECGSq
         ndoA62oQ462UujHtPY8Kojitn8ikD5+QClydl3/zTCVHAo/4Qoc2psP1+MVquYf+5sxx
         JdIfft31p/8bbvSeggj10XbtvJ+G6um3pEHQefoy54kVgjAveKNBYD3Ty9/u7a75H2xd
         2goxIyxqjPLdm+R5dAexN7WFnyNvEK4WVYUp2DHrSXCdlTtZG9C4fxt7BFzrnmCDxZbG
         CZLw==
X-Gm-Message-State: AOAM5324vl1jN2PyGdXIL4IcoZh0jTX8Rq/X8nPkLyOPfh4VJ8aK4w21
        CXzcEkgxCbcWVYNmUQWCzah4+g==
X-Google-Smtp-Source: ABdhPJxzJq1ObPAHmK7Vjb9EsyiIlE/7Ye5Fz3mGt+YDqeaUp/n3hjCFiazmPSpPRtSNUtXJ2IcfOQ==
X-Received: by 2002:aa7:8dda:0:b029:1fa:19b3:7ed9 with SMTP id j26-20020aa78dda0000b02901fa19b37ed9mr4585969pfr.32.1615318590858;
        Tue, 09 Mar 2021 11:36:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id s62sm14727512pfb.148.2021.03.09.11.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:30 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 4/8] iio: gp2ap020a00f: Remove code to set trigger parent
Date:   Tue,  9 Mar 2021 11:36:16 -0800
Message-Id: <20210309193620.2176163-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309193620.2176163-1-gwendal@chromium.org>
References: <20210309193620.2176163-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

iio_trigger_set_drvdata() sets the trigger device parent to first
argument of viio_trigger_alloc(), no need to do it again in the driver
code.

Given data->client is client, and we call devm_iio_trigger_alloc() with
&client->dev, we do not have to set data->trig->dev.parent to
&data->client->dev anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
Improve commit message.

No changes in v3.

 drivers/iio/light/gp2ap020a00f.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index e2850c1a73533..d1d9f2d319e45 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1551,7 +1551,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 	}
 
 	data->trig->ops = &gp2ap020a00f_trigger_ops;
-	data->trig->dev.parent = &data->client->dev;
 
 	init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
 
-- 
2.30.1.766.gb4fecdf3b7-goog


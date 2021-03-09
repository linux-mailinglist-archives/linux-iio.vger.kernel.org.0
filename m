Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC2331C3B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCIBSv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCIBSe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D3CC061760
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so261092pjb.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nogSq/6WveLekJ/NyRYHHKD9b41O+Z0RQYdJpsSFI+k=;
        b=Y9TGcBbTF4yzLC0buoEV0VDiOiaXoqLJRcbGDrUfrqtCeTpstScNeeHGqbKlAVPaXd
         tes5XcSj5tS1vUUP7bcrWDRUdASNvH3AEyKIu9WSqpqyJEZeQwyVSvOUWSTh2pqPnOWE
         c/XHUWc5bUYHYKJu8jSBBJneDenZbieiQmAT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nogSq/6WveLekJ/NyRYHHKD9b41O+Z0RQYdJpsSFI+k=;
        b=oGZuk9YqC/mXLnG6ETZhafppNk2ptEgZY8wsoFTPfM4k/gft7VSbgBlCDFIJsxo1cu
         wW93TSN5BtDfoUvCpnNR3yBAK45L2U/of4PP6sh4dr5zumlx/dZm/1EeStaFUtMgUE0X
         7KTN81zxtxgK4uX2IWwoGIA/HxIjI5xUDkY0Kl/9RQMBjjJjzPuupqL6elFlVmh2K5Uf
         qz8tTCvCH0/7oa26YVxWGlE5hh0J8yxlzUAqpOINOmxal1eNPny1VnOPRNwwXNEwxraf
         ecUEI60i43S81iGGBMz9cYR0EqExHSRvW6Ruz9jEZlpUdP0egDFZj8trH7l529nwA3uX
         WQMg==
X-Gm-Message-State: AOAM533npaPlE4+Kfa1h0+jkO0avz7OdDVP+sMxzXtNNOIQLj63f6rFu
        EbC1qr5MGsIpCPW0cLkqZILQ7oWTrHO8RQ==
X-Google-Smtp-Source: ABdhPJydbF9VywBiFlmbdGWbRzB6YWrFODTOrVTe4uxm73edrqdXThKycFsrariIRvuaQRsnVcUxmA==
X-Received: by 2002:a17:902:ed8d:b029:e2:b3fb:ca95 with SMTP id e13-20020a170902ed8db02900e2b3fbca95mr23238700plj.17.1615252714388;
        Mon, 08 Mar 2021 17:18:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id d14sm577940pji.22.2021.03.08.17.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:32 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 5/8] iio: lmp91000: Remove code to set trigger parent
Date:   Mon,  8 Mar 2021 17:18:13 -0800
Message-Id: <20210309011816.2024099-6-gwendal@chromium.org>
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

 drivers/iio/potentiostat/lmp91000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index f34ca769dc20d..8a9c576616ee5 100644
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
2.30.1.766.gb4fecdf3b7-goog


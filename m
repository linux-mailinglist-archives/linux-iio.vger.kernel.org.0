Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC565332F18
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhCITgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhCITgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588FC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u18so7107282plc.12
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1brO+GIInSKgDIGGpQZ7kTDaEATbbDamTivrGWcOrRs=;
        b=IMBqB78QpnCsVPeBZNksLMilbIC4n/c82YpYnZyxnQoY01vGKPl3Qe2gBdlVY2Y9O+
         jncyzbZXzTFyNuWxMZCwtOm+3ZPF302m1/LrsaT1sCi7zugflxPi4ISXSSRt9dPtKt6E
         MT8w8m2Opa21wvBkSGupvK5A+Hoy5ZaIxrg1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1brO+GIInSKgDIGGpQZ7kTDaEATbbDamTivrGWcOrRs=;
        b=tk6OEWQ+tV4FIUIlUlkWN7HnniahRMNIkxtxMVqXgXVx0vuJB9ejzBUvxFLbjoO+W/
         BP8WQvR5GluPo0PTM8Zhxmu+Z/vUbxNprxorS2l7y8zYd3uikDkwC2HrVDvYS5qcR6xB
         /3/Dpol031QdOgguR6rYtIlCpDGBEv+i2u1S3xWvvsdA3G2OEhKImoop6H9lCIKdUvwl
         QR+2AGh3zDpNNKWQOUAq9uMiaV4Md0VkR3vC0yaScjgdkGxtKNf32no7OujXBqrpjbik
         LJ1ZuohRiygbMNiJrK+HgLtYtBxNOnN/RvZA8RsabjOvDVW6Eeu7meC3E0KCLoQII0Ne
         TznQ==
X-Gm-Message-State: AOAM532nm6acua0OojYqEAH861ZnDHUMvQXytQBfMqJlZD6EbEMP5Jsl
        4deDe3wgfjCLHuhzeFmBENkXdw==
X-Google-Smtp-Source: ABdhPJyHqFQzst1Pdol8x2qzy1rgCxVN4JRsk2jfLe7TwimO0MojA77Q577jRL04nclpPPtxqaSUYA==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr6267968pjt.226.1615318592368;
        Tue, 09 Mar 2021 11:36:32 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id m17sm2575169pff.88.2021.03.09.11.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:31 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 5/8] iio: lmp91000: Remove code to set trigger parent
Date:   Tue,  9 Mar 2021 11:36:17 -0800
Message-Id: <20210309193620.2176163-6-gwendal@chromium.org>
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

Given data->dev is dev, and we call devm_iio_trigger_alloc with
dev instead of data->dev, we do not have to set data->trig->dev.parent to
dev anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
Improve commit message.

No changes in v3.

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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66850331C3F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCIBSv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCIBSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F3C061760
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so261117pjb.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lb3YlmZQbxHbVqLvOeIMo+Kf5cBBvQ634iPfDXoGJTo=;
        b=X2jgTs1aWCQp26Bgbe3WaDuEVHGC+KT8A6Eph3QEVEoBcb65d8YEH4Rob+gz+4XObZ
         7PyHh5UdjV5BORNrm4fM5Q/jEMi5ENc/F/4CPgXaEgu2RNIzTguxpOj22o1KzEO6H8xC
         wi9ljSqDpfoXoTJKs/RBw24E1PcCverQF8DIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lb3YlmZQbxHbVqLvOeIMo+Kf5cBBvQ634iPfDXoGJTo=;
        b=fG/zyblsiOiQC+uADCdAuy45/orsRkeQbwSYtMLDzjVvsK/JsqawkIl07tcej0cKQd
         U4Is1AkyXVGweuASZBB7YOrCB70dee85fPr5mgKEjlaxOX1bRAJOeuAENlQYUzIpVn9A
         JS06k0CiktDgY4Ll4POQ380zFK9KhP4L0c2xJXKJvXI0fY3I9wPC1gqX6mVVtlmWKN39
         /FDaU/ad/qhutLLHsMU/MX9k4PQwUYgLDI2QB9h00OJSEZucwrh3V2XfwiqWfIF0LerT
         o/4VGUdRAqrD/wGuiQQyukjg+L2L5UcuiPzcB4kGvDu4fyWM6GpMb7aORgNJd7eTn7OK
         W9IA==
X-Gm-Message-State: AOAM533/OvVv6GyYVyZWYm28LnewYS9Tb9rbeJZLhwFzSNDyeSR4HT5n
        Lpu3JrdSJ0606JkfkWWR4Vj+Kw==
X-Google-Smtp-Source: ABdhPJw12X8Dio4t4uYLvDo7EL8YojBnUE1KV3IG+W6KbY4nM+1vXlKTx+bRkX3TQjucrPJu637HaQ==
X-Received: by 2002:a17:90b:110c:: with SMTP id gi12mr1854804pjb.48.1615252716089;
        Mon, 08 Mar 2021 17:18:36 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id x67sm12193131pfx.144.2021.03.08.17.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:35 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 6/8] iio: chemical: atlas: Remove code to set trigger parent
Date:   Mon,  8 Mar 2021 17:18:14 -0800
Message-Id: <20210309011816.2024099-7-gwendal@chromium.org>
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

 drivers/iio/chemical/atlas-sensor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index cdab9d04dedd0..56ba6c82b501f 100644
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
2.30.1.766.gb4fecdf3b7-goog


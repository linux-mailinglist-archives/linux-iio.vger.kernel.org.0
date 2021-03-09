Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFD331C37
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCIBSu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCIBSc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:32 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC47AC061760
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:31 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id x29so7637334pgk.6
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0PrhgcYJVgTqe4+CQit8K21Qzx2NgW6BSu6fKAZzAo=;
        b=IwGlZHA4rVBq8ou3VQZrkpT01V+b20W5FTIho8sX5M1+FYY224kRhZ27DRlRxfiwJj
         uOCcxAPVlIRsm5mUXGWOG71KxT/w7lFIzN6qMU7qD4st5QlcB7g55NbJ9wmki5vt6ezi
         lCQBRTTCEy81Iu24kuhEf9uZBnOXDpiaoWo0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0PrhgcYJVgTqe4+CQit8K21Qzx2NgW6BSu6fKAZzAo=;
        b=B91xnaQwUQzR0eZ+RFtRplWBRhh+kKA+dRAemhy0miBUSZyeuWg2XnVnFw8VfNNfiM
         3NBM/AJwXFh4T4AOgbgnAWsYi3C5SHvdru3NHid/MXS76oR5JOFTekI+C01JzHdGkkDk
         kP3b1bhB/fwqI1gHhGqW+m9s6K2FtFEqyLzZAqd48UeLnwc5OYCiPHGqSckAN7qodsIW
         cscxpaCvn89S1GtgC60SfqPYNmVqkUBjeHNtMj0bWA+KfxSTS4v5hbjT0nNdPPe3uV4a
         K/5iCnWgq/A14r9IgcBQxbkqyUyxMvkDgoQAeRL6Rk0UiXENztyRCVoHAyKztWFIBBzC
         Gfyg==
X-Gm-Message-State: AOAM533ujddPHhSYwmFcIzm+xDDXz+rEAbGlv2BPfz1kpwuMX9s5sMha
        eBaIIhqxGArEocNc2xqPg0I2Xg==
X-Google-Smtp-Source: ABdhPJydX+WFLDfDtDmBc829cTdBdgwRNiqeVZiwi+7svnFxEDJ2PhQ+rAM2Ofxr2zxNB6JclOH0Lg==
X-Received: by 2002:a65:458f:: with SMTP id o15mr8362394pgq.111.1615252711587;
        Mon, 08 Mar 2021 17:18:31 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id q25sm3332721pfh.34.2021.03.08.17.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:31 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 4/8] iio: gp2ap020a00f: Remove code to set trigger parent
Date:   Mon,  8 Mar 2021 17:18:12 -0800
Message-Id: <20210309011816.2024099-5-gwendal@chromium.org>
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


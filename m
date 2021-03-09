Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD20E332F1F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCITgj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhCITgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:36 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D88CC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id l2so9488450pgb.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5rJk32IYXKnAiL7w4qtgr/qP8Mr5akR81UgSTuQHew=;
        b=HL1eSJATdgYadJ++3uAB8OSzCirin4nWzE3XFtbi8sixGB3qtMgnUOKMN+Y/18zsN4
         jfaN4sqKTRcm4dyrvdBT9aVbk5B/q+WT6wgH/x1/aBZdcMKlbHuwzbRPJkPVY2kj8dAo
         zZ8KOqbCfTL/1eunVlm5qGcaPOgBEYcxyFHH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5rJk32IYXKnAiL7w4qtgr/qP8Mr5akR81UgSTuQHew=;
        b=UQztJ3/qTUQwIR9jNOql2FTUeW8oTBtK9tGRfwscqFKZo9LhlpjvOgOmm49elDNs2n
         S1Vw+T1Tt61Iv5C6R7buns12leHnREQyhD14vnZRFYgK8iFX+ej6m+06QIzBrTjl/pN5
         /wDctdW9RrbRQEvxSWudOKpJP+xrUMzFDhHPsumcdEbYjDq+gQeXUReiDapZfE1XKPDp
         GDYjyBXzjAyBEmy03U/0RvNAYMQ/JaGVlVxw0kWMCV+2dLRIZzbU/nX6fdFSoggOHdSp
         OckUJykMnxHvcNRuMgxtVZTfI5xZCWoyBCRfKD9NVx51Qmm8dNltSlsY74TCur45zhVY
         /6PA==
X-Gm-Message-State: AOAM533ibcllJYGSTe2VjY/JIeKeRioSp411/7SUsYlX+JzjzW7Yd8ng
        dnutk9Wymwz4JdVkGpm3usUNaw==
X-Google-Smtp-Source: ABdhPJy9yLNfKELStxDK2H4REwscAY3nMZKRrfUXKWJgeBeOh5rRkBIBrfviqFqKTozUjsOTNmbSpw==
X-Received: by 2002:aa7:96ab:0:b029:1f6:2d3:3c91 with SMTP id g11-20020aa796ab0000b02901f602d33c91mr5032324pfk.10.1615318595859;
        Tue, 09 Mar 2021 11:36:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id x7sm4837880pfp.23.2021.03.09.11.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:35 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 7/8] iio: as3935: Remove code to set trigger parent
Date:   Tue,  9 Mar 2021 11:36:19 -0800
Message-Id: <20210309193620.2176163-8-gwendal@chromium.org>
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

Given we call devm_iio_trigger_alloc() and devm_iio_device_alloc() with
dev as parent, we do not have to set data->trig->dev.parent to
indio_dev->dev.parent anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
Improve commit message.

No changes in v3.

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


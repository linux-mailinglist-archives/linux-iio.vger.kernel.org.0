Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3961F332F1E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCITgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhCITge (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:34 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F6C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 30so2566562ple.4
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soVpBbkPXJfM/RkjYCK7snnTTDh8er7781CZS/0NccI=;
        b=CkHC/WAGNq45ZBwV/AFvhXb8KZuYQlEKZ3s4PwEgtL79cjf5x1jtPSdL6TW93ZLCDM
         wmHKvPaScDp1i0kslsW23UZKOr7IfrDLKmUAg7O8KTkRKgJH8z8FwuqJ+rCpU7C84pwq
         lBtKrRw42U6803l7vIiH9fLiyd+WLlTF6SVQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soVpBbkPXJfM/RkjYCK7snnTTDh8er7781CZS/0NccI=;
        b=Fq6QNczDyhtc+hqsHAxRA4OnRfh4ZciLxJ2re3xeR06riErv77qxfIpKw1gxJ6sKka
         Y0L5Mhxr1rJaN/rkM4ZaLvBUy10vPDBuOXNyWo2WGl6lJCOqnOXhPlo1ltnbhEBVeB80
         p3Kl0WTgsLkrl4xyv4ozc0bFy9nC8rMTyra4s04Z5BNx7JjulFf9zIxUdIz1hq/c/iVY
         3NU+n7nh3VsW+Srws6TkZCb4SEo8fLXHa6eYK3omfMOWNgt4iL6KBan9eqMuEkGzKQMd
         gcHhSPH+TFeGNJzsmK98XGuSht0ioXHHsu7Dn0NKQdNCFUwJGnNhWQJk4zMzOT3h1AKA
         P8Yg==
X-Gm-Message-State: AOAM531dAvxENiYE2DJQ1OorGwLXy1Tn6BPAc6709WywUhAteE6P42Ph
        18wZyrG2qM0IfPoWMrCGEOhgkg==
X-Google-Smtp-Source: ABdhPJxJVuKzGXuGYQMXTZPgRoAdmizJtLczmVRznmV8a27ttcuy3R4IvVR6FTP4ZWVgfDwrDOz8jw==
X-Received: by 2002:a17:902:9001:b029:e6:2e56:8b0d with SMTP id a1-20020a1709029001b02900e62e568b0dmr9849577plp.31.1615318594205;
        Tue, 09 Mar 2021 11:36:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id y8sm15043404pfe.36.2021.03.09.11.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:33 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 6/8] iio: chemical: atlas: Remove code to set trigger parent
Date:   Tue,  9 Mar 2021 11:36:18 -0800
Message-Id: <20210309193620.2176163-7-gwendal@chromium.org>
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
&client->dev as parent, we do not have to set data->trig->dev.parent to
indio_dev->dev.parent anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
Improve commit message.

No changes in v3.

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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D6332F1A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCITgh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhCITg3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF94C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z5so7139770plg.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2A6HgZpfcj7n4+bznUbpJiLnsGQ0Ys3LWgNwb56x4a8=;
        b=BCPlp2DzMiO7SneqUNY2PWeKzW0o3TGYh9UAejne6lOs1eqW8aiAcM+CjzwS5VVlJW
         cqkAIx7A5mGGt+4BbiaXODmz17BhdJA6Z06zMQcV/VzP5kyIxrQuxfN4srcMZTi9OxOp
         VxrbBFZ5Q4HyGIxe2DOpyAKueCDD8uV4Pf7Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2A6HgZpfcj7n4+bznUbpJiLnsGQ0Ys3LWgNwb56x4a8=;
        b=ev4om3Qm9RjKmc1Jtl19ldfCgrmaVHqqWJDVWk+4aR2IZiol0jFW85PNxZcgQFgXoY
         fuBo2II9uZq5qDfMANAFlfvVpB7NH0VzGLXyyL09ibOchzPTiRt+xUiPyI78OQco8MJw
         nd28WcTWqhmjeF+B9Gfl4iyI5kIhA/OJ8aQjrE0oFrgq+1ueenRwJkUW7on2fGkHcuWa
         61Nb8RIg3frmeO9NOeo8viW2/SFVLOBfWfccGR6ZI8PxnOi3+QNlOE/Mw/HQPbNMYxsp
         21n8pQdAJLOp9ILzyJtBq3eIEiJfFtxImugFMXkfCmsEbYfPDlPUQXUwIg6TwENgQIGi
         uRWA==
X-Gm-Message-State: AOAM533gth2jAP5G4p51KzLStNsdk7A8PpADTVoL0+qVZ1auGAs296H6
        yY749UeNW+Xx8IGj/ii3Vl+3uA==
X-Google-Smtp-Source: ABdhPJwnTN2pYpFGnSBr6BfA8iZLKQqB2AhFqFIZOodeQCtJeT7RT01YP6j3avjASKCuG2OZLHA5ig==
X-Received: by 2002:a17:902:207:b029:e4:471d:82a with SMTP id 7-20020a1709020207b02900e4471d082amr27289907plc.24.1615318589321;
        Tue, 09 Mar 2021 11:36:29 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id d8sm2725682pfo.194.2021.03.09.11.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:28 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 3/8] iio: adis_trigger: Remove code to set trigger parent
Date:   Tue,  9 Mar 2021 11:36:15 -0800
Message-Id: <20210309193620.2176163-4-gwendal@chromium.org>
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
Remove adis_trigger_setup() to match other drivers where setting the
trigger is usually done in the probe() routine.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
Improve commit message.

No changes in v3.

 drivers/iio/imu/adis_trigger.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 64e0ba51cb18e..0f29e56200af3 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -27,13 +27,6 @@ static const struct iio_trigger_ops adis_trigger_ops = {
 	.set_trigger_state = &adis_data_rdy_trigger_set_state,
 };
 
-static void adis_trigger_setup(struct adis *adis)
-{
-	adis->trig->dev.parent = &adis->spi->dev;
-	adis->trig->ops = &adis_trigger_ops;
-	iio_trigger_set_drvdata(adis->trig, adis);
-}
-
 static int adis_validate_irq_flag(struct adis *adis)
 {
 	/*
@@ -72,7 +65,8 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	if (!adis->trig)
 		return -ENOMEM;
 
-	adis_trigger_setup(adis);
+	adis->trig->ops = &adis_trigger_ops;
+	iio_trigger_set_drvdata(adis->trig, adis);
 
 	ret = adis_validate_irq_flag(adis);
 	if (ret)
-- 
2.30.1.766.gb4fecdf3b7-goog


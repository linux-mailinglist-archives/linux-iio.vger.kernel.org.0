Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC8331C40
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCIBSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhCIBSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:45 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F179C06175F
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a24so5726369plm.11
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKn/M5SsI+/8Ujc6bkROYgoE8KY8le0ozHcjTqb+gnc=;
        b=GANRBdJ4a5N0JltScVkrBkm8LYvXjRn0lbOouwsIuzz1JHm3JbSdvid3THk4sMl+VZ
         7mhO3KQwfv/9cnjF2G2Y9uVclJEB9eJAV6q0HATV6zBNgBikD9OHuqqmROciQpE/VweB
         IX6hpC2Wd2igkms1n5aiXtThFEhl/UaEHQP3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKn/M5SsI+/8Ujc6bkROYgoE8KY8le0ozHcjTqb+gnc=;
        b=cd9/LaNMkre1Vi7WbiJVu8pt8mhWH2heZooJNBy7W4JkMbZD5EYnfCgmqVFLg+M5mm
         9Q4l9ztJyXCkW4fMTZCz2wIV9SuODO2HxLsU+YGXCB/AZbUCYXy8eq+pqrpFWD51Vf8P
         a6ErTtbSoPKX5zfNh+SmB6rI3O1ojTO1Q+xD1JU4BKNutybhzkhOFXCX+0fcmNrsqazm
         S/sqouI6zVhsnDYTTm4hE0zlzmNA2eBpDG/BnPwldCBJHk9OYmQFPRiVd6WU0+KVLTec
         703B1WLf8fhZUwGn3P11ICMvcq/6eQO6akEg1EXBP1wMPf7QaE2HnMdPM4SXmmh1rfKq
         /LYQ==
X-Gm-Message-State: AOAM5321iAwvRF8xqWMQ4KMcbRrxmyUy3srlMUIRNGVZ2ULjkeODkY1k
        RLONYDn5jiGNXRxGx14tcB8cog==
X-Google-Smtp-Source: ABdhPJxs0xqQ3YWUD27eUzAdYB5XKwAjZSokGGugd61D3K2oFX/4M55RkHxx+QY/6xeZtY6E7igDEA==
X-Received: by 2002:a17:902:9b8a:b029:e6:17bb:eff0 with SMTP id y10-20020a1709029b8ab02900e617bbeff0mr9373336plp.54.1615252709989;
        Mon, 08 Mar 2021 17:18:29 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id g21sm515976pjl.28.2021.03.08.17.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:29 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 3/8] iio: adis_trigger: Remove code to set trigger parent
Date:   Mon,  8 Mar 2021 17:18:11 -0800
Message-Id: <20210309011816.2024099-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309011816.2024099-1-gwendal@chromium.org>
References: <20210309011816.2024099-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes since v2.

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


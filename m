Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A62497C3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 09:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSHxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 03:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHSHxv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 03:53:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B6C061389
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2020 00:53:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so17328885eds.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2020 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyHxYnikk4aL0fAERJoWnAheKV+1tCKTGdC7Xl7sb8k=;
        b=cB58bQMA27QO3ZewJJh4p1oonryO3ZlxeQ56Qfu1+i4ishR0NxKZMzBbd/XGUcHvXa
         RYuo6WTDW94ziNhhvgj3TjqgdQkxyj9qQoXCB/d6C/ZBUjbeAKXID+vRC3vQJRqdE1wB
         s28JgnnjscoFOsz5KnGeByXNLBHtCXe92wVVdAus6gxHruvX9iSNekKVkdxT6JKfqDn3
         /mMuvY6NnUxqIfxvXcvefb7Zd+QsyqrdHxb/M2vEtP23fg8MN2uppKjIDyd5xCxFBzvS
         z54rDjFwIZufnXLnvK1coLyQG+81knUeCLD8jMVp+idw9WibVy1n6j2UFh5RyZDz82SH
         sOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyHxYnikk4aL0fAERJoWnAheKV+1tCKTGdC7Xl7sb8k=;
        b=gz4pdsuPu+t31TjZqa+zZ2kkPyYhPPpnehYXRn7Yaxb0w+Nqkyr0027jog2ff/edrh
         YRtEist7sK66YTI7njJUsv5Cl+FuSS4cqUUvMrZi5h6CX8zv2wTXrLpY527kuVi3u8hp
         30LE6/C+rSIAoCqYMUejWauUUb7BjBJ/U+R6MsNSyrbZdApzIM/5nQexC/Y6+8TJrXjc
         rdDEyb0FQS+NsdEzaP85koXfruZ6T8mv6tLEayuUjM8eLorD3/KGTr38o2efplnaly+L
         3DWaDpc63Cp8YC/vDaBpRbNtEXiIfpYauf3jMMlpbMODF8nDokIqqKgD70tE/nIKmB6q
         Wmbg==
X-Gm-Message-State: AOAM5303SoxvLJdzA10cSocjQO7HvloGsDPGBYTcIFW2IZgMptKfTNj2
        T+UKdcpa5e6nvhK7UPk0biFd1cXm8rE=
X-Google-Smtp-Source: ABdhPJwcPIf3lfUtGWhQfX/LRfYTAKnkK4PoQxCZsUzo2bebQTWr2VJaAX3rMkfcIfdE3QasTfdPEQ==
X-Received: by 2002:a05:6402:12d0:: with SMTP id k16mr24108201edx.199.1597823629538;
        Wed, 19 Aug 2020 00:53:49 -0700 (PDT)
Received: from localhost.localdomain (host185100178123.static.fidoka.tech. [185.100.178.123])
        by smtp.gmail.com with ESMTPSA id z17sm17276199edi.19.2020.08.19.00.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:53:48 -0700 (PDT)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
To:     linux-iio@vger.kernel.org
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v2] iio: adc: mcp3422: fix locking scope
Date:   Wed, 19 Aug 2020 09:53:45 +0200
Message-Id: <20200819075345.1392772-1-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Angelo Compagnucci <angelo.compagnucci@gmail.com>

Locking should be held for the entire reading sequence involving setting
the channel, waiting for the channel switch and reading from the
channel.
If not, reading from a channel can result mixing with the reading from
another channel.

Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index d86c0b5d80a3..02a60fb164cd 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
 {
 	int ret;
 
-	mutex_lock(&adc->lock);
-
 	ret = i2c_master_send(adc->i2c, &newconfig, 1);
 	if (ret > 0) {
 		adc->config = newconfig;
 		ret = 0;
 	}
 
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
@@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 	u8 config;
 	u8 req_channel = channel->channel;
 
+	mutex_lock(&adc->lock);
+
 	if (req_channel != MCP3422_CHANNEL(adc->config)) {
 		config = adc->config;
 		config &= ~MCP3422_CHANNEL_MASK;
@@ -150,7 +148,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
 	}
 
-	return mcp3422_read(adc, value, &config);
+	ret = mcp3422_read(adc, value, &config);
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
 }
 
 static int mcp3422_read_raw(struct iio_dev *iio,
-- 
2.25.1


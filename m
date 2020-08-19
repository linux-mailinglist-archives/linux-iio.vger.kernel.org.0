Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC392497CC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHSHzu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSHzo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 03:55:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D61C061389
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2020 00:55:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so17314937edk.6
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2020 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyHxYnikk4aL0fAERJoWnAheKV+1tCKTGdC7Xl7sb8k=;
        b=L9Jpn8ffSRf3ZEwBYMKZLoRYgscGcvbz/nJmYH9ofKB2qIKLgXYSIkqq1IvY9WCsy8
         w8U35LkOGvBrLkqymNXD9XipLOOkKMIS6d9eIv6X8p2VmlVDFNEMKSAR48BZL3OCdlg0
         s5qRNd617UeGttJR75yOPvLyqq4SE9F9g4BrwbNc11RizJIAT03QB3nPH42xhjdu7Btu
         RkaAo8xtLA1WYauAqhlTQNSU/HU9JnmZYKa64VHDCZ8ig0EbRK9nWHi82/9Z03OYhzcW
         Qstwe33pyWSqJwZ6A0wqIeBATxrEXkmakF2xXlvFNYOaLKCUVNUAEdL96mG6f5IVXpZT
         Z95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyHxYnikk4aL0fAERJoWnAheKV+1tCKTGdC7Xl7sb8k=;
        b=Zx67VY0bLB4wyVk67twy9xq4YDatOn3TbcQy4FuodujBbp89pUFs0WXXB3aKKJ3WPT
         WVH5Zmu5I9TK+aDcUlWYr49feoMdFiQl6b7LBWR16tvSVCkn2Qi3y/fG+rh33TAuNoWV
         nPzzKwr0ucobb5vzxRzhfj0Kd/KeKAG7VZNGeI6mY25mhPx8ofhjj1TltzgYaQQZgSgh
         Haog+t5saeOG8NZizgTjKLOjO6/ShKVNtbNpWh/RazMXgUgJGB0TnTvaFyqTCgehkiWV
         nLR0sqAocThB7F3RX3hcp1SIbjwweOSdE3Ow7tznPI//oER1juFhZl06/KG1GAmOrVe7
         v9VA==
X-Gm-Message-State: AOAM533rWxtbSayeNe0IoLHV3vMcLObRBLI06268tTVnAFrR9QHeOeIh
        SJ8GIETPisp3xvSKmhDr7Ox+lPPW6J0=
X-Google-Smtp-Source: ABdhPJwWMHtRFlh5e1ovv1LlgG9Ljay209u7Q4SfI3lPUJq4mLF291EMWMpPPxG13a/Rgn7TtklwCw==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr22931444edz.115.1597823742089;
        Wed, 19 Aug 2020 00:55:42 -0700 (PDT)
Received: from localhost.localdomain (host185100178123.static.fidoka.tech. [185.100.178.123])
        by smtp.gmail.com with ESMTPSA id qp16sm18425902ejb.89.2020.08.19.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:55:41 -0700 (PDT)
From:   angelo.compagnucci@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v2] iio: adc: mcp3422: fix locking scope
Date:   Wed, 19 Aug 2020 09:55:25 +0200
Message-Id: <20200819075525.1395248-1-angelo.compagnucci@gmail.com>
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


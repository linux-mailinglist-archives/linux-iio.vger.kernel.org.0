Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42A9492FFC
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jan 2022 22:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiARVZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jan 2022 16:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiARVZM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jan 2022 16:25:12 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9BDC061574
        for <linux-iio@vger.kernel.org>; Tue, 18 Jan 2022 13:25:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 133so433463pgb.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Jan 2022 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TpFe5tqNXNULt2W2L3XtheVP+3XzuIrJvrSOX2JG/g=;
        b=YGd9Khbhr2ugr9SI+ps+6NOWHfBMaHcsWZqsojSoX6q8RG0LEdKiqHT39Yez8fogcE
         lXmP3wIR/q1mLQTeu1d4uwUbM6IeEY4l+IWQeEx4Uj29Fr4286yaCIRk0knR5UYCQyR5
         ODIHq3cYOZju9/eQIHvQavN4JMsq/nDhO6fSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TpFe5tqNXNULt2W2L3XtheVP+3XzuIrJvrSOX2JG/g=;
        b=Gh7F7QK/H7MKvJd5g+xpIrVvu4zp3K5VBCx1VGE6kHckabW32NiMFVsC7i+Ox9o/Dr
         ZBLGfsnGOiB9laxvm+gauKG8iyDVsqBV0VZw5iy0ANxuBPaVhHF5F3uQYjXUGsKJPmxg
         3lLjOFZZXucnoP8DcwBxAjle5o+AX8xTPuI629e8WTqWl/wKSjM4vP78+VEjiUIRIYG7
         8OZfciknAL5Jh3pxyekRNmBLrBb5hGvSYcoLz6jj/F3P2VFPcorIgW2ABzcQc4NM+MeM
         XnRi7ly9PN+ZZbjSceHAlYm8w3lTKEyW5v1Pi9yYniow034WmuXwMLPA7Uk0UlyEeW7v
         AwKw==
X-Gm-Message-State: AOAM530d7HjnODtipAGV159bpJz8MWTBCx77xtwyEhhhUGsXct2wxfqK
        IS+D2qaQG3Iv4grPvj+nXP9Tpg==
X-Google-Smtp-Source: ABdhPJzaBdgQZB1BER440prPoJzd2izEEU2jPH+pL/9nd8sckj8cxIkcKpIKGJ13GS9Mg9RH0kK6IQ==
X-Received: by 2002:a63:350c:: with SMTP id c12mr24911765pga.568.1642541109871;
        Tue, 18 Jan 2022 13:25:09 -0800 (PST)
Received: from localhost ([2620:15c:202:201:89d2:8dd6:a9dd:e988])
        by smtp.gmail.com with UTF8SMTPSA id d1sm15446066pge.62.2022.01.18.13.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 13:25:09 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jongpil19.jung@samsung.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: sx9360: enable push iio event
Date:   Tue, 18 Jan 2022 13:25:04 -0800
Message-Id: <20220118212504.832429-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jongpil Jung <jongpil19.jung@samsung.com>

Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")

To convert SX9360 status register ["REG_STAT"], into a channel
index, we need to right shift by |stat_offset|, not left shift.
Also the PROXSTAT bit (3) is for channel 1 (PHM, PHase Measured), not (PHR,
PHase Reference, channel 0), so the offset is 2 instead of 3.

Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9360.c    | 2 +-
 drivers/iio/proximity/sx_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 6fd6561bb6f5b8..3ebb30c8a4f61d 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -775,7 +775,7 @@ static const struct sx_common_chip_info sx9360_chip_info = {
 	.reg_reset = SX9360_REG_RESET,
 
 	.mask_enable_chan = SX9360_REG_GNRL_CTRL0_PHEN_MASK,
-	.stat_offset = 3,
+	.stat_offset = 2,
 	.num_channels = SX9360_NUM_CHANNELS,
 	.num_default_regs = ARRAY_SIZE(sx9360_default_regs),
 
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index ac8fd5920481cb..a7c07316a0a91e 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -87,7 +87,7 @@ static void sx_common_push_events(struct iio_dev *indio_dev)
 		return;
 	}
 
-	val <<= data->chip_info->stat_offset;
+	val >>= data->chip_info->stat_offset;
 
 	/*
 	 * Only iterate over channels with changes on proximity status that have
-- 
2.34.1.703.g22d0c6ccf7-goog


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF94496E1C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 22:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiAVVet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 16:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiAVVes (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 16:34:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C2C06173B
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 13:34:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e8so11966485plh.8
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 13:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpmIN/syFARwCGCzyBTIOFhtizRz986WcFIb/aB3/SA=;
        b=ZgvT9kTahbESsdUuZ6wzy+BOHw5ncv0IP0DltorPMKm2LnFAq8a5OMq1ElVeK5a3gW
         rAc51AiRhcy9my01vWm4ae215AvCkzU/hRbd4HAU591BiPmFHxWyH+DQ93pu7rpK33Yz
         pSpXTofNL/EVW3Q1r+S7jQPkAMJ/4irgeJAC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpmIN/syFARwCGCzyBTIOFhtizRz986WcFIb/aB3/SA=;
        b=sMF1fmJ7nrlK26MHduo5ZAE428oN3dSIRB7WbOj9dNj5AAMrF9fzwx79RdcyWLxjcC
         qtGpRO5jZvvXvWsohwqQtWa2O2xnn4bNQcp7fQXvqKehWGCay3jZ6PDGK/QSRnYHjbT7
         6w4cX0VQaZ50yT1ZWDu2CXo+GsXnmFtyyUcYXyGFTZDo4yJKOhyZODtyl9q8Bw6Ho1Rt
         koWFKCwyMrIDWjVtyTyRQbEeeaLb6+4eK8OeU3+r6lu+gPzgsY5Nqktm8TsRS8gCVW1K
         6IcBCEsh9J8wjsR1oWnW0UgWE5LLeu9itAAAGGJDVSmTFmXrtFvtd74voqcgF68R5f8u
         GM7A==
X-Gm-Message-State: AOAM532qs7KKfvjGDONA8vfUJGoE/9ApHAbvNbLkCZc7Xp6ThnWE87rR
        nKus3kZjjBgNJGKjf3txIF6aDw==
X-Google-Smtp-Source: ABdhPJyHnunDfWSI48Ml+iR8btWRW1Os8mhYlVghJ60eayMqYMpUMhbyjbjObzyC3VGISoMXxs3c+w==
X-Received: by 2002:a17:902:9894:b0:149:8a72:98ae with SMTP id s20-20020a170902989400b001498a7298aemr8826360plp.132.1642887287850;
        Sat, 22 Jan 2022 13:34:47 -0800 (PST)
Received: from localhost ([2620:15c:202:201:dae8:9acd:1e66:15d7])
        by smtp.gmail.com with UTF8SMTPSA id mt14sm8904882pjb.21.2022.01.22.13.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 13:34:47 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: sx9360: fix iio event generation
Date:   Sat, 22 Jan 2022 13:34:44 -0800
Message-Id: <20220122213444.745152-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jongpil Jung <jongpil19.jung@samsung.com>

To convert SX9360 status register ["REG_STAT"], into a channel
index, we need to right shift by |stat_offset|, not left shift.
Also the PROXSTAT bit (3) is for channel 1 (PHM, Phase Measured), not (PHR,
Phase Reference, channel 0), so the offset is 2 instead of 3.

Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Change title to highlight the patch is a fix.
- Put "Fixes:" tag in the commit message footer

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
2.35.0.rc0.227.g00780c9af4-goog


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC243A21EA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 03:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFJBjK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 21:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBjK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 21:39:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECAC061574;
        Wed,  9 Jun 2021 18:37:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x73so243251pfc.8;
        Wed, 09 Jun 2021 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D9NMWJTej053t447eIPNR0Qklez1ed8b2jcSOvvdes=;
        b=NUsN/F7tXiK21ga7MhoXMSQLca9QR16Q/e7wwMPykRvyv6gqXjYETS8olVF8gLt+lw
         G/5KhrIutjANeYKZzVrcirzu4OYN36lqmgy522uGlRPSSywUnOtOwLwKxxpCgou8K2y/
         hzZmnmothERUPg828a0xIXXl3oyKPY2rOXbNRpCUBc84CSRgSvT539uTzzzQQ1WzhvRr
         7r+T22X4siZafcHH+70o2qcY2iHtvzPlYOM9GUy/xZ6TmTePWIbwO/oh28ITh/o7XTwk
         aoRFkxjSJcd+b/CZICR3Nj+XXRqyNxRlSzhxeoY5SIbOW1P16KjGC2UOCxBpWOLPL83I
         3f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D9NMWJTej053t447eIPNR0Qklez1ed8b2jcSOvvdes=;
        b=ByGxiPUnL1oirA0uuk9Nlo8aQx7KJ1usPZpC2k+VSz0LSc+QX5A/nxhBVVJQ/M/ZZV
         B8l18J2fOAV0JgakwnBeoR8OBqncgmzoSrjOQ1gy8L1hniRSdtqDvxw31rgxu+2B4rdD
         cpDALTqbCDSb57hJuHQ2yUdqj6J58qHA+SewvUjxZjK/yg4tknw0zR9E7Pv5oPixj8en
         pk/FkxpAXTNDEX7JNBSngj62evZSLi6o302nG/r2aZoN6xIIbiIEVis6PQ9qmXpwOJfp
         zDmjMpLBb9ktmCHumx57DxD/m6eerPrfyzwgkisvC9nUDkINFQxFJsVSyZiKfyV9jgVp
         lxlg==
X-Gm-Message-State: AOAM532CFx1NMy8tC6cKlI6WM9rm0MrkYPpWebrM7Jok4v2GkQZFeT8h
        tSfseTASRFmD1JAd+9rsBXU=
X-Google-Smtp-Source: ABdhPJy+vh3dS9ZcvT9Niyzh7n9FP0Rl4ErnxE0G+a8F8CQviyw6gQUQZSTsrLu2JtVq3vM5Upjs1A==
X-Received: by 2002:a05:6a00:148e:b029:2ec:398a:16db with SMTP id v14-20020a056a00148eb02902ec398a16dbmr587135pfu.74.1623289020979;
        Wed, 09 Jun 2021 18:37:00 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s24sm6101533pju.9.2021.06.09.18.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 18:37:00 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org, linux@rempel-privat.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] counter: interrupt-cnt: Add const qualifier for actions_list array
Date:   Thu, 10 Jun 2021 10:36:42 +0900
Message-Id: <20210610013642.149961-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch renames
interrupt_cnt_synapse_actionss to interrupt_cnt_synapse_actions and adds
a const qualifier to match actions_list.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 827d785e19b4..5df7cd13d4c7 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
 	},
 };
 
-static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
+static const enum counter_synapse_action interrupt_cnt_synapse_actions[] = {
 	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 };
 
@@ -194,8 +194,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	priv->counter.signals = &priv->signals;
 	priv->counter.num_signals = 1;
 
-	priv->synapses.actions_list = interrupt_cnt_synapse_actionss;
-	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actionss);
+	priv->synapses.actions_list = interrupt_cnt_synapse_actions;
+	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actions);
 	priv->synapses.signal = &priv->signals;
 
 	priv->cnts.name = "Channel 0 Count";
-- 
2.32.0


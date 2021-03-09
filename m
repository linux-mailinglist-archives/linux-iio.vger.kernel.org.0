Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38BE3326BF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCINV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhCINVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B04C06174A;
        Tue,  9 Mar 2021 05:21:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y67so9520693pfb.2;
        Tue, 09 Mar 2021 05:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rC2Th++vNt7CqGAj8WhJOkxOFf8ZEs13/9ziRoW9ymc=;
        b=E/4zwhWgcU4xyOXY8FDQeW+SR9ur9RmudK7zimF4LzKDITpUVG4827s/iONgSA9PpG
         y9Tby0YfFWbRhVpxHArnaYYiqbKBuTV5jVQyckjVVAxHjufzRbu70bxnbXuYrr2sKz78
         Azqb0OjEmY08D5CCel1gMdHXed8HtHiT2xBGNlLhKuS/Fs2W+/9HpIe7RfjBM1uWQOJ+
         czzF9qSKODr59CXoLqF1iJTdYqABa64zXh00WbOV2AMDX8GPj/rDiOYJcCFVqAfcMfE/
         xsqpJniF26aFbx9eCEEI+DnaWOsEKuW4ns05JQLBiDwb8tfqP/WNMJfIxzpH2me97cIL
         Enbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rC2Th++vNt7CqGAj8WhJOkxOFf8ZEs13/9ziRoW9ymc=;
        b=JUxIiVYgyPyqYayEDw4CIDSQxwhlGmPoCsq26gcLzgXbkCUYmmD1UqDT2q5Og+MCNG
         0ey3fP6Uz2oH+wdd76fB/cwaW1/67LUzacAu7rLaOtekqze8j3A08qeNKBSQS1vAcdq1
         VtqXtmDNkXZxhpTJ+lczo/k0/KkLvex+/kUSdtxkNfbGmvB396drpXZyu9zzleZj3YA0
         BaptfGbAPQF3+b0BU2VjciysApM3t51DpYLgm/DecQzpnL6grJtUtvLmEBLhpeJwKowF
         erHFUurg0TdvGn1k09WgzDvyPgWEndzcvWIP/XYoKfFnBQBXrcvM4M75zy1/b5HHhp1X
         DLWg==
X-Gm-Message-State: AOAM532Rvt+7hkeM6dU4xqE2gmnPJgxIkUwLha9B6rwVGihO/ii997BI
        f1i2FJFL1hiq4xoNveVAEVs=
X-Google-Smtp-Source: ABdhPJw9kLoA+icLpJPLdh1A/lMDX6fb53r5KBvtgKq0qWuhM1Z2JhSYca6Qi8lTMgRjJfO1PhKqmw==
X-Received: by 2002:a63:2e06:: with SMTP id u6mr9962931pgu.444.1615296089500;
        Tue, 09 Mar 2021 05:21:29 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:28 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 15/33] counter: microchip-tcb-capture: Add const qualifier for actions_list array
Date:   Tue,  9 Mar 2021 22:19:28 +0900
Message-Id: <08b2f787df2965aca63988ca35e58133cb4e2c3e.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
mchp_tc_synapse_actions to match actions_list.

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index cabcfebfc799..51b8af80f98b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -49,7 +49,7 @@ enum mchp_tc_synapse_action {
 	MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
 };
 
-static enum counter_synapse_action mchp_tc_synapse_actions[] = {
+static const enum counter_synapse_action mchp_tc_synapse_actions[] = {
 	[MCHP_TC_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.30.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE03326C5
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhCINWB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCINVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006FC06174A;
        Tue,  9 Mar 2021 05:21:40 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q204so9361338pfq.10;
        Tue, 09 Mar 2021 05:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+ywkOKIYI1rUeLTBajU0K1er4fWBGM8+BnI9DpZoy4=;
        b=llzPUbkZxWj2ssspPIFBoD9My5GmxNP0UdKdVEXdz2zTh/foocktiGWxwlIfJRrW45
         FOQPeFWkgFJA6uvgzNbb18ffI2aSIKJaf2Nxh1NOqOr43nJx5WTDzmKwlzYr1lcWwDUc
         clNvv9Co6ef7KmnE8OQszPLQ4TtmGTF65GqOntoIFFysIoFobvTu6O2G4VGTVNQyJDxo
         d1T1n//jA+sdhr3RSOgPIrY77OCfVqPS76BZ7+Pk9u10JTdIgL7mUuSUisGCW8n+9uYU
         pJLL6lkUIBYwiaig6NrOJ9TKFfZraijrjmUYMN7yhxoLuFmGdPhNkp5Y5a8nxQG/MYlI
         hejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+ywkOKIYI1rUeLTBajU0K1er4fWBGM8+BnI9DpZoy4=;
        b=eID89azRpHPgD4YyORh2znfsy/vUcktjVMhEa1UF5SvHR/l9QYti/iKIZ6OBLNVLm8
         05ib97cuYzkoLz9oTC7rTHzxDc2KyW3RmgCOb0d2ixUc7Kz6ktpVtjFbR6PB0w0OJIzT
         CabkA6KRU+rjzLk8aTuRj6TbIVGcGU7/o3U3yFSGGr3yczk11pesF9lzI+kMlCj7eZeY
         oYTaumhDIiT/1akb8gNwsQ/xSzMNjoPnl/9CeSIcy2fGkQW0ADPmJhMVQeNMUBOfiDRF
         AYGNUX78tp1KtG28hdnU2bu/intjRDMxF+zSlTjU5HIXNc0q+gABJyOqZODLi6YAgBcG
         zALw==
X-Gm-Message-State: AOAM530MvbnqW+cRdqnsbanSFqgIoptriE8jWljSBt4u+7qBYgZN7VH8
        +0z95jcUg59aLE3HxtT5PqtPbdnFBbnWAQ==
X-Google-Smtp-Source: ABdhPJyMLZ5b8EtqeiyGaxx6CJ7F0mX+VStcZ4Cbtooq3osrjRxIYqYrjb9XnyiH4sa4PKgADAZXqg==
X-Received: by 2002:a62:928f:0:b029:1ef:2370:2600 with SMTP id o137-20020a62928f0000b02901ef23702600mr24730883pfd.9.1615296099884;
        Tue, 09 Mar 2021 05:21:39 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:39 -0800 (PST)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v9 17/33] counter: stm32-timer-cnt: Add const qualifier for actions_list array
Date:   Tue,  9 Mar 2021 22:19:30 +0900
Message-Id: <4d1b80ddf1ec22c70b7b11389a5c14fe209e06c2.1615293276.git.vilhelm.gray@gmail.com>
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
stm32_synapse_actions to match actions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 0c18573a7837..603b30ada839 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -267,7 +267,7 @@ enum stm32_synapse_action {
 	STM32_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-static enum counter_synapse_action stm32_synapse_actions[] = {
+static const enum counter_synapse_action stm32_synapse_actions[] = {
 	[STM32_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
-- 
2.30.1


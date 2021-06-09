Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E423A0939
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhFIBfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhFIBfV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C63C061574;
        Tue,  8 Jun 2021 18:33:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x19so4549192pln.2;
        Tue, 08 Jun 2021 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SU3yllOH/J0JpGXFrD3OtM7IjEx3tP3j/eYcgE0Cn9E=;
        b=oU1U3suREqcUR8q+DQoV+nOF9l7+V7jxKkd2qE+LkqkyCNFZh07cG9+R+F5fNxJEk3
         cQkD3YHNjxDcJOzu0gzBshTatLobefQPDj/DKzqbzwx9MmJKknkzxPhRUF49sWb0W2bO
         GSPdUDYaBGqGA/jnANrtrJw0y2T92z6g5S6nokSsKhtjl5U6h4Ukgr8yPA1WIBkJN+Ni
         dQxsA1vjjDMjceCj4aWFHX6enVIKBpbBZuNTKJ5+EBVsh6pd503wTo90qSvBubigMVca
         C6m7mcqgG/euILcG+F0uYuCZ8axZfxVuZLjEnBLs6nqX+xzqQbkabix6SYoBcq1C/LQp
         xrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SU3yllOH/J0JpGXFrD3OtM7IjEx3tP3j/eYcgE0Cn9E=;
        b=qRaoc9uzUPBhBLQDnO1YRGhjDaTnBWEi+DDhYDCM4FywAzt6ciFUvHyRHoxF/CTiCC
         ff9E1RprG0cfrYp7lMdRTbUU1t1QdpiJTOIulkB5n5d3t3qLten9/P8Fxktp9DCZeoDc
         wVFDigR1bdXY8fV4Cn1RFMffrVk1z+lq+vqdPclBi1GBus7uAnLe+ap0KOCb/OtEI5CA
         mHzTskzQAQsrppIhkxUo32j/fWv5QWTd4UWU7c7OtOxXUWZp5j9oUHwcsZzdVWVDWncI
         gLdB+/KNYP077Dpko+oSTaC9xHPh0nXVuIz59tMBHaWoX6GndYrF8dohF6hT0nKPRHuz
         B0lQ==
X-Gm-Message-State: AOAM530346xWblj7sdYKdskObQ/a0jOcCjF00+VGw6hLABWz4TCnwf2x
        Dgfkdl0dGYjD1NpQpNmEZiA=
X-Google-Smtp-Source: ABdhPJy2EGG18WDW1z0FafQej0ZZkhrbqQ/DOtLGtgMSYWe3RJuz3NX/UdT0WMsW/+wMSKpBeoazDg==
X-Received: by 2002:a17:90a:2ec6:: with SMTP id h6mr7924018pjs.103.1623202396937;
        Tue, 08 Jun 2021 18:33:16 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:16 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v11 17/33] counter: stm32-timer-cnt: Add const qualifier for actions_list array
Date:   Wed,  9 Jun 2021 10:31:20 +0900
Message-Id: <9675edda958ee2ca371d271f46445d3e1934ba82.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
stm32_synapse_actions to match actions_list.

Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
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
2.32.0


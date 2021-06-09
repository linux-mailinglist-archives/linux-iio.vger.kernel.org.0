Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED03A0927
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhFIBfB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbhFIBfA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E0C061574;
        Tue,  8 Jun 2021 18:32:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 69so11673287plc.5;
        Tue, 08 Jun 2021 18:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et8AgYiB6JXtqMQ6TgVirGOTerpkjIUvfoH2D1VR5DQ=;
        b=s4EJY6oEU0CsvYizvi25LdRJb2Ox2KhzCDY6fWObA1JbKtiOjj6MKIPiwJh3712EsS
         xaqI7Cfrd8CIbUlJS5kavZ2eRRNZfad94QzYcKWCxIT/xCo1qMI2skqIq/2vpPFBeP/1
         qNcivthCgoWXblUzE4xI3LbcE0beNpRCDS0f054cqovstGhJ3g5erM4vibYU1j/RA47M
         J4iIh2GivW8CASwYIjkiJFTlCXZ1ZMCrIKGMPJhKthmgb4ybgx7aCZMieR/AfnsD2pqW
         EWn1OHUK4WFpQQG5QQ215pawQsYiiP18KgHT2i2XVgLqz0/Py6SDHKzZM3Nxqgd6yM8D
         i4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et8AgYiB6JXtqMQ6TgVirGOTerpkjIUvfoH2D1VR5DQ=;
        b=mHUG/UOztzPkiAoioIqUr8UarvvxFBdCSjydrP09IRDQxLlcYlrvccQkwDT8XvbJZK
         BnPiPqJ4wSOW/IncWekGPIHkNABbzC1rLLqYJd/TmPiRp9kcCXkG6dxGGLkaPPTCH9+z
         +JNd++FMg7XKOaFTp6epsbRwDYPzxqn0BZlaJN0sd8C/3ymGA1Dx+g5Tjclj8xuK7Z6l
         keYsjarR4AuBXyeF/fvODdLj6lc5LpCHaFCtokSm0MHiOQq2Td5uHcd6oZ6oylufPOrU
         22vsCWCqyrQZt97xaDImOzC2M4JLLrUgXUvt9hilbhl1Q6irwb2IqdfLTEzG9yM3cRTK
         8NIg==
X-Gm-Message-State: AOAM533nq8uvuIgQukENM8aN4/mIjEz+NCHSjQ7zOLxJjNLLTBFx714d
        QHwNaDisNOQyE/uW3Gmb+hk=
X-Google-Smtp-Source: ABdhPJztjspuIkpz3EqDj0zBUxhmL8cYAKO2dqyNJadSoJVsV9LoWb0NmJhKu06JkRV65RJmxTLnqg==
X-Received: by 2002:a17:902:db11:b029:110:a7cc:ff46 with SMTP id m17-20020a170902db11b0290110a7ccff46mr2943414plx.60.1623202370664;
        Tue, 08 Jun 2021 18:32:50 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:50 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 12/33] counter: 104-quad-8: Add const qualifier for actions_list array
Date:   Wed,  9 Jun 2021 10:31:15 +0900
Message-Id: <776ba3ad0a3c609d3600cffe0ed6446baf29fee9.1623201081.git.vilhelm.gray@gmail.com>
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
quad8_index_actions_list and quad8_synapse_actions_list to match
actions_list.

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ae89ad7a91c6..09d779544969 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -305,12 +305,12 @@ enum quad8_synapse_action {
 	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-static enum counter_synapse_action quad8_index_actions_list[] = {
+static const enum counter_synapse_action quad8_index_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
 };
 
-static enum counter_synapse_action quad8_synapse_actions_list[] = {
+static const enum counter_synapse_action quad8_synapse_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.32.0


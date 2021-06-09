Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16EA3A095F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhFIBgP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:36:15 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:45031 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhFIBgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:36:07 -0400
Received: by mail-pj1-f44.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so412959pjq.3;
        Tue, 08 Jun 2021 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lw85OY9IsEQkeBky8rQsiGABab3FzcsYXmNq0PU+6y0=;
        b=Wfncoto56Nnmo+4w8Z+qxMwcdO9zZDMQwYTo1BRw2xORjxeCGglPpRO1Kb6UuuFMR/
         gFjdGSAJvlZ/0DnwcfN5XQmqy6pTvpX2rJlce/wXRRyLqJMy9B1/qKnTvWNQEhO6IR6s
         iGhK9GsKdMAO16cnTVBxhxVefl0KwsVjJbDj+u9Pma8RykOLrgU8kFDhbeDuLu9wkR2o
         z11kDN/8/hqSvyuvfxgkPVem2rhR6kaJ9C+1LKR1rsV4uwTA24T9B/ef6PK9z6Y1Qwll
         rHmruZTFGxc4fe9Si6kuMROCJLh97s2R/ZiBeUrGMTAMsdIsnfzHMsbreiO25ThM2HCX
         xNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lw85OY9IsEQkeBky8rQsiGABab3FzcsYXmNq0PU+6y0=;
        b=un4DLhzmLmlY7RTzKJq66GcGJQXTOvHqFpoZuFJeTscoCeK3ZeeztECbGZcfiUCOib
         xNCh3s+R0YRsVMaXiAOUL2s7+tz48fkb9agdNkj2V0uDFqRCG5CYWeWwTStEb3P2t+xU
         W6M8FppZDvrRu8KWfyigYe9lJusXCzQW5gFjfkUBOKk+HgYOeKqIooAvwFWe5Uz4DfVF
         uH7mnFVk5oJuUFew6fxsw/XoHzI7vIvz2Ujq3IvLXQMsJARBQ2avGzrcUam/eoUxN1ub
         m4GhAuO/DVtGvwV7YOgBRFq9gG0dN5vzgQkiVKiKxL2BTCBNAK+mJM5cjzCl5vXYgGF3
         EZ1A==
X-Gm-Message-State: AOAM532CXcDspneCL6lgcLccDwtmF4FhI0QAbKy9RvELIHDGnxyeKqgD
        xt0xbY7t3FhQ4F2NwtLLKjU=
X-Google-Smtp-Source: ABdhPJwUKxbd6KAFcOZwqLerEiDxQZpMz2EYRlzoI+lmPjPlPXIz2hVf9gZtdqAD8keK/olId5lsqQ==
X-Received: by 2002:a17:90a:117:: with SMTP id b23mr29364330pjb.183.1623202380699;
        Tue, 08 Jun 2021 18:33:00 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:00 -0700 (PDT)
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
Subject: [PATCH v11 14/33] counter: interrupt-cnt: Add const qualifier for actions_list array
Date:   Wed,  9 Jun 2021 10:31:17 +0900
Message-Id: <a3bdffbe7c38eb95ea692ed30aeb50dbb65c9e6f.1623201081.git.vilhelm.gray@gmail.com>
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
interrupt_cnt_synapse_actionss to match actions_list.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 827d785e19b4..0e07607f2cd3 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
 	},
 };
 
-static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
+static const enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
 	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 };
 
-- 
2.32.0


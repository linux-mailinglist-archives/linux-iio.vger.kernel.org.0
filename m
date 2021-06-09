Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923AD3A0961
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhFIBgR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:36:17 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35356 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbhFIBgM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:36:12 -0400
Received: by mail-pl1-f171.google.com with SMTP id x19so4549021pln.2;
        Tue, 08 Jun 2021 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvDxZk7tQB+qPWeMP5/A5ST4dMAl9tR54BVIdJolS0A=;
        b=KiHWgCk0fMMuPdY/N9oF1xeLIsZSAzMgmsgZApr4RK9jG6MVI6mEY0HIz5UhLsMG/y
         yLnZgBvC6SdBhXebLewyHqxSCgoU5G+OpovEKrXIQbW9kIS+bp7i6FILVXSJOqWpBO7V
         SYby1ZrNHw5KIwqhdEstKb08RFH2U5d2YFYRPWD1J5QjgSfzj2fpedKp0qUpft/UJ1vz
         0Bz3uAHrv3baLXfQg/zLemXSumnFo8zHsFGlsDNZjho/BX/hwpyb7anI4cejTKNVdYSa
         24jtuZadKmJRCsAo2u1lQ44PNcxTwClzvzhU3IgOo1WdziaJCJhoDxWGe0PfEPGO/RGK
         Q8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvDxZk7tQB+qPWeMP5/A5ST4dMAl9tR54BVIdJolS0A=;
        b=KN6pHpzn53tmb9BhoSvJHSQlopeQ/4ywIlhhJOm66c2K1HFNTINJVlMOOKdonA6ypt
         qV/N09f9RbHOnY4IBuZQWVqTZuw9yylW7tpE7fvR1hCbhBAwz9QZgnJf0KHsgh4eZpj3
         iNgSi1NmO80SWXJ2azaCT6YIJc18Cpe1S1Wawea9uALhSqfTa26E9YYK5v2tVf6brxXi
         L6y8X5DhSVpKVOoDDrR0bs9Dm3VEN8madVRrS9UgiNwbIvEIy63pmDtXXar51p20QKEI
         xO6dLi/dHvVrhXGrqIUWQZ0UucYA/0C5FUYiJVgi1PT8MJLkna75Xv387HeXR7pE8+s0
         cbbw==
X-Gm-Message-State: AOAM533AIm8ZyihZ/jr+07GmtR4sdYH8rDF3k17al5LyK4M1qGJeLst0
        6LrxTFAuQKTY6WAOJ2okCe0=
X-Google-Smtp-Source: ABdhPJzGnzC0MKdX0Eu53cfIj6zq6TTIP6Kfu//OQycsPALjV760dgRZAs4Rrh1Wpc7XhPqBUiME3g==
X-Received: by 2002:a17:902:c20d:b029:110:483c:b965 with SMTP id 13-20020a170902c20db0290110483cb965mr2920907pll.77.1623202386223;
        Tue, 08 Jun 2021 18:33:06 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:05 -0700 (PDT)
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
Subject: [PATCH v11 15/33] counter: microchip-tcb-capture: Add const qualifier for actions_list array
Date:   Wed,  9 Jun 2021 10:31:18 +0900
Message-Id: <165f9682ce308a60a477aaa56fdae7bc949dc218.1623201081.git.vilhelm.gray@gmail.com>
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
2.32.0


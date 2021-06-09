Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3183A091D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhFIBen (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhFIBen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:34:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343CC061574;
        Tue,  8 Jun 2021 18:32:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x73so17150845pfc.8;
        Tue, 08 Jun 2021 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQg0KzWxyLI89TDhRMac/T4xtYtkVk6VuJ1hKQ5bvSc=;
        b=HJGgBGbAjNlvU50Q85PSF+HLHqQwaJ0i/X84fLizAxTBqAMiUe/Vg/Mmwu5pW7AC5o
         0gGuq0YrZ6C7U2euTXPonLgdH0FK/k4BCwWQL6T6Bqa/JOM70dE3/yfQV/kywYqDiuHs
         OeUnD2z6Bck57hihtB9niX2G3p61v0KW4lb68UDWQvhm6BxLR5l1gRfGGn7LTWDEIoUB
         DolNTg+cVwUqVCpN2sFCC4+AWU0Qk+epLPHATux7grkie5cv/TNrXr7tosAEbmTsGK3q
         Wu+yX63QnLGFb8BAVqX4rMn81jJ9+HawssBBfvT6F+0bXcxKCJ+r8GZ6MmjMPPy1EmuU
         4CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQg0KzWxyLI89TDhRMac/T4xtYtkVk6VuJ1hKQ5bvSc=;
        b=HHu+CWjbQ78En6DribH3M1krGcPyMGFPSU9X5lIeRxFlSJdQkOaKJOKurXWffcvW9X
         3/BS4eH43BpytzbK7OH52Oc5RGDuNEV/BE7GfssjVH4dOnDQmJ/DbEAnB6M5zpmNlUfx
         OPpV1q6I/SDXneyUfmpvYYfodC3ItqkqwzAl4OYNKAjknerIAX8A2A6eC606YenOyDTU
         3saMUe1QpgWW5eu7WqS9vgW6r4JzJZR+KuZla3+V64HLrltO0NZ3VdOpAaTP0Hevd2qn
         Lbzcx51dAjhGhBDwDGSsrJ1Kg9sPLgvGeGyz4hGke2sgsdMBnspBSeuDd7IgatA2TI3e
         aRPA==
X-Gm-Message-State: AOAM533+B9ux27BhJJKtRQUfJaKfpiUiDLAuz58t9ovSbuqwzK6eJvJu
        KO9qMiUzzQ1j5eAqhC+cjCo=
X-Google-Smtp-Source: ABdhPJz9AKFpQjyj238FycuGBzVMG+AOxE5pKG97IxPudIluTn3M/FdKu1JEiqaaPp3g9toMHaFYvw==
X-Received: by 2002:a65:4d03:: with SMTP id i3mr1171671pgt.422.1623202355014;
        Tue, 08 Jun 2021 18:32:35 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:34 -0700 (PDT)
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
Subject: [PATCH v11 09/33] counter: microchip-tcb-capture: Add const qualifier for functions_list array
Date:   Wed,  9 Jun 2021 10:31:12 +0900
Message-Id: <74cb91ab7b459563762ec28633cd8808093aa2ad.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
mchp_tc_count_functions to match functions_list.

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 710acc0a3704..cabcfebfc799 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -37,7 +37,7 @@ enum mchp_tc_count_function {
 	MCHP_TC_FUNCTION_QUADRATURE,
 };
 
-static enum counter_count_function mchp_tc_count_functions[] = {
+static const enum counter_count_function mchp_tc_count_functions[] = {
 	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
-- 
2.32.0


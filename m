Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1E3326A4
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhCINV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhCINVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:09 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4AC06174A;
        Tue,  9 Mar 2021 05:21:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a188so9477489pfb.4;
        Tue, 09 Mar 2021 05:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNvPFH0nbH03EWMVb853Te4h5hOebkH389D/4/Ar3Gc=;
        b=oHsuOiqMdMxnXlvuMVnuJtbCtO6m8GaPBzu1TtoNuV/yMutJbslbGT93vPW6pcL0qA
         E0QsNVaJRX6FG2ROv+fQUG6WEiyDTo8YHATz03XYW16NghpHEhJd/AAH06zrrfwJjBWQ
         fLBvXF+gmx6rqoJj25pjIxs0PmYuigH9GCxrirLNUvKeW9lfqW9sxg6i/GSlX3OlqS3b
         CRfxOYwVwIWcd8gAPZPyMDSnhG4/v30MZQMxqNHUVvjR++z6lOysCgS5gJ9kQkFqtOLi
         3LwS4D6yUCljHjF4s86ICVhzqenEdJge6p3VwyMcj5k4Qc/gXohYgSEVxqCF4TwLzgaD
         eAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNvPFH0nbH03EWMVb853Te4h5hOebkH389D/4/Ar3Gc=;
        b=o0I9dM3IOxeluootHbsMa60EqIeo6u4r9/9mIV+FMGgPVo5a6vmXAocmuRfZ81kWeJ
         YaHk0og0Y6UfHvzEGcSC9yBsF+pxGMH2T7EPrRcN9DVoEOjql57bWUYiPbEI+Ikkk3hc
         ZRekPy1Z1bz6msEMjRGvYuRgsxpG1sgAPI5wJTKvAAOLCFb8szmIpHXVejGM/hdFr+Oa
         H5HoWQyG3DMb7Lvah7N9/d6llXy3Q86c1wIspLk1cJ9e4DLKYHAVO7fuV8273380em9H
         O4genYY5u+6S5tm4SKRbf9HsWPTKIhw4zjPVU1UzMglvFFG9Ff/18+gnuv4mLFFB/8Un
         goog==
X-Gm-Message-State: AOAM530WIdcM2vrX1zmInaeM7mwdNF2I5xFgsigiMEdCQqjRhsnUco3z
        S6VxFRewNkuRAerKMzm2vTg=
X-Google-Smtp-Source: ABdhPJwIKDxPC96PkVg3vgpek6rrcJkG+VKEdqIg1FFHHf4+K1TPcqyv7FyM+65t0sLIKaMaxK5uTw==
X-Received: by 2002:aa7:91d2:0:b029:1ed:b10b:5a7 with SMTP id z18-20020aa791d20000b02901edb10b05a7mr3666547pfa.2.1615296068948;
        Tue, 09 Mar 2021 05:21:08 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:08 -0800 (PST)
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
Subject: [PATCH v9 11/33] counter: stm32-timer-cnt: Add const qualifier for functions_list array
Date:   Tue,  9 Mar 2021 22:19:24 +0900
Message-Id: <84fc37f8c32e8b9b52ca55e0ffeda67cd93e16f5.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
stm32_count_functions to match functions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 75bc401fdd18..0c18573a7837 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -50,7 +50,7 @@ enum stm32_count_function {
 	STM32_COUNT_ENCODER_MODE_3,
 };
 
-static enum counter_count_function stm32_count_functions[] = {
+static const enum counter_count_function stm32_count_functions[] = {
 	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
 	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-- 
2.30.1


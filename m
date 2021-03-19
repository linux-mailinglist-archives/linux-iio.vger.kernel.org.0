Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5F341AA9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCSLBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCSLBj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DC8C06174A;
        Fri, 19 Mar 2021 04:01:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r17so3427647pgi.0;
        Fri, 19 Mar 2021 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSocH1pEsSl5GXfkgGEmzp3nM7R7NfVZbOAEiTfnQJI=;
        b=kjOcLKbCFtzL3WRZ+TMUVvMnzsHKXNVNuCHl+oo/fV0dipngNeeNES1u/UHkJEUIml
         JyNwebt5WfgbhZmvTperffY9h84hMNYEP06UtCLJ9T1v0RpU1hRDzD+XI1A/BYGnt9Lc
         MfCI6WX5r71fnHUV4PPxjLoproqN6KLXMJn6aZ9Q1kAY7Ss74bngKQboFwr0VTX/GCYa
         ej+x9hIjxQpoIgyS+vVJ0zi9bVzHFRIVfnblEGgNGTHXc1k0T3UuFMdWkidJr06aYdjP
         blwfMp7eW9R6K6ZNgCiM2bjzxp+/YJg4JOvwt35Wd2S0MMCUewYFiHtnzhfBvPuM+iHQ
         ghqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSocH1pEsSl5GXfkgGEmzp3nM7R7NfVZbOAEiTfnQJI=;
        b=C0/7TEO9BgVEJa5Jr2/cYwPQBFbtY4fHR4LcemmC5Ow32FI1vnrW72rtkPT7BYS0Rf
         lSTbfv4xdqYB1qug5tA7ylvkKL2S/dNqR7mLhTrNU0hfyvMINNIDNY8UAvlm8rpyVuI3
         TXleXsTk03BXLV0kkKKyOLV74eFAHyeGmvdIla4Y8UU93YlmAfB7oeFe3g1ePs7PwTjo
         C3LIowH+RVGKsXE9rfbPPcbYH0R6l6fdl0ZNCglhuibPC0wRWLfrEJBGFH/5eqbUjjiW
         O1xRdyydZ69GFGnv6JZJZmrCA1jthDYnI/WAcXJLoWtb2H04g0mLT4Foo6m+81Pw1dSN
         KKtA==
X-Gm-Message-State: AOAM530KK2/R2kuQqneYIrJh4f2VONpSmQkrKo73ioYVDUxtJ/OcSLwZ
        jTuChbxyfv0HOva7DVoIfS8=
X-Google-Smtp-Source: ABdhPJzRoI1fHcE1ZAKUXQ3BHSbmbZz4CqkRJPGAcm7nkR1fgIQrZY50i8oPgAoFDMztWakz8atzYA==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr11288574pgd.385.1616151698789;
        Fri, 19 Mar 2021 04:01:38 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:38 -0700 (PDT)
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
Subject: [PATCH v10 07/33] counter: 104-quad-8: Add const qualifier for functions_list array
Date:   Fri, 19 Mar 2021 20:00:26 +0900
Message-Id: <c3d989972172945bbc616c973c1a759df5fa3d19.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
quad8_count_functions_list to match functions_list.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 51fba8cf9c2a..ae89ad7a91c6 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -193,7 +193,7 @@ enum quad8_count_function {
 	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
 };
 
-static enum counter_count_function quad8_count_functions_list[] = {
+static const enum counter_count_function quad8_count_functions_list[] = {
 	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
 	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
 	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-- 
2.30.2


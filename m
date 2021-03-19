Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95733341ABA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCSLCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSLBy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB0C06174A;
        Fri, 19 Mar 2021 04:01:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so2782147ply.6;
        Fri, 19 Mar 2021 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjJQUNTwsBa+RZPOzEy/Sih/eBggOo9hBH9OJm4YwV8=;
        b=MkepcUzFZogp8zB2PNJuWmigI/5LesD3IUw/sJfRQzB0wwWDPN2B68iLLpurdR1PlC
         23YaLOV5bj7v1kw1cMApbc0X/pyIXCcElFFarf+j4sPzHc+tx8zuBtOQ4c3qCWNC/5Lt
         05cFWeoLzkV2rUjlBaW2nYTAf8d+fM6eo8FoP+xYxMVnyAK2Q6jGAp830LeYJ2AYZkcc
         6I3dnDKWWuSMhU6UCtFZXrP/kCQkPZ6eXD5zOPjCO965p6fagAdyZ/YA3//Bd0A2TFml
         /j+OEFAA/OFVAl0JiwokRoDye5rzYz/Htk0+SZSycagbQXl0qapDLqtUgJSh7MIEyEu+
         PjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjJQUNTwsBa+RZPOzEy/Sih/eBggOo9hBH9OJm4YwV8=;
        b=C3ww7TWeNDw3Q1ulgnHNWL7RhBJiNiGGqRQszMYC7WOKakg+exHgds4bqSozIIVfvt
         4fFQ6+afttah2KhuxJmQw6lWhQ4ALl3apeWgaVs5kbU/IqepIvz8HjL3Wwvox//3buxu
         IXRphxyE2n+OuSW6TN/HFFCdMsKdb+U5ZLEarOzi7hXREABzxj2/c8XVWlgrnjRLsNWW
         3wmkni2WFMQ+lb3qp3Fq3GFKU7dJgw975jxnrptxDBO2MbEVcJWqn3mI2SP8lRPpR+6u
         50JsK2G3apVE751AeX5R4GaHOuAopNbwq03uxOzykK1QA1W60ZFS9Qzk0Vs4+eoZfiqP
         pioA==
X-Gm-Message-State: AOAM531yAzrgfH41FGWm6ffOXUJcnfqAwPK6mfAaq7Jpdr7e7a7YWyb1
        HBojt928rS8Y6zNYH3Kbk5h4UVq+3WdYvA==
X-Google-Smtp-Source: ABdhPJzh7KmTVF5c/eWnSvJBwidUGWNTKqwczSwnvsTNxu/q0mMuF7gvIYCDa+BqKEltXK4+qmPpMA==
X-Received: by 2002:a17:902:d4cd:b029:e5:dd6d:f9b3 with SMTP id o13-20020a170902d4cdb02900e5dd6df9b3mr13540874plg.43.1616151713477;
        Fri, 19 Mar 2021 04:01:53 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:53 -0700 (PDT)
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
Subject: [PATCH v10 10/33] counter: stm32-lptimer-cnt: Add const qualifier for functions_list array
Date:   Fri, 19 Mar 2021 20:00:29 +0900
Message-Id: <e5dc16652697919af7baed6a630c436359455131.1616150619.git.vilhelm.gray@gmail.com>
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
stm32_lptim_cnt_functions to match functions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 937439635d53..0f7d3f1ec1b6 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -134,7 +134,7 @@ enum stm32_lptim_cnt_function {
 	STM32_LPTIM_ENCODER_BOTH_EDGE,
 };
 
-static enum counter_count_function stm32_lptim_cnt_functions[] = {
+static const enum counter_count_function stm32_lptim_cnt_functions[] = {
 	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
-- 
2.30.2


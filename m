Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C243A0943
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhFIBfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:34 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:43590 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhFIBfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:30 -0400
Received: by mail-pl1-f181.google.com with SMTP id v12so11670264plo.10;
        Tue, 08 Jun 2021 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14DXo/gQwzalmPUmXYTocs4CME9s7GOS9p5R5YtgXZk=;
        b=TujjSmROvBrFm01zCy+diwD2kEaIeC/luEfVKI6a+7CAs3QqhClnQIiOCfvlDfovfI
         kguTKJXsGYYi6vfHmsLBFjANn84GA8qvOFXnlW5iDkJFT/ZvgKfc4RblfH+cHI8amlWn
         JvGJtraGSuUIispgYtbnJb0K+zp7ZpvSIe4QU+S51QARJnhXBMxXGg/gRgjM97Y7HbVl
         lXaoDnaRigz5WtWoWni7hJjWzWAZ+p+RmlE/IXLvT2arvaxJAilPo9aEYeEGETuFfy1x
         qJMxwClxz5zXmr2LnVIUdoLutEghVw6HGNk4ZAiAq/MtSIorcOmfMyzHxih/EdRdMdZn
         7Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14DXo/gQwzalmPUmXYTocs4CME9s7GOS9p5R5YtgXZk=;
        b=ZvXh7wgI+IJKu2d7tTDTjMRsZNSnJORD9D0JMEETmbIUG0Nzm7AO3oZCkG47FYtSrH
         58xX/S2RFF2XJoo+nhMJb//tPQfDYKJsECgbR2icou2DGNxytd5uNiKY1q4PJWU3LnvA
         QrZf4N+roee1EijcHD05/ic5wf3HK2qAM1+NeN1LziUm5s+W1RliGZADjtimZBRw3vWB
         u78IDavwt8XL/DCMpcN0MVtkHdR0M5zgN/Wy5rbW6iBBMhrDW/7w9P6QQHWeD6fK/xmL
         tlYgqhcwUEtjkqWuItmkrLLoqviXirIp9gAtMd5IxPog1knsEutu1KABY7rFxbS1vtgK
         CrgA==
X-Gm-Message-State: AOAM533DQdEw8Vq/YhNZa+azqXv3AHMZB70nwvVYyjrgGQ9wVzTvs8aD
        ygxFhlvOrQ6rY5BH+4ctLxE=
X-Google-Smtp-Source: ABdhPJzdTdPJRUr3bOq9BJfkgAU6+P4ZrboFuZvPrV9jwLOHXPdzTe0Wc1iBMzp5BFUXBHO5+zC0CQ==
X-Received: by 2002:a17:902:8a98:b029:f9:36dc:37cd with SMTP id p24-20020a1709028a98b02900f936dc37cdmr2904637plo.68.1623202344988;
        Tue, 08 Jun 2021 18:32:24 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:24 -0700 (PDT)
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
Subject: [PATCH v11 07/33] counter: 104-quad-8: Add const qualifier for functions_list array
Date:   Wed,  9 Jun 2021 10:31:10 +0900
Message-Id: <6847da7553208e7f2554e6c7688e2021f7e19716.1623201081.git.vilhelm.gray@gmail.com>
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
quad8_count_functions_list to match functions_list.

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
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
2.32.0


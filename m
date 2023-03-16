Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A226BDA41
	for <lists+linux-iio@lfdr.de>; Thu, 16 Mar 2023 21:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCPUfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Mar 2023 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCPUfp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2023 16:35:45 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17BA25E
        for <linux-iio@vger.kernel.org>; Thu, 16 Mar 2023 13:35:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id i24so3239680qtm.6
        for <linux-iio@vger.kernel.org>; Thu, 16 Mar 2023 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678998942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IE1250/2US2zV8QQj0KyqCMX+KmBvfqMdwAVgwdELME=;
        b=w5rRW2KOpCnN3DdPwoZpKeaGFHs1CM/vq8nxhnvmwS1h16TgYlkXJV85nAeDcHFH7r
         Bm/dHEjQP/bEy3SwRB1XF352kH/m39dDWl0/qiEIgS5iydEwIWwIvvna215W7Jwbeq26
         FwJoijNRoc49HljO+F0xQY3LbgkrNWpA346niAY1WTk9fWksuVvwBxP+yZ0NVKLvFpdV
         dhyAjJINXHvakwMBT/ezi52MA+PbasxZ97Cx1HAaiEM/4RmZRac51euWXXhWTAPaxS2O
         TVCAuBGsj9OQZhVQv+jsa+ICbrwJ4PA/M16C/F+gPx/w8DUE1swbjTUhOl23TnG3Kjyc
         tJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE1250/2US2zV8QQj0KyqCMX+KmBvfqMdwAVgwdELME=;
        b=F1nhXUara9sQIMGkvl4pvFtinjvNydKUM9h/GrQpd16fmJ9oEp1jXD0QSaUz9Z8ZX3
         UPAtx5es9drNUNr4+9t8EOkxNF5tKviiBHuV5fW1FAUxFOwFDRxJ5iVTu1o6BhBIKpAw
         wl1atd4fkJU0cNngeVzGUkzocJM63/nTXBTqupBW5SrnNpcevSjfkMTfTQTgoNpM3NHI
         t2ZjnlAgp/SEUGuPWEPX4QnmDWR+ZxkrvnVjR4iKAmpqih7zQ/5AOqy6Ye1+qXwFSP0n
         jyZ47/vUqsl+uSvNWgHkL4G7DG/rpH0LtNuyUIBgxuRePwkFoHBKwdkUvDUyN1lSAzJX
         F2cA==
X-Gm-Message-State: AO0yUKWeHNaIaMKL7XHg41n28ynY9wkhes6f9jGJt6EaC8UoIPoCzIKF
        sI6MpMlsrApqrJrRhM+K6CcukJXl/YYEoZSUttg=
X-Google-Smtp-Source: AK7set8jf9tMnvGewKasTIgyUjXUE5MzpvB47G/1uVe5ibMLbIXNssLJe4lqLxR4ykEX/TL4Fy6XHw==
X-Received: by 2002:ac8:5c01:0:b0:3c0:3dc3:aa5b with SMTP id i1-20020ac85c01000000b003c03dc3aa5bmr8132949qti.4.1678998942273;
        Thu, 16 Mar 2023 13:35:42 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 68-20020a370747000000b007426e664cdcsm205306qkh.133.2023.03.16.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:35:21 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] counter: 104-quad-8: Fix Synapse action reported for Index signals
Date:   Thu, 16 Mar 2023 16:34:26 -0400
Message-Id: <20230316203426.224745-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signal 16 and higher represent the device's Index lines. The
priv->preset_enable array holds the device configuration for these Index
lines. The preset_enable configuration is active low on the device, so
invert the conditional check in quad8_action_read() to properly handle
the logical state of preset_enable.

Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
Cc: <stable@vger.kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index deed4afadb29..529bce4ee631 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -378,7 +378,7 @@ static int quad8_action_read(struct counter_device *counter,
 
 	/* Handle Index signals */
 	if (synapse->signal->id >= 16) {
-		if (priv->preset_enable[count->id])
+		if (!priv->preset_enable[count->id])
 			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 		else
 			*action = COUNTER_SYNAPSE_ACTION_NONE;

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2


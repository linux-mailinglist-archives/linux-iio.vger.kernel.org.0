Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A158743739
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjF3Ibh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjF3Ibe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 04:31:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B651FE3
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 01:31:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635f48814b4so10078146d6.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688113892; x=1690705892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJtRVTrBXHzy1SAWRtn4ErvKw0dJAPtFGr8YFV61VM0=;
        b=Mwg5wcWZqfPJ9jLPYPvXyjxdyXMwEWm00Q8tZvEGl4TmpkIp85Jh1aDf0T975wVtrl
         n14yEk1vswKw8QbaTorG58E+wcU6JvpXrexZ+hpMVHv3Bz7zmQ2DJmbjKThqI5bdizxl
         wObcuaYRB3g9zjU2t1TTqx+dbezvZmHVUfzoc9R2YLIDnq+dToMaocVUl33sGqYV5SLB
         Z6u8Og0ostgnY+Ho6jxgzUOLWTxOw2BTIZMYSbiIYkzE+RfGtNPf/1n2tpsBIpOqaF7O
         2h/joWIT5rXW6/TQ5guZ8TuTEl7GsW+M+fwYPH4oSW2OkpKm5SDVzRK+K7zanwJNFn4M
         Eo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113892; x=1690705892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJtRVTrBXHzy1SAWRtn4ErvKw0dJAPtFGr8YFV61VM0=;
        b=dr1Ufa9L7eiCSjOeepOfqFPblcth2gpT4ql3i1f6G27XtqnZQVHVU12NhhSF2Lb9Wh
         4nBx4ubENjDGYlT1qTklZ7yCrpDTGvZZ7zTXEG+OcXA8Y3OK6so4Lc+ghE0CHNRegQ7i
         M/JkxQw6cjVz/bntUedBpEiPa9XOLEy9DBcPQ1bWDbAAR5wkR4bcsd8gtvyOEa2MDcCd
         KsbpRcDj5W0/ab67wW1PsNo8niEdRzrYreAnAMmUhiCwqXeQo2SiVZswQVCMm53i0Xg4
         G0dx3O0payKcCRAb9c7UJcwUWI3L+RBM8pa8nJkRwMrLA9ChGzTUR5c9hvjoN2pOKmVr
         v0jQ==
X-Gm-Message-State: ABy/qLbbY6EzeIBe1MUc/sjIC9Tq0yo5Xh60Tbfti7f1vUDzEYa+vV9C
        h/PWc/MIbwh0cb4qKKP/j2A=
X-Google-Smtp-Source: APBJJlE9Fi+oiwjKrHm4+GLJT1H7D5HMQLdwOGJjYgx1gXutxBbvOrgmmvUkYCM6uysI5UIG58/Lpg==
X-Received: by 2002:ad4:5f4e:0:b0:635:da2a:4706 with SMTP id p14-20020ad45f4e000000b00635da2a4706mr2698383qvg.15.1688113892241;
        Fri, 30 Jun 2023 01:31:32 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id jy19-20020a0562142b5300b00635e9db359bsm4765587qvb.82.2023.06.30.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:31:31 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     tzungbi@kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@chromium.org, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
        yguoaz@gmail.com
Subject: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
Date:   Fri, 30 Jun 2023 16:31:12 +0800
Message-Id: <20230630083112.2344234-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZJ6F4THLoYy6S8HP@google.com>
References: <ZJ6F4THLoYy6S8HP@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct cros_ec_command contains several integer fields and a
trailing array. An allocation size neglecting the integer fields can
lead to buffer overrun.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
---
v2->v3: 
 * Added R-b tag from Tzung-Bi Shih
 * Aligned the code by adding an extra tab before "max"
 * Added a patch changelog
v1->v2: Prefixed the commit title with "iio: cros_ec:"

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 943e9e14d1e9..b72d39fc2434 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -253,7 +253,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
+	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
 				max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)
-- 
2.25.1


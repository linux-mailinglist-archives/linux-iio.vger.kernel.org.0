Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401D743512
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF3GcZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjF3GcH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 02:32:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79F199E
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2023 23:32:06 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401e0ceb4e6so12648991cf.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2023 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688106725; x=1690698725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMqc59JLjfsmDQrIpQpsMtV1yNjY1VclkrG5Cc3ePcs=;
        b=KPFrrw3MO4GX/bJHUB4qB5OA41otQVjAGbZvBvc3a2/xRNUu4i3WZ/3Mjcu8SHEWxa
         PsIkvNu6G2JPEcDonDFHgc0sFKoGC+NOEAYVjoRJJkn3j1ug/pFhAHZdliYMbAJ8nZEP
         Jl3Ec0ruWH3jB3o9eSI5998MiE1YGu/2Qn7ci0kExFaCAazJr629hMqnVVosTwm7p8K3
         e0JQtUZPl3d/8hXb1QEmVSQ2akAzdlYj7osdfrIUARVGPwiI8AOY/9ZAFjdrzPnsLhBn
         odlXkRhadJ5UpafhIz6dLqw6vga4JfkaahgSWFOjiNWHqWWGcSvCVq+43Tyo7lOFabmz
         GJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106725; x=1690698725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMqc59JLjfsmDQrIpQpsMtV1yNjY1VclkrG5Cc3ePcs=;
        b=IVm7ulKyUSy3hPy7Kyt1ZuHsTChNtCpq9xrLpntXHzRZYOEag2CNF+XeWD/sjYaTIy
         2V5l5u3Xs9XXWS+Ey1f4fAq2UdqJwBovu5cboBXtOog03XYdysEIAE0RduuqFvBjOrDH
         K0TVbDiDjMZf++s8G6mkLY3ATImTiP4GeiCemkXb6Jw+zNX9fwG2Hg6srQ6pHF+xLJzI
         EgfUQUj39OTiOKcdwVrsMl48QCVdAFaiQS2hhMf83VaNpwk4rPFTgQK1wEzOoojkUOtW
         w64jB7lCxVmvBd/5jdtRp0C7V0v/t6zT/LDyIVVmNvclQzid0k0v2oqejJ1SXVqyNNLR
         eoxw==
X-Gm-Message-State: ABy/qLYbnqAM8YFsAW6EfWtRAe4Xrn7aUKygZbkoFlPD0UfjBp196NBG
        8NJ5ZfUYhPaaBkx4qRkWTlA=
X-Google-Smtp-Source: APBJJlEk3/ngJX1N5MvlA6E+V5P2WsRTbwcrawrVMV7XdSehniPRa6Qcf4Gq9H7kAqmg/F+br49bhA==
X-Received: by 2002:a05:6214:21ab:b0:635:da2a:4712 with SMTP id t11-20020a05621421ab00b00635da2a4712mr1857880qvc.40.1688106725503;
        Thu, 29 Jun 2023 23:32:05 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id u18-20020a0cf892000000b0063660329d57sm175276qvn.67.2023.06.29.23.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 23:32:05 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     tzungbi@kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@chromium.org, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
        yguoaz@gmail.com
Subject: [PATCH v2] iio: cros_ec: Fix the allocation size for cros_ec_command
Date:   Fri, 30 Jun 2023 14:31:32 +0800
Message-Id: <20230630063132.314700-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629132405.1237292-1-yguoaz@gmail.com>
References: <20230629132405.1237292-1-yguoaz@gmail.com>
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

Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 943e9e14d1e9..e4c01f1072bd 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -253,8 +253,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
-				max((u16)sizeof(struct ec_params_motion_sense),
+	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
+			max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)
 		return -ENOMEM;
-- 
2.25.1


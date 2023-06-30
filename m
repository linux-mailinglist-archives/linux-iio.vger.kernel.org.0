Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C938743DA3
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3Oia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjF3Oi2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 10:38:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4635A6
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:38:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-400a9d4b474so15050211cf.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688135907; x=1690727907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJtRVTrBXHzy1SAWRtn4ErvKw0dJAPtFGr8YFV61VM0=;
        b=qo3c6gQ1aurXfcty4ClitGHXhU+jPlmGo49d+CkjKkjvIi1LJbt+s9zkIT6KBeb6VS
         htw7qWxVw/SmPP8H4T/3TxIChnmbiPs98uaK6xU8AeBsMI96ZZdL49ugCuz7UutZOLY5
         wCNL+MNIT1e6RFeRlUXUaombnzbBlK7YGspY03gw+ZiCWOUkfJEFRWJKcpDRzKkZUoev
         0XjGTySAb2db0Uvh+dlktnozINVfhguYTrMB/rqGrzLf+7/AMRdk51lRHTYFhDz77OSe
         4LDrBmpluWDKanHDbBcWXtOpMCv8bnyiTrc8zzpkLMd5NvfYLkXUaEpmzGvK2S+0C/fx
         y0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688135907; x=1690727907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJtRVTrBXHzy1SAWRtn4ErvKw0dJAPtFGr8YFV61VM0=;
        b=huxcao/+qVsiwqndVsZFk9T8FgwovXniIkmXDfSgrjngsKwQ0NE31cin0NIZzxuuHV
         ZkE5trZNRSUZ4oPFQg1VF70MRdFeB66NtKPujd7Ec+uOMNyZFiGdColVYD3YhBwVnJ+O
         hefGddKPo6dSyqW1p6ufcBTkY6dgIpHd0yIIAkAfzjWxT8sYKDYyhH8gkDvEEC5BFQcB
         GkbbdSdd3PDmlFLLAg8x8S2trcwhsp7hV0DBCUGrcNu8BXH80a+9qxYTszx/H2OVPcWz
         KMn5BSAHWCZCpfA+wN1gvgg2svjVu5vKn2jVtC0xt5NLbxz79kDC7bR+vG8KSs/w+oSw
         1sAg==
X-Gm-Message-State: ABy/qLbyYHl39/bbZ7LYxSPBLA94o476mp2raD6lKxAM3KOJlDmLuAb7
        cqwoP8AikeTfpBQYJJ+YDprhQDpIefMSaA==
X-Google-Smtp-Source: APBJJlGl49NkX3puvlSHJbA3MwbpD7GXW1Ez14RmX3plv1Gv8oo9e3Lj4B7DSVGpda0ARFzY9/VOtg==
X-Received: by 2002:ad4:5966:0:b0:623:9ac1:a4be with SMTP id eq6-20020ad45966000000b006239ac1a4bemr3302573qvb.12.1688135906782;
        Fri, 30 Jun 2023 07:38:26 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id g10-20020ad4510a000000b0063623c266easm1832100qvp.3.2023.06.30.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:38:26 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     tzungbi@kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@google.com, dianders@chromium.org, mazziesaccount@gmail.com,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev, yguoaz@gmail.com
Subject: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
Date:   Fri, 30 Jun 2023 22:37:19 +0800
Message-Id: <20230630143719.1513906-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
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


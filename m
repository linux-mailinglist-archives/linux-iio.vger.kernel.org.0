Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAC742750
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jun 2023 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjF2NZ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jun 2023 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF2NZ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jun 2023 09:25:27 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654530DF
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2023 06:25:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635ed0114ecso5319646d6.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2023 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688045125; x=1690637125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hMqc59JLjfsmDQrIpQpsMtV1yNjY1VclkrG5Cc3ePcs=;
        b=YECbENiP1T1aRxkh7wMBIccAQs5xbJmnOtTGez2fjWzkY8z60Ng4fIrbin8eKfY2Qh
         NjqmdyJxhQfsgv3LkmbTCPj5eSMP9ppEseASW2eiiXI8fd/uL1kNjEsrvrbdGSmX8B24
         hWaDPdohAvJOW43sY0zlkwbOjCcAPlKArRyIzXCeUT4Yzu8pwpou1tywG+ypkh0a1XJx
         A5XnW9YXQuAjqZ/PwBoWeLZrPYQi+o7ffjT8uUmV8Ey+QDXFHU2eU1aEQIqSspi5GxD5
         iUZTb/lM9fIiwxKKitjWlRtd9v6mCDJW2cbRL3Sz8fEmT+FEjf6WaIRFjh6FR0EyB91D
         Aqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688045125; x=1690637125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMqc59JLjfsmDQrIpQpsMtV1yNjY1VclkrG5Cc3ePcs=;
        b=OfRgqjNtINgvhKml2nWZdXXkfE1tzG5Btc/HkZDtNz7LfsEv/Tt+n+wezW2gQNicCm
         pJy6rIZHnR9ToHZPCP8NYzmqYXyP+UdsIXHPe6Oxh1+izx9iNxKGZHAt50ocLe9bhFwB
         EOcJ+RGs/6RRkCdub+p+ngzBogceJ8OwBdPpfN3MmgPXcqZLAGufuwXnjicRomOcdWEl
         G0EsGN3V+qGREM8rgICSQDj99ix75eKzCEXCDiLDgfXKZZsbSXIdOQ7ghOHv2ztnY6Ih
         5kjZE78YDpkBNZeWwymmJ6aJfVUY3M9wyPQ4ZJxldBvhAZWoE/SMO7TQbcv3y4Ms5EIH
         ezQA==
X-Gm-Message-State: ABy/qLZIQQb2iaje6zz8hk3SOw24TKTCJk+4Xhsf8FCqYPL21gJ2IPgD
        lMR0/WrweuqEXXsasuiq5kY=
X-Google-Smtp-Source: APBJJlEKDJ/EBwBtGazRkXSXvIakwn2FfvV9Cd4dnKnKnIggg+6sAwFydC8nw3NE3Swc/kOq+zajtw==
X-Received: by 2002:a0c:ea50:0:b0:626:3a5a:f8f8 with SMTP id u16-20020a0cea50000000b006263a5af8f8mr376728qvp.58.1688045125146;
        Thu, 29 Jun 2023 06:25:25 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id ej8-20020ad45a48000000b0062119a7a7a3sm7061271qvb.4.2023.06.29.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:25:24 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@chromium.org
Cc:     dianders@chromium.org, mazziesaccount@gmail.com,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev, yguoaz@gmail.com
Subject: [PATCH] iio: Fix the allocation size for cros_ec_command
Date:   Thu, 29 Jun 2023 21:24:05 +0800
Message-Id: <20230629132405.1237292-1-yguoaz@gmail.com>
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC89861DF2E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Nov 2022 23:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKEWwH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Nov 2022 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKEWwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2022 18:52:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5503EE21
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 15:52:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 130so7504787pfu.8
        for <linux-iio@vger.kernel.org>; Sat, 05 Nov 2022 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMy/PTptvW7Ce3EPf5t7gDuBXUnwvaP51kbDF9GjDz4=;
        b=LN0dzFu9UrdEXAeNl3FZmiAp71DdyoS9LfFO42VtexmYkOMw80gKcP5dHNrHCaMiro
         TsH/XgpUPDm07Bqp+lheaoTFxtEa2FbFMaZuZT5MRXw8yx3KIrXVPOCBHF1xFhlvWEM2
         tLZHHKgFFR5FLLwsfoP7v8oycZ0bsbfMpFe4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMy/PTptvW7Ce3EPf5t7gDuBXUnwvaP51kbDF9GjDz4=;
        b=Edlut4g6WVTdFAjWWu6K9rlSfi41w99KLv0Y2YKMeDoERyYh01zDp+lJxJAgwOJoNJ
         bJ0ON9Z6k73t51OfheS2EGLaO6RW6c3YLoL6+vkiSJtI72wNMiE+aDC3unuNe21glhvd
         hzPrbUy8KcjKlnBUCm18b4TrVvAKEg/PyCD9UJnLsEMy0wjsYWklXDBBUUyKUOmW3jiX
         Hj/+ai3x2mvGHTVlowq3flhSg0BRiF85RESEcRjctx1YGpYi1j+tMBejzvz8xTX7a/5X
         q8iTb2yNMCWrbLADiKYG9b4ZDXY9CZe/c5lBVi0eAAaEPthiYIT6pwITlVWi1f/1bl4T
         lPGg==
X-Gm-Message-State: ACrzQf3EPxgUC+KvP1r+YSbo1U8sgWGSf04ryMwjoUTmHXYQUSN2R/ri
        78iI5o1vq1kJjDCJeawsC4AaqL4PHhlmnQ==
X-Google-Smtp-Source: AMsMyM7aDcQeRZoE4WxJIwe2eJarzUaAJQxEJZRPNp2Kr0MtVsHCB0pICvtqpizJGGh+F3M6DY7JkQ==
X-Received: by 2002:a65:55c4:0:b0:46f:f932:fd39 with SMTP id k4-20020a6555c4000000b0046ff932fd39mr20856265pgs.251.1667688725236;
        Sat, 05 Nov 2022 15:52:05 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:cda0:c532:e575:4fc1])
        by smtp.gmail.com with UTF8SMTPSA id i2-20020a170902c94200b001869394a372sm2142540pla.201.2022.11.05.15.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 15:52:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Jordi Torres <majosamaso@gmail.com>
Subject: [PATCH] iio: proximity: sx9360: Add a new ACPI hardware ID
Date:   Sat,  5 Nov 2022 15:51:57 -0700
Message-Id: <20221105225157.10081-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From
https://treexy.com/products/driver-fusion/database/sensors/semtech/sx9360-proximity/

sx9360 SAR sensor can be presented with ACPI ID SAMM0208.

Reported-by: Jordi Torres <majosamaso@gmail.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9360.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index d9a12e6be6ca6..4ebc5784aa6d9 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -865,6 +865,7 @@ static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
 
 static const struct acpi_device_id sx9360_acpi_match[] = {
 	{ "STH9360", SX9360_WHOAMI_VALUE },
+	{ "SAMM0208", SX9360_WHOAMI_VALUE },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9360_acpi_match);
-- 
2.38.1.431.g37b22c650d-goog


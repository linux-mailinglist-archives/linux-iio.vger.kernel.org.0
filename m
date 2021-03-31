Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCD350639
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhCaSWv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbhCaSW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Mar 2021 14:22:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4906C06174A
        for <linux-iio@vger.kernel.org>; Wed, 31 Mar 2021 11:22:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w8so9938446pjf.4
        for <linux-iio@vger.kernel.org>; Wed, 31 Mar 2021 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fG3M9tA0KoHwDLLm38rn/CCdGLZ4zzjS0UaZN9gjYs=;
        b=CXzu91MfNaKV/RkPW5JWqeToS32DZALRnPfsqYUQqEEb7vDFKohysIrfFw22LpT53X
         LE/rBeI1jpRLL/VCekdNewN0AnCCgMYwu+RL9q9mBHDn33dKqp/ft2SU0LCvm3ZaMIkR
         U4jUPJK3yQPbnS+bNpwCCfju0YI0qFub5SpEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fG3M9tA0KoHwDLLm38rn/CCdGLZ4zzjS0UaZN9gjYs=;
        b=ORL7Uhd2OPN+dDTy5O5va24keNdR44FMqGVkBKxL61y11vTxUf9aXu+hXvWhvrSvZn
         nlJKtHABeF0etQjveDuaF+dZmYd7DjdUqqpXEDhdhWgkBAUC6zTRA0vRO2lTzWAc+KXc
         Yy8noqVDlhATlgDM0nlFWBE+kueAAaVP2Op42rFpos1znl4yugiBBMztgYM6tDYvXupP
         O3xLMgweKJQKjmFlM7jnzsCTOcEk1ZPXxIZ+UMdXpWSAgeqwKdftCOX4HqKfNuxExHS7
         vAuBQksdRKgEdSD/zfpaipMfw3f8+osDxugEyzS8wqm/I/KHCdIBrlB3/xNsGZVo0DSC
         5XyQ==
X-Gm-Message-State: AOAM5325A5KZ/aVC1TtsWxqeVdcGkl2cl1VDrYCNoWvGXWxl4SZA6KVM
        rryMAyP8YIudLo+X+dGBqbaP/Q==
X-Google-Smtp-Source: ABdhPJyQ6IwDLoJEcFdxS/PdQYeV96UpU/r9hnWhj9bMCMezNLMSmLBtAcCfVnQX2pOMV9NOSJtdyg==
X-Received: by 2002:a17:902:6541:b029:e6:27a4:80fb with SMTP id d1-20020a1709026541b02900e627a480fbmr4272304pln.15.1617214948164;
        Wed, 31 Mar 2021 11:22:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9840:2987:57cd:7dfe])
        by smtp.gmail.com with UTF8SMTPSA id j21sm2634142pfc.114.2021.03.31.11.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 11:22:27 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        stable@vger.kernel.org
Subject: [PATCH] iio: sx9310: Fix write_.._debounce()
Date:   Wed, 31 Mar 2021 11:22:22 -0700
Message-Id: <20210331182222.219533-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check input to be sure it matches Semtech sx9310 specification and
can fit into debounce register.
Compare argument writen to thresh_.._period with read from same
sysfs attribute:

Before:                   Afer:
write   |  read           write   |  read
-1      |     8           -1 fails: -EINVAL
0       |     8           0       |     0
1       |     0           1       |     0
2..15   |  2^log2(N)      2..15   |  2^log2(N)
16      |     0           >= 16 fails: -EINVAL

Fixes: 1b6872015f0b ("iio: sx9310: Support setting debounce values")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Cc: stable@vger.kernel.org
---
 drivers/iio/proximity/sx9310.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 578d8841c5398..e5a756f4afa2b 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -764,7 +764,11 @@ static int sx9310_write_far_debounce(struct sx9310_data *data, int val)
 	int ret;
 	unsigned int regval;
 
-	val = ilog2(val);
+	if (val > 0)
+		val = ilog2(val);
+	if (!FIELD_FIT(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, val))
+		return -EINVAL;
+
 	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, val);
 
 	mutex_lock(&data->mutex);
@@ -781,7 +785,11 @@ static int sx9310_write_close_debounce(struct sx9310_data *data, int val)
 	int ret;
 	unsigned int regval;
 
-	val = ilog2(val);
+	if (val > 0)
+		val = ilog2(val);
+	if (!FIELD_FIT(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, val))
+		return -EINVAL;
+
 	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, val);
 
 	mutex_lock(&data->mutex);
-- 
2.31.0.291.g576ba9dcdaf-goog


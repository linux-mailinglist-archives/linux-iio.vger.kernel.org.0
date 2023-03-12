Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7236B6835
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCLQX2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCLQXZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 12:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC201D91B
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678638060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q4/iPsVRBPkg6AepawVnMg1wwRgKOLDi6FjhOobj1H0=;
        b=fenYV8AbC4PvBf2tf8BqYAUphAwh7yu85DxG/L6J7xTsVAxoA118l+1U77TQ3yIS+j/ztu
        w3zEcoWx28PGRW2GOrGmxvaS5jVhdStKZdhwN67p9QbNEhr4AXMSxJzNd0obCuWRQ50bw2
        HzJhuxHNayI4ayG2GpBgVA8yRquuSzg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Sy8gUGY6NdOLWKuSTt90uA-1; Sun, 12 Mar 2023 12:17:47 -0400
X-MC-Unique: Sy8gUGY6NdOLWKuSTt90uA-1
Received: by mail-qt1-f198.google.com with SMTP id g13-20020ac8124d000000b003bfba5d76a3so5680358qtj.15
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 09:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678637866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4/iPsVRBPkg6AepawVnMg1wwRgKOLDi6FjhOobj1H0=;
        b=T2OzJ01FPvylgAeQrjvItOz2bIsIAgH9XLsHsdj01C3h8B2FgMxaz2YFOEctGwCnvr
         O5bEIzDzSkRIMaSprS4VozhcNCDvJSSz5RJBS5mH+LUCoy5hYEGtBFG4pOjUJKuloBn8
         uW8EKS5WC8O2Q2dIThf1OMqRxTNOORVeCro6VQNtag/BKLdngFji26UZdqbxEmkFLM70
         yC2nDWtVYXQqo5iuHV8ZDnlNXfbjb5azkgpb5NwNP3bwxnSTaJAAKM/UPUaE9XMIWSRF
         ie+KxGKR1tUOFhSn0+jbdK6P933WmJJ1c1GUX2S3+NA3j7jaOXkis3vG5pEEkWTboBy1
         szsQ==
X-Gm-Message-State: AO0yUKUBbVXd3hG7pWyxsX7IVEulrzqfTLLC8meWjYTrETgG8lnRNG+1
        FwruiYHmMgVED/A3ixgzDmLjIbqxDYMUfpvmZ3/twSshMs+oouQrXjg0KFoYXNwNHjGviG6yBqK
        MhG+u6J6SUlio92Yno0If
X-Received: by 2002:a05:622a:1811:b0:3bf:b70c:cb02 with SMTP id t17-20020a05622a181100b003bfb70ccb02mr56462028qtc.61.1678637866662;
        Sun, 12 Mar 2023 09:17:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set/zwEcGLiorbWwvzcLRN7QE8tQwzoIcsH7hK+o/zR3XjwOjx605byBFLnz8cxnvcIf7BNPJ8w==
X-Received: by 2002:a05:622a:1811:b0:3bf:b70c:cb02 with SMTP id t17-20020a05622a181100b003bfb70ccb02mr56462004qtc.61.1678637866429;
        Sun, 12 Mar 2023 09:17:46 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g1-20020ac84801000000b003b7e8c04d2esm3815120qtq.64.2023.03.12.09.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 09:17:46 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com, andy.shevchenko@gmail.com,
        yannick.brosseau@gmail.com, nuno.sa@analog.com
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: adc: stm32-adc: set some stm32-adc.c variables storage-class-specifier to static
Date:   Sun, 12 Mar 2023 12:17:33 -0400
Message-Id: <20230312161733.470617-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

smatch reports several warnings
drivers/iio/adc/stm32-adc.c:2591:20: warning:
  symbol 'stm32_adc_min_ts_h7' was not declared. Should it be static?
drivers/iio/adc/stm32-adc.c:2610:20: warning:
  symbol 'stm32_adc_min_ts_mp1' was not declared. Should it be static?
drivers/iio/adc/stm32-adc.c:2630:20: warning:
  symbol 'stm32_adc_min_ts_mp13' was not declared. Should it be static?

These variables are only used in stm32-adc.c, so they should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/stm32-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 45d4e79f8e55..1aadb2ad2cab 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2588,7 +2588,7 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.irq_clear = stm32f4_adc_irq_clear,
 };
 
-const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
+static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32h7_adc_cfg = {
@@ -2607,7 +2607,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.ts_int_ch = stm32_adc_min_ts_h7,
 };
 
-const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
+static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
@@ -2627,7 +2627,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.ts_int_ch = stm32_adc_min_ts_mp1,
 };
 
-const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
+static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
-- 
2.27.0


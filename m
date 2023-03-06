Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E06AB5C0
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 05:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCFEsZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Mar 2023 23:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCFEsY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2023 23:48:24 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093483DB
        for <linux-iio@vger.kernel.org>; Sun,  5 Mar 2023 20:48:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s17so4765753pgv.4
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2023 20:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw1hBC9A/T7c7/6d29lQBMKDggNhBUc0s3wWoSHxwag=;
        b=0RRJTh1gw5TSMZxTJLsBLxRCc3WZaciWFXRunYIzdp6UPfb0c1cDSwWdftQP8WtiGG
         noREEZweu5+4eSsKDTLAaoa0x3Hx5suDR3z7kL5kLoiFB8RyswEMlA7LXkmC3axY7gdJ
         GO1mmDkzQhBkzL9BpTIxCLrBBPdNSeM2BkPdSMqowgVAp+NfCzTa5ynU+vchFLFedmrp
         Z5nfdDkgUgUxQk3z9LfquPuNaB65T+VeVo9LQLe5sg/8KNRfmQLKDCoDNcLzlCLF7qAN
         Ot4KCElN/1pz3Aj1N7Ftad2kJN9xRUgoBKYuw0I1MP7hEBiOcAsivJCLs02An8cfPP6b
         +5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sw1hBC9A/T7c7/6d29lQBMKDggNhBUc0s3wWoSHxwag=;
        b=QQo+zbTHqonBIteDmMhkuhHS2GcZdCMreSqIBmEMctbknM4I4gZ1aEOkCkVOjbTTu/
         98vBCx50MoOZin0ga65jH7OZXPpUHh2uv2nrjmk8hrRj0RwwXAzQArMEIzYdpFb5wS+M
         Z0kgpfQRIBl1RBHZRJVr75QlkV2BBnDKlx16dp66G1UPz8XAcPjD4pMWR6DdwpGRfOLg
         74G8HVNGbHgIML1+msMXdgeM/otGWMvSJs/F2FDlwlsAK20KZrrMyNUrr7iDWkxdJcNL
         2S6nJP8wx09bNl6RNhOHZ+cZXoVHEPheQc9Qu6R2Yf8u/6lWEfKdCuh/KtA0n/MnGoSw
         UUsQ==
X-Gm-Message-State: AO0yUKUcMqIJzzpZbju4tL6003bRLJVIhYCx4ODOvF+uyxVjGl93yJbl
        M8pJdeSKnpi5NmhO2Wa5ei833H7P2uGQFUkaQ3U=
X-Google-Smtp-Source: AK7set8FOzS5wy746xZoFwpLWq3BLunrGC7FI3jFRV9tMJ3lqi2hzeXqmi1VNH6sIghehZVfFyENBw==
X-Received: by 2002:a05:6a00:2d28:b0:5a8:4ae7:25d5 with SMTP id fa40-20020a056a002d2800b005a84ae725d5mr15343961pfb.8.1678078101072;
        Sun, 05 Mar 2023 20:48:21 -0800 (PST)
Received: from localhost ([2400:4152:be0:9900:9c88:7abb:2dbd:9df7])
        by smtp.gmail.com with UTF8SMTPSA id h16-20020aa786d0000000b005921c46cbadsm5442052pfo.99.2023.03.05.20.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 20:48:20 -0800 (PST)
From:   Masahiro Honda <honda@mechatrax.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Honda <honda@mechatrax.com>
Subject: [PATCH] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Date:   Mon,  6 Mar 2023 13:47:37 +0900
Message-Id: <20230306044737.862-1-honda@mechatrax.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC using ad7793.ko, such as AD7794, may read incorrect data.
Extra interrupt is pending if the data on DOUT contains a falling edge.
Therefore, wait_for_completion_timeout returns immediately.
This patch fixes the issue by setting IRQ_DISABLE_UNLAZY flag.

Signed-off-by: Masahiro Honda <honda@mechatrax.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f620..364051809 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -584,6 +584,7 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-- 
2.34.1


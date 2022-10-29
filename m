Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12D76121D1
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ2JaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ2JaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2E158169;
        Sat, 29 Oct 2022 02:30:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp11so9412882wrb.9;
        Sat, 29 Oct 2022 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpsqUmkgwpxZ/VajIIb/0zX7NJyKUT5sNbfK2Me1e70=;
        b=gBhyZYf4MEHBZbUCcbcAX5qPx+1ALqys/p/WikBYGuqVwCiNBh6Ha62Ayyp1kxFCGR
         V/IxcDIeHGJ8yp63Pg+4yqKNbDXx+kE0dgBCt/YreCij3Txpev9iCsFRfODtNjkZOuCZ
         /0oTrZK8GSVo/AT2FXKaghyXQDQB9bVgYlp0+bj4tYvdiY6Ygeh8U9DD7St4xDsAnWBe
         22eI8v5lPk5zqF8ahcbM9YrXPUy6WSAddalWf1ZYMM7D8fXmTBfoMYD7rycQgElG8Xag
         HCYka6q5MOdA5sp30IJ29sx0iXCrTUJpM3tpNCJlxd8F05SX+RQu/DrKqZRTRI72kQiO
         jrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpsqUmkgwpxZ/VajIIb/0zX7NJyKUT5sNbfK2Me1e70=;
        b=3JYm3pX/yGe1Z627A8vYs7uInGaNUXCTHlPeCqlKvA/J4s6fqA9VCdMkhpM+uD75HP
         gbqYgW1ebLInSYdnWJfPmAonC/eDhe/xeugZGPPN2HNPiWtCZyAbtTfnxu8ESVMl3NX9
         LRvxVI25Fhn5gxoDOgSVuE/JILb6tP3WRf5xRo/MVsrDSBt5LzbpZBtj2zz7LrCU4PCK
         EfmpZwkgUIGJ6fERhTxSkZvhDN0qduK2VyEbHqc5JJX7Zb40SN25Rc/Y58xnQKaehMz8
         Q7xN88bh2YVIdktItx+s7qAxpDfmlfzl+8vEEPwZMM6d5tJg6ys4FBsZNpaooPesX+Y6
         IsKA==
X-Gm-Message-State: ACrzQf2zhkoMgzEvs44Vqo0bsdthshDYk2i8cLqcZ5AsRyMugYd0ylGo
        0Afn77bcx1Mpc+9WgnMN+So=
X-Google-Smtp-Source: AMsMyM5U4VXpUFXYQ7mnJB0yZC0RjNlWxY0OoI4rSzqmTtGHDrVYf17r5Jr8rrZq6DM4X0fCkjEsYg==
X-Received: by 2002:a5d:6d89:0:b0:236:7d7d:1e79 with SMTP id l9-20020a5d6d89000000b002367d7d1e79mr1972329wrs.673.1667035806663;
        Sat, 29 Oct 2022 02:30:06 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:06 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 3/8] iio: adc: mp2629: fix potential array out of bound access
Date:   Sat, 29 Oct 2022 11:29:55 +0200
Message-Id: <20221029093000.45451-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add sentinel at end of maps to avoid potential array out of
bound access in iio core.

Fixes: 7abd9fb6468 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index f7af9af1665d..88e947f300cf 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -57,7 +57,8 @@ static struct iio_map mp2629_adc_maps[] = {
 	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
 	MP2629_MAP(INPUT_VOLT, "input-volt"),
 	MP2629_MAP(BATT_CURRENT, "batt-current"),
-	MP2629_MAP(INPUT_CURRENT, "input-current")
+	MP2629_MAP(INPUT_CURRENT, "input-current"),
+	{ }
 };
 
 static int mp2629_read_raw(struct iio_dev *indio_dev,
-- 
2.32.0


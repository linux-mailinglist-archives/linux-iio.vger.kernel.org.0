Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A456B5AEE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCKLRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 06:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCKLQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 06:16:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D795A6D6
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g10so1863905eda.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkQ93ugInkPpe3EPUwb7aGvfZMjL9q8ZpB0fY5f8jKo=;
        b=XQHEU5fAyON0vwZZc62gyPq4Sy+fd+RyFUbsV4vy1brKHUhuicHAAM3ykR8/lJxA5M
         FeQU2hHzfyYWr+daojlvdYgOSdiy85KzmPs2hATdnOO1LedgyLGlbbqmAZ4LmExBU4Zo
         vzqvIlza0evLN1j79EANAnwcvF0fCLHWDV20rc04T8OdnqTjSCTcr5baGT1yHqtVr1Ru
         tQ/wmkUCX24MvH3wssfFeQ0xdIRThGWUyEFI3MH68a9MtdWkNHyjVLjLgeQBjk/j3fOG
         kXWvgLEnNm9DYJV/2vHOgu/pXy4I0s9QwC72bTd0ncn4sMRpEu8+XWWjtTS9ldp/N/Fx
         9VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkQ93ugInkPpe3EPUwb7aGvfZMjL9q8ZpB0fY5f8jKo=;
        b=TuOrhYxsPdVYnfMeDMevfxT9S61FbGsoQYgWbFaU+aFD4K+lTkDayyrzPe9hch/EFT
         XLn7W8kGa6d6+laHK8QG3yYbJbiEpzK+aWHw7TsDdDH+i+bOektcNe33Fp/FDTeW9NOb
         REzeC4HjulQfmf+1AYVDCNITTlgfMbtn/sJ+dnsynI09CBAWAWD7alFQR+kQiuon6Z51
         wCMwJ2RsTf6OHD0REoYazSZWZFh9tkCpGUIyjOHgdb3TfOonLOC/aofgfm/biPaAy+ST
         Bh0mIbkVEDlkA6a79GAPAuwxfKrGPtHOnn/ZYBZ3gZTt8+jAri7fArRPKUK9I8JsCmvK
         yx3A==
X-Gm-Message-State: AO0yUKXoWa/r5dqH1GAaU44RqH4AP9SLOW9AJwYXbQmsMWxibRXBJLML
        osIaNkIUVW9PsdWyoN6+7jUWyw==
X-Google-Smtp-Source: AK7set+z4zxyOf7CpZVLt0gglQ5DB998s3uuWJhfpQFzYH02HmfMrZpH5iRqWTeANabxmkeP7ronfA==
X-Received: by 2002:a17:907:6f12:b0:8f3:9ee9:f1bc with SMTP id sy18-20020a1709076f1200b008f39ee9f1bcmr5368673ejc.13.1678533304460;
        Sat, 11 Mar 2023 03:15:04 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm223427ejc.164.2023.03.11.03.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:14:57 +0100
Message-Id: <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
certain data unused:

  drivers/iio/proximity/sx9500.c:1039:34: error: ‘sx9500_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/proximity/sx9500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 8794e75e5bf9..840db1953998 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1036,13 +1036,13 @@ static const struct acpi_device_id sx9500_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
 
-static const struct of_device_id sx9500_of_match[] = {
+static const struct of_device_id sx9500_of_match[] __maybe_unused = {
 	{ .compatible = "semtech,sx9500", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sx9500_of_match);
 
-static const struct i2c_device_id sx9500_id[] = {
+static const struct i2c_device_id sx9500_id[] __maybe_unused = {
 	{"sx9500", 0},
 	{ },
 };
-- 
2.34.1


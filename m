Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A776B5AF6
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCKLRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 06:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCKLQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 06:16:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599FCA3B52
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r15so3545805edq.11
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWDnMi7QDZcdU4X1J04rb9K92AwZUFTrHqFetObZuyA=;
        b=FPB6LP9qGChtUK7gsfHHUoQz9aOtglbfyIbyXKjx+q88Uc7gEE//joK7NgZoHsVQId
         Q3SW4vnMZ7Mi7REyHsmktqkrH4LfkEJOSOih3tcOOiRlQWr7oi3m3aPv+dSNJa+6OKg5
         PS1sfqnBPBvFHObJy+cLm2EkysAX+jQQozk7oM1uahf4fg0le3hH4AshRYN16o3RTX2Z
         ops6O9KHRmxXB9sLZZXBeZye9/NVgqoQEhJdYWc3gbO/U7xpju7CSlCG5u5fvzPXCgFI
         MPgSb/RwDWBY8OHc2kNbtoEEA9/Fj+SWIIojRJVBKNqRGtO5isIsFnV7KCTV8c6uHvDj
         9JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWDnMi7QDZcdU4X1J04rb9K92AwZUFTrHqFetObZuyA=;
        b=q7TB8VeaeawCwz/SrBwX1zVojZm/Bb6WsT1G0eFYBi0N38YzfG5Ut2qh9XmbtU3lOs
         sTwORTh+gstKF00G82Grlm3O+Jp4f2Jh66puj5UwvGgEKdNy6q8JOP6ke7p9uVWsDBlF
         mx7GYievhQS4de6XH9ijBG2GzhkDWs9TssQzrCStijdLg7xCWGE5J6AcPakIl9faRotS
         /j+W5ZYuKqV5jARc3B7EeUBlk/ab+QMQgSoYFq+isMAqBc7daSHn02CqzDJzaZo3jle1
         n5l2Ns0GBFHnG5GH95UWP3WwuwGb3BC7KFPzNRHWBlfMy7hFbflw/mawBH1bo/mfg+m8
         jZqQ==
X-Gm-Message-State: AO0yUKWzXGFX9C0oNAuwJVSpplVYhZZtCMGNhQNvUYYgssHFYU+EiDP/
        hnGGr5oK/AkEkvCYXV31Ic2C/w==
X-Google-Smtp-Source: AK7set/CMxwbblIW2mcgQdrWF+nrSueg14JbkoTX1/WzgpY9XADsiMemFhpivXEjozp2h9uVjs1CIQ==
X-Received: by 2002:a17:907:86a5:b0:8b1:7fe9:ac69 with SMTP id qa37-20020a17090786a500b008b17fe9ac69mr37804712ejc.75.1678533302588;
        Sat, 11 Mar 2023 03:15:02 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm223427ejc.164.2023.03.11.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] iio: dac: ad5755: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:14:55 +0100
Message-Id: <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused (of_device_id is not used for device matching):

  drivers/iio/dac/ad5755.c:865:34: error: ‘ad5755_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index beadfa938d2d..a6dc8a0bfc29 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -862,7 +862,7 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
-static const struct of_device_id ad5755_of_match[] = {
+static const struct of_device_id ad5755_of_match[] __maybe_unused = {
 	{ .compatible = "adi,ad5755" },
 	{ .compatible = "adi,ad5755-1" },
 	{ .compatible = "adi,ad5757" },
-- 
2.34.1


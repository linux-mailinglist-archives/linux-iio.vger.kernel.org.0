Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01226B5AF3
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCKLRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 06:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCKLQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 06:16:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A4B3E2F
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ec29so30739623edb.6
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbuERcpEYZZP8DGMBzAh4rdJ1ALZ/Zuq4Tpuw7i37QU=;
        b=s1xUOQhcbhWhG1M5xwYIVLhZzW8yYgXze58GEm8I9tqSPr4cDP1sIZqWFOmshus417
         cuQTec9FPallYt2WywWTMeP69LfZiVSoGJpdge4ApFV89YZNPV+xwxDVlDQmlTnXb8wU
         13PbVGrC+6T4iQU5dhn5xDIkk4a/QMR74HCsLRGwQgMkNBO7Ir7Fdt39aLFbGE+tsLbV
         I+69e+kJFFlIAt1VCvx+3F+Go7BWib3wx29fLQonHklHjg5PVDB9zwBdgX+P+qYNqiSP
         ufmCh1/sFukPceHV3LzRFgaXTLjpavu6HffksjCEaUAQ7NEXAYg2D2e1F5SDiutcZKZ0
         2T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbuERcpEYZZP8DGMBzAh4rdJ1ALZ/Zuq4Tpuw7i37QU=;
        b=IBWRVvJUapLaPTsH8eotkDK9Q3MvnOJan6SY0IX3dfKWzOCHow4ODWBp+IIUPVJjDv
         HwXJjnzj0JNuOqlALNf7Kb01yyYp6nJAeP9GvgdUhJk1/GSeFvD+s2VOfUxmQIzVmgB0
         lQDOSlS6Xd5i8GT3vfVH6Km0EZffkSP15oKQdwYA4JRdJOt5OGm8flxEEmVzxqCcoAls
         xHItIU3WD9NJI7DYyNaczVXOJm3EKMTM2qN6ogjedAAOmsXf3W17nmcCcZQTj8S/nKfk
         Jt9zSHBJnlG2PgIv9AfVBKTJcHL8A5u4hIURu36gBxtGBM85HVHOJXpcb2rsFLWiVD3N
         Mk7Q==
X-Gm-Message-State: AO0yUKW3ScPFb+LbJQIm+ggGv6sLTTTb411329cyNhjkCDfRQooTq1W1
        6R93F3l9A9Vcq9KHYn0sgO9WIbWfh51GbKO/RPc=
X-Google-Smtp-Source: AK7set/SvdvndrUH7v4K4asorZK728UuGdUey1pkP4ms8CL3ApHZAV0xRJzv86TrDbUh979XIWnklA==
X-Received: by 2002:a17:906:dd7:b0:87e:a34b:9e2b with SMTP id p23-20020a1709060dd700b0087ea34b9e2bmr28951517eji.28.1678533301747;
        Sat, 11 Mar 2023 03:15:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm223427ejc.164.2023.03.11.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] iio: adc: rcar-gyroadc: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:14:54 +0100
Message-Id: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/iio/adc/rcar-gyroadc.c:286:34: error: ‘rcar_gyroadc_child_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/rcar-gyroadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 27d9e147b4b7..b8972f673c9d 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -283,7 +283,7 @@ static const struct of_device_id rcar_gyroadc_match[] = {
 
 MODULE_DEVICE_TABLE(of, rcar_gyroadc_match);
 
-static const struct of_device_id rcar_gyroadc_child_match[] = {
+static const struct of_device_id rcar_gyroadc_child_match[] __maybe_unused = {
 	/* Mode 1 ADCs */
 	{
 		.compatible	= "fujitsu,mb88101a",
-- 
2.34.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8752C5163AB
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbiEAKiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 06:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbiEAKiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 06:38:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FEDF1C
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 03:34:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l7so23100431ejn.2
        for <linux-iio@vger.kernel.org>; Sun, 01 May 2022 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2ns7ipBZOIfI9eYR5XNbFPvQdAnHfmlBHB+KUxSjlA=;
        b=XKrhM7A9/fGhlDKnSBy713skq8Jb6hNY5w3j5RcEu+Kq6biOP3KN1blmkItGAqYLEn
         GvmtgSP0m5j3IVPJE/gOLXtQPds0HXF1OLznJUy8rwuLaVc/dwZQZyUi0DPYzV9YVdr/
         OoeOkquJP0RSTwFUvTCcNj+EZ7N8KhpiZvuWlhUm0Zm3ujPOj3pm7wgrQryJgr16cxV/
         csIlDioGBoRPm7CP1sAiaWVMOybenEYO7YXUbHPbj0OwZzcSnld6dNF9btfO2zM/EU/R
         dnyj1pbbN5T2WyL3xZ+RGUSZD7G8vXOi5PyEsjgdyA7+IZxvesXiyVg+FXHbw7egT7wz
         xI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2ns7ipBZOIfI9eYR5XNbFPvQdAnHfmlBHB+KUxSjlA=;
        b=lRon4nY9BCyH0nHDUs0WN7zuFKqGYz9hphrRkqypBaT9oTZOlZd6iehK+d+TMHYeko
         jqwc3fvvDPuHyfGPDOgwPwZvOd7jJVLf83jjkL3T8pZsZ1ITGVd/gcZ0hkOgzlmVQ06C
         we0Z6PthVgxAsPDWvQ2uhjJXyF3UYP9xffdLw+we8zaTBDcp8+ZJQsRO8eqd6lgaQhJc
         ju8sy+j8TArRBSpGXct8LkF6Qh0p1dJMuJQSYOUfzoq63U3Bi4T5WfHC7tUouek0bvgE
         eEThGuD3jVBwpB+UzdAO82r6PVWbQXWukRfaAytjP12JEraGbIWdvEsczdoV78lx1MZR
         MjEw==
X-Gm-Message-State: AOAM530Gclw8JJmKYz+rknyN+zgl8LZeU92eeZeeVMiSB6Wa2XZaGMCg
        BuJyECVx3S9ViMlaXKbmr1No9Q==
X-Google-Smtp-Source: ABdhPJwZhJl6e4trr4YOaYl/CYYLw9KiekLiz8lTQZvRTpDBo+Hw3P6ZJeQaLMTFJfS8pK/1BqiRiA==
X-Received: by 2002:a17:907:a413:b0:6f3:a9e5:d076 with SMTP id sg19-20020a170907a41300b006f3a9e5d076mr6891556ejc.183.1651401291330;
        Sun, 01 May 2022 03:34:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e11sm2492945ejc.119.2022.05.01.03.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:34:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] iio: ti-ads8688: use of_device_id for OF matching
Date:   Sun,  1 May 2022 12:34:47 +0200
Message-Id: <20220501103447.111392-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501103447.111392-1-krzysztof.kozlowski@linaro.org>
References: <20220501103447.111392-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The of_device_id was added to allow module autoloading, but it should be
also used to allow driver matching via Devicetree.

This also fixes W=1 warning:
  drivers/iio/adc/ti-ads8688.c:501:34: error: ‘ads8688_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/ti-ads8688.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 22c2583eedd0..708cca0a63be 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -508,6 +508,7 @@ MODULE_DEVICE_TABLE(of, ads8688_of_match);
 static struct spi_driver ads8688_driver = {
 	.driver = {
 		.name	= "ads8688",
+		.of_match_table = ads8688_of_match,
 	},
 	.probe		= ads8688_probe,
 	.remove		= ads8688_remove,
-- 
2.32.0


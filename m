Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC06661411
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 08:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjAHHsF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAHHsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 02:48:04 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B279D113
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 23:48:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w3so6254779ply.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhcXBzrn20649nc8IxPxwEjVK58PQr8EjRb8EUxvkFs=;
        b=WINLc0+hFYFWqHxePC9Sz9UGwHvLuCAVo7a4i5Pb21XvLPPqpWZYe8+ITyqDbrwfVf
         hDogTnfTz+DcAP4r+r4/9tN8nsYvDze6CPilqgfYXO9OmBP3rm9mZbQqaFUlCJcctiEj
         1ADVzpcOGrC4Vjme8/yCU0XK5Jq+s8sToiSIn22Wh5r+/r8RV37SQ1Dc/lpq6rsHw0Il
         ENvoLni+0ra3VodaS7c2y8ZP9D+tncGkf+n3XH84FezX9UMbv7LRqiyVm4V6NjPG+ExZ
         laUHIea5pWsbEL7EC7ghQCpRxs55vclo4l2sQjmMgPogK8bYYPfn1pINNBeTFBLlpGbI
         c5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhcXBzrn20649nc8IxPxwEjVK58PQr8EjRb8EUxvkFs=;
        b=i5l7RBuE90kWnkELGuwhqZvq/anqtYU2UJnkuIhtVtRw3PNF9xRd5f7ezeo2y9iaV4
         F+VnCB5lMWhQhvTgrNHwoCm7v5ZV5UXoYBvacKcdf3pWPGIeOiueBoyyezjgaGg/OerI
         OXCqM2RXsven9ePed/vsEKwv5QH5XwhbY5O/h0XZpLMWPOuZJgySnTtXTrC5bRgbHlqq
         FEpwfQR88OFlYk856oqG8P1pz5A7hUmiH4LUw36ep7+hCmYIiA5TVemEZXpcywTs9sG5
         6CX52XubaZWZTSaZhAN8/FeXt+EcsB+e7dGHOEj8Pzr21o0moi67e+vodndD66sGd/rf
         lDNQ==
X-Gm-Message-State: AFqh2kp/kllhp1h6O23O1tKet/RpoUX03y7G4xUgn/TIIbH4UGGqyMFH
        H8LPMz65RYe1r9thcA5iXis=
X-Google-Smtp-Source: AMrXdXv8O8q3J69CWiL1PKG8XV77EHY4Rx/fcjw+qVK5k4LD0kfMwIAze8F0P08IJ/PhIqurz+tAQA==
X-Received: by 2002:a17:902:8c89:b0:193:62a:80c8 with SMTP id t9-20020a1709028c8900b00193062a80c8mr9153694plo.45.1673164083759;
        Sat, 07 Jan 2023 23:48:03 -0800 (PST)
Received: from morpheus.lan (106-69-189-37.dyn.iinet.net.au. [106.69.189.37])
        by smtp.googlemail.com with ESMTPSA id h5-20020a170902680500b00189348ab156sm3672212plk.283.2023.01.07.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 23:48:03 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 3/4] counter: FTM quad: Depend on the Layerscape SoC
Date:   Sun,  8 Jan 2023 07:47:49 +0000
Message-Id: <20230108074750.443705-3-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230108074750.443705-1-pbrobinson@gmail.com>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
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

At the moment only the Freescale LS1021A is the only HW that
supports this IP block so add an appropriate dependency and
compile test.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 011e6af840fc..ef78386ccd2e 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -31,6 +31,7 @@ config 104_QUAD_8
 
 config FTM_QUADDEC
 	tristate "Flex Timer Module Quadrature decoder driver"
+	depends on SOC_LS1021A || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	help
 	  Select this option to enable the Flex Timer Quadrature decoder
-- 
2.39.0


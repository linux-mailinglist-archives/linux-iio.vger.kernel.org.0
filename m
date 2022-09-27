Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0E5ED07E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiI0WyW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI0WyR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:17 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593DB514A
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:16 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1280590722dso15237723fac.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TSmzC4k5RDlY3jB66Q9l4SG5pWj9tmKJxCdO7HIT4mA=;
        b=TUGRr/9vIRDAvWK9o5G7Hf8VSrXugLilSiMbDYHPjejjZCRWfIu4Z/qp1MyvEA36uV
         uuLCH2g2oB4XmEp228HJ6QWJ71Gw3Pw6veajbUTlYB7UCoLdFgiv1FkDecaCwA/pZCAJ
         7aOgz025kQXHwRZ7b/ttiy9wdkwgksQDTN1DJavXWJUn4Yorp7ZLs6taZLLwSSUlmfdA
         C+SkBws9IIWLAgQ5iqUcJ98phqRXsgG8L8oED7z1+l6GZc0SIjJu8huMFq3eNGB4Irqm
         KVnJl2Bf+7pQg57yzr+OKe+AaVgG1Xjkr9tVvIEkDr53ovgarwjHoYeJIWe5PLZs16pH
         3GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TSmzC4k5RDlY3jB66Q9l4SG5pWj9tmKJxCdO7HIT4mA=;
        b=pQcgD3OiKMHx8XVxOSWO1k2z5QHWvU8MSwrUPq/0KkDz4Tcg7eOh0eEdwxRGLqeJTE
         PnvT4upfSIOCESjx7h+CgfR18udE77EFEz4goZW1RYBuLp7Oqu35uZQc1bHUVlo0xo4M
         IQj49iafgMKyzWGHyI3tHVGm3FXjzsxjW09L92RXmROsnlllVeFwdtPjrHkNA2k47hIk
         uFMcFJh0Nmk4yXwVixxm2EifvR23ke21bQGfeMP1m1myP8AspjBnin5XE+F9SQSI1wey
         FvSIBRfkdYrPwUWzDWD6t6c0aaB+hovyX1Rwuy8nnl5951vQas1H9eJ4g8C4b4cpo/Km
         cYeA==
X-Gm-Message-State: ACrzQf20h+wS7X04KkzS/5/AHDFcB3TQQRYMa7tKT6wesdVUxhX3tmjp
        IJv68QnQ9xThwIbk+7ECxm/a1n9rycA/kjom
X-Google-Smtp-Source: AMsMyM6XTRy1t/WFI+/Rmc0deOf4NfdItQVd8UHg/gjchlBdUi/LE7GHeO3KT88Y89EzzUSeLB+EyA==
X-Received: by 2002:a05:6870:639e:b0:127:bbc2:223e with SMTP id t30-20020a056870639e00b00127bbc2223emr3591065oap.167.1664319256262;
        Tue, 27 Sep 2022 15:54:16 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:16 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 12/12] MAINTAINERS: add TI ECAP driver info
Date:   Tue, 27 Sep 2022 18:53:46 -0400
Message-Id: <bb980cb69381c570b72701398991100ac91079ec.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Julien Panis <jpanis@baylibre.com>

This commit adds driver info for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Link: https://lore.kernel.org/r/20220923142437.271328-5-jpanis@baylibre.com/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4999f68bda8..c189117f58eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20322,6 +20322,15 @@ T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
 F:	drivers/media/platform/ti/davinci/
 F:	include/media/davinci/
 
+TI ENHANCED CAPTURE (eCAP) DRIVER
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+R:	Julien Panis <jpanis@baylibre.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
+F:	drivers/counter/ti-ecap-capture.c
+
 TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
 R:	David Lechner <david@lechnology.com>
 L:	linux-iio@vger.kernel.org
-- 
2.37.3


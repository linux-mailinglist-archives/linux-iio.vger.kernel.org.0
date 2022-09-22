Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E5C5E6922
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiIVRES (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiIVREO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 13:04:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE45FCA64
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:04:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so16614516wrq.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GR6QqlWwcUCHVPDy1PIJ3cv5rzI8XO1SG3L1WODR4pQ=;
        b=5/xG4bNfcawZqP5d1tciuXBStQXxGo/tY+dSf7Oa5JslTzHv70UBaJZhOWVgMJhAjB
         r2srFqm3rE9CtuX4U9mqgTT8du1sDAiVqHtXUxRtaW65eLxZXvO6sFyA/rlf40aNHJFa
         bajB4AtAHtfaa3p1XiKlPmekaJJ6lFcu64+WvfQjjFfagMCX5T2uHNHc2pEb61+7q3K/
         vj2Sc4pgExtEQdi0jDt/e7wRbejb1vuw0fYRFbDfuEEaXk6on1UmpWHWbAZzK5l7ZUa9
         fuxnx4uidHhX4aEvbBxOAfkHUhAOlsrUIM8Z1TCNj6tfv3L/1wgVAFnAOt0R3WN0rIfM
         nxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GR6QqlWwcUCHVPDy1PIJ3cv5rzI8XO1SG3L1WODR4pQ=;
        b=6Bxs1i89HLkyu/RIri3/Vpr/k+j8ZolVc7UFac4PHd2i91qKuETO7mqUzOm4T426/Y
         mcKlBKO0ZM6L3O+wAQK9Fgon0cKN5Ap/MlJt0GqIhBIkOSYGzuADOXMOCtU+WLYNH7z7
         6+NjIk3n47Uz2RatNjUNs/oEhc8Ivva+dGb2mUAI2qJJMRPp8TM6f1nG/Nd4l4BmC2TX
         lPXMTUqqa/Px7WvfLZmlv0S7vwg55T6T7DoFnR9V/IWiV3LaB1QTZ6BV32tmZpsKE37M
         VRLJO5N8v5QOVQDJQWNDzPYzQ1/B6pvsSRbaxQosURqo09/c4ZuCd+vqlqzs/eoqzx6L
         POWg==
X-Gm-Message-State: ACrzQf1ylTRCoOD8Xw1A5l9rBFCxFpOEA11bx70ntt35U5MEnQjle+mY
        2HPyhepyq33vUciX0rGl2FxblZ5V6MsNPA==
X-Google-Smtp-Source: AMsMyM6lUAz4T7XZ1WtDGRMTGXtFvw6AwsVg2d8BrgUmXBgVc4MeLXk7GbrTV/Mo7lkRfVPha9S0lg==
X-Received: by 2002:a5d:4688:0:b0:22a:f718:7f36 with SMTP id u8-20020a5d4688000000b0022af7187f36mr2662331wrq.315.1663866249650;
        Thu, 22 Sep 2022 10:04:09 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003a604a29a34sm20334wmc.35.2022.09.22.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:04:09 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v8 4/4] MAINTAINERS: add TI ECAP driver info
Date:   Thu, 22 Sep 2022 19:04:02 +0200
Message-Id: <20220922170402.403683-5-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922170402.403683-1-jpanis@baylibre.com>
References: <20220922170402.403683-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds driver info for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4999f68bda8..906b93e266f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20322,6 +20322,13 @@ T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
 F:	drivers/media/platform/ti/davinci/
 F:	include/media/davinci/
 
+TI ENHANCED CAPTURE (eCAP) DRIVER
+M:	Julien Panis <jpanis@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
+F:	drivers/counter/ti-ecap-capture.c
+
 TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
 R:	David Lechner <david@lechnology.com>
 L:	linux-iio@vger.kernel.org
-- 
2.37.3


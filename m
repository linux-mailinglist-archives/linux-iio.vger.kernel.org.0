Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE6B4CFFF4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Mar 2022 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiCGN1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Mar 2022 08:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiCGN1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2022 08:27:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27158A6D9;
        Mon,  7 Mar 2022 05:26:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q14so7710018wrc.4;
        Mon, 07 Mar 2022 05:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrvPXGx3ECGbsCld0OXvgemkzzslR2gxe66aKxR+p9I=;
        b=hyppcdLO+2rETw9IC/eu8Kpp4ltF1ah2GbiKcZe+1eLlftYwaBJi0mV3ceuHSwY3Gx
         oCYXHfVs/uBwMGp2gAHQbAZNBEXiGl4skcMHQFBSLdr5Alk70f+eKs0iPV8RSX+M+1Qa
         aeWJV2tRWxIk8hzEHjwcHtVe2ehn/8nbvXBLjzu7jhpUxH5u5do4q5U8A/pLmX9MqQZ5
         jFJDio7WJjmuTLJMClqy8Mqyc3Dav6bALBPQ+09zYeHpvO2B95QGk7EO+e11h3djvnQW
         00mTew/9yvs/NUGjYsd3YUf9MizbOGaZH3XD+eSyy/tAz5namxPHUYznVzEjCD2nnDQB
         RHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrvPXGx3ECGbsCld0OXvgemkzzslR2gxe66aKxR+p9I=;
        b=gSWkcoM5eqz0IkLZ3EiQnX4Ktn1QqTTW1kuFATj0IOINCXB+iTm4tC+A2rO0lpkIzi
         QAYnde6jaCOSnblClfCAlbYF7tzzarB4OjZsXxi2j4CQfsIgEpnHGqZPZWVkaZX8fnKb
         jQWAxVsqMWph68SKMrujwi2bmxP9b5MNqTGJvVRpk+bLHomovPvnzS5DCgw/BLC1AYk9
         CHDKZ0Fz+tx3FvwEFz2CBZIAHKIBtLIJXIQUiu1rmXGtqVu+8cWCehMm8MsMPCW6++JE
         wj3caalwLJjzPvAUSVSbfv1YQTeXJPxMeI70PKm3O36IqpY/iylM4bgUAOslsGXv2spr
         MVzQ==
X-Gm-Message-State: AOAM532aA8f8PmCIJZ7uimDlb4M6BmEspyHbA774h+PpggRDXiGpUUzT
        KVVPgfk0KXNdONBd0iOvoMk=
X-Google-Smtp-Source: ABdhPJyrJq880QeGkHGXC6rHTVHmNVZ9L6zTj5XOa7n9AowOvnB5G7nydaUAcdfAuViagWqmYAPzig==
X-Received: by 2002:a05:6000:15cc:b0:1f1:f814:27c4 with SMTP id y12-20020a05600015cc00b001f1f81427c4mr4053854wry.630.1646659574524;
        Mon, 07 Mar 2022 05:26:14 -0800 (PST)
Received: from tpt440p.steeds.sam ([41.84.249.145])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm11524965wrw.74.2022.03.07.05.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:26:14 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        maemo-leste@lists.dyne.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: st,st-sensors add LIS302DL
Date:   Mon,  7 Mar 2022 15:25:00 +0200
Message-Id: <20220307132502.73854-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307132502.73854-1-absicsz@gmail.com>
References: <20220307132502.73854-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update st,st-sensors bindings for STMicroelectronics LIS302DL variant

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 71de5631ebae..321fd16b6ea7 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -29,6 +29,7 @@ properties:
           - st,lis2dw12
           - st,lis2hh12
           - st,lis2dh12-accel
+          - st,lis302dl
           - st,lis331dl-accel
           - st,lis331dlh-accel
           - st,lis3de
-- 
2.35.1


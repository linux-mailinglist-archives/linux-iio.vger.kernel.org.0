Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D3F4F68C6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbiDFSNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiDFSNL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 14:13:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2D140DD7
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 09:50:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w7so2956695pfu.11
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EReQwLDpITzSuxpuTYCqKmyFkRWM0fiL0s9dOZnYNMU=;
        b=mIRy35eLzAo2AiUAQ6+6rDIAiJubAwwbFJc3kAnYE9ezR3KBdyDW4+pu1kEk3pzF/N
         veWNjSdrrNovXqLVA4IQxvTKISSEh9kXg+RfSnx4bJPbC7YKgCcd4ikci00xCkowRKLX
         Tggq12vtt2zc2PvOyUgxt42ILEud9VdAgyhHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EReQwLDpITzSuxpuTYCqKmyFkRWM0fiL0s9dOZnYNMU=;
        b=rseOqqWejYmaq294AvJOfgB5buCImjo03Ob77pGetvCB8riLXipqEDbMokOvN6oDdr
         c1fXjV8WrIYLIYuI7FqH35ptKZ5ppdLKM/visPI3PMaKECPJ/vd96xlblseJC+sUgIGv
         HJSd//Pi7FBiKNGgBww+NOYNATAHGB8buqmtcjSFewLKFim8mbiSn+xPxoc7OcLfxdGM
         nf5e0ciO4HcgqSGYcppZufaViEDssPagXJ0vTvAwR6aUKqNITdmmd/juvU3AVU8s5d+l
         VNvjfQMQRgXb/Y998bGpeADl7vEobLnms/z3l7PDE5DdSx4RqNNe4t+k04k0n5cIQYeX
         Q56Q==
X-Gm-Message-State: AOAM532z5yQmrmOhmSqrKgj2I1mAlySUO1bYvKaBu6aX0QGyR7AC4Q5l
        K6+2611wBQyTu5p7GCTdjyRYrJnUngRqVA==
X-Google-Smtp-Source: ABdhPJw/8XSEVADvPjMzxdOkS3KsGOu811RyfZc/zr7UYu6EwjWvN6h4kn7jWZ1PT7+7NCX7X0DQnQ==
X-Received: by 2002:a63:7741:0:b0:386:330e:1dcd with SMTP id s62-20020a637741000000b00386330e1dcdmr7641821pgc.71.1649263837029;
        Wed, 06 Apr 2022 09:50:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9d3:469f:91e4:c022])
        by smtp.gmail.com with UTF8SMTPSA id x29-20020aa79a5d000000b004f0ef1822d3sm19617880pfj.128.2022.04.06.09.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:50:36 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/8] dt-bindings: iio: sx9324: Add internal compensation resistor setting
Date:   Wed,  6 Apr 2022 09:50:08 -0700
Message-Id: <20220406165011.10202-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220406165011.10202-1-gwendal@chromium.org>
References: <20220406165011.10202-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow setting the internal resistor used for compensation.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v3:
- Added Review tags.

Changes since v2:
- no changes

Changes since v1:
- no changes

 .../bindings/iio/proximity/semtech,sx9324.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index a22cad1507b6b..f99b2c1cd3ac2 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -126,6 +126,15 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,int-comp-resistor:
+    description:
+      Internal resistor setting for compensation.
+    enum:
+      - lowest
+      - low
+      - high
+      - highest
+
   semtech,input-precharge-resistor-ohms:
     default: 4000
     description:
@@ -165,6 +174,7 @@ examples:
         semtech,ph01-proxraw-strength = <2>;
         semtech,ph23-proxraw-strength = <2>;
         semtech,avg-pos-strength = <64>;
+        semtech,int-comp-resistor = "lowest";
         semtech,input-precharge-resistor-ohms = <2000>;
       };
     };
-- 
2.35.1.1094.g7c7d902a7c-goog


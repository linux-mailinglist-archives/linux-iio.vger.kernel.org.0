Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6175157BB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381196AbiD2WFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381157AbiD2WFY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE0DC59B
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:02:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y38so7983264pfa.6
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkcgukZ2Facg00OQD0krU/6vExPSQRU78CLh6trJKEY=;
        b=SPEt8MnCV+Eo0x8qi69cvUMPd7kkLuPRUQZ7rRa8FfS6cpmR1Yn53jF5aRJvgenxdS
         DpmCKPsf8QlrC3rRS50kM8vMid1pn334jYtbwsirLJ5fRw/G+n+2QKljvST3JrAm/Vu2
         T49InV2y+BZIA0e+in3Uw4Njz9wMh0Or5EthQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkcgukZ2Facg00OQD0krU/6vExPSQRU78CLh6trJKEY=;
        b=nhQnZxc9EOeLshrfPlsmhccFrkzNcoxhfb15raoBJpx7tsDwMveMMQ/3HxZILDgqjR
         jnupbV3OPRO3pYKHYJ2zvOwlOLS7sssh2pSHKEqSxce4F4B/Td/+GmqHEywLlXX9iAvB
         vzuJheB9KSal8bj1nZt5bI3ySK4YWlK9vGcYk2hTs4+GW8U8/82Wbjd8qhjMCx6w2Dsl
         dgOP/qJ+tQyZZgK4n53ewD+GEWluST9lF3L9rE0sKjnlB02GnNghor2lJ1XS6Ffnx9ac
         Ugo7Iz4fdlqDUw11tSYHTXItr3fwUUpuBUXk7lalI2bk/wzabmzPcA5ueP7v2gKG3ryo
         WZhQ==
X-Gm-Message-State: AOAM531c70+IUWKcRfS0quuN0RftG5z42W7Crlpa5ceapBN/JKsCF88t
        nJurav6ru3lxwiAocxXCo5Tx4Q==
X-Google-Smtp-Source: ABdhPJw73s2zmkdst/yM75uAYU18Xv8KUdgyfgxOL9ZhsyV+X5yJ6CAxiwkLe4pYc/jJDCG7X9u7jw==
X-Received: by 2002:a63:68c6:0:b0:380:3fbc:dfb6 with SMTP id d189-20020a6368c6000000b003803fbcdfb6mr1036051pgc.326.1651269723049;
        Fri, 29 Apr 2022 15:02:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id c17-20020aa78c11000000b0050dc7628197sm166082pfd.113.2022.04.29.15.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:02:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 09/10] dt-bindings: iio: sx9360: Add precharge resistor setting
Date:   Fri, 29 Apr 2022 15:01:43 -0700
Message-Id: <20220429220144.1476049-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220429220144.1476049-1-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow configure the resistance used during precharge.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since v4:
- Add multipleOf propery
- Move description at the end, to match convension.

Changes since v3:
- Fix maximum field. Check make dt_binding_check passes.

Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix property with kOhms.

 .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
index 63e1a1fd00d4c..f088c5d2be99c 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -61,6 +61,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-ohms:
+    default: 0
+    multipleOf: 2000
+    minimum: 0
+    maximum: 30000
+    description:
+      Pre-charge input resistance in Ohm.
+
 required:
   - compatible
   - reg
@@ -85,5 +93,6 @@ examples:
         semtech,resolution = <256>;
         semtech,proxraw-strength = <2>;
         semtech,avg-pos-strength = <64>;
+        semtech,input-precharge-resistor-ohms = <4000>;
       };
     };
-- 
2.36.0.464.gb9c8b46e94-goog


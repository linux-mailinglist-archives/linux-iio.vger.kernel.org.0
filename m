Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A94E7D29
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiCYWKN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiCYWKM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:10:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639EB166675
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s8so7568963pfk.12
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J75R2mMWF+az1P2ih4+x2IsyXN2geBWtCz9aNcOKaxw=;
        b=ghnQ+axF4TfKN/r4BClayoJ7umXeJR8NdKsDPb8+HwFX26PE59UJcLsCvNRgaOgCS1
         PW57qG6c1CklfBb4XRfvvz8rXDB1obEkyOzvkRG5mD8URLoJxK/SdukTbAyZ1rIu2W5a
         590i2AQzAJJrUmj9bW4K/Lla51o5reYmKADPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J75R2mMWF+az1P2ih4+x2IsyXN2geBWtCz9aNcOKaxw=;
        b=tviMi4cKYlDEtAJqiD1ZxtFfUMn3jzomXdZTAn2cKJpECC8yhYwft/cjyebOoy8U71
         d1P5XRqVtKOw7vLvddtygV1oMwcQDovEoz3ImBs81uQLjZYb35ueQ9e5ChkcwZr7jxsW
         ZMaKPsqIWCxv8NN6v9vxKmndmKdRr+g7lewfBL891LADOOMDikbLleonMXxOQVcuMwfG
         mZVDdKTdcIHXufAouO5x4F9JUGZQfdLtPDQ+7dX7AYmH2x8I2sGWe/cS729CP4NuNpXg
         ILxTw0l8WMFIqmHjCkZPx9gUbT5NObADKaSDfN2Sa3Imn1Ea/yElBDiZ+iuLYDkoElR2
         MzEw==
X-Gm-Message-State: AOAM532t/GAkpAMlCP5ZYuiTIQI9PndHF0Jo7UlqlfugPbDwtXiXwTt5
        G7CQQ+krKh+/MfpKBYkb4VQQrA==
X-Google-Smtp-Source: ABdhPJwZSnZde78UWv/gJ1OrMqQ2vOL0kb970ASV7h4I0DGIonxpOZG6gAjD1zCWi9IouGycrb2Q8g==
X-Received: by 2002:a63:d13:0:b0:381:f043:c627 with SMTP id c19-20020a630d13000000b00381f043c627mr1301911pgl.168.1648246117890;
        Fri, 25 Mar 2022 15:08:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f21c:980b:7d64:94f9])
        by smtp.gmail.com with UTF8SMTPSA id cd20-20020a056a00421400b004fa7d1b35b6sm7575899pfb.80.2022.03.25.15.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:08:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 5/8] dt-bindings: iio: sx9324: Add internal compensation resistor setting
Date:   Fri, 25 Mar 2022 15:08:24 -0700
Message-Id: <20220325220827.3719273-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220325220827.3719273-1-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow setting the internal resistor used for compensation.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
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
2.35.1.1021.g381101b075-goog


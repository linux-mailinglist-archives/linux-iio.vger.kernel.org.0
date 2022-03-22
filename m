Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC994E38DC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiCVG1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbiCVG0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569E33E11
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id jx9so996736pjb.5
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30RcZys3m+mnl1wP4Li2+2cSCnquqYOBajAz0JIjDJs=;
        b=V3aUEaQA32XUGTV33Mandcv3Lgfa4gFsNJTEvaf+bqRWidZOP6Jnjaa/oTUkMfgTAE
         BwaQtd8esfQvUJhfr1lds+siUo+tD/Pr5yFGLfrjteMEhxVhj+5cfiK4Ee/V1V/UGvZ7
         iUL4kyaidVBtyeB+3tvRbdyQ4wKge6UR5jalE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30RcZys3m+mnl1wP4Li2+2cSCnquqYOBajAz0JIjDJs=;
        b=OpbXDPE4qQNRfzDRufgsC7ubTIQxLWrjG0YpYyfOu3RDk1vMsujHs8jvy1AVHyHYK2
         cjz2R8NUfnjiLLnfR8+mdNhOaUNY3LCZy784Ly0Mz27oMBJCzgmFpSij4VPy8ao3+2aF
         nlCC7KnFgJ4x/fcrowfOlhsVW6+OL21dn1NuzamNX3FJeNPZ5UOG0apTs7lYWClGv715
         iYLsRVSQb47/IwZVtzD/slSALaN85orzUg4F+4EtN1k8bdCBn6nipKAs/7amMkppje3T
         J+/gZSrsSjt42lQMaDlUTZuaqzylYsJyS0Iw7HfWnbYDofFE0z0DJYzGFenWhGCO2k81
         /EkQ==
X-Gm-Message-State: AOAM531t5fm7nXHvCEAgOEoaYspvqsSluWNfYJoSg6TfSqF2O6FNlLN5
        ubQaTJzob5PsZcJR/rJspEmCLQ==
X-Google-Smtp-Source: ABdhPJyLtfBqUQpoVZNoqWX48X/ynHku0Q/mpdlADxhZE9maHPd7pzNzlEz8Vp+sXtbfa1/CJYhJYA==
X-Received: by 2002:a17:902:b113:b0:153:2251:c1b0 with SMTP id q19-20020a170902b11300b001532251c1b0mr16128580plr.44.1647930316996;
        Mon, 21 Mar 2022 23:25:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id y2-20020a056a00190200b004fa865d1fd3sm9903049pfi.86.2022.03.21.23.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:16 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 7/8] dt-bindings: iio: sx9360: Add precharge resistor setting
Date:   Mon, 21 Mar 2022 23:25:03 -0700
Message-Id: <20220322062504.1019504-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220322062504.1019504-1-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow configure the resistance used during precharge.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- no changes.

 .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
index 63e1a1fd00d4c..1225f64f14174 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -61,6 +61,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-kohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Pre-charge input resistance in kOhm.
+    minimum: 0
+    maximum: 30
+
 required:
   - compatible
   - reg
@@ -85,5 +93,6 @@ examples:
         semtech,resolution = <256>;
         semtech,proxraw-strength = <2>;
         semtech,avg-pos-strength = <64>;
+        semtech,input-precharge-resistor-kohms = <4>;
       };
     };
-- 
2.35.1.894.gb6a874cedc-goog


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614364E38D8
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiCVG0y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiCVG0p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109D37AB6
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so1285472pjq.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCQuJ6XtkWARCT/SeBBl76pl1bofCmdHbO/6yKxBBCo=;
        b=Ef9IMR5PloZldV944IOtnJP7DY0QGiNygulYQxKRA7KJ2s/f7AM9i1YHestywoOrKC
         naUthvieNsv5XmbQ7M6XuzjnIyAvnuNpNoJ6pGqRa8+CEi1MnbI/NT4EI8GP7e3ycqyQ
         /4lPfRoMc98ybFknXjOtfGnD2jH086iDbcp8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCQuJ6XtkWARCT/SeBBl76pl1bofCmdHbO/6yKxBBCo=;
        b=cJXFKTaCmVE1l1azIdrCVpuE6hHiFzvx0pdKmot/EMqPBrPkb+34qRP95y67UqQUeO
         mjRBcJRkk8MGyXYb+NJpa6520k1NQsCttJH0vNASFOXANDp832dnM/GD3gyF2ZkW0f5b
         FAJtu07tGgqAFUN14AnocQ6GQCxswA7Q4Qd3Qti3SBmabPd5psZ6bjeaI/Orrc4gOGOd
         9ZDstwwu6I0ed9rldIBBFdJGFvjqxPEfcXO94mVtl5+Hm8ibudsds7uMUxqrge4B+mf7
         uWtfMQGV+38zVcxvc2nWtmdgGe4FEPvR4G/Tgu7ffjs4cAAv/I5D0pYwZMX376PfCkz+
         Sq0g==
X-Gm-Message-State: AOAM531N1Ifc5cF+BTMiqljgEM1nAJ/u6X7o+Qv3PsR+btkj0QAtEnaX
        7ET+MtsnrdSzBbwJ49GgaA6fpQ==
X-Google-Smtp-Source: ABdhPJxdE48xQ9kOe4WzGs68fXv4gq+U0bmSw+O/9Qzj2sXXtHdhMkXWrttyzW1Ew7LYj08BBxR0Lw==
X-Received: by 2002:a17:902:9345:b0:153:4d7a:53d9 with SMTP id g5-20020a170902934500b001534d7a53d9mr17003306plp.116.1647930312172;
        Mon, 21 Mar 2022 23:25:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id x23-20020a63fe57000000b0036490068f12sm15853883pgj.90.2022.03.21.23.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:11 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 3/8] dt-bindings: iio: sx9324: Add precharge resistor setting
Date:   Mon, 21 Mar 2022 23:24:59 -0700
Message-Id: <20220322062504.1019504-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220322062504.1019504-1-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org>
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

Allow configure the resistance used during precharge.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Suffix field with kOhms unit.

 .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index b8a6ee16854ff..8fbea71823e76 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -126,6 +126,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-kohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 4
+    description:
+      Pre-charge input resistance in kOhm.
+    minimum: 0
+    maximum: 30
+
 required:
   - compatible
   - reg
@@ -157,5 +165,6 @@ examples:
         semtech,ph01-proxraw-strength = <2>;
         semtech,ph23-proxraw-strength = <2>;
         semtech,avg-pos-strength = <64>;
+        semtech,input-precharge-resistor-kohms = <2>;
       };
     };
-- 
2.35.1.894.gb6a874cedc-goog


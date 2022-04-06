Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753464F6946
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiDFSNr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiDFSNL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 14:13:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCCC5581
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 09:50:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d15so2448339pll.10
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwTLIXG6NYLkv6EJfl+8yB7+FdoszwL8ecou1g8gaKU=;
        b=gAYgnpBhrJuU2f4NBc/dm8OQkvdpbiPCRd7pRfz+XFIZnhlznJD/juizzx8B5zyBlA
         ai4qdK80/jW4ayldRym39ExLDEqAYXKAXFS7ipgobYAWHq9YZiHR6WJ7LcMNv32Dy+DJ
         UsRC+zlmb+1b7T8EmVf1IUrl33WHC1qzOEK98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwTLIXG6NYLkv6EJfl+8yB7+FdoszwL8ecou1g8gaKU=;
        b=Bvr3uqzkqtit2BWvjGWBp2xWZHkuupHB9dWKn4cmes6EvxXTthtbhJqFmamnvB5w59
         ZLUd837HTnslCEtodvem4FIsRxHHjbrolioWO3ZQPXjh7/p04deRIMP8bzhROWsZEwWQ
         NTh8vGC8Mfq4exEk1fLiDlBQTr4RBPx4MMAAUqh7qRRpqvt25pNyhB/Z7TW2JXIJ5t0v
         u8rFrN80VMj+6GGJDOdQsgs4e8r8JFqfg+lw22gmVHpswtZrGdzqt02A1RFuxDdjWj9W
         YEPFoWKqDVmgi9U1XoQveuv+gOSMipIOWWVyx01r6iaehK+emeiIP3HFKSUKMIOUvPYd
         aKXQ==
X-Gm-Message-State: AOAM533TV/+WyRstyuzFmQHuSmHGiaSUzYqYfbFiVNuCgzneAJGopi9D
        RU/Yt4Am/QjIWE1gQ1+QJurOhg==
X-Google-Smtp-Source: ABdhPJxVKSQyEeWuWPRgm4Cp+DK1+VnKA2WARnQ3Ieg/UkHByCHKs3ljooT3+ArhQdIgP1+adZaSXw==
X-Received: by 2002:a17:90b:2246:b0:1c6:5781:7193 with SMTP id hk6-20020a17090b224600b001c657817193mr11201226pjb.48.1649263840123;
        Wed, 06 Apr 2022 09:50:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9d3:469f:91e4:c022])
        by smtp.gmail.com with UTF8SMTPSA id 68-20020a621647000000b004fa763ef1easm19547512pfw.125.2022.04.06.09.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:50:39 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 7/8] dt-bindings: iio: sx9360: Add precharge resistor setting
Date:   Wed,  6 Apr 2022 09:50:10 -0700
Message-Id: <20220406165011.10202-8-gwendal@chromium.org>
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

Allow configure the resistance used during precharge.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v3:
- Fix maximum field. Check make dt_binding_check passes.

Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix property with kOhms.

 .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
index 63e1a1fd00d4c..20c2759ced436 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -61,6 +61,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-ohms:
+    default: 0
+    description:
+      Pre-charge input resistance in Ohm.
+      Rounded down to a 2000 Ohm multiple.
+    minimum: 0
+    maximum: 30000
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
2.35.1.1094.g7c7d902a7c-goog


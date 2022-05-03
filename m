Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF42518D41
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbiECTnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbiECTnP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 15:43:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF12E081
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 12:39:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p6so16228007pjm.1
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb09R8V6T/hLKKorfQqqI/dYQ92aTPVCxYGvivN1WrQ=;
        b=nTnedbqZxvH3D4aoZhb8M4LN7yGE7oQAKVek4oFDpicjTEEuiiy1QnCB4CMj2ITh3r
         E35d1+bmNmbhlwRH6UBciyjGg3S/PzaInsbNHCmaq4LEz3tuoY082AAiyFKfvrkwXBeo
         JfIuom64Lrfu2J6c+jqE1UOZTnEjASjIOGqjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb09R8V6T/hLKKorfQqqI/dYQ92aTPVCxYGvivN1WrQ=;
        b=euiv/lSRZha4ZHII857to27zKMLFguPYYV0WaytOc2w4A9HuBJhNeOrYFXf9mI8Zig
         lSseBX/3TILrZRffohcQ1SOI6RP+cm7imbC0dkzwMuP81PD5T4WnjOjpT5YKtj37z88d
         hSvNCrfgYGdHEmXYaDZlJbespQBGnJNKDwtq5Ssp2G/0WNWd73pjF858Q0IvWO/mcS/n
         UBwsP4c8B3ma9NhYhdhbbWs23CIW0hTlcOOl8Cm282Y41G6OWy7wLdmPk1b9WWudnbpy
         3msmmZcHzf3psjACPPPxBp2Axqp0xbyuezMzkuerpKnvr+lIdhnVrZaQbwanOyiTrtfV
         yKNA==
X-Gm-Message-State: AOAM530/uHnTkQBgMf5F5ZHdhZwh/rlmlr+2Loek3HpH6QTfSL1dEfVR
        q6uUjAVSCQqu5Yy/pWa0dg34RtoUNc2Few==
X-Google-Smtp-Source: ABdhPJzTCzLG6PohQNnCIuBLy07mZZOZm1WT+JhkbF402wdu6mru5FQFvmPnqMVpAfcfohVdTAjmFQ==
X-Received: by 2002:a17:90b:4c09:b0:1dc:6c30:f230 with SMTP id na9-20020a17090b4c0900b001dc6c30f230mr6442474pjb.110.1651606781671;
        Tue, 03 May 2022 12:39:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15e:c760:9a04:7fbe])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b0050dc7628154sm6680804pfd.46.2022.05.03.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:39:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Date:   Tue,  3 May 2022 12:39:36 -0700
Message-Id: <20220503193937.3794477-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220503193937.3794477-1-swboyd@chromium.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to configure the sleep and idle mode of the CS pins for this
device. Add a DT property to do this so pins are in a proper state
during sleep (either hi-z, grounded, or pulled up to vdd).

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index d265eb5258c8..b3aa2ebf9661 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -126,6 +126,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,cs-idle-sleep:
+    description:
+      State of CS pins during sleep mode and idle time.
+    enum:
+      - hi-z
+      - gnd
+      - vdd
+
   semtech,int-comp-resistor:
     description:
       Internal resistor setting for compensation.
@@ -187,5 +195,6 @@ examples:
         semtech,avg-pos-strength = <64>;
         semtech,int-comp-resistor = "lowest";
         semtech,input-precharge-resistor-ohms = <2000>;
+        semtech,cs-idle-sleep = "gnd";
       };
     };
-- 
https://chromeos.dev


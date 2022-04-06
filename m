Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7247E4F6913
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbiDFSNb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiDFSNK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 14:13:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2D13366A
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 09:50:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z16so2997204pfh.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdvKq2bscTZt/VsXb1uunFIxTYvgH9XB58umwCf0yGg=;
        b=Pp/FPeYEqE+g40Rj8Vhn3PoKm2vryAt+M56GT2dHwPoyHHFJ+f0Zlwg4BqnfrF5jr7
         259EwePTCaB2ZJel1eCL1qe6pjf5HA46zSYF1fbMxMXJrITsitLThA1bFKf/XXtam1ek
         1+AvecIPIyOxW81SvM0Nw3WEYEOECnRFr16bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdvKq2bscTZt/VsXb1uunFIxTYvgH9XB58umwCf0yGg=;
        b=PX6+XFoNf85TMio+bWpO5P0xtb6oTxWCoLa9uyHXX2uFJOuNspU2giaUPk3ftL5XM3
         mmScZ6BKFU4YesBVGzi8V3tzLqvYZa3oAUSEhku+Ur7h4VsN2yfhB8QLMSZa3+jQEopA
         bJtIJlD+jEI8hNWP7k7XLQmp3CHXWZyPOqksWsTcphQTAtd3YjFjd/35e6VPRz9cqrnR
         RD1CL5yvVRl0iQBy2rNbPfFefw+fHomk+f4cRfs15rC9YYdWrhmaBI4W2qBOEAAsr4kw
         GKCxApMsRrLIuj810QLZaCVhMkKiv0xMIP+mzfPgDI+S46U4PPN+NymEuuhj26jlMrLA
         FiqA==
X-Gm-Message-State: AOAM531E+gGf1IHr7VPJJqHWQSj3+ujacwazvEqA6XvJMlTjlZOotF49
        1Slq8bgtTcgZNgs0SMUb2ESR4Q==
X-Google-Smtp-Source: ABdhPJw9n47rUsn59e8ap37YHUSGCW8Y62MEhOpU+JsO6DxlGg1HjTG0r4Ej5JPzXtgmrK8QrbxXmg==
X-Received: by 2002:a05:6a00:134d:b0:4fb:1307:cef3 with SMTP id k13-20020a056a00134d00b004fb1307cef3mr10000560pfu.79.1649263834079;
        Wed, 06 Apr 2022 09:50:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9d3:469f:91e4:c022])
        by smtp.gmail.com with UTF8SMTPSA id x123-20020a623181000000b004fdf99d25f6sm12463906pfx.80.2022.04.06.09.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:50:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/8] dt-bindings: iio: sx9324: Add precharge resistor setting
Date:   Wed,  6 Apr 2022 09:50:06 -0700
Message-Id: <20220406165011.10202-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220406165011.10202-1-gwendal@chromium.org>
References: <20220406165011.10202-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v3:
- Added Review tags.

Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix field with kOhms unit.

 .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index b8a6ee16854ff..a22cad1507b6b 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -126,6 +126,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-ohms:
+    default: 4000
+    description:
+      Pre-charge input resistance in Ohm.
+      Rounded down to a 2000 Ohm multiple.
+    minimum: 0
+    maximum: 30000
+
 required:
   - compatible
   - reg
@@ -157,5 +165,6 @@ examples:
         semtech,ph01-proxraw-strength = <2>;
         semtech,ph23-proxraw-strength = <2>;
         semtech,avg-pos-strength = <64>;
+        semtech,input-precharge-resistor-ohms = <2000>;
       };
     };
-- 
2.35.1.1094.g7c7d902a7c-goog


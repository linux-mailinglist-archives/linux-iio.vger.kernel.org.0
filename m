Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A445F625D4A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 15:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiKKOkD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 09:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiKKOjs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 09:39:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A765874
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:39:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so12993589ejc.7
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUDZC72vgUX/+mjOceon1Lp8omkXG06DLgI5cBosnQ=;
        b=iFvwZclfbIiKwXP++pqGCXBltsjAlYxG6Eg2T2fA6LMnFCV5dUD1qVPwaeCSWErf33
         ekEzJFjqde0fdpIQCgmDy2gvE8PG82AcoO12V0spWo0LUtjPIH7vdyx9dsRZoPmkZNYf
         604eIeEENYz2NPWEJYYEBCQKKihY8U4xDLRDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nUDZC72vgUX/+mjOceon1Lp8omkXG06DLgI5cBosnQ=;
        b=7mMlr/4WaoGNidlvNkt5PV7E2yICDTxZgby6oe46VUz/aejwIhEcmQSfw0PJkfcWdZ
         KSX+BNYTkaRUw1FW+GodlPXuv8vHbpxIw3beG4EKDAGOt+JPwSYFwYxJYRWPbvPsYz23
         WD+TeZ9aY+7ben8GjjPrl4lg1sp/Z4FQJoXltjOUUmfQvv9VuuFgATbyAieI02/KPNYH
         Z9NrS0NCrjehNKxzGljnoWFTss40HbgJR+dH2a0ZJ4EypSDT7b3dR8UGbTHxAAaMMm3o
         ZH5iiXNG+wcZoW32TNfZchQUkPjunIDoO4SVtmt7dibHZTbe9Id5IOKyXO59v28MiP/t
         jtPg==
X-Gm-Message-State: ANoB5plb4VDg/xibl9PIE/QNEQqt1wT22krWs4vX3/4SQ4e77qX1GEYg
        nVtwq5S0AwoAkIENLvAVCvZa0w==
X-Google-Smtp-Source: AA0mqf5iH//Tm204ldnCOaAvtZbOZb56fKbSpew5u5OxZ4DlhaeYDYvvxEZ6X1G7mx9HpGdqjUNu1A==
X-Received: by 2002:a17:906:3d52:b0:7ae:44b2:cb7f with SMTP id q18-20020a1709063d5200b007ae44b2cb7fmr1982156ejf.437.1668177568980;
        Fri, 11 Nov 2022 06:39:28 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:28 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: iio: ad74413r: add optional reset-gpios
Date:   Fri, 11 Nov 2022 15:39:20 +0100
Message-Id: <20221111143921.742194-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ad74412 and ad74413 devices have an active-low reset pin. Add a
binding allowing one to specify a gpio tied to that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index e954d5ae4f4f..70f82cc716ae 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -51,6 +51,9 @@ properties:
       Shunt (sense) resistor value in micro-Ohms.
     default: 100000000
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.37.2


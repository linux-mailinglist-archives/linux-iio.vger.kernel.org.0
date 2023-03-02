Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4FA6A83CB
	for <lists+linux-iio@lfdr.de>; Thu,  2 Mar 2023 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCBNtk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Mar 2023 08:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCBNta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2023 08:49:30 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB6166D5
        for <linux-iio@vger.kernel.org>; Thu,  2 Mar 2023 05:49:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j17so17622170ljq.11
        for <linux-iio@vger.kernel.org>; Thu, 02 Mar 2023 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFDandIs/wWW0RZ0s4trhSYP6hO5Cu+0LMuOOdJjn54=;
        b=fXbfjLWD5wow0IgUIsNvtmgvsgvdaB+VuwBS8lvjPc9Lx2VeB4mNsRb9vqa/bnJYay
         SbpWcIAMNi27+vEfM8hjGIha5uuKybpDkJyt5r8v06Oj6Xa0HVL/2JuQ60O7B1bcSc5f
         cplg3BMrFPEGJ7q+C70RFKNoVB0FgDZUn99JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFDandIs/wWW0RZ0s4trhSYP6hO5Cu+0LMuOOdJjn54=;
        b=c+pvyjYPt7LaXs3cxNmpQwkHWgOYK+2siPLjiUg6tlY8hVWnnkfJLhDqTKrW/x2wzU
         qEqnT8DhHUXx6ikg0bHjVttclgkuJ4zPGNZ8/R2E++61Ma81cMHOHDbXxSF8ceIAO9mm
         MNbuszoA2BeGTkOkLt9YOs2dUx7RNml7f7b3VFVJ8F4nLnw7wjS9d9I0fVYnfHObuEnb
         Q4Ju49hyJdRABB9zVG9n7rLVGNycov6XgeH0UNARSuWAWrF3Q0hw+nh0W7sYSksNQ94O
         5d/G6OLgCstIZSCa6ypzRnzryl+BZks4bXie9qHbXT2YlCuHacZg6FxgFkCl0yT2qXct
         ejTQ==
X-Gm-Message-State: AO0yUKULXfqoOXaI+qwZQI3j989IC65LjHsWs6bO3q3fWipTXVlyCCmM
        U7cJE8WB2aIdT63sZ5NockfYDw==
X-Google-Smtp-Source: AK7set+rPBpimAvdVXmPhPHeTOmkunGsxjRFqhQJkRhWtDUaTFnVVjkkOLQHCXKF7WgltoOLCkJf3Q==
X-Received: by 2002:a2e:90d6:0:b0:295:c333:2a24 with SMTP id o22-20020a2e90d6000000b00295c3332a24mr3176109ljg.19.1677764965697;
        Thu, 02 Mar 2023 05:49:25 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25ff0000000b004cb3e97bff8sm2139088lfg.284.2023.03.02.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:49:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: ad74413r: allow setting sink current for digital input
Date:   Thu,  2 Mar 2023 14:49:20 +0100
Message-Id: <20230302134922.1120217-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Depending on the actual hardware wired up to a digital input channel,
it may be necessary to configure the ad74413r to sink a small
current. For example, in the case of a simple mechanical switch, the
charge on the external 68 nF capacitor (cf. the data sheet's Figure
34) will keep the channel as reading high even after the switch is
turned off again.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../devicetree/bindings/iio/addac/adi,ad74413r.yaml    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 9eb3ecc8bbc8..fcae300182f7 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -101,6 +101,16 @@ patternProperties:
           When not configured as a comparator, the GPO will be treated as an
           output-only GPIO.
 
+      drive-strength-microamp:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          For channels configured as digital input, this configures the sink
+          current.
+        minimum: 0
+        maximum: 1800
+        default: 0
+        multipleOf: 120
+
     required:
       - reg
 
-- 
2.37.2


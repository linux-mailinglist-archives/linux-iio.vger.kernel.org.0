Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6827625D42
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 15:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKKOjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 09:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiKKOji (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 09:39:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05D654DB
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:39:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i10so4339561ejg.6
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lxqynGN1zb3SeT8QyXA1+0ZwfAUv0vy1HULeEAsp+0=;
        b=BY47XsVmK51QERSuv9y2eWZAjkN5DPflYrv9P/kAP1nvo563DsVXnrBG2y65QznhVM
         SJJXYc3oBd5budwHsKVFz1tIAxtTFQHFuRjvG2Qow3zmfnhU4p6vdjvcEJwBKzhZFQac
         supnDkrsavwNMIaDcwLsbcfXTXa6D3sSBou3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lxqynGN1zb3SeT8QyXA1+0ZwfAUv0vy1HULeEAsp+0=;
        b=znXTw4Ntd9Xaocte5qIT/H83q9yob46f9UcJ+MnKk79zWq/kE2zshhT958+4IVvf6F
         GPqZ5NYuMcHjlYnPc0H/B9xF0FSfJGCEVAL9Y/kj/4vIXEhnqUPiZ1DNRfwzyXCOKPiL
         SaPQ0TC+2ig5GaWuPMH2CUQTKHTcWFCV3kjQySNPHdZQqLvZ3OEkV6XHmEdbdPzSpQfz
         NapoYAbWC6ljqbBjp4GnxuwedmUdOIwRJy6MaOqcvOPULRsgYMI3Fd/p7TPq1wn8eG7s
         /xlys7i8xjJohbXQJ+LgInf+F+fk3MNEv7z0JSzAscHn3KSTB16ajcpDqAbee1eB48wj
         LTrQ==
X-Gm-Message-State: ANoB5pnUEWTDtwrBNctFeDefZgNT+HkTTwZRcNFqbfiKC3c5sOY8QOjj
        3KSVyxepaHbCE7SO+xW38kcvMg==
X-Google-Smtp-Source: AA0mqf4T+udwGoWTudovo/FSHJ7IAR9wOH9fTJtKpCchExVGoh2RGDgoSsgTqibYqqdzi4ULw93B0w==
X-Received: by 2002:a17:906:8cf:b0:7ae:59dd:e3f4 with SMTP id o15-20020a17090608cf00b007ae59dde3f4mr2017438eje.755.1668177567004;
        Fri, 11 Nov 2022 06:39:27 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:26 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: iio: ad74413r: make refin-supply optional
Date:   Fri, 11 Nov 2022 15:39:18 +0100
Message-Id: <20221111143921.742194-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
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

The ad74412r/ad74413r has an internal 2.5V reference output, which (by
tying the REFOUT pin to the REFIN pin) can be used in lieu of an
external 2.5V input reference. So stop marking refin-supply as
required.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 03bb90a7f4f8..e954d5ae4f4f 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -56,7 +56,6 @@ required:
   - reg
   - spi-max-frequency
   - spi-cpol
-  - refin-supply
 
 additionalProperties: false
 
-- 
2.37.2


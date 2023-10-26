Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB867D7E8A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 10:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJZId2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Oct 2023 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZId2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2023 04:33:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07367129;
        Thu, 26 Oct 2023 01:33:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b92b852390so335125a12.2;
        Thu, 26 Oct 2023 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698309205; x=1698914005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0rAQQMv1ZezqzCyridF6wP4Hk8j91NSdkTPCmyPZUck=;
        b=mpuFgqrtkuT98lFKqukKjlm4uQCAqjrNSI9YbqC0WO0NZ9Wz+uTvoPSeGX2sRxy9ws
         O3qrX7i7ZpSmqX3iHCyvsjE/HueD0DFGkKWtHvdSFdmsQlqvERDaBZE9H7XWkv16r1+P
         kPmS08UW8rTuCxocwzFiLpJkxgNsymzMAcpMFx+4/dwlWIYGNlr6vkuoKDkR779lst0n
         LSvcbBCSu9cJDTVsl4/C5o8VS8ZwLal1fX+kN4JBe1IU310bYOyF4lG2bhPY8GOU/xVt
         LHWvlpluK/9WzE8H8nDkQ2ysBlBBMuaaljpQBTyk//qvxVlMYyPcQCKuYRKtOTr13KTB
         RX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698309205; x=1698914005;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rAQQMv1ZezqzCyridF6wP4Hk8j91NSdkTPCmyPZUck=;
        b=aqo1QIpbMWFxAEi667PjZu2Acqhho6zAtpnWeeG3qWsDpfjEiXeyBFqNGxGygHwVsT
         29NGD9TWQiqjyqlkUvFGmbnTTNMB5dgZ68D3RGzDxZGg3bvg7gEM0aRHL7A4CFUYj34F
         Yx/WNlr2cMtxN9nf5K1+ZuUZwui2zYQzG7QjOZ+Hlel/8sPnSKi2W7HZMKRsxDwOZhlB
         EeUvO/F88FCfFEa9NFuDQr7LdUi+2zEgDBf0CXs5oS4oVJ/+cxInwTXqovS0ZXFnfWAt
         2cznMHr5fHoWif20UUHwib0Sf0xM1STUPtS3/CYMC0Jvus13jD3EnVvVxEZFIxtexh3T
         tuSg==
X-Gm-Message-State: AOJu0YzMNSeHEaPEg9PqeksyXLCxShtH8rBizhiidGZxqD1o70eMLgY3
        XqPDDRiA51qpnm1RGm7aSA4Wu1Gxnl0+DRJZGjGl5+CwWsk=
X-Google-Smtp-Source: AGHT+IHvQxMAWX/Z4H95EPaFqPcP0wO8CcaB+algzWFJoGOaHbQ8N+r8aNPd2I95+/b6+yLyCuDb0riOpy/pSRxsgdU=
X-Received: by 2002:a17:90b:1204:b0:27c:eb59:e9c7 with SMTP id
 gl4-20020a17090b120400b0027ceb59e9c7mr17400460pjb.36.1698309205459; Thu, 26
 Oct 2023 01:33:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Oct 2023 01:33:25 -0700
From:   Amit Dhingra <mechanicalamit@gmail.com>
MIME-Version: 1.0
Date:   Thu, 26 Oct 2023 01:33:25 -0700
Message-ID: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
Subject: [PATCH] MAINTAINERS: correct file entry IIO LIGHT SENSOR
 GAIN-TIME_SCALE HELPERS
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers"),
updates the MAINTAINERS file. However the files listed do not exist.
These presumably come from commit 38416c28e168 ("iio: light: Add
gain-time-scale helpers")

Fix the entries.

Found by ./scripts/get_maintainer.pl --self-test=patterns

Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a493d96ffd85..6dd44ec48886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10287,8 +10287,8 @@ IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	drivers/iio/light/gain-time-scale-helper.c
-F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/industrialio-gts-helper.c
+F:	include/linux/iio/iio-gts-helper.h

 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
-- 
2.42.0

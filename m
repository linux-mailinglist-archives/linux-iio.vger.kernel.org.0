Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D047D8196
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjJZLNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Oct 2023 07:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLNr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2023 07:13:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688B9D;
        Thu, 26 Oct 2023 04:13:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27dc1e4d8b6so628480a91.0;
        Thu, 26 Oct 2023 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698318825; x=1698923625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZFon3MaibAevtN9zdhx0zxMOp24hQ9jO8ot1zqWQZ0=;
        b=Qz/PjCbLe5itd1j9NspgIoEpRTecZNhRK2B7arnpfO5iPOMKo5i6dIW9FPyAxCTtn0
         4iDG/4sajfjWyqgrnzx40aOIwIT8cxvWgR1jBu1610unp/FQCyCNu7TnkulvJLiOXIrK
         XirsBIG24H4B3h6ePCiPNexDgnYQ7VxSHQ3ubxvUPops7gG5vSozxgpyWSNbVT38DoiV
         vxysoMRpw7FSOrvj9HXdqPF+Fv9rRMeIf8S7TiuNP3SR8YWejcyZjOhiL2z6JIEIgz25
         bRUbPo01iZB+h4UyThB2xQfvrKs1+5VsdjEHf/rej58k3INP812tuFIHdDXB7rIatkMJ
         Q4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318825; x=1698923625;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZFon3MaibAevtN9zdhx0zxMOp24hQ9jO8ot1zqWQZ0=;
        b=HlKQWV2GPicEJ/oqEs/amK1Ny7Yh+gNahmNp+7mOlGFXo+GdPvTNO7Z+DOc+kBwySQ
         18oelyqduU5UPzp0/bUL4kt6TwseFaKbHHJahqwjquor9i2coSoolp7AbGX6i325cH4X
         RxUdeSlzUcfy0d58yc/rnVn4QdIxawdD9Sco5NKKoIid3uTOXViMjYv+4CU7bZvSqMXX
         VTQ8wjCrNojBmNtxgPwegr455/jkITXp6n6kuj6/Kdvfv/ajQT7W7BsM/vJMRSUelo5H
         sL3N3R1M4yejUYvLeKZWFiH50Y+FgFin7X9kHTylSmm+Jx0V6tj+Q97VRJQ8dN+zbPo0
         HsrA==
X-Gm-Message-State: AOJu0Yw8xPMfUB3M1OWTLg0ob5/zpvtPAFGsWWrnXz6UxMgt+cKs9Ybu
        XZRBjHS5fr4RWvwXhVhyu1VsshlRAv3zAOqzez0=
X-Google-Smtp-Source: AGHT+IFGj7m0laBf1IV+kcmIE6Q7YsmNBrpdVs5WJtRU6dvpXZecP8JKujp4hO6bRcP7p6kybCPuCT8LOYviQcu8Sdg=
X-Received: by 2002:a17:90a:34ca:b0:273:4944:2eba with SMTP id
 m10-20020a17090a34ca00b0027349442ebamr17458214pjf.40.1698318825396; Thu, 26
 Oct 2023 04:13:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Oct 2023 04:13:44 -0700
From:   Amit Dhingra <mechanicalamit@gmail.com>
References: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
 <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com> <e806f42f-9baa-4689-882a-144647cc03a3@gmail.com>
 <CAO=gReECvyMDe5kbSeFQ3rAc1n6e2vkcE2mtMYUE3c45QMvW-A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAO=gReECvyMDe5kbSeFQ3rAc1n6e2vkcE2mtMYUE3c45QMvW-A@mail.gmail.com>
Date:   Thu, 26 Oct 2023 04:13:44 -0700
Message-ID: <CAO=gReFVhp7QK_XZRBO5vbv6fmFb4BdsZeQPSzWvuiz9UeQekA@mail.gmail.com>
Subject: [PATCH v3] MAINTAINERS: correct file entry IIO LIGHT SENSOR
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

Fixes: ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers")
Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 668d1e24452d..99c2285c58e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10177,8 +10177,8 @@ IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
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

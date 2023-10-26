Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE17D806D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjJZKPS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Oct 2023 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJZKPR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2023 06:15:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE51AD;
        Thu, 26 Oct 2023 03:15:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so670574b3a.1;
        Thu, 26 Oct 2023 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698315314; x=1698920114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyDPyIOy3XGS88UTNLJJ1fkRqGcbB4V7iUeidXioJIs=;
        b=guKqWrB2KLSZn9bDyKr7422ZnfRDpzZvUDsmNyQaYma9Rp7LXkgsiZLRNmC18T2UOQ
         emrTihRRG6TM2vnD67P0xHPZYggAKpLBSP1mL9YFrjVJ9RAgaudg3OXDEvP94qbUHsos
         5SM8lcDRuqVe/vTRjkImYL4u9YO1znXqUvktBp+PRlu+8ePxE+1mJB8oZGKWvkvcg6pr
         kUSzTlVzVGupv6skwlunexuh5UcYwkGoggHfqkPChnbecFQHjcy3GEPIOAyGN/4jPyq3
         kbi1ghwcTEYcacmO3GLwbOwGtNV3z7GMNb3r+kzF3v1ExbbPD+oG5V5ED7vP3KgFox/U
         a18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315314; x=1698920114;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyDPyIOy3XGS88UTNLJJ1fkRqGcbB4V7iUeidXioJIs=;
        b=UeYq5AsVau3clibg5h2bHMgAkp61X9ImdVGG89+6JWYrY53BD9z6aC2LShQ/qoiGV2
         bkn3b4K9f3KIt+n/xuTUmq4ZSYKwrFw/s16sd+pTiZ5rq3iv9ZIV+CYXlQyylQ3T1F9t
         PqqIxBZQMdcuAv7sU6JeAxIIZxg+MKfqsIL2Tnk4S7Y/9IWQ24lzOrJgBu8kk17sCe7N
         DTNa2vPn00f5vZ7hUY7RIrR4U8VCJKwfjyVELA/8izpmYjGrI61hCpGnsgCqBUswe4yJ
         toZa2m5CD2hKlImhnlRowc7J9e6ntKobY94emEi8yJxYiGUAKDCmgDT99g5lJAlJ6xT4
         WaYQ==
X-Gm-Message-State: AOJu0Yzeyzm8qJL6oqhpx6Kg5NicsSgWoH3qnNyrbIXvZqiKHpYjht5G
        ttZbM0rYvrVEeC4y/gQqJ0sjg4NdtwEgN+Sx16Q=
X-Google-Smtp-Source: AGHT+IEvmXLZL/xtR66yyrtzsgrGj6la/m8oCdfPB91c59DRAGDeBlWylY+chg+bCKBIBocZbVFU5r0Fk/kq4IX1oaY=
X-Received: by 2002:a05:6a21:7189:b0:15d:8409:8804 with SMTP id
 wq9-20020a056a21718900b0015d84098804mr7034921pzb.57.1698315314297; Thu, 26
 Oct 2023 03:15:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Oct 2023 03:15:13 -0700
From:   Amit Dhingra <mechanicalamit@gmail.com>
References: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
 <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com> <e806f42f-9baa-4689-882a-144647cc03a3@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e806f42f-9baa-4689-882a-144647cc03a3@gmail.com>
Date:   Thu, 26 Oct 2023 03:15:13 -0700
Message-ID: <CAO=gReECvyMDe5kbSeFQ3rAc1n6e2vkcE2mtMYUE3c45QMvW-A@mail.gmail.com>
Subject: [PATCH v2] MAINTAINERS: correct file entry IIO LIGHT SENSOR
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

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4869B2F9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBQTTm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQTTl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 14:19:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44D4E5C0
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:19:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l11so8587600edb.11
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtTQBO/lEy5P7YLVvevPkTALi7Sc18bUh3l7cYAul08=;
        b=nutpcu7g6CXik/peN0kjDbmiDPr2RMBMIZe628qw9jStMWNvvdcDi3CbwGHnbXPKS8
         Te4YQ9NGBRTfN0zPbRI7+5sH2G/QwWi1ZcjEIcpC+GMyQmzREDHhuFzL8LMsmNChThXT
         AAl1yzO142Y4ccfxzEJnWAqLeDmCKKQ1ZOIWtY0+/qUvCpZ+dHj+JYLXpcfnFOLunF09
         et23FQ2t82Fn6ACunS+cVe/6mNdfLq6RCqoRs+oo8XtlY6Mv56ZJQ9Q36FzCLeFuJP0t
         FDsSzbCskvPAx3Syq3byuliBgvSfsdHdZLu5aAuAn4QfPBMwWtblPbSkh6SSeqlLdfJ3
         qwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtTQBO/lEy5P7YLVvevPkTALi7Sc18bUh3l7cYAul08=;
        b=mRYZkCPYKBRr7yjToK1r9Q7wWAIgaT5Hb2d0kJOSmkaPI9UoFHGPElN4pP5HFy17KT
         iULnX2jrD0s4Edy/XZD8OUEfq6Xesl3v68DufqtCJNTvRwkey/XDSaRtHTxAgx1wJ5Bv
         pZpy+mc65evKEVMelg4PGerQhUjPPSHgip3HprdBuUzxs8gT8qsNrxQvekKRYqDaYgJu
         5qnbyeS1vMXF9ePAwjUhcdd2+Ija1Gm9X5QnJYg/BPnQFuvp4jYKf2cP3yukllSbFQkz
         qJg7oPIDhvPmUYJlTbDp4YAkc56YOFWPCdbmf63MXTVvhwX5eIeXkD6SJr80KKHOSHUM
         cp2g==
X-Gm-Message-State: AO0yUKWng88h5UBlp9xHTEiO8h1tSfZwirCdT8g7kqlh9u4zu/LyBMrc
        nz0DXeWuFhT2n5RrMHJ3iDg=
X-Google-Smtp-Source: AK7set+2QcyQjGOj8bxk196In6gvIBpyRwyADjo+aJVmL0hawEdqTfnyhKHgHzFVJ7CaRDJTD8QL0g==
X-Received: by 2002:a17:906:6d54:b0:8b1:7f87:8174 with SMTP id a20-20020a1709066d5400b008b17f878174mr3958000ejt.65.1676661578930;
        Fri, 17 Feb 2023 11:19:38 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::af9d])
        by smtp.gmail.com with ESMTPSA id h18-20020a17090619d200b008b9d2da5343sm253708ejd.210.2023.02.17.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:19:38 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 0/1] iio: accel: kionix-kx022a: Timestamp minor fix
Date:   Fri, 17 Feb 2023 20:19:20 +0100
Message-Id: <cover.1676661174.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As discussed in [1] here is a patch to get the timestamp in the
trigger handler from the driver's private data 

[1] https://lore.kernel.org/linux-iio/Y+%2FLpcc0Wa2VGsGO@carbian/T/#mec923c14d1324ffabfa88dde225eeb227005b48f

Mehdi Djait (1):
  iio: accel: kionix-kx022a: Get the timestamp from the driver's private
    data in the trigger_handler

 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.2


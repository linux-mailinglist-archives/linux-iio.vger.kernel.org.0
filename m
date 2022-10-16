Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AA600210
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJPRKb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJPRKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 13:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4A10FC7
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 10:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B7CBB80D2B
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 17:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DDCC433D7;
        Sun, 16 Oct 2022 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665940168;
        bh=Fz75YTOMmwiCYQOS4LbO75iZ8wC5dP72cwi1ZTjmTSc=;
        h=From:To:Cc:Subject:Date:From;
        b=D5DXl/6708gwJtaqg/mv/MweAZipGKLApxRRTEVBVxnrWDeLCKSIMIbSo46XRewZP
         GffRsA0SWDMEkm4REnp0KhQNOOXJN0S+qQjbYHr6Kbao6Es4QbRPIykrt1muNV/Mor
         LPQAxLenXjsrOWNybapIjDSHjORiKJ/6P+ngnT6XqaQ02b9jlo0D62eJ8YLqDegKDC
         iW5v7/jnVe0+ln6hWfPcjLeyBRfelYIofaBcKZkGSHjMn64GzmhWbErMN5YFqAC/PI
         whMkegcpp8X0xmGXe6IupN+Fx7IuqVEJndE3eS0gnZYGApowW1QSgSf1mFxm5Bg6Fs
         WXm7sBi1V6sCg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phani Movva <Phani.Movva@imgtec.com>,
        Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: [PATCH 0/5] iio: adc: cc10001: Devm conversion
Date:   Sun, 16 Oct 2022 18:09:45 +0100
Message-Id: <20221016170950.387751-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A very simple example of how using devm_ managed calls for everything
can reduce complexity error handling and removal ordering in a driver.

Note I don't have one of these to test so if anyone has a chance to do
so or give these a quick look at that would be much appreciated.
Note this is a fairly old driver, so relative unlikely original authors
still have access.

Cc: Phani Movva <Phani.Movva@imgtec.com>
Cc: Naidu Tellapati <naidu.tellapati@imgtec.com>

Jonathan Cameron (5):
  iio: adc: cc10001: Add local struct device *dev variable to avoid
    repitition
  iio: adc: cc10001: Add devm_add_action_or_reset() to disable
    regulator.
  iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
  iio: adc: cc10001: Use devm_ to call device power down.
  iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ forms.

 drivers/iio/adc/cc10001_adc.c | 89 +++++++++++++----------------------
 1 file changed, 34 insertions(+), 55 deletions(-)

-- 
2.37.2


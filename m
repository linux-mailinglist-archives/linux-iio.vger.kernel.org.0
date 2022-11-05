Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF461DA77
	for <lists+linux-iio@lfdr.de>; Sat,  5 Nov 2022 13:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKEMvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Nov 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMvX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2022 08:51:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46E26130
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 05:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 331D7B80B64
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 12:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25058C433D6;
        Sat,  5 Nov 2022 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667652679;
        bh=Ed1uVF0foRnsII5hW95mdFur0KrIkcTLvmc8JFsOwvE=;
        h=From:To:Cc:Subject:Date:From;
        b=TvgJnpxoTccEiVIJmLZuySjPUp0RFyQH6OMy5j9Zc+5cIO57Q2ePAJHll+ur6R3du
         412wQa41q7MwJr2RF1Ph629qIgSTOW3iDSIQm1sDOCoQagYNN7+FmaOMOQAK5GGair
         NzYpyyylrcZKCOze2M9XrQJgZLT5rf3y3cWiyRSEAgiUgflT6uhpzhUIIKMWMJwDHq
         3UAcvcEotSCo9RcC8E3ZENaRz/JxRrjS/tY+rR+2VGTOwhl5Yq1cruJkIndxio8O79
         xmhL9hGSra48NQ4qxEf9wd4ZBz0CIxYnuBRoZJx3ZONfd4VwozWI1g31i+ZVvjNL9s
         uT5pUdWv05F0w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Cc:     coverity-bot <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] iio: mlx90632: Minor fixes
Date:   Sat,  5 Nov 2022 12:51:06 +0000
Message-Id: <20221105125108.383193-1-jic23@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A couple of minor fixes.  The devm_ error handling was a coverity report.
Static was a warning I'd missed originally but saw in build whilst testing
the above.

Crt, could you give these a quick look (+tag ideally) then I'll get them
on the tree so the issue is fixed in Linux next before I send Greg a pull
request.

Jonathan Cameron (2):
  iio: temperature: mlx90632: Add error handling for
    devm_pm_runtime_enable()
  iio: temperature: mlx90632: Add missing static marking on devm_pm_ops

 drivers/iio/temperature/mlx90632.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.38.1


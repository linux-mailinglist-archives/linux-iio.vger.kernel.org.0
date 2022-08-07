Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4620558BC96
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiHGSx6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHGSx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:53:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D06381
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4D9FB80DCF
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7EFC433D6;
        Sun,  7 Aug 2022 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659898434;
        bh=z+WiK8o4dSR9LF98NSaGNCOBWQU7HkFw0it16Aw1w+I=;
        h=From:To:Cc:Subject:Date:From;
        b=n/yC6Ndj1NfoTV3eOUB7P+BbHdz34Vr9uEUrec0qVCS8vuW3/c/IS13nHAu6BxPtD
         P0IQvi1d3KGz8fqSD9UdRT0WWQu/KWUHNmCFQVAirTjbD/mahLwz2u3hAvysn4oxJV
         Ud1arTQul3McZys/HHJvn6RZqdnYzffHQNoEkFoN9pkljg3q85rjFOWXeFiBF3YFiD
         k7dy413XRz49fQ5EqAjMabAR7mYHvqnMqooESUIcBfuNUXRWWlV7ugC6Yp7CseYld1
         voTqmOaVNpo18jxQL7TuXpk0wCN/6J8YrZ5kub2SSkuRxQSp8XWQXtlJZcXo8m9Ggu
         YIyLN9WSz8kmg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] iio: Convert some drivers from deprecated UNIVERSAL_DEV_PM_OPS()
Date:   Sun,  7 Aug 2022 20:04:12 +0100
Message-Id: <20220807190414.1039028-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

During discussions of the new PM macro definitions, it because clear that
UNIVERSAL_DEV_PM_OPS() generally doesn't make much sense as it can lead
to unnecessary work.

For the drivers in this set I've taken a look at how the ops are used
and believe we can just switch to DEFINE_RUNTIME_PM_OPS() which will only
do the suspend if the device is not already runtime suspended.

I'd like some review of these (more than for the straight forward NOP conversions).

Thanks,

Jonathan


Jonathan Cameron (2):
  iio: pressure: icp10100: Switch from UNIVERSAL to
    DEFINE_RUNTIME_DEV_PM_OPS().
  iio: temp: mlx90632: Switch form UNVIVERSAL to
    DEFINE_RUNTIME_DEV_PM_OPS()

 drivers/iio/pressure/icp10100.c    | 10 +++++-----
 drivers/iio/temperature/mlx90632.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.37.1


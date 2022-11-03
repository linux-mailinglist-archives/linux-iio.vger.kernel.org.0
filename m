Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED61618A9B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Nov 2022 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCVe1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Nov 2022 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCVe0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2022 17:34:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66C18360
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 14:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BC861FE8
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 21:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA8C433C1
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667511264;
        bh=wnG2kgtlQtFi5D2/X0w7SbHgkD/ww2jUHHJkQJCOJJw=;
        h=Date:From:To:Subject:From;
        b=g2M02v9PoY+PNdxtnHnlrWlzDvm56kjLOkSrOGjxOovT7ggVRL/0Qd/U1XnkbnKIT
         PrmUwlWvjVsE9iwdvDZq3qA9RhrYSuLVWm4PjY34fCmKXcofve6JEXoced/YbUvrEH
         QRhMmgD0jmMw6Q517M+b2Skq5++/ayzW8XS/ce9G9WR/ipUT0MASuAeFm42abL4dP8
         VJmatAsMHa7/TV+Dd2kVHrKIvo2+bMRLuGKsuw6g/thUtWOgaSMkpWnmmjAQIrwJ50
         JxoujkLE6bqvxRjlNyfTGdF3sZBib2jFjS3ooRLa7UuMRvgYpPGjYR9VcPrPENS6Qb
         eWgUre/xXgbLg==
Date:   Thu, 3 Nov 2022 21:46:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: iio: rebased the togreg tree.
Message-ID: <20221103214625.2ae85190@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I hadn't been paying close enough attention to dependencies that were building
up between changes in the fixes-togreg branch / upstream and a few
patches I was carrying on the togreg tree (specifically around ms5611 and bma400
and the regulator and devm changes).

As such I decided to rebase to drop some of the problem patches for now.
Given the pain such a rebase will cause anyone using the togreg tree is pretty
much the same, whatever I rebase it on, I've moved the whole thing forward to
v6.1-rc3 on basis that includes fixes that are dependencies of some other
patches on this list and will make merging them easier.

I normally try to avoid a rebase that isn't a fast forward of the tree,
but meh, sometimes it's not worth the pain.

Jonathan

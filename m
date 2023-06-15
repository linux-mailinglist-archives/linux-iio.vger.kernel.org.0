Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFCB731600
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jun 2023 13:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFOLCO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jun 2023 07:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFOLCN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jun 2023 07:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C63F199D
        for <linux-iio@vger.kernel.org>; Thu, 15 Jun 2023 04:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375B2629DD
        for <linux-iio@vger.kernel.org>; Thu, 15 Jun 2023 11:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D92C433C0;
        Thu, 15 Jun 2023 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686826931;
        bh=OHpe9YzuObS4ivFCDM2qy6d4BdLcwnvO8TItlvGBQ/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/LftE/xbv0t8HlZJ6jYlGEpVxV/xeCFsoDHjDcbPwYF5PSQXCdcRFvlKEV9RSao3
         8tu55QiWkHc6kjNInctC+SmYFXl5+AOuoN9REk+qG7hVjkVQhnDQ0i17K41lB2rPlI
         /H3UsQlWjYaYdzPiakfZA3oaG+9YFuNrmWJgu+Jk=
Date:   Thu, 15 Jun 2023 13:01:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for 6.4 (probably for 6.5 merge
 window given timing)
Message-ID: <2023061525-factsheet-opposing-4dea@gregkh>
References: <20230611173351.5b8c19eb@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611173351.5b8c19eb@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 11, 2023 at 05:33:51PM +0100, Jonathan Cameron wrote:
> The following changes since commit 48e156023059e57a8fc68b498439832f7600ffff:
> 
>   test_firmware: fix the memory leak of the allocated firmware buffer (2023-05-31 20:31:07 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.4b
> 
> for you to fetch changes up to c57fa0037024c92c2ca34243e79e857da5d2c0a9:
> 
>   meson saradc: fix clock divider mask length (2023-06-10 18:57:51 +0100)
> 
> ----------------------------------------------------------------
> 2nd set of IIO fixes for the 6.4 cycle.
> 
> Given how late this pull request is, I'm expecting these to get queued
> up for the 6.5 merge window.

Now queued up for 6.5-rc1, thanks.

greg k-h

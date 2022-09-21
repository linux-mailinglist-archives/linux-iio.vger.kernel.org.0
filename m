Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F45BFEEC
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiIUN0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiIUN0W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 09:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA90915C9
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 06:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9054D62B84
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 13:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA5C433D6;
        Wed, 21 Sep 2022 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663766780;
        bh=4E09QZSMx/7gmRFKwUnjkowcOZndZZ8a0tQ0CJtpFNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hixZS/K0L+PoZFVMLVx66p8BLc9pssXJR5N8aRmXQNQxXj4/EEok/dqe0bSsPHyJu
         0422XqTrDSthi0z9+BgFpWsGgv+gr2JgaHTQ+9V7GGWwdagKAphfLm7hVr6zaZ48pw
         Yv03pwldqFGjMgnxqh6hBGq9Z06GyyRYQU6mbL08=
Date:   Wed, 21 Sep 2022 15:26:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] counter: First set of Counter fixes for 6.0-rc5
Message-ID: <YysQ+JUP0u3kge53@kroah.com>
References: <YyNWADWgfl1sL10S@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyNWADWgfl1sL10S@ishi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 15, 2022 at 12:42:40PM -0400, William Breathitt Gray wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.0a
> 
> for you to fetch changes up to 8294b04153c33602e9c3dd21ac90c1e99bd0fdaf:
> 
>   counter: Realign counter_comp comment block to 80 characters (2022-09-11 11:45:02 -0400)
> 
> ----------------------------------------------------------------
> counter: First set of Counter fixes for 6.0-rc5
> 
> counter
>  - Realign counter_comp comment block to 80 characters
> 
> 104-quad-8
>  - Fix skipped IRQ lines during events configuration
> 
> ----------------------------------------------------------------
> William Breathitt Gray (2):
>       counter: 104-quad-8: Fix skipped IRQ lines during events configuration
>       counter: Realign counter_comp comment block to 80 characters
> 
>  drivers/counter/104-quad-8.c |  6 +++---
>  include/linux/counter.h      | 40 ++++++++++++++++++++--------------------
>  2 files changed, 23 insertions(+), 23 deletions(-)


You signed this pull request, yet I don't see your key in the kernel.org
pgp repo, and so I get this error when trying to merge:

# gpg: Signature made Thu 15 Sep 2022 06:40:07 PM CEST
# gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856CABE12232B
# gpg: Can't check signature: No public key

Did you use the right key, or is it somewhere else?

thanks,

greg k-h

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1963B143
	for <lists+linux-iio@lfdr.de>; Mon, 28 Nov 2022 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiK1S0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Nov 2022 13:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiK1S0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2022 13:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C08E2A265
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2022 10:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1675161365
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2022 18:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E26C433D6;
        Mon, 28 Nov 2022 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669659529;
        bh=GfTE4AdXtX1QA43ZKIx8yajlPTC42jokaYp5YAsSbbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhcWk/xwsuuE4goK15NssTtmrtFhK/VwPedMuuWtym1IivgR0p9kwO7G8v6uFdyXs
         CTUmuRxe69jD4RWNUqA2hcAoGbSRYPHwCMveKL/M1bYqP9a7VksR+vFaZMrO/bBPcU
         fQk0k1gyhImAgLTdTuC6XToDDI/ZqZjg/JYoKZDI=
Date:   Mon, 28 Nov 2022 19:18:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of Counter fixes for 6.1
Message-ID: <Y4T7hhgWsa43ehnN@kroah.com>
References: <Y4TDkoUSJchHFDLd@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4TDkoUSJchHFDLd@ishi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 28, 2022 at 09:20:02AM -0500, William Breathitt Gray wrote:
> The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:
> 
>   Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.1b
> 
> for you to fetch changes up to fd5ac974fc25feed084c2d1599d0dddb4e0556bc:
> 
>   counter: stm32-lptimer-cnt: fix the check on arr and cmp registers update (2022-11-26 16:49:28 -0500)
> 

It's too late for 6.1-final, so I took this into my 6.2-rc1 merge tree.

thanks,

greg k-h

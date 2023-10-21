Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986627D1DF2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjJUPhF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjJUPhE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 11:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87CF4
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 08:37:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C76C433C7;
        Sat, 21 Oct 2023 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697902621;
        bh=iK5g6jTk8JWx3Vb31syW9gmi1nHhtaCpgH9W/zSSV6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ztywut6Ty+zlsAoQ84NSPJGjYuUAMsccdgKViqYLlpgirtYO5KWgJaG++A71P4lgG
         bKujBifVWxvk/aDKuYAPhT6qLTKs4tgBcQfKflA00rTia0Sl308B3+vRq9NAYFud5j
         2ztFJsf/z2/r3J+s+zNK+a2630tFq4hzVyCMdTtA=
Date:   Sat, 21 Oct 2023 17:36:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 6.6 cycle (probably for 6.7
 merge window given timing)
Message-ID: <2023102131-mocker-unfreeze-e4d6@gregkh>
References: <20231021155727.511a344c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021155727.511a344c@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 21, 2023 at 03:57:27PM +0100, Jonathan Cameron wrote:
> The following changes since commit ffd1f150fffe8a708f6ccd15152791d0e8f812b6:
> 
>   Merge tag 'iio-fixes-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2023-10-06 16:58:28 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.6b
> 
> for you to fetch changes up to bee448390e5166d019e9e037194d487ee94399d9:
> 
>   iio: afe: rescale: Accept only offset channels (2023-10-17 20:25:32 +0100)
> 
> ----------------------------------------------------------------
> 2nd set of IIO fixes for the 6.6 cycle.
> 
> Note, given timing my expectation is these will be queued for the
> 6.7 merge window but they could go quicker if the 6.6 cycle ends up
> being extended.

Let's see how long the cycle takes, I've pulled this into my "to linus"
branch for now, thanks!

greg k-h

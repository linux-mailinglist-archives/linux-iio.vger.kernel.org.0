Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E3682590
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 08:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAaHb4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 02:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaHb4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 02:31:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB52B0B7
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 23:31:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC766140C
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 07:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8A1C433D2;
        Tue, 31 Jan 2023 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675150314;
        bh=QGZo1udlt4LgckxGWigxYth6FMRT84RKl/P/imgMwsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjGNSYhc1ekEavqFat0IBTGyeGMLw41T5mPtxqjRIZCE4gczwxEuGzMaNEw813jEA
         UaH4CmltQKBsnmwpjZJYe/nzhw7SDvi4keYp/bL/2qy0+LYQoo06QBW2x2IIFGKlTQ
         UG6rwnp6cXkp/WHZWEqN+o0GxJS16IKaP1TomRLk=
Date:   Tue, 31 Jan 2023 08:31:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9jD5h64XFknwb8/@kroah.com>
References: <Y9g5MOWkDGZxovjW@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9g5MOWkDGZxovjW@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 30, 2023 at 04:40:00PM -0500, William Breathitt Gray wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.2a
> 
> for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff2c:
> 
>   counter: fix dependency references for config MICROCHIP_TCB_CAPTURE (2023-01-18 09:59:58 -0500)
> 
> ----------------------------------------------------------------
> First set of Counter updates for the 6.2 cycle

You mean 6.3, right?  These aren't bugfixes for 6.2-final from what I
can tell.

> This set of updates consists only of Kconfig cleanup and changes for the
> Counter subsystem. In particular, the Kconfig entries are reorganized to
> to alphabetical order, and dependencies added to restrict building
> certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture) to
> systems that support them.
> 
> Changes
> * counter
>   - Sort the Kconfig entries alphabetically

This isn't needed for 6.2-final at all from waht I can tell.

thanks,

greg k-h

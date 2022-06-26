Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA855B15D
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiFZK5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiFZK5v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 06:57:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D419E00E
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 03:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 454C4B80D77
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 10:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E63C34114;
        Sun, 26 Jun 2022 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656241068;
        bh=nSCYTpB7DMcSyuqtdGS6KMpVW/RieMrVRCYiqK24T2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nuVCbl4Nmm4HWysuSGtmEbg8RjfwwGA7R0APZlpNlMzIHbZTo4gXP9TLF5vEKSjNU
         WQrZr3DWy2ldrEE7lFoNF+8cUN51VtexZcHwCwMhFxjfylKci5jqK/o86NV/KXCQRI
         qIL7cIMfHsZKWrr9skO10mlt7Y8Gz0zHGZKuj2MC+VrUbABUYLkLW5CBo4EgPOBC7x
         ZmoSOFdl/yJNKX3Torz4CEs5WUFDScL90Tj8xUuv0/kJYd8IWn73TMWxxXunJFUKKe
         extKxQR/RZcojsRzoE0NleTiBoCZUdtjtrHK+nYNbh8P1YeCa2iQ6drzsarqKxfcg3
         CtpbkEQS4KT6Q==
Date:   Sun, 26 Jun 2022 12:07:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/17] staging/iio: Clean up AD7746 CDC driver and
 move from staging.
Message-ID: <20220626120716.511158f4@jic23-huawei>
In-Reply-To: <20220622130754.GA3639@axis.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220622130754.GA3639@axis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jun 2022 15:07:54 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Sun, Jun 19, 2022 at 08:58:22PM +0200, Jonathan Cameron wrote:
> > Vincent: I'm getting some instability with roadtest after forwards porting to
> > current mainline. Tests run 'sometimes'.  Other times I get a crash
> > in um_set_signal.  Seems unrelated to the test this series adds.  
> 
> My local work-in-progress version has a lot of changes since the RFC,
> but yes, I'm seeing a splat too (below) if I use the RFC version on
> v5.19-rc3.  The problem goes away if I enable CONFIG_UML_RANDOM=y, as I
> have done in my local branch:

Thanks, that's indeed effective though I guess papering over a real problem.

Works for me though :)

Jonathan

> 
> diff --git a/tools/testing/roadtest/roadtest/tests/base/config b/tools/testing/roadtest/roadtest/tests/base/config
> index c1952d047c8e..74b201c48d42 100644
> --- a/tools/testing/roadtest/roadtest/tests/base/config
> +++ b/tools/testing/roadtest/roadtest/tests/base/config
> @@ -4,6 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_EXPERT=y
>  CONFIG_HOSTFS=y
>  CONFIG_UML_TIME_TRAVEL_SUPPORT=y
> +CONFIG_UML_RANDOM=y
>  CONFIG_NULL_CHAN=y
>  CONFIG_PORT_CHAN=y
>  CONFIG_PTY_CHAN=y
> 
>  [  547.130000][   T21] BUG: failure at arch/um/kernel/time.c:415/time_travel_update_time()!
>  [  547.130000][   T21] Kernel panic - not syncing: BUG!
>  [  547.130000][   T21] CPU: 0 PID: 21 Comm: python3 Not tainted 5.19.0-rc3-00018-gcb2e63986f7f #77
>  [  547.130000][   T21] Stack:
>  [  547.130000][   T21]  605860dd 60290b07 60037130 00000000
>  [  547.130000][   T21]  605860dd 00000000 607a39d0 60426253
>  [  547.130000][   T21]  6064d1a8 00000000 604106ad 60557d16
>  [  547.130000][   T21] Call Trace:
>  [  547.130000][   T21]  [<60290b07>] ? dump_stack_print_info+0xd7/0xf0
>  [  547.130000][   T21]  [<60037130>] ? um_set_signals+0x0/0x50
>  [  547.130000][   T21]  [<60426253>] ? dump_stack_lvl+0x5b/0x7a
>  [  547.130000][   T21]  [<604106ad>] ? _printk+0x0/0x9b
>  [  547.130000][   T21]  [<60025440>] ? time_travel_del_event+0x0/0xc0
>  [  547.130000][   T21]  [<6040b016>] ? panic+0x1a8/0x372
>  [  547.130000][   T21]  [<6040ae6e>] ? panic+0x0/0x372
>  [  547.130000][   T21]  [<604106ad>] ? _printk+0x0/0x9b
>  [  547.130000][   T21]  [<60037130>] ? um_set_signals+0x0/0x50
>  [  547.130000][   T21]  [<60037174>] ? um_set_signals+0x44/0x50
>  [  547.130000][   T21]  [<60025440>] ? time_travel_del_event+0x0/0xc0
>  [  547.130000][   T21]  [<60409c35>] ? time_travel_update_time.cold+0x6c/0x133
>  [  547.130000][   T21]  [<6043b5f0>] ? __schedule+0x780/0x880
>  [  547.130000][   T21]  [<6043ae70>] ? __schedule+0x0/0x880
>  [  547.130000][   T21]  [<600bd220>] ? random_get_entropy_fallback+0x0/0x30
>  [  547.130000][   T21]  [<6003be10>] ? get_fp_registers+0x0/0x80
>  [  547.130000][   T21]  [<600258fd>] ? timer_read+0xbd/0xf0
>  [  547.130000][   T21]  [<60305fb0>] ? mix_pool_bytes+0x0/0x60
>  [  547.130000][   T21]  [<60305fb0>] ? mix_pool_bytes+0x0/0x60
>  [  547.130000][   T21]  [<60430d32>] ? try_to_generate_entropy+0x14d/0x164
>  [  547.130000][   T21]  [<60430f98>] ? entropy_timer+0x0/0x48
>  [  547.130000][   T21]  [<60431049>] ? urandom_read_iter.cold+0xc/0x11
>  [  547.130000][   T21]  [<60176b52>] ? new_sync_read+0xe2/0x150
>  [  547.130000][   T21]  [<60178dc2>] ? vfs_read+0xf2/0x200
>  [  547.130000][   T21]  [<601a51d5>] ? __fdget_pos+0x15/0x60
>  [  547.130000][   T21]  [<601793a1>] ? ksys_read+0x61/0xf0
>  [  547.130000][   T21]  [<600280ca>] ? handle_syscall+0xaa/0xf0
>  [  547.130000][   T21]  [<60039236>] ? userspace+0x346/0x570
>  [  547.130000][   T21]  [<60037130>] ? um_set_signals+0x0/0x50
> 


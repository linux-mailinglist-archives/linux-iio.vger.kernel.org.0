Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF77D1DE8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJUPed (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPec (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 11:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC9F4
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 08:34:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5463C433C7;
        Sat, 21 Oct 2023 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697902470;
        bh=UncLsmIkpzTZYCDxeJsgQju28pweZIn3oi2c0Gt32zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wp/3qS6JGvz3f2XAF64MRZx3ZsgVxrkXfJPFCGXqVkwWGSyY4hLcJPLJhx1aGidNX
         4TBZ0K5/pKWbPBGdDTaURdI5L1sZ01ei/ncd664xWCz9pQdyA9fonwx2OkYojMWPX5
         sbOs2J/3hUzUMCG/hxkLxd31GFtnmn4lSilazVOkHxSbGMLjaIvvlKp/Afo2THHizv
         zDXc3C1S/Jsyi2RRQQdlNG1YmxWuR0LxOK4qKAjVCQvqyLbMI14AupyaLPT9A5iR9P
         9YZHpb56GSftbu4GC7ImWa4Nv0rP69OyYPHKa4ulGVHcHwIqHZEWW54ijthKDwPLZM
         UiGUZzf18rfhA==
Date:   Sat, 21 Oct 2023 16:34:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt@ranostay.sg>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] mailmap: Change email mapping from previous employers
Message-ID: <20231021163425.589f59f0@jic23-huawei>
In-Reply-To: <20231021085250.21431-1-matt@ranostay.sg>
References: <20231021085250.21431-1-matt@ranostay.sg>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Oct 2023 08:53:17 +0000
Matt Ranostay <matt@ranostay.sg> wrote:

> Signed-off-by: Matt Ranostay <matt@ranostay.sg>
Applied to the togreg branch of iio.git, but almost definitely 6.8 material
now due to timing (last pull request for 6.7 from me went out just now)

Jonathan

> ---
>  .mailmap | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 2643b7203a74..f06431ac148e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -381,9 +381,10 @@ Matthias Fuchs <socketcan@esd.eu> <matthias.fuchs@esd.eu>
>  Matthieu Baerts <matttbe@kernel.org> <matthieu.baerts@tessares.net>
>  Matthieu CASTET <castet.matthieu@free.fr>
>  Matti Vaittinen <mazziesaccount@gmail.com> <matti.vaittinen@fi.rohmeurope.com>
> -Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
> -Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedalley.com>
> -Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
> +Matt Ranostay <matt@ranostay.sg> <matt.ranostay@konsulko.com>
> +Matt Ranostay <matt@ranostay.sg> <matt@ranostay.consulting>
> +Matt Ranostay <matt@ranostay.sg> Matthew Ranostay <mranostay@embeddedalley.com>
> +Matt Ranostay <matt@ranostay.sg> <matt.ranostay@intel.com>
>  Matt Redfearn <matt.redfearn@mips.com> <matt.redfearn@imgtec.com>
>  Maulik Shah <quic_mkshah@quicinc.com> <mkshah@codeaurora.org>
>  Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>


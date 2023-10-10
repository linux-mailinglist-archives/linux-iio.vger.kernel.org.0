Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075677C0173
	for <lists+linux-iio@lfdr.de>; Tue, 10 Oct 2023 18:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjJJQTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Oct 2023 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjJJQTS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 12:19:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07899D
        for <linux-iio@vger.kernel.org>; Tue, 10 Oct 2023 09:19:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ABCC433C7;
        Tue, 10 Oct 2023 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954757;
        bh=GjxqpjwchcuUVKMmIq+lPxoh8A/cioZblyS6xHSS1Gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WSLWfEoBnRXLelSNl9kLo+Kv8Qn/UkRLCmcqbgooemBjgdeEwwvxJLRvoWSiYVh9S
         r6H6xoIn5Tu5yt/FV0MT5qtqj4e4USLREeSn3oNJy08FIxmNhxhGnctW3BRsAkBfkQ
         OmZ7HPuVY0geolxuLad3Ad7+b/4EhYHpqz9ijaDwfGwjwvooxgrCNi8Tk/lqJcVzcR
         2Sj+A0bs6mOpqK6p6Vhs7vNF9xlQFZH5+mT2UT2VsKvbl3Zc1kXum9nqLJMnqiKuh2
         1s5038kGI5R6N8QH43DvbmzKpwdCii01oGkd224NEqDKdVZDp8NjFAwlC65KoK9tsm
         H47ul+as0OvQw==
Date:   Tue, 10 Oct 2023 17:19:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Conall O'Griofa <conall.ogriofa@amd.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] Xilinx XADC fixes
Message-ID: <20231010171928.75451192@jic23-huawei>
In-Reply-To: <20230924173210.13f2bf85@jic23-huawei>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
        <bae646e9-7977-4de3-927b-ffcb7a94ac48@amd.com>
        <20230924173210.13f2bf85@jic23-huawei>
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

On Sun, 24 Sep 2023 17:32:10 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 15 Sep 2023 08:52:49 +0200
> Michal Simek <michal.simek@amd.com> wrote:
> 
> > +Conall
> > 
> > On 9/15/23 02:10, Robert Hancock wrote:  
> > > Fixes for a couple of issues in the Xilinx XADC driver: one where
> > > preconfigured temperature/voltage thresholds were being clobbered and
> > > potentially breaking overtemperature shutdown, and another for inaccurate
> > > temperature readings on UltraScale family devices.
> > > 
> > > Changed since v2: Updated to also remove disabling XADC alarm bits.
> > > 
> > > Robert Hancock (2):
> > >    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
> > >      thresholds
> > >    iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale
> > > 
> > >   drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++-------------------
> > >   drivers/iio/adc/xilinx-xadc.h      |  2 ++
> > >   2 files changed, 16 insertions(+), 25 deletions(-)
> > >     
> > 
> > Conall: Please test and review.  
> 
> I'm sitting on this one until I hear back.   No huge rush, but if you
> can estimate when you'll get to this I know to leave you alone until after
> that!

I'll ask one more time, then probably just assume these are fine and apply.

So Conall, have you had a chance to look at these?

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > Thanks,
> > Michal  
> 


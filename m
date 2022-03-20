Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA14E1BCF
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 14:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiCTNQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 09:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiCTNQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 09:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483B3586D
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 06:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2172C610A2
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 13:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CCFC340E9;
        Sun, 20 Mar 2022 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647782098;
        bh=B+JQNGWZsjHcdVYzsssQHMMyqLdRj647LigJ4EivYkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f4zD+bbMOCu/dEz2vg4PGQi5CQZgmY/AAqneyQsbsc6fDp5w89P3Qc/VY4NrbqWxl
         33YL6T6eH1ywGw0//6vLRmzQVubjUsrY+gkKYu2ZkpGENl6HIja7gkBMNLdRljnBQJ
         C+2xucOAlywVayB8MCZvWf5Y3XxCYHXTUZkBo1hTNmkN37x+3IA8hVw157y8623pwH
         nJiNILsasKtd2GeYlQ305kYnmpLhnPRg3gyg1XhnD1eyu+v4sEZryYiO4UKw0FNyii
         hLqlFDRgPXXVvGh1dMp8MJ2UQu0O6FUHX2YErgntkKS2WGEOyR3hDo1wp6Yse/3r8P
         0iAYX/HQnODRg==
Date:   Sun, 20 Mar 2022 13:22:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
Message-ID: <20220320132222.793abcea@jic23-huawei>
In-Reply-To: <35811c26-2363-6be0-09fe-91ee77f29069@denx.de>
References: <20220310003402.490478-1-marex@denx.de>
        <20220310003402.490478-4-marex@denx.de>
        <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
        <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
        <CAHp75VfDv5CE0cDSBDeMeWj4ub1JV9o-jPpqhLvwnmmN+=WJ0Q@mail.gmail.com>
        <1504edf0-5773-781a-1a4f-056f57dfbf15@denx.de>
        <YiuA3jvbpkSQfuFM@smile.fi.intel.com>
        <35811c26-2363-6be0-09fe-91ee77f29069@denx.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Mar 2022 19:51:56 +0100
Marek Vasut <marex@denx.de> wrote:

> On 3/11/22 18:03, Andy Shevchenko wrote:
> > On Fri, Mar 11, 2022 at 12:33:49PM +0100, Marek Vasut wrote:  
> >> On 3/11/22 12:29, Andy Shevchenko wrote:  
> >>> On Fri, Mar 11, 2022 at 1:55 AM Marek Vasut <marex@denx.de> wrote:  
> >>>> On 3/10/22 15:25, Andy Shevchenko wrote:  
> >>>>> On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:  
> > 
> > ...
> >   
> >>>>>> -            .realbits = 12,                                 \
> >>>>>> +            .realbits = (_realbits),                        \
> >>>>>>                .storagebits = 16,                              \  
> >>>>>
> >>>>> This seems inconsistent a bit. What if the next chip wants to have more than
> >>>>> 16 bits in realbits?  
> >>>>
> >>>> When such a chip exists, this can be parametrized as well.  
> >>>
> >>> Yes, My point is that it's error prone.  
> >>
> >> Won't IIO core warn if realbits > storagebits ?  
> > 
> > If it's the case, then it's very good!  
> 
> No, apparently it won't .

Easy to add I think and a good idea. Though can only be a runtime
check obviously.

Put a verification check in iio_buffer_add_channel_sys() which
is registering the _type attr used to get access to this info from
user space.

Jonathan

> 
> > ...
> >   
> >>>>> I see two options:
> >>>>> 1) add static assert to make sure realbits <= storagebits;  
> >>>>
> >>>> Does static_assert work in array of structures (I don't think it does) ?  
> >>>
> >>> You can check, but IIRC some of the macros have it. Don't remember the
> >>> details, though.  
> >>
> >> I already checked before replying, hence my question, as I didn't find a way
> >> to make it work.  
> > 
> > It seems that current use cases have it either in functions or in
> > the expressions as ({...}). I dunno if the result of ({...}) can be
> > a data structure or compound literal.  
> 
> I added a patch to v2, but ugh, it isn't nice:
> 
> [PATCH v2 7/7] iio: adc: ti-ads1015: Add static assert to test if 
> shifted realbits fit into storagebits


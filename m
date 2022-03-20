Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4154E1BC7
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 14:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbiCTNEp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTNEn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 09:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF6532E9
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 06:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919B9610A0
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 13:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA96CC340ED;
        Sun, 20 Mar 2022 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647781397;
        bh=xGGyDuFQuAHfoomObPtgIIQRgA0zCdIsNkjY3uMDiNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SdfHqtIYm8FsZNxVT3mRrNuIby7mxK/Y3coZ3U74ZR3lNh27xX4mlTY1N3X+wHhpq
         vZ0caJXk2zge7qdo21MPm7CrNtelxU5aGp613Hd1yz8Lu1SSBKFj8uRx2Yz4jn0/Fa
         hKpuCBE0ViYET/xAj3V+pORcZsbrg/jHZNBmgaOGXxmSAWvpYszhCZpVzoY7MoqU35
         AHEnoUJrlKWqa7CVSdxHZFUuGb6OYTRLj2ravxpgiYpAGlEjRJ8S9W4WZmFS0qpDhE
         ajUtALOVjV05ZMP9Czg+aVrumnp9ZIx3weyFLgFPXOYhI+jCgXW55/nzK6bRt5N4Pr
         Hq6VoTg/fW8NQ==
Date:   Sun, 20 Mar 2022 13:10:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ti-ads1015: Add static assert to test
 if shifted realbits fit into storagebits
Message-ID: <20220320131041.4efcf35b@jic23-huawei>
In-Reply-To: <65e934d0-b002-1cf1-1b4d-1ff53d04df50@denx.de>
References: <20220311184925.99270-1-marex@denx.de>
        <20220311184925.99270-7-marex@denx.de>
        <CAHp75VdS+VRFSu8q3Si4yVEJd3aYxoFBaz4cYh7PXLGCLmNvaA@mail.gmail.com>
        <65e934d0-b002-1cf1-1b4d-1ff53d04df50@denx.de>
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

On Sat, 12 Mar 2022 22:28:22 +0100
Marek Vasut <marex@denx.de> wrote:

> On 3/12/22 13:19, Andy Shevchenko wrote:
> > On Fri, Mar 11, 2022 at 8:50 PM Marek Vasut <marex@denx.de> wrote:  
> >>
> >> Add compile-time static_assert wrapper to verify that shifted realbits
> >> fit into storagebits. The macro is implemented in a more generic way so
> >> it can be used to verify other values if required.  
> > 
> > Thanks! I think we may leave it to maintainers to decide if it is
> > worth adding or not.  
> 
> Right, that's why I placed it as 7/7, since the macro is ... not pretty.

It's ugly but that's all wrapped up in the macro so I'll take it and
see what blows up :)

Longer term, maybe we'd should add a general runtime check in the IIO core?

Not quite so nice as catching at compile time but would catch all such issues
the moment anyone actually tries out a driver with whatever device they've
just added support for.

I'll let this sit a little longer for additional review before picking it up
(missed this cycle anyway so lots of time).


A few other comments on this driver whilst we are here on things we should
cleanup at somepoint.
1) Move over to the read_avail callback rather than having the attribute
   groups.  It may well be slightly more code but then makes them available
   to in kernel users.   Slowly moving all drivers with _available for standard
   ABI over to the callback is on the todo list but it will take a while...
2) Possibly introduced a static const array of
   struct ad1015_chip_info {
	all the per device stuff currently handled in code in probe
   };
Then simply access that directly using the the device_match_data.

Jonathan

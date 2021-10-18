Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2D43282C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 22:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhJRULZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 16:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJRULZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 16:11:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22AE611EF;
        Mon, 18 Oct 2021 20:09:11 +0000 (UTC)
Date:   Mon, 18 Oct 2021 21:13:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org, kernel@axis.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
Message-ID: <20211018211326.7148b03e@jic23-huawei>
In-Reply-To: <5f3b6dd9-b90c-9e54-1772-56a79cc8c1cc@axentia.se>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
        <7c14fabc-8811-5875-15a0-67884e2da78d@axentia.se>
        <20211017183108.1797d416@jic23-huawei>
        <5f3b6dd9-b90c-9e54-1772-56a79cc8c1cc@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Oct 2021 23:08:06 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2021-10-17 19:31, Jonathan Cameron wrote:
> > On Sat, 9 Oct 2021 01:09:56 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi Vincent!
> >>
> >> On 2021-10-07 15:46, Vincent Whitchurch wrote:  
> >>> On one of our boards we use gpio-mux with iio-mux to read voltages using an ADC
> >>> from a few different channels, and on this board the input voltage needs some
> >>> time to stabilize after a switch of the mux.
> >>>
> >>> This series add devicetree and driver support for this kind of hardware which
> >>> requries a settle time after muxing.
> >>>
> >>> v1 -> v2:
> >>> - Move property support to iio-mux and delay handling to mux core as suggested
> >>>   by Peter.
> >>>
> >>> v1: https://lore.kernel.org/all/20211004153640.20650-1-vincent.whitchurch@axis.com/
> >>>
> >>> Vincent Whitchurch (3):
> >>>   mux: add support for delay after muxing
> >>>   dt-bindings: iio: io-channel-mux: Add property for settle time
> >>>   iio: multiplexer: iio-mux: Support settle-time-us property
> >>>
> >>>  .../iio/multiplexer/io-channel-mux.yaml       |  5 +++
> >>>  drivers/iio/multiplexer/iio-mux.c             |  7 +++-
> >>>  drivers/mux/core.c                            | 36 ++++++++++++++++---
> >>>  include/linux/mux/consumer.h                  | 23 +++++++++---
> >>>  include/linux/mux/driver.h                    |  4 +++
> >>>  5 files changed, 65 insertions(+), 10 deletions(-)
> >>>     
> >>
> >> This looks really nice, thank you! The only question I see is if it should
> >> go via my (virtually unused) mux tree or via the iio tree. Yes, the meat is
> >> in mux/core.c, but I'm happy to just ack these patches and have Jonathan
> >> handle them. But, I'm also fine with handling it in the mux tree (but I'm
> >> getting old and forgetful, and it's been so many moons that I need to
> >> re-learn the steps).
> >>
> >> Jonathan, you or me? If you, you can add:
> >>
> >> Acked-by: Peter Rosin <peda@axentia.se>  
> > 
> > I don't really mind, but the 4/3 and 5/3 have broken my b4 based flow + Rob
> > hasn't yet given an Ack on those two, so I'll not pick any of them up just yet.
> > I can sort out the two oddly numbered patches if Rob is happy, though they'll
> > probably not have the nice link tags that b4 automates.
> > 
> > Note Rob didn't actually say he was happy with patch 2 yet as far as I can tell.  
> 
> Getting Rob's ack on 2/3 is of course a prerequisite to 1/3 and 3/3.
Given Rob has now given that, I'll queue these 3 patches up.

Applied to the iio-togreg branch of iio.git and pushed out as testing for 0-day
to poke at.

> 
> Just ignore 4/3 and 5/3 if they are holding things back or are making things
> difficult in any way. I'll resend them later if need be, as they really have
> very little to do with this series.
> 
> With hindsight I should probably have sent them as a fresh series, and I can
> re-post them as such immediately if that helps? But then again, maybe that
> just muddies the water even further...

Let's deal with those two separately.  I can pick them off list if Rob is happy
with those two.  The dt bindings patchwork has them as needing review so 
I'm sure they'll get it shortly.

Thanks,

Jonathan

> 
> Cheers,
> Peter


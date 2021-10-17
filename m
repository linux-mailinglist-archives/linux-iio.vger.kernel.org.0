Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946D1430B34
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 19:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbhJQR3X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 13:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344366AbhJQR3W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 13:29:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107DE60FD8;
        Sun, 17 Oct 2021 17:27:09 +0000 (UTC)
Date:   Sun, 17 Oct 2021 18:31:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org, kernel@axis.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
Message-ID: <20211017183108.1797d416@jic23-huawei>
In-Reply-To: <7c14fabc-8811-5875-15a0-67884e2da78d@axentia.se>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
        <7c14fabc-8811-5875-15a0-67884e2da78d@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 Oct 2021 01:09:56 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi Vincent!
> 
> On 2021-10-07 15:46, Vincent Whitchurch wrote:
> > On one of our boards we use gpio-mux with iio-mux to read voltages using an ADC
> > from a few different channels, and on this board the input voltage needs some
> > time to stabilize after a switch of the mux.
> > 
> > This series add devicetree and driver support for this kind of hardware which
> > requries a settle time after muxing.
> > 
> > v1 -> v2:
> > - Move property support to iio-mux and delay handling to mux core as suggested
> >   by Peter.
> > 
> > v1: https://lore.kernel.org/all/20211004153640.20650-1-vincent.whitchurch@axis.com/
> > 
> > Vincent Whitchurch (3):
> >   mux: add support for delay after muxing
> >   dt-bindings: iio: io-channel-mux: Add property for settle time
> >   iio: multiplexer: iio-mux: Support settle-time-us property
> > 
> >  .../iio/multiplexer/io-channel-mux.yaml       |  5 +++
> >  drivers/iio/multiplexer/iio-mux.c             |  7 +++-
> >  drivers/mux/core.c                            | 36 ++++++++++++++++---
> >  include/linux/mux/consumer.h                  | 23 +++++++++---
> >  include/linux/mux/driver.h                    |  4 +++
> >  5 files changed, 65 insertions(+), 10 deletions(-)
> >   
> 
> This looks really nice, thank you! The only question I see is if it should
> go via my (virtually unused) mux tree or via the iio tree. Yes, the meat is
> in mux/core.c, but I'm happy to just ack these patches and have Jonathan
> handle them. But, I'm also fine with handling it in the mux tree (but I'm
> getting old and forgetful, and it's been so many moons that I need to
> re-learn the steps).
> 
> Jonathan, you or me? If you, you can add:
> 
> Acked-by: Peter Rosin <peda@axentia.se>

I don't really mind, but the 4/3 and 5/3 have broken my b4 based flow + Rob
hasn't yet given an Ack on those two, so I'll not pick any of them up just yet.
I can sort out the two oddly numbered patches if Rob is happy, though they'll
probably not have the nice link tags that b4 automates.

Note Rob didn't actually say he was happy with patch 2 yet as far as I can tell.

Thanks,

Jonathan

> 
> Cheers,
> Peter


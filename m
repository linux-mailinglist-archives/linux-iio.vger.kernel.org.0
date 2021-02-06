Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34A311E73
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBFPbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 10:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhBFPbX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 10:31:23 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40D364E83;
        Sat,  6 Feb 2021 15:30:40 +0000 (UTC)
Date:   Sat, 6 Feb 2021 15:30:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] iio: adc: ad7124: allow 16 channels
Message-ID: <20210206153037.1b497941@archlinux>
In-Reply-To: <20210204113551.68744-1-alexandru.tachici@analog.com>
References: <20210204113551.68744-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Feb 2021 13:35:49 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> AD7124-8 can have up to 16 pseudo-differential channels
> enabled simultaneously and only 8 configurations. 

I'm curious.  Datasheet says up to 15 pseudo differential
channels.  I can't immediate see why though!

> In this
> scenario we cannot assign one configuration per channel,
> some channels will have to share configurations like, ODR,
> gain and filter parameters.
> 
> Allow the user to specify channels and configurations
> separately in device-tree and assign, if needed, the same
> configuration to multiple channels.
> 
> If two channels share the configuration changing the
> sampling rate of one will change the sampling rate of the
> other too.

I can see why you want to do this via device tree to keep
things simple, but it does sort of feel like it might be
something we 'should' be configuring from userspace.
This is unlike the whether the channels should be differential
or not in the first place (which is mostly down to what they
are wired up to).  It's a little bit of a mess as some things
like the reference are in the 8 config registers and we
already have those in the per channel description.

I'm trying to get my head around how we might do this in
the ideal case.

So what we'd want would be:
1) Userspace to not have to care about this restriction if
   whatever it requests is 'possible'.
2) If multiple channels have the same config, then we'd want
   to 'pack' them into the same configuration register.
3) Be as flexible as possible.

The problem is we don't have any way in the ABI of making
atomic adjustments to multiple parameters, but perhaps it
'could' be made to work as follows.

1) All settings go through a level of indirection - i.e. we
   cache them in the driver and only apply them as needed.
2) Sysfs raw reads work on a basis of LRU + packing where we
   can.  (or we just use one config and pay the cost of
   switching every time)
3) Buffered reads.   We check whether the requested
configuration of all channels is possible and set it up if
so.  Otherwise we return -EBUSY or similar to indicate
that what is currently requested can't be done.
Hence we make it atomic at the point of enable.

Most of the time, I'm going to assume that users either have
a carefully crafted optimum setup for their system in which
case they can read the datasheet to figure out what is possible
or they want to have a small number of groups of channels
where it makes sense to replicate configuration because they
are reading the 'same sort of thing'.

Perhaps just pushing all this to dt is fine, but I'm not that
keep on it if there is a reasonable way to avoid it.

Things like filter selections and calibration offsets shouldn't
be influenced by DT (by putting them in shared groups like
this series does).

These are weirdly flexible devices (what fun!) :)

Jonathan

> 
> Alexandru Tachici (2):
>   iio: adc: ad7124: allow 16 channels
>   dt-bindings: iio: adc: ad7124: add config nodes
> 
>  .../bindings/iio/adc/adi,ad7124.yaml          |  72 +++++--
>  drivers/iio/adc/ad7124.c                      | 183 +++++++++++-------
>  2 files changed, 166 insertions(+), 89 deletions(-)
> 


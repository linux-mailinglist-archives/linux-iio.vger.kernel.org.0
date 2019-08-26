Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC59D9CCBA
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHZJoL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 05:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfHZJoL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Aug 2019 05:44:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3AD2070B;
        Mon, 26 Aug 2019 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566812650;
        bh=mILm2o9krLxM2CH+RyJgcI4T3TbVaeKFfro54YUuTDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CpZsYdLhKtw0uoP3XJifs1dCqR+iP7OxwIJhoDHll/jY+nd0VJOfqcgMhCTxDuexs
         VXgxJdrgmYfRLza6S6hWMUV71PQTEsBNilZ/Qrl+v2kOC6WtpCGdISjb9Ex9aFYBF8
         B1BM8Z+/MN8AeEqqBBn1PJdWI9dtKzTvoi6TlU88=
Date:   Mon, 26 Aug 2019 10:44:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Pollak, Leonard" <pollak@tr-host.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Add ADE9000 driver to staging:iio:meter?
Message-ID: <20190826104404.3409567c@archlinux>
In-Reply-To: <60e09b1c93eb54a6f8042ece9d34da80@tr-host.de>
References: <60e09b1c93eb54a6f8042ece9d34da80@tr-host.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Aug 2019 11:25:14 +0200
"Pollak, Leonard" <pollak@tr-host.de> wrote:

> Hi,

Hi Leo,

Welcome to IIO :)

> 
> I have written a driver for the ADE9000. It has enough functionality to 
> calibrate the device
> and use it for energy metering. This was tested on a Raspberry Pi 3 
> which i also have
> a dts for if anyone is interested.

Cool.

> 
> There are some quirks though since the ABI doesn't really make it easy 
> on this kind of device.
> For example: my driver (ab)uses the iio modifiers x and y to distinguish 
> between Wh and VAh.

IIRC we discussed this in the thread I linked to from the driver review.
The IIO interface as it stands is not quite descriptive enough to
cover these devices.  That's fine - just means we need to work out how
to extend it without breaking corners.  The problem normally when doing
this is events as the even codes are our most constrained space.

> There are other issues with the driver I can think of (especially the 
> channel definitions).
> I think if you would want a more complete implementation of this IC as 
> an iio device one would
> need to start adding modifiers/types to the iio chan spec which would 
> probably need a lot
> of discussion. 

Agreed.  Dive in there and propose something.  Might take a little while
but that's the only way to expand our ABI to support new classes of
devices.  Though we've had meter drivers in IIO staging for a long
long time, we've all been aware they weren't suitable for moving out
and this type of device needed revisiting.  

> Since this is the first driver I have written for the 
> linux kernel don't
> expect too much, but I am commited to learn and happy to implement any 
> suggestions for
> making this a nice driver in the future :)

Cool. Certainly not an easy one to start with.  The problem is that we
need to think through the whole ABI even if we initially only implement
a subset so that we ensure it will generalize if the fancy features
are added in future.

> 
> For now, I have forked the kernel tree from GKH made a patch and cleaned 
> it up with checkpatch.pl
> should I just send the driver as a patch is there anything else I need 
> to do beforehand?
> 
> Regards,
> Leo

I now understand a little more why you posted it under staging.  I'd
suggest we don't do that for now, but rather just assume this may take
a few rounds of patches to get it right.  Mostly the only reason we
would take a driver into staging now for IIO is that it comes from some
vendor tree and we want to clean it up in a clear way that keeps it's
history etc.  For a new driver like yours, where the history is on
the mailing list, there is limited benefit in doing so.

Thanks,

Jonathan


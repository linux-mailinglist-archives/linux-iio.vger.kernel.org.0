Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57C2C7968
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgK2NUI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2NUG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:20:06 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA0D20719;
        Sun, 29 Nov 2020 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606655965;
        bh=fCx6fwmi8WQt6POlTCutPpdDn3o6P79sJ7Sltq7x7jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HnS+K1qNu3xw8tALhL+jejePnBjJkaI0RPCR8M3nD143gzDJ3mrzcsQXVchuqcyHG
         95QIeIFMhn8ipdlyDWhtlY8PTWC4l2peJa5GyR9wkIS3n3Cno+bn5OeKGIeif0z8OC
         sRIOX2aec/FRaA9SFRg9hFwUbbtjnwSlKMbkRVG0=
Date:   Sun, 29 Nov 2020 13:19:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio:trigger: Remove re-poll logic.
Message-ID: <20201129131918.319c16d4@archlinux>
In-Reply-To: <20200920191814.4a7e8a25@archlinux>
References: <20200920132548.196452-1-jic23@kernel.org>
        <78141dee-33a2-c28d-2e80-38918c03f81d@metafoo.de>
        <20200920191814.4a7e8a25@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Sep 2020 19:18:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 20 Sep 2020 17:02:32 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 9/20/20 3:25 PM, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > This code isn't used by any current mainline drivers (except
> > > via error handling routes that shouldn't exist).  The original
> > > user is long gone.  It is causing issues, so let's drop it.
> > >
> > > The main bulk of this mini-series is renaming the function to account
> > > for the change in what it does.
> > >
> > > Lars, what impact does doing this have on your patches to mark hrtimer
> > > and irq_work as expiring in hardirq context? I got a bit lost in the
> > > discussion of that series, beyond figuring out his corner needed cleaning up.    
> > 
> > I think no impact. This is an issue that is orthogonal. I think the 
> > patches should still be applied as they are.
> > 
> > For this series:
> > 
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> >   
> Great.  Hopefully resolving this one will get us acks on that series.
> I've just posted a quick note in that thread to point at this one as resolving
> the latter part of that discussion.

I sat on this one far longer than I should no basis I was planning to
also sort out issues around calling iio_trigger_notify_done from an
interrupt handler.   However, it stands on it's own even if it doesn't
clean up all the problems around this code so better to apply this now
than forget about it!

I'll get to the iio_trigger_notify_done sometime soonish hopefully :(

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4991949
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRTdC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 15:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRTdC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 15:33:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10BB21872;
        Sun, 18 Aug 2019 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566156781;
        bh=DH+GvLRI5SnBTvTzB9S0LlBf0DT1Vt1g7eXiDOWIoLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ooAtLWnay300t1EoLggY/KcqB/RPLVjRKfY1TG4PGTx8k2x5zHCpjCvbANH3SVM4P
         kU+WDdzGBo5MCv8nT71tb7LMFxD8Mq/U4ten1OLSNhIgsh4izlJ0NDXYwKX555SMZ0
         NAfPL2qBUVLbDv4AvTx4hD3uMobKBpYH+qGx5/x8=
Date:   Sun, 18 Aug 2019 20:32:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Martin Kaiser <martin@kaiser.cx>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: Is storing output values to non volatile registers
 something we should do automatically or leave to userspace action. [was Re:
 [PATCH] iio: potentiometer: max5432: update the non-volatile position]
Message-ID: <20190818203256.202318d3@archlinux>
In-Reply-To: <42d99cc8-e59b-6c0b-d1e3-5690b8d1fe53@electromag.com.au>
References: <20190809160617.21035-1-martin@kaiser.cx>
        <20190811101137.5bd495e9@archlinux>
        <20190812103751.gumfzgazlytq5zqm@viti.kaiser.cx>
        <42d99cc8-e59b-6c0b-d1e3-5690b8d1fe53@electromag.com.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Aug 2019 19:08:12 +0800
Phil Reid <preid@electromag.com.au> wrote:

> G'day Martin / Jonathan,
> 
> On 12/08/2019 18:37, Martin Kaiser wrote:
> > Hi Jonathan,
> > 
> > Thus wrote Jonathan Cameron (jic23@kernel.org):
> >   
> >> The patch is fine, but I'm wondering about whether we need some element
> >> of policy control on this restore to current value.  
> >   
> >> A few things to take into account.  
> >   
> >> * Some devices don't have a non volatile store.  So userspace will be
> >>    responsible for doing the restore on reboot.
> >> * This may be one of several related devices, and it may make no sense
> >>    to restore this one if the others aren't going to be in the same
> >>    state as before the reboot.
> >> * Some devices only have non volatile registers for this sort of value
> >>    (or save to non volatile on removal of power). Hence any policy to
> >>    not store the value can't apply to this class of device.  
> > 
> > I see your point. You'd like a consistent bahaviour across all
> > potentiometer drivers. Or at least a way for user space to figure out
> > whether a chip uses non-volatile storage or not.
> > This property doesn't quite fit into the channel info that are defined
> > in the arrays in drivers/iio/industrialio-core.c. Is there any other way
> > to set such a property?
> >   
> >> My initial thought is that these probably don't matter that much and
> >> we should apply this, but I would like to seek input from others!  
> >   
> >> I thought there were some other drivers doing similar store to no
> >> volatile but I can't find one.  
> > 
> > drivers/iio/potentiometer/max5481.c and max5487.c do something similar.
> > 
> > They use a command to transfer the setting from volatile to non-volatile
> > register in the spi remove function. I guess that the intention is to
> > save the current setting when the system is rebooted. However, my
> > understanding is that the remove function is called only when a module
> > is unloaded or when user space does explicitly unbind the device from
> > the bus via sysfs. That's why I tried using the shutdown function
> > instead.
> > 
> > Still, this approach has some disadvantages. For many systems, there's a
> > soft reboot (shutdown -r) where the driver's shutdown function is called
> > and a "hard reboot" where the power from the CPU and the potentiometer
> > chip is removed and reapplied. In this case, the current value would not
> > be transfered to the non-volatile register.
> > 
> > At least for the max5432 family, there's no way to read the current
> > setting. The only option for user space to have a well-defined setting
> > is to set the wiper position explicitly at startup.
> > 
> > I guess the only sensible way to use a non-volatile register would be a
> > write operation where user space gets a response about successful
> > completion.
> > 
> > We could have two channels to write to the volatile or to non-volatile
> > register. Or we stick to one channel and update both volatile and
> > non-volatile registers when user space changes the value. This assumes
> > that the setting does not change frequently, which is prabably not true
> > for all applications...

I'm not keen on multiple channels as that is a fairly non obvious interface.
Definitely want to avoid writing all the time.

> > 
> > Whatever we come up with, we should at least make the max* chips behave
> > the same way.
> >   
> The AD5272/AD5274 Digital Rheostat has a 50-times limit for programming the NV register.
> So you want to be real sure that you want to set it.

Ouch, I new some were limited to a few thousand cycles, but 50 is rather nasty!

> 
> I'd rather my system default to a known "safe" value for next boot than
> set to whatever the last write was. So some kind of policy on setting this would
> be nice. I personally think it's something that userspace should initiate via an explicit
> command.
Agreed. I think we should look at an explicit write.

Perhaps an extra attribute on the channels?  Hence a shared_by_all version
could be used when there is only one write command.

> 
> Writing the NV for the AD5272 is something I planned to add at some stage.
> But so far the default factory values have worked ok.
> It'd be nice for cross device consistency for any interface for this.
> 
Agreed. This is an area that crept up on me, so we haven't enforced any
consistency on it yet.  However, we definitely should!

Thanks,

Jonathan


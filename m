Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E231B8756
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgDYPVH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDYPVG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:21:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65EF2071C;
        Sat, 25 Apr 2020 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587828066;
        bh=XT458vq0XN1WLWI28Diyiv9sG8dG5RTg3qgKZyWEnqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w2Z9xofFm6mP3p6Bw0TBrKkoMEtxca6iBgpF3jQXay+xV8dAyXts2Urhhmz/slMR/
         yMGhTyTJGLtDP5GC+hnN5LdkDx7oSonXPhx3zysAkHfEE6q98yHgwinUTuNJ1RiWsv
         cHFgEeh4gup0YcLboBlXX0hcg+YkFEx9Vg8SXxuU=
Date:   Sat, 25 Apr 2020 16:21:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: counter: Add Cros EC Sync counter
Message-ID: <20200425162101.21f7960e@archlinux>
In-Reply-To: <20200420190810.GA16124@icarus>
References: <20200413195514.192868-1-gwendal@chromium.org>
        <20200414204814.GH7347@icarus>
        <CAPUE2utas86PQdQem7bPsNL+xnHreepG8wbvbt2Vk5rtjoyn-A@mail.gmail.com>
        <20200420190810.GA16124@icarus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 15:08:10 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Mon, Apr 20, 2020 at 11:54:16AM -0700, Gwendal Grignou wrote:
> > On Tue, Apr 14, 2020 at 1:48 PM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:  
> > >
> > > On Mon, Apr 13, 2020 at 12:55:14PM -0700, Gwendal Grignou wrote:  
> > > > When the camera vsync pin is connected to the embedded controller (EC) of
> > > > a chromebook, the EC reports a sensor with a counter that increases
> > > > at each GPIO rising edge.
> > > >
> > > > The sensor is presented using the counter subsystem.
> > > > In addition, it is also presented via the IIO subsystem with a timestamp,
> > > > allowing synchronisation with sensors connected to the same EC, for
> > > > image stabilisation or augmented reality applications.  
> > >
> > > Hi Gwendal,
> > >
> > > Sorry for the delay. I have some changes requested below.
> > >  
> > > > To enable the counter:
> > > > via counter ABI:
> > > > echo "rising edge" > counterX/count0/signal_action
> > > > via iio ABI
> > > > echo 1 > iio:deviceY/en
> > > >
> > > > To disable the counter:
> > > > via counter ABI:
> > > > echo "none" > counterX/count0/signal_action
> > > > via iio ABI
> > > > echo 0 > iio:deviceY/en  
> > >
> > > Although in theory a user could manually disable the actions for a
> > > Signal, this is a very roundabout way of actually disabling the Count.
> > > It's better to expose an "enable" attribute to allow the users to
> > > perform this functionality; for example:
> > >
> > > echo 0 > counterX/count0/enable
> > > echo 1 > counterX/count0/enable
> > >  
> > > >
> > > > To read the current counter value:
> > > > via counter ABI:
> > > > cat counterX/count0/count
> > > > via iio ABI
> > > > cat iio:deviceY/in_count_raw  
> > >
> > > I know we discussed this in the last review but it's still the same as
> > > before: IIO_COUNT interface is deprecated so new drivers won't be
> > > allowed to use it. You'll have to remove the IIO_COUNT code in this
> > > driver and replace it with Counter subsystem equivalents.  
> > I understand the need of a clean separation between counter and IIO subsystems.
> > I will wait for counter to offer a way to gather timestamp'ed counts.
> > Do you have a plan/proposed ABI you can share?
> > 
> > Thanks,
> > 
> > Gwendal.  
> 
> Hi Gwendal,
> 
> I'm working on a reimplementation of the internals of the Counter
> subsystem: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chardev
> 
> I'm hoping to submit it to the mailing list later this week if I don't
> hit any delays; it'll include support as well for a character device
> interface for userspace application.
> 
> Once those changes are merged into IIO, I'll submit a patch to add
> timestamp support -- hopefully within a week or two after. Right now I
> haven't yet chosen any specific format for timestamps, but I will likely
> match the format IIO subsystem currently has for its timestamp support
> so that migration is easier for these drivers.
> 

Don't copy our crazy clock choosing stuff. That's legacy rubbish for
compatibility with a silly choice I made a long time ago.  Pick
a sensible clock type and stick to it.

Jonathan

> William Breathitt Gray


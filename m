Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF383ECA24
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhHOQHZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhHOQHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 12:07:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E226121E;
        Sun, 15 Aug 2021 16:06:53 +0000 (UTC)
Date:   Sun, 15 Aug 2021 17:09:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] iio:adc:ad7124: Convert to fwnode handling of child
 node parsing.
Message-ID: <20210815170951.52378891@jic23-huawei>
In-Reply-To: <20210727192013.00003f3c@Huawei.com>
References: <20210725172458.487343-1-jic23@kernel.org>
        <20210725172458.487343-3-jic23@kernel.org>
        <CAHp75VcgMkPw8BudKkF9MN2ijjDuT=VRo3FivVcjEYsEY4L-0w@mail.gmail.com>
        <20210727145141.0000230d@Huawei.com>
        <CAHp75Ve6L+5zAwBJ5ep2VExyNDaSSrEBAonfMT6cFCxEpgUQQA@mail.gmail.com>
        <20210727192013.00003f3c@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 19:20:13 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 27 Jul 2021 17:16:07 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Tue, Jul 27, 2021 at 4:52 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > > On Sun, 25 Jul 2021 23:33:12 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:    
> > > > On Sun, Jul 25, 2021 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:    
> > 
> > ...
> >   
> > > > > -       for_each_available_child_of_node(np, child) {
> > > > > +       device_for_each_child_node(dev, child) {    
> > > >
> > > > Isn't this
> > > >   fwnode_for_each_available_child_node()
> > > > better to use?    
> > >
> > > Given we would be extracting the fwnode just to call this
> > > loop, I'd say no, device version makes more sense..
> > >    
> > > >
> > > > ...
> > > >
> > > > So the gaps I see are
> > > >   device_get_available_child_node_count()
> > > > and
> > > >   device_for_each_available_child_node()    
> > >
> > > Do we then fix the fact that
> > > device_for_each_child_node() will call the _available() form
> > > for device tree?  That seems inconsistent currently and
> > > I was assuming that was deliberate...    
> > 
> > I'm not sure I got your point. Mine (see below) is to add the APIs
> > that you want to use as a direct replacement of the corresponding OF
> > counterparts.  
> +CC Rafael,

Rafael, if you have a chance to give input on the questions below it would
be much appreciated.

Thanks,

Jonathan

> 
> The oddity is that device_for_each_child_node() is a direct replacement
> of the for_each_available_child_of_node() other than the obvious
> use of device rather than the of node.
> 
> https://elixir.bootlin.com/linux/v5.14-rc3/source/drivers/of/property.c#L939
> 
> static struct fwnode_handle *
> of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
> 			      struct fwnode_handle *child)
> {
> 	return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
> 							    to_of_node(child)));
> }
> 
> So the question becomes whether there is any desire at all to have a
> version of the device_for_each_child_node() that does not check
> if it is available or not.
> 
> Looks like it goes all the way back.  Rafael, any comment on why the available
> for is used here and whether it makes sense to introduce separate
> versions for looping over children that cover the _available_ and everything
> cases?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/base/property.c?id=8a0662d9ed2968e1186208336a8e1fab3fdfea63
> 
> I'm kind of assuming this was deliberate as we don't want to encourage
> accessing disabled firmware nodes.
> 
> Jonathan
> 
> >   
> > > > Both of them I think are easy to add and avoid possible breakage.    
> > 
> >   
> 


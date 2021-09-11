Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC34078F6
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhIKPCX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 11:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhIKPCX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 11:02:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C5661206;
        Sat, 11 Sep 2021 15:01:08 +0000 (UTC)
Date:   Sat, 11 Sep 2021 16:04:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] iio: ABI: Document in_concentration_co2_scale
Message-ID: <20210911160439.1b6deaa3@jic23-huawei>
In-Reply-To: <20210910114733.0000446c@Huawei.com>
References: <20210909094537.218064-1-jacopo@jmondi.org>
        <20210909094537.218064-5-jacopo@jmondi.org>
        <YToGpTR0aJ97GxG0@smile.fi.intel.com>
        <20210910114733.0000446c@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Sep 2021 11:47:33 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 9 Sep 2021 16:05:41 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Sep 09, 2021 at 11:45:37AM +0200, Jacopo Mondi wrote:  
> > > Document the 'in_concentration_co2_scale' standard IIO attribute.    
> > 
> > ...
> >   
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale    
> > 
> > I don't know the history of the discussion about this attribute but it seems
> > too specific to have in list of kinda generic ones.
> > 
> > Shouldn't be rather air / gas / etc used instead of CO2?
> >   
> I'm not following.  The sensor is measuring c02 concentration (in the air) so
> we need to call that out.  Making it more general would mean we couldn't then
> handle a sensor that had channels for c02 and oxygen for example.
> We don't bother to distinguish the difference between concentration in gas or
> liquid because it seemed unneeded.  This is sort of similar to the fact we
> don't distinguish gas temperature (say in a humidity sensor) from object temperature
> in an IR thermometer.  We could do so if there is a strong reason for it.
> 
> Using c02 as a modifier on a concentration channel is in line with how we
> handled things like different light frequency ranges ir, visible, red, green, blue.
> 
> Jonathan

We had a quick chat about this off list.

Andy's point was that ultimately it might be better to have a separate
attribute for the gas type. Andy may well be correct long term but this is
an existing bit of ABI so lets leave it as it stands for now.

Perhaps we will revisit this in future if we get a wide range of different types
of gas sensor.

Jonathan

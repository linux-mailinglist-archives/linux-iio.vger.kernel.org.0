Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E0278774
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYMmJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgIYMmI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:42:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD7F20BED;
        Fri, 25 Sep 2020 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601037728;
        bh=LO0gPY984oiIUSpPfcW9X05uDJeA8MA43SFncHO9SD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nT86u59/8tpdv2naRdqwcV2TANUuG3KuqpYNB9zC8v0obh5wn1D9is6RdeVkS7orT
         9bZGg2J4znw0av5FzVkwAsmMyNZ8bhlcdPwH1AyXx6QJ3VJxhIBF/BG4cJDO+AZzZC
         QZcGv6XWaT8uftoCrWgrl9+ENNtxxgBgDppZeQj8=
Date:   Fri, 25 Sep 2020 13:42:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Sanchayan Maity <maitysanchayan@gmail.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20200925134202.76ecf6cb@archlinux>
In-Reply-To: <0861e8406165c4faf6ab0443cc05ffc0@agner.ch>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200814113008.00002733@Huawei.com>
        <20200920191545.4ed79276@archlinux>
        <5007153.c9bsiqU2ZW@n95hx1g2>
        <20200921105703.000048b3@Huawei.com>
        <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
        <20200921143206.00006b43@Huawei.com>
        <AM8PR04MB731594F51648126A764EA066FF3B0@AM8PR04MB7315.eurprd04.prod.outlook.com>
        <20200924064132.GA22507@core-precision>
        <0861e8406165c4faf6ab0443cc05ffc0@agner.ch>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 10:54:39 +0200
Stefan Agner <stefan@agner.ch> wrote:

> On 2020-09-24 08:41, Sanchayan Maity wrote:
> > On 20-09-22 02:51:11, Andy Duan wrote:  
> >> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>  
> >> > On Mon, 21 Sep 2020 14:27:28 +0200
> >> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> >  
> >> > > On 2020-09-21 10:57:03 [+0100], Jonathan Cameron wrote:  
> >> > > > So looking at this the other way, are there any significant risks
> >> > > > associated with this change?  If not I'm tempted to queue them up
> >> > > > and we have the rcX time to fix anything we've missed (just like
> >> > > > every other patch!)  
> >> > >
> >> > > I've been told that it only performs IRQ-thread wake-ups in hard-IRQ
> >> > > context. This is fine then.
> >> > >  
> >> > drivers/iio/adc/vf610-adc.c
> >> >
> >> > However, there looks to be a lot more wrong in there than just this.
> >> > So normally for a device with a data ready signal like this we would hook up as
> >> > follows.
> >> >
> >> > Data ready #1 -> IRQ chip (trigger) ->  Read sensor #1 +
> >> > iio_trigger_notify_done()  
> >> >                                     ->  Read sensor #2 +  
> >> > iio_trigger_notify_done()
> >> >
> >> > (note that the read etc is normally in a thread - all we do in interrupt context is
> >> > usually to  grab a timestamp if that makes sense for a given sensor).
> >> >
> >> > This driver does both of.
> >> > Data ready -> Read data from itself and call iio_trigger_notify_done() IRQ chip
> >> > for a different trigger -> Take a timestamp and never call
> >> > iio_trigger_notify_done()
> >> >   or read any data for that matter.
> >> >
> >> > Which won't do what we want at all.
> >> >
> >> > Andy, if I have a go at fixing this are you able to test the result?
> >> > I think the simplest is probably to introduce a trigger to tie the two halves
> >> > together.
> >> > We can set it as the default trigger so things should keep on working for existing
> >> > users.
> >> >
> >> > For more general case, we should probably have two functions.
> >> >
> >> > iio_trigger_notify_done() which is only called from places we can sleep.
> >> > iio_trigger_notify_done_no_action() which only decrements the counter (or
> >> > given this is only called inside industrialio-trigger.c could just replace  with
> >> > atomic_dec(&trig->use_count)).
> >> >  
> >>
> >> Sanchayan, can you help to verify the fixes that Jonathan will send out ?
> >>  
> > 
> > Sorry for the delay in reply. Unfortunately can't as I do not access to the
> > hardware having left Toradex.
> > 
> > CCed Stefan Agner who might be able to help.
> > 
> > @Stefan
> > 
> > Hello Stefan :), may be you can help here?  
> 
> Hi all,
> 
> I do have access to the hardware and can run a test if required. I guess
> I would just need to test if ADC sampling still work with something like
> tools/iio/iio_generic_buffer.c?

Yup.  I haven't written the fix yet though.  Will make sure to cc you!

Thanks,

Jonathan

> 
> --
> Stefan


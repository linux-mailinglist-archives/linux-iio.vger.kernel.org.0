Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477D5276CAC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIXJBj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 05:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbgIXJBU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 05:01:20 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Sep 2020 02:01:19 PDT
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0090C0613CE
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2020 02:01:19 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2D95A5C0CB2;
        Thu, 24 Sep 2020 10:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1600937680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3wWTJTfRYELC5LTzFivh5+jp3zsfFlyHLlDX3q01bY=;
        b=BAYrLs0DUwaX1n3d+fWZbxvpSp9Shk6BV76S3xhlKzUSvzs+Z/GM2HUV65IZYFEuyODKfH
        X9HWbEHIj95VqiQHNKB/3U1xOlUax0uelCl1//V3ug94VSKCVeC3Dsx55zYvbZ1g+vz8ja
        mAJWyRsm6U3iuBU8o/LO9v8/6kRd3yc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Sep 2020 10:54:39 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Sanchayan Maity <maitysanchayan@gmail.com>
Cc:     Andy Duan <fugang.duan@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
In-Reply-To: <20200924064132.GA22507@core-precision>
References: <20200813075358.13310-1-lars@metafoo.de>
 <20200814113008.00002733@Huawei.com> <20200920191545.4ed79276@archlinux>
 <5007153.c9bsiqU2ZW@n95hx1g2> <20200921105703.000048b3@Huawei.com>
 <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
 <20200921143206.00006b43@Huawei.com>
 <AM8PR04MB731594F51648126A764EA066FF3B0@AM8PR04MB7315.eurprd04.prod.outlook.com>
 <20200924064132.GA22507@core-precision>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <0861e8406165c4faf6ab0443cc05ffc0@agner.ch>
X-Sender: stefan@agner.ch
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-09-24 08:41, Sanchayan Maity wrote:
> On 20-09-22 02:51:11, Andy Duan wrote:
>> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> > On Mon, 21 Sep 2020 14:27:28 +0200
>> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> >
>> > > On 2020-09-21 10:57:03 [+0100], Jonathan Cameron wrote:
>> > > > So looking at this the other way, are there any significant risks
>> > > > associated with this change?  If not I'm tempted to queue them up
>> > > > and we have the rcX time to fix anything we've missed (just like
>> > > > every other patch!)
>> > >
>> > > I've been told that it only performs IRQ-thread wake-ups in hard-IRQ
>> > > context. This is fine then.
>> > >
>> > drivers/iio/adc/vf610-adc.c
>> >
>> > However, there looks to be a lot more wrong in there than just this.
>> > So normally for a device with a data ready signal like this we would hook up as
>> > follows.
>> >
>> > Data ready #1 -> IRQ chip (trigger) ->  Read sensor #1 +
>> > iio_trigger_notify_done()
>> >                                     ->  Read sensor #2 +
>> > iio_trigger_notify_done()
>> >
>> > (note that the read etc is normally in a thread - all we do in interrupt context is
>> > usually to  grab a timestamp if that makes sense for a given sensor).
>> >
>> > This driver does both of.
>> > Data ready -> Read data from itself and call iio_trigger_notify_done() IRQ chip
>> > for a different trigger -> Take a timestamp and never call
>> > iio_trigger_notify_done()
>> >   or read any data for that matter.
>> >
>> > Which won't do what we want at all.
>> >
>> > Andy, if I have a go at fixing this are you able to test the result?
>> > I think the simplest is probably to introduce a trigger to tie the two halves
>> > together.
>> > We can set it as the default trigger so things should keep on working for existing
>> > users.
>> >
>> > For more general case, we should probably have two functions.
>> >
>> > iio_trigger_notify_done() which is only called from places we can sleep.
>> > iio_trigger_notify_done_no_action() which only decrements the counter (or
>> > given this is only called inside industrialio-trigger.c could just replace  with
>> > atomic_dec(&trig->use_count)).
>> >
>>
>> Sanchayan, can you help to verify the fixes that Jonathan will send out ?
>>
> 
> Sorry for the delay in reply. Unfortunately can't as I do not access to the
> hardware having left Toradex.
> 
> CCed Stefan Agner who might be able to help.
> 
> @Stefan
> 
> Hello Stefan :), may be you can help here?

Hi all,

I do have access to the hardware and can run a test if required. I guess
I would just need to test if ADC sampling still work with something like
tools/iio/iio_generic_buffer.c?

--
Stefan

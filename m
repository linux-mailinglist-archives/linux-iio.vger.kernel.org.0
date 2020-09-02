Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8C25AC91
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBOIq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 10:08:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727965AbgIBOIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 10:08:32 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8E65A4BAA80922454AE3;
        Wed,  2 Sep 2020 14:18:15 +0100 (IST)
Received: from localhost (10.52.121.91) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Sep 2020
 14:18:15 +0100
Date:   Wed, 2 Sep 2020 14:16:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Darren Schachter <dts86@cornell.edu>
CC:     Jonathan Cameron <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        Matthew Porter <mporter@konsulko.com>,
        <robertcnelson@beagleboard.org>, <drew@beagleboard.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: pulse: Support PWM capture with TI AM3358 eCAP
 module
Message-ID: <20200902141640.00006b53@Huawei.com>
In-Reply-To: <CAMEcr2-0_ZPE4uNGZJZDe8G-GtqchvyTLVGG+QZRYGEMMBwfiw@mail.gmail.com>
References: <20200818153614.6438-1-dts86@cornell.edu>
        <20200830134239.449bf411@archlinux>
        <CAMEcr2-0_ZPE4uNGZJZDe8G-GtqchvyTLVGG+QZRYGEMMBwfiw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.91]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Sep 2020 17:11:46 -0400
Darren Schachter <dts86@cornell.edu> wrote:

> On Sun, Aug 30, 2020 at 8:42 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 18 Aug 2020 10:36:14 -0500
> > Darren Schachter <dts86@cornell.edu> wrote:
> >  
> > > This IIO driver adds support for PWM capture with the TI eCAP module.
> > > This driver is based on Matt Porter's eCAP driver from January 2014,
> > > which was never merged into the mainline [1]. Like Matt's code, this
> > > driver implements interrupt driven triggered buffer capture. However,
> > > the driver has been updated based on previous suggestions in the IIO
> > > mailing list. Additionally, support for prescalar control and finer
> > > polarity control has been included. Users can now configure the
> > > polarities of CAP1 and CAP2 individually, allowing for the measurement
> > > of a signal's high-time, low-time, or period.
> > >
> > > [1] https://marc.info/?l=linux-iio&m=145968010427392&w=2
> > >
> > > Signed-off-by: Darren Schachter <dts86@cornell.edu>  
> > Hi Darren,
> >
> > I'll review this as is, but from earlier feedback it seems we have
> > some other questions to answer before potentially taking this
> > into IIO.
> >
> > There is a fair bit of new ABI in here that all needs documenting.
> >
> > Thanks,
> >
> > Jonathan  
> Thank you for the feedback, Jonathan. I am working through your
> suggestions now. I have most of the requested modifications completed.
> However, I was hoping to receive clarifications on some of the notes
> you left (see below). I really appreciate your help.
> 
> Best,
> Darren
> 
Hi Darren,

Replies below.

Thanks,

Jonathan


> > > +static ssize_t ecap_attr_pol_cap2_store(struct device *dev,
> > > +                                     struct device_attribute *attr,
> > > +                                     const char *buf,
> > > +                                     size_t len)
> > > +{
> > > +     int ret;
> > > +     bool val;
> > > +     struct ecap_state *state = dev_to_ecap_state(dev);
> > > +
> > > +     if (test_bit(ECAP_ENABLED, &state->flags))
> > > +             return -EINVAL;
> > > +
> > > +     ret = strtobool(buf, &val);
> > > +     if (ret)
> > > +             return ret;
> > > +  
> >
> > The locking around state->flags is a bit uneven.
> > Whilst these are atomic they could happen mid way through
> > the read modify write cycles elsewhere and leave things in an odd state.  
> 
> I understand what you mean with this. I have combed through the code
> and ensured that all non-atomic reads/writes are surrounded by mutex
> locks. I believe you are suggesting that, in addition, I surround
> these atomic functions with mutex locks to ensure they are not
> executed in the middle of some other read-modify-writes to
> state->flags. Is this correct?

Exactly. An atomic update can otherwise occur somewhere after the
read and before the write in rmw.

> 
> >  
> > > +     if (val)
> > > +             set_bit(ECAP_POL_CAP2_OFFSET, &state->flags);
> > > +     else
> > > +             clear_bit(ECAP_POL_CAP2_OFFSET, &state->flags);
> > > +
> > > +     return len;
> > > +}
> > > +

...

> > > +static struct attribute_group ecap_attribute_group = {
> > > +     .attrs = ecap_attributes,
> > > +};
> > > +
> > > +static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
> > > +     //.owner = THIS_MODULE;  
> > Unusual to not have at least an enable tied up to a trigger.
> >
> > If the trigger is only useful for this device and is sufficiently
> > tightly coupled to the buffer (like here) then there is no need to
> > expose the trigger at all.
> >
> > We have other devices that provide buffered access without triggers.
> >  
> 
> I have looked through other IIO drivers and I assume that, by enable,
> you are referring to the set_trigger_state function. I have added this
> function to trigger ops. Right now, I am not entirely sure if it is
> necessary -- I am still seeing if there is any useful functionality I
> could include in it -- but I will continue researching this. I should
> hopefully have more to say on this with v2.

It's possible it isn't required here because we are effectively enabling
the interrupt as part of the buffer setup.  That indicates we shouldn't
really be exposing this as a trigger at all.

> 
> With regards to not exposing the trigger, would your recommendation be
> to use a pure buffer instead of a triggered buffer? If not, is there a
> way to prevent the exposure of a trigger used in a triggered buffer?

Yes, setup the buffer without using the triggered_buffer helpers..

> My apologies if this problem has an obvious solution -- I have tried
> looking through the documentation and other IIO drivers, but I can't
> seem to find the answer to this.
> 

No problem. I should have given an example.  This particular combination
tends to happen when there is a hardware kfifo involved.  In most drivers
where that happens, we also have a mode where a conventional trigger can
be used to capture one scan of the channels at a time.  Those take no
supplied trigger as meaning we should use route that skips it.

IIRC

https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/ti_am335x_adc.c#L390

Is an example where we only support buffered capture with no option for
triggers.

> > > +};
> > > +
> > > +

...


> > > +static irqreturn_t ecap_interrupt_handler(int irq, void *private)
> > > +{
> > > +     struct iio_dev *idev = private;
> > > +     struct ecap_state *state = iio_priv(idev);
> > > +     u16 ints;
> > > +
> > > +     dev_dbg(&idev->dev, "TIECAP: Interrupt handling...\n");
> > > +
> > > +     iio_trigger_poll(idev->trig);
> > > +
> > > +     /* Clear CAP2 interrupt */
> > > +     ints = readw(state->regs + ECAP_ECFLG);
> > > +     if (ints & ECAP_ECINT_CEVT2)
> > > +             writew(ECAP_ECINT_CEVT2, state->regs + ECAP_ECCLR);
> > > +     else
> > > +             dev_warn(&idev->dev, "unhandled interrupt flag: %04x\n", ints);  
> >
> > This should be in the try_reenable callback I think to ensure we are actually
> > done with the interrupt.  Will also allow us to use the trigger to gather
> > other measurements at roughly the same time.  
> 
> I have tried moving this section of code to the try_reenable callback
> of the trigger, but I am running into issues. It seems like the kernel
> is getting stuck in interrupt mode if I do this. I have spent a few
> hours looking into this. My understanding of why this is happening is
> that try_reenable is called in the bottom half of the IRQ (at least
> with my set-up). In particular, try_reenable is only called after
> iio_trigger_notify_done is called, which occurs in
> ecap_trigger_handler in my code (i.e. the bottom half of the trigger's
> pollfun). Therefore, because the interrupt is not getting cleared, the
> ISR is continuously being called and the bottom half never has the
> chance to be executed.
> 
> Does this seem reasonable? Would you recommend keeping the interrupt
> clearing in this function, or do you think there is a better solution?
> Please let me know if I am misunderstanding something.

Mark the interrupt as ONESHOT when you request it and it should be masked
until we are ready for another one. This is often needed for level interrupts
with threaded handlers. 

> 
> >  
> > > +
> > > +     return IRQ_HANDLED;
> > > +}
> > > +

...


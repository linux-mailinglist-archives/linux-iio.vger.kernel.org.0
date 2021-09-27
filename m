Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7C41966A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhI0Obp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 27 Sep 2021 10:31:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44091 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhI0Obp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 10:31:45 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 40A2A60005;
        Mon, 27 Sep 2021 14:30:05 +0000 (UTC)
Date:   Mon, 27 Sep 2021 16:30:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v4 14/16] iio: adc: max1027: Use the EOC IRQ when
 populated for single reads
Message-ID: <20210927163004.54f1a824@xps13>
In-Reply-To: <20210926153659.70162a99@jic23-huawei>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
        <20210921115408.66711-15-miquel.raynal@bootlin.com>
        <20210926153659.70162a99@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 26 Sep 2021 15:36:59 +0100:

> On Tue, 21 Sep 2021 13:54:06 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > So far the End-Of-Conversion interrupt was only used in conjunction with
> > the internal trigger to process the data. Let's extend the use of this
> > interrupt handler to support regular single-shot conversions as well.
> > 
> > Doing so requires writing our own hard IRQ handler. This handler has to
> > check if buffers are enabled or not:
> > 
> > *** Buffers disabled condition ***
> > 
> >   This means the user requested a single conversion and the sample is
> >   ready to be retrieved.
> >   
> >     -> This implies adding the relevant completion boilerplate.    
> > 
> > *** Buffers enabled condition ***
> > 
> >   Triggers are used. So far there is only support for the internal
> >   trigger but this trigger might soon be attached to another device as
> >   well so it is the core duty to decide which handler to call in order
> >   to process the data. The core will decide to either:
> > 
> >   * Call the internal trigger handler which will extract the data that
> >     is already present in the ADC FIFOs
> > 
> >   or
> > 
> >   * Call the trigger handler of another driver when using this trigger
> >     with another device, even though this call will be slightly delayed
> >     by the fact that the max1027 IRQ is a data-ready interrupt rather
> >     than a real trigger:
> >   
> >   -> The new handler will manually inform the core about the trigger    
> >      having transitioned by directly calling iio_trigger_poll() (which
> >      iio_trigger_generic_data_rdy_poll() initially did).
> > 
> > In order for the handler to be "source" agnostic, we also need to change
> > the private pointer and provide the IIO device instead of the trigger
> > object.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > 
> > Jonathan,
> > 
> > I hope this fits the IIO model now. In order to be sure I got the big
> > picture I first refused to look at your code snippets. Just with your
> > "plain english" explanations I wrote most of these three patches, before
> > checking back that they were indeed fully aligned with your examples. I
> > truly hope they do now, but do not hesitate if I missed something.  
> 
> Looks great to me (in fact I just applied it but I'll reply to the cover letter
> shortly for that).

Great, thanks!

> Thanks for persisting with this and I'm looking forward to that blog you
> mentioned.

Thank you for all the time you put in these reviews.

I wrote most of it, it's not very long but I tried to cover most of the
common interactions with the core. It is under internal review, I'll
certainly show you its content before publishing in case you have
comments or spot any mistake.

>  If you have time / inclination to help improve the documentation
> in the kernel tree that would also be great.  This discussion has made it
> clear to me that it would be great to have a set of 'patterns' for common
> types of device + how we map them onto the model of IIO (particularly
> when they don't quite fit that idealised model).  There are similar
> compromises around when to use multiple buffers for instance.
> 
> It is always on the list of things to work on but somehow there is always
> something else more urgent :(

Hehe :) I know, documentation is always a good-to-have item that is not
often reached... I feel I need more occasions to work in the IIO
area (for example with hardware fifos/buffers or events) before being
able to fully appreciate the internal design, but I agree having a set
of 'usual patterns' that drivers should conform with depending on the
devices capabilities/constraints would be a must.

In the mean time, let's start by clarifying this 'iio_dev->modes'
property :)

Thanks,
Miquèl

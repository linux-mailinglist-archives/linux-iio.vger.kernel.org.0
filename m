Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9FD4F7E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfJLMB2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfJLL72 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:59:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C043420673;
        Sat, 12 Oct 2019 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570881566;
        bh=9exQG7nr3/lBFBoQlVSUc3OlNg8VsRMGFm1wTu5IZlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MB1IHdrhZiJ1u2/UEUf/EsywsbLh1XeaHjt/hDbdw9ic3Ndz11qNvzyV9nzfaI2YW
         vHBptnfNuIrlEtqM2OnaorTbnBj0KHlwmwGqLtZL3SdjdZqG1PUgqqPiYTWCaM3nNH
         gchu3XELBmGNWy3KZrpzjapsm8QFzbuiyXFrvsSc=
Date:   Sat, 12 Oct 2019 12:59:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for ADUX1020 sensor
Message-ID: <20191012125921.4cf04474@archlinux>
In-Reply-To: <391446566afd59da7d94e8af5c7ecd13b57e1540.camel@analog.com>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
        <20191007101027.8383-3-manivannan.sadhasivam@linaro.org>
        <30c4a0f9aff5a40879d6839ad8a5ce40565f0923.camel@analog.com>
        <20191009094524.GA17962@Mani-XPS-13-9360>
        <391446566afd59da7d94e8af5c7ecd13b57e1540.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Oct 2019 10:21:27 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2019-10-09 at 15:15 +0530, Manivannan Sadhasivam wrote:
> > [External]
> > 
> > Hi Ardelean,

For some reason, my email client decided not to filter this thread
correctly so I didn't realise so much discussion had gone on when
I applied the newer version earlier today.  Oops.  Hopefully
there was nothing major outstanding.  Let me know if there was
as it's not yet in a non rebasing tree...

I've cropped to just where my name got mentioned ;)

..

> >   
> > > - Just curios here: there is gesture mode as well; will that be
> > > implemented
> > > later? Or will there be other modes implemented?  
> > 
> > Currently only proximity mode is implemented. There are gesture and
> > sample
> > modes and I left those as a TODO. But I'm not sure whether IIO is
> > supporting
> > gesture mode properly or not.  
> 
> I don't have any input on this at the moment [about gesture support & IIO].
> I'd have to investigate.
> Maybe Jonathan has some thoughts.

Properly is a hard term for gesture support.  The issue has always
been that every device does it slightly differently.  There are
way too many types of gesture that a device 'might' use.

We do have some drivers (IIRC) doing some gesture sensing, but you may
well find places where things need to expand!

...
> > > > +static int adux1020_read_raw(struct iio_dev *indio_dev,
> > > > +			     struct iio_chan_spec const *chan,
> > > > +			     int *val, int *val2, long mask)
> > > > +{
> > > > +	struct adux1020_data *data = iio_priv(indio_dev);
> > > > +	u16 buf[3];  
> > > 
> > > This buffer looks a bit weird. [8]
> > > It's 3 elements-wide and passed without any information about size.
> > > And only the first element is used.
> > > So, maybe just convert u16 buf[3] -> u16 buf?
> > >   
> > 
> > The buffer declaration is based on the hardware buffer available. It
> > is 3 elements wide since the remaining 2 elements will be used by other
> > modes. The idea here is to reuse the adux1020_measure() API for all 3
> > modes (which has varying buffer sizes).  
> 
> The only thought I have left about this buffer [and forgot to mention it
> earlier], is whether this should be cacheline aligned [or not].
> If it has to be, then maybe it shouldn't be stored on the stack and moved
> to a malloc-ed buffer [on "struct adux1020_data"].
> Cacheline aligned stuff typically deals with potential DMA issues. The DMA
> issues [in this case] could be coming from i2c controllers that can do DMA.
> 
> Jonathan may have more input here.
> 
The i2c subsystem in general doesn't assume that buffers are dma safe
though it would like to ;)

Wolfram did a good presentation on his efforts to sort that out at
ELCE 2018

https://www.youtube.com/watch?v=JDwaMClvV-s


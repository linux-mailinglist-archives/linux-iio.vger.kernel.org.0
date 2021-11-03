Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35A4446F2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhKCRXk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 3 Nov 2021 13:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhKCRXj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 13:23:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281BB61073;
        Wed,  3 Nov 2021 17:21:01 +0000 (UTC)
Date:   Wed, 3 Nov 2021 17:25:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211103172534.5fddfcf3@jic23-huawei>
In-Reply-To: <PH0PR03MB6366D6B1B17D3882FF2E35FA998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211027092333.5270-1-antoniu.miclaus@analog.com>
        <20211027184324.51811ef1@jic23-huawei>
        <CY4PR03MB3399339315289769615E4DCD9B869@CY4PR03MB3399.namprd03.prod.outlook.com>
        <20211028113101.0587a658@jic23-huawei>
        <PH0PR03MB636669F27992B59B8A7B603D99879@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211030161435.6ceaab21@jic23-huawei>
        <PH0PR03MB6366D6B1B17D3882FF2E35FA998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Nov 2021 10:00:58 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, October 30, 2021 5:15 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>;
> > robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lars-Peter
> > Clausen <lars@metafoo.de>
> > Subject: Re: [PATCH v2 1/2] iio: frequency: admv1013: add support for
> > ADMV1013
> > 
> > [External]
> > 
> > On Fri, 29 Oct 2021 07:49:41 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > Hi Jonathan,
> > >  
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Thursday, October 28, 2021 12:31 PM
> > > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > > Cc: robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Sa,  
> > Nuno  
> > > > <Nuno.Sa@analog.com>; Lars-Peter Clausen <lars@metafoo.de>
> > > > Subject: Re: [PATCH v2 1/2] iio: frequency: admv1013: add support  
> > for  
> > > > ADMV1013
> > > >
> > > > On Thu, 28 Oct 2021 10:08:08 +0000
> > > > "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
> > > >  
> > > > > Hello Jonathan,
> > > > >
> > > > > Thanks for the review!
> > > > >
> > > > > Regarding the interface for the Mixer Offset adjustments:
> > > > > ADMV1013_MIXER_OFF_ADJ_P
> > > > > ADMV1013_MIXER_OFF_ADJ_N
> > > > >
> > > > > These parameters are related to the LO feedthrough offset  
> > > > calibration.  
> > > > > (LO and sideband suppression)
> > > > >
> > > > > On this matter, my suggestion would be to add IIO calibration  
> > types,  
> > > > something like:  
> > > > > IIO_CHAN_INFO_CALIBFEEDTROUGH_POS
> > > > > IIO_CHAN_INFO_CALIBFEEDTROUGH_NEG  
> > > >
> > > > These sound too specific to me - we want an interface that is
> > > > potentially useful
> > > > in other places.  They are affecting the 'channel' which here is
> > > > simply an alt voltage channel, but I'm assuming it's something like
> > > > separate analog tweaks to the positive and negative of the  
> > differential  
> > > > pair?  
> > >
> > > That's also my understanding. This kind of calibration seems to be  
> > very  
> > > specific for TX local oscillators...
> > >  
> > > > Current channel is represented as a single index, but one route to  
> > this  
> > > > would be
> > > > to have it as a differential pair.
> > > >
> > > > out_altvoltage0-1_phase
> > > > for the attribute that applies at the level of the differential pair and
> > > >
> > > > out_altvoltage0_calibbias
> > > > out_altvoltage1_calibbias
> > > > For the P and N signal specific attributes.  
> > >
> > > Honestly, I'm not very enthusiastic with having out_altvoltage{0|1}  
> > as the  
> > > this applies to a single channel... Having this with separate indexes  
> > feels  
> > > odd to me. Even though we have the phase with "0-1", this can be a  
> > place  
> > > for misuse and confusion...
> > >
> > > I was thinking about modifiers (to kind of represent differential  
> > channels)  
> > > but I don't think it would work out here... What about  
> > IIO_CHAN_INFO_CALIBBIAS_P  
> > > and  IIO_CHAN_INFO_CALIBBIAS_N? Or maybe just something like
> > > IIO_CHAN_INFO_CALIBBIAS_DIFF and internally in IIO we would  
> > automatically  
> > > create both P and N sysfs files since I don't think it makes senses in  
> > any case to  
> > > just define one of the calibrations... Anyways, these are my 5 cents :)  
> > 
> > Definitely not a modifier.  It's almost arguable that these are different
> > characteristics of the channel so I can live with the ABI perhaps, but
> > unless this is a very common thing I'm not sure I want to burn 2 chan
> > info
> > bits for them. Note we are running very low on those anyway without
> > changing
> > how those are handled.  We will need to tackle that anyway, but let's
> > not
> > tie that to this driver.  
> 
> Hmm, Honestly I was not even thinking about the mask size and used
> bits. But I guess it's very unlikely for a driver to define lots of bits in one
> of the masks (just curious)?

It's a fairly small set in most cases, but as it is a bitmap that doesn't
help us.  We still need to fit in an unsigned long (so 32 bits).

Any change to how we do this may be painful.  We might just jump to the
BIT_ULL() approach for now and be a bit more resistant to adding more
entries in future.


> 
> > I don't like the idea of adding core magic to spin multiple files from one
> > without more usecases.  So for now use extended attributes for these
> > if
> > we go this way.
> > 
> > I think I still prefer the separate channels approach.  Note this is how
> > we deal with devices that are capable of either single ended or
> > differential
> > operation.  The channel numbering is reflecting the wire in both cases.
> > However, I'm not sure we've ever made it clear the ABI would apply
> > like this.
> > We may have devices that use this interface but expect it to not apply
> > to
> > the differential case....
> >   
> 
> Well, you actually gave me something to think about over the weekend and
> I'm getting more convinced with the ABI you purposed here. Getting all
> the bits in one differential channel could lead to having to "duplicate" bit masks
> to differentiate between P and N. Or we would have to do some non obvious
> handling in the core as I was suggesting.
> 
> With your ABI, the "single ended" files already differentiate the pair. The only
> thing we might be missing is to have a clear rule in the ABI docs. Like, if we have
>  
> out_altvoltageX-Y_phase and then 
> 
> out_altvoltageX_calibbias
> out_altvoltageY_calibbias,
> 
> it should be clear that X is the N part of the pair while Y is P. Or the other way
> around... The point is to have a clear rule.

differential channel is X-Y so P-N would be how I would interpret it.

> 
> However, looking at the new series spin, it looks to me that we have an issue
> that Antoniu might have to address in the series... These channels are both differential
> and use modifiers and If I'm not missing nothing, we use channel2 for both cases.

ouch.  That indeed is going to blow up.  Can't have modified differential channels
and that is very hard to work around because of lack of space in the events format.

I couldn't think of a reason why we'd have differential modified channels when
I made this stuff up...

Jonathan


> 
> I will leave a comment in the series which might be better...
> 
> - Nuno Sá
> >   
> > >
> > > - Nuno Sá  
> 


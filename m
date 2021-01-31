Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC0309C3E
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhAaM7S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 31 Jan 2021 07:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhAaLgs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 06:36:48 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD1264E10;
        Sun, 31 Jan 2021 11:36:01 +0000 (UTC)
Date:   Sun, 31 Jan 2021 11:35:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH 0/4] Fix/Improve sync clock mode handling
Message-ID: <20210131113557.0cba0496@archlinux>
In-Reply-To: <CY4PR03MB2631C3338B5930546C5EB6C399BD9@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
        <20210124142036.44f7d58f@archlinux>
        <CY4PR03MB2631C3338B5930546C5EB6C399BD9@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Jan 2021 09:16:19 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, January 24, 2021 3:21 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Rob
> > Herring <robh+dt@kernel.org>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; Lars-Peter Clausen <lars@metafoo.de>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Ardelean,
> > Alexandru <alexandru.Ardelean@analog.com>
> > Subject: Re: [PATCH 0/4] Fix/Improve sync clock mode handling
> > 
> > 
> > On Thu, 21 Jan 2021 12:49:50 +0100
> > Nuno Sá <nuno.sa@analog.com> wrote:
> >   
> > > The first patch in this series is just a simple helper to lock/unlock
> > > the device. Having these helpers make the code slightly neater  
> > (IMHO).  
> > >
> > > The following patches introduces changes in the sampling frequency
> > > calculation when sync scale/pps modes are used. First, it's important
> > > to understand the purpose of this mode and how it should be used.  
> > Let's  
> > > say our part has an internal rate of 4250 (e.g adis1649x family) and  
> > the  
> > > user wants an output rate of 200SPS. Obviously, we can't use this
> > > sampling rate and divide back down to get 200 SPS with decimation  
> > on.  
> > > Hence, we can use this mode to give an input clock of 1HZ, scale it to
> > > something like 4200 or 4000 SPS and then use the decimation filter to  
> > get  
> > > the exact desired 200SPS. There are also some limits that should be
> > > taken into account when scaling:
> > >
> > >  * For the devices in the adis16475 driver:
> > >      - Input sync frequency range is 1 to 128 Hz
> > >      - Native sample rate: 2 kSPS.  Optimal range: 1900-2100 sps
> > >
> > >  * For the adis1649x family (adis16480 driver):
> > >     - Input sync frequency range is 1 to 128 Hz
> > >     - Native sample rate: 4.25 kSPS.  Optimal range: 4000-4250 sps
> > >
> > > I'm not 100% convinced on how to handle the optimal minimum. For  
> > now,  
> > > I'm just throwing a warning saying we might get into trouble if we get  
> > a  
> > > value lower than that. I was also tempted to just return -EINVAL or
> > > clamp the value. However, I know that there are ADI customers that
> > > (for some reason) are using a sampling rate lower than the minimum
> > > advised.  
> > 
> > So the opening question I'd have here is how critical is the actual
> > userspace sampling rate to your users?   Often they don't mind
> > getting a little more data than they asked for (say 200.5Hz when asking
> > for 200) and can always read back the attribute after writing it to
> > discover this has happened.  
> 
> Well, honestly I'm not really sure here. I can just say (from the info I got internally) that some
> users are really using these parts with a data rate lower than the advised. However, I'd say
> that this would depend on the use case. For some critical cases, I would expect that users really
> want to have an exact sample rate. Though I'd argue that in those cases, they should know what
> they are doing and provide an output rate that fits nicely (multiple of both the input clock and IMU
> internal sample rate). And as you said, they can always readback the value to check if they are
> getting something that is not really what they expect...
> 
> > As such, once you've discovered that value doesn't have an exact
> > match, perhaps tweak the output data rate until it fits nicely?  
> 
> I did thought about this. The reason why I didn't went for it in this first version is because of those
> who seems to really want to run the part at lower rates. Let's assume we have an input clock of
> 1HZ and someone writes an output rate of 3000SPS. The only way to accomplish this is to set
> sync_scale at 3000 and let the IMU run at 3000SPS with decimation off (DEC_RATE=0). If we are
> going to tweak the output rate to fit nicely, we would have to force it to 4000SPS which is
> significantly different from the desired 3000SPS.

Good point. If someone wants to do that there isn't much we can do
to make it work nicely.  I'd argue they are wrong and move it to
the nearest within the constraints, but that might be rather unexpected
for them... 

I wonder if we do something ugly like have an extra control to
say 'really do what I say even if it's horrible'.
That would mean we'd get what 'most' users expect (I hope) in that
it's within the documented range, but provide the control to those
who want to do something horrible..  Not nice, what do you think?

> 
> > A bit of quick investigation suggests (by my wife who happened
> > to be sat across the room) suggests that you have a hideous set
> > of local minima so your best bet is to brute force search
> > (not that bad and we don't expect to change this a lot!)  
> 
> Hmm, not sure what do you have in mind here :)?

You have two controllable parameters both of which are integers.  As such
there isn't a nice easy 'right' answer for what combination to use.
For example, if we have a case where there is no right answer, you
will have to search for every possible multiplier, find the best divisor
and check how far that is above the desired frequency.  Of those
find the smallest one (best option given constraints).

Jonathan

> 
> - Nuno Sá
> 
> > >
> > > That said, the patch for the adis16480 driver is a fix as this mode was
> > > being wrongly handled. There should not be a "separation" between  
> > using  
> > > the sync_scale and the dec_rate registers. The way things were  
> > being done,  
> > > we could easily get into a situation where the part could be running  
> > with  
> > > an internal rate way lower than the optimal minimum.
> > >
> > > For the adis16475 drivers, things were not really wrong. They were  
> > just  
> > > not optimal as we were forcing users to specify the IMU scaled  
> > internal  
> > > rate once in the devicetree. Calculating things at runtime gives much
> > > more flexibility to choose the output rate.
> > >
> > > Nuno Sá (4):
> > >   iio: adis: add helpers for locking
> > >   iio: adis16480: fix pps mode sampling frequency math
> > >   iio: adis16475: improve sync scale mode handling
> > >   dt-bindings: adis16475: remove property
> > >
> > >  .../bindings/iio/imu/adi,adis16475.yaml       |   9 --
> > >  drivers/iio/imu/adis16475.c                   | 110 ++++++++++++----
> > >  drivers/iio/imu/adis16480.c                   | 120 +++++++++++++-----
> > >  include/linux/iio/imu/adis.h                  |  10 ++
> > >  4 files changed, 178 insertions(+), 71 deletions(-)
> > >  
> 


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA644597E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 19:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhKDSVW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 4 Nov 2021 14:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhKDSVW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Nov 2021 14:21:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21392611EF;
        Thu,  4 Nov 2021 18:18:41 +0000 (UTC)
Date:   Thu, 4 Nov 2021 18:23:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211104182317.2b448a43@jic23-huawei>
In-Reply-To: <SJ0PR03MB6359234D6DA5D0CC58DB1113998D9@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
        <PH0PR03MB6366548C1CE5476989662F74998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211103200325.3416988c@jic23-huawei>
        <SJ0PR03MB6359234D6DA5D0CC58DB1113998D9@SJ0PR03MB6359.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Nov 2021 08:11:12 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Wednesday, November 3, 2021 9:04 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>;
> > robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 1/2] iio: frequency: admv1013: add support for
> > ADMV1013
> > 
> > [External]
> > 
> > On Tue, 2 Nov 2021 10:09:15 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > > +#define ADMV1013_CHAN_PHASE(_channel, rf_comp) {		\
> > > > +	.type = IIO_ALTVOLTAGE,					\
> > > > +	.modified = 1,						\
> > > > +	.output = 1,						\
> > > > +	.indexed = 1,						\
> > > > +	.channel2 = IIO_MOD_##rf_comp,				\
> > > > +	.channel = _channel,					\
> > > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE)		\
> > > > +	}
> > > > +
> > > > +#define ADMV1013_CHAN_CALIB(_channel, rf_comp) {		\
> > > > +	.type = IIO_ALTVOLTAGE,					\
> > > > +	.modified = 1,						\
> > > > +	.output = 1,						\
> > > > +	.indexed = 1,						\
> > > > +	.channel2 = IIO_MOD_##rf_comp,				\
> > > > +	.channel = _channel,					\
> > > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS)	\
> > > > +	}
> > > > +
> > > > +static const struct iio_chan_spec admv1013_channels[] = {
> > > > +	ADMV1013_CHAN_PHASE(0, I),
> > > > +	ADMV1013_CHAN_PHASE(0, Q),
> > > > +	ADMV1013_CHAN_CALIB(0, I),
> > > > +	ADMV1013_CHAN_CALIB(0, Q),
> > > > +	ADMV1013_CHAN_CALIB(1, I),
> > > > +	ADMV1013_CHAN_CALIB(1, Q),
> > > > +};
> > > > +  
> > >
> > > Hmm, If I'm not missing nothing this leads to something like:
> > >
> > > out_altvoltage0_i_phase
> > > out_altvoltage0_q_phase
> > > out_altvoltage0_i_calibbias
> > > out_altvoltage0_q_calibbias
> > > out_altvoltage1_i_calibbias
> > > out_altvoltage1_q_calibbias
> > >
> > > To me it is really non obvious that index 1 also applies to the same
> > > channel. I see that we have this like this probably because we
> > > can't use modified and differential at the same time, right?
> > >  
> > 
> > Indeed, this is the problem you mentioned in the discussion on v2
> > My suggestion of making it clear it is a differential channel and then
> > applying calibbias to the parts doesn't work as it would need to
> > have both modifiers and a second channel index.
> > As for why that is an issue, it comes down to trying to keep the
> > event interface descriptive, but still minimal.  We basically ran
> > out of bits and at the time I couldn't think of a reason we'd want
> > both differential and a modifier...  
> 
> I'm not really seeing the issue with the event interface but that is mostly
> because I still never had to deal with it, so I never looked that deeply into
> the code. Might be a good time know :)

not that it really matters for this discussion, but meh - I know where
to look :)

/**
 * IIO_EVENT_CODE() - create event identifier
 * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
 * @diff:	Whether the event is for an differential channel or not.
 * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
 * @direction:	Direction of the event. One of enum iio_event_direction.
 * @type:	Type of the event. Should be one of enum iio_event_type.
 * @chan:	Channel number for non-differential channels.
 * @chan1:	First channel number for differential channels.
 * @chan2:	Second channel number for differential channels.
 */
#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
		       type, chan, chan1, chan2)			\
	(((u64)type << 56) | ((u64)diff << 55) |			\
	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
	 ((u64)chan_type << 32) | (((u16)chan2) << 16) | ((u16)chan1) | \
	 ((u16)chan))

I'd forgotten the odd chan vs chan1 bit :)

Otherwise, key thing is we are running out of space in the 64 bits that
are pushed through the event kfifo.

> 
> > > Jonathan, I'm not sure what should be the done here... From the top  
> > of my  
> > > head  I guess we can either:
> > >
> > > * drop the modifiers (not perfect but also not that bad IMO)
> > > * tweak something adding extended info (not really neat)  
> > True, it's not neat but might be the way forwards for 'now'.. We don't
> > have
> > events or anything on this driver, so we could make it look right
> > without any
> > risk of not being able to extend it.  However it will probably come back
> > to bite
> > us and userspace may not expect whatever we do.
> > Horrible though it is you could use extend_name - which was originally
> > intended
> > to let us 'label special purpose channels'.  It was a bad idea, but is there
> > and
> > not going way any time soon.
> > 
> > If you did the differential thing and set extend_name = "i" etc that
> > might get us around the internal issue of reusing channel2 for mod and
> > differential
> > channel.  
> 
> Couldn't we use the label to achieve kind of the same? Or do you think
> that having the "i" and "q" in the filenames is really mandatory? 
https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L135

The i and q are ABI already, so we are stuck with them if we want to maintain
consistency.

> I can
> understand if you think they are as they are valid modifiers. OTOH,
> IIRC, with the latest patches from Paul, adding the extended_name will
> automatically get us the label sysfs file which might be a little odd but I
> guess that's already true for all the legacy drivers using it... So yeah,
> between this or extended info, we might have our "band aid" for this.

Ah good point.  Paul's stuff was to allow userspace to basically skip these
fields which in this case would be bad...

extended info is the best plan for now. We can always change that over to
a more standard option at a later date it turns out to be necessary.

Jonathan


> 
> > > * or handling this in the core with a new variable. Of course, we  
> > would need  
> > > to be careful to not break existing drivers...  
> > 
> > We would end up something hardly ever used so I'm doubtful that's a
> > good
> > idea until we have some visibility of how common it would be.  
> 
> True, most likely we would end up with a public variable only used in
> this use case... Better to wait if some users like this pop up.
> 
> - Nuno Sá


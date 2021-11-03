Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB38E444945
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhKCUB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 3 Nov 2021 16:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCUBv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 16:01:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B9F61073;
        Wed,  3 Nov 2021 19:59:12 +0000 (UTC)
Date:   Wed, 3 Nov 2021 20:03:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211103200325.3416988c@jic23-huawei>
In-Reply-To: <PH0PR03MB6366548C1CE5476989662F74998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
        <PH0PR03MB6366548C1CE5476989662F74998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Nov 2021 10:09:15 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > +#define ADMV1013_CHAN_PHASE(_channel, rf_comp) {		\
> > +	.type = IIO_ALTVOLTAGE,					\
> > +	.modified = 1,						\
> > +	.output = 1,						\
> > +	.indexed = 1,						\
> > +	.channel2 = IIO_MOD_##rf_comp,				\
> > +	.channel = _channel,					\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE)		\
> > +	}
> > +
> > +#define ADMV1013_CHAN_CALIB(_channel, rf_comp) {		\
> > +	.type = IIO_ALTVOLTAGE,					\
> > +	.modified = 1,						\
> > +	.output = 1,						\
> > +	.indexed = 1,						\
> > +	.channel2 = IIO_MOD_##rf_comp,				\
> > +	.channel = _channel,					\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS)	\
> > +	}
> > +
> > +static const struct iio_chan_spec admv1013_channels[] = {
> > +	ADMV1013_CHAN_PHASE(0, I),
> > +	ADMV1013_CHAN_PHASE(0, Q),
> > +	ADMV1013_CHAN_CALIB(0, I),
> > +	ADMV1013_CHAN_CALIB(0, Q),
> > +	ADMV1013_CHAN_CALIB(1, I),
> > +	ADMV1013_CHAN_CALIB(1, Q),
> > +};
> > +  
> 
> Hmm, If I'm not missing nothing this leads to something like:
> 
> out_altvoltage0_i_phase
> out_altvoltage0_q_phase
> out_altvoltage0_i_calibbias
> out_altvoltage0_q_calibbias
> out_altvoltage1_i_calibbias
> out_altvoltage1_q_calibbias
> 
> To me it is really non obvious that index 1 also applies to the same
> channel. I see that we have this like this probably because we
> can't use modified and differential at the same time, right?
> 

Indeed, this is the problem you mentioned in the discussion on v2
My suggestion of making it clear it is a differential channel and then
applying calibbias to the parts doesn't work as it would need to
have both modifiers and a second channel index.
As for why that is an issue, it comes down to trying to keep the
event interface descriptive, but still minimal.  We basically ran
out of bits and at the time I couldn't think of a reason we'd want
both differential and a modifier...

> Jonathan, I'm not sure what should be the done here... From the top of my
> head  I guess we can either:
> 
> * drop the modifiers (not perfect but also not that bad IMO)
> * tweak something adding extended info (not really neat)
True, it's not neat but might be the way forwards for 'now'.. We don't have
events or anything on this driver, so we could make it look right without any
risk of not being able to extend it.  However it will probably come back to bite
us and userspace may not expect whatever we do.
Horrible though it is you could use extend_name - which was originally intended
to let us 'label special purpose channels'.  It was a bad idea, but is there and
not going way any time soon.

If you did the differential thing and set extend_name = "i" etc that
might get us around the internal issue of reusing channel2 for mod and differential
channel.

> * or handling this in the core with a new variable. Of course, we would need
> to be careful to not break existing drivers...

We would end up something hardly ever used so I'm doubtful that's a good
idea until we have some visibility of how common it would be.

> 
> Not sure if labels could also be something to use... Any suggestion from your
> side?

Let me think a bit more on this for a day or two...

Jonathan

> 
> - Nuno Sá
> 


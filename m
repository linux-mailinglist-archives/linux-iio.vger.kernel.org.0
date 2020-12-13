Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8C2D8D0E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 13:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406676AbgLMMNE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 07:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406675AbgLMMNE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 07:13:04 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E5E22203;
        Sun, 13 Dec 2020 12:12:22 +0000 (UTC)
Date:   Sun, 13 Dec 2020 12:12:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
Message-ID: <20201213121219.6623bb13@archlinux>
In-Reply-To: <320464d8-659c-01de-0e08-34e4c744ef16@axentia.se>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
        <20201115174408.000b05d4@archlinux>
        <320464d8-659c-01de-0e08-34e4c744ef16@axentia.se>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Nov 2020 09:18:24 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> On 2020-11-15 18:44, Jonathan Cameron wrote:
> > On Mon,  2 Nov 2020 00:22:11 +0100
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >   
> >> It happens that an ADC will only provide raw or processed
> >> voltage conversion channels. (adc/ab8500-gpadc.c).
> >> On the Samsung GT-I9070 this is used for a light sensor
> >> and current sense amplifier so we need to think of something.
> >>
> >> The idea is to allow processed channels and scale them
> >> with 1/1 and then the rescaler can modify the result
> >> on top.
> >>
> >> Cc: Peter Rosin <peda@axentia.se>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> > 
> > Sorry, I kept leaving this to last as it was in the 'needed thought'
> > pile - then running out of time and not getting to it.
> > 
> > Anyhow, I think this is the best we can do for the situation
> > you describe so I'm happy with this.
> > 
> > @Peter, I definitely want your input on this one as well though
> > before I apply it!  
> 
> Yes, sorry about the delay. Same pile here, amplified with way too much
> to do at work. My immediate reaction was that this is not that simple,
> but after looking at it for a few minutes I also came to think that it's
> perhaps the best that can be done.
> 
> But it's been a while, so it just took a while for things to dawn on me.
> 
> The rescaler passes on IIO_CHAN_INFO_RAW as-is to the underlying
> driver in the .read_avail op, and this patch xforms the processed
> channel into the raw channel. So that is a mismatch. I don't think
> it's easily fixable in the general case because the processed channel
> rarely, if ever, implements .read_avail?

There is nothing stopping them doing so if we have a particular usecase
that requires it.  To be honest, very few drivers implement read_avail
at all yet!

> And I don't know if it
> is allowed to return -EINVAL for the .read_avail op for the raw
> channel, because that would be the obvious patch to squash-in...

I'm not sure it matters. As things stand the rescale_configure_channel
queries if read_avail is available for the _RAW element only.
So currently we'd just not register that at all if only processed
is available.

It might be a nice to have, but there are plenty of other cases
where read_avail isn't provided and this driver might be used
so I'm not that fussed.

Thanks,

Jonathan

> 
> Cheers,
> Peter
> 
> 
> > Jonathan
> > 
> >   
> >> ---
> >>  drivers/iio/afe/iio-rescale.c | 31 +++++++++++++++++++++++++++----
> >>  1 file changed, 27 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> >> index e42ea2b1707d..ea90034cb257 100644
> >> --- a/drivers/iio/afe/iio-rescale.c
> >> +++ b/drivers/iio/afe/iio-rescale.c
> >> @@ -29,6 +29,7 @@ struct rescale {
> >>  	struct iio_channel *source;
> >>  	struct iio_chan_spec chan;
> >>  	struct iio_chan_spec_ext_info *ext_info;
> >> +	bool chan_processed;
> >>  	s32 numerator;
> >>  	s32 denominator;
> >>  };
> >> @@ -43,10 +44,27 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
> >>  
> >>  	switch (mask) {
> >>  	case IIO_CHAN_INFO_RAW:
> >> -		return iio_read_channel_raw(rescale->source, val);
> >> +		if (rescale->chan_processed)
> >> +			/*
> >> +			 * When only processed channels are supported, we
> >> +			 * read the processed data and scale it by 1/1
> >> +			 * augmented with whatever the rescaler has calculated.
> >> +			 */
> >> +			return iio_read_channel_processed(rescale->source, val);
> >> +		else
> >> +			return iio_read_channel_raw(rescale->source, val);
> >>  
> >>  	case IIO_CHAN_INFO_SCALE:
> >> -		ret = iio_read_channel_scale(rescale->source, val, val2);
> >> +		if (rescale->chan_processed) {
> >> +			/*
> >> +			 * Processed channels are scaled 1-to-1
> >> +			 */
> >> +			ret = IIO_VAL_FRACTIONAL;
> >> +			*val = 1;
> >> +			*val2 = 1;
> >> +		} else {
> >> +			ret = iio_read_channel_scale(rescale->source, val, val2);
> >> +		}
> >>  		switch (ret) {
> >>  		case IIO_VAL_FRACTIONAL:
> >>  			*val *= rescale->numerator;
> >> @@ -132,8 +150,13 @@ static int rescale_configure_channel(struct device *dev,
> >>  
> >>  	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
> >>  	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> >> -		dev_err(dev, "source channel does not support raw/scale\n");
> >> -		return -EINVAL;
> >> +		if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
> >> +			dev_info(dev, "using processed channel\n");
> >> +			rescale->chan_processed = true;
> >> +		} else {
> >> +			dev_err(dev, "source channel does not support raw+scale or processed data\n");
> >> +			return -EINVAL;
> >> +		}
> >>  	}
> >>  
> >>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  
> >   
> 


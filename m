Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB524571E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgHPJgp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgHPJgo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:36:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2682065C;
        Sun, 16 Aug 2020 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597570603;
        bh=juovi0J4Pza8QjxX62PquhxnT2vWe5L7cKG6gR8LUqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0WLEEcwMhr52vvlDJ3kLscapI/Q7bR7OlEp8i+jjcnAzZV0pSnzF7cWEANGf5t76I
         1Bzx6KySkUZBwBKkwrxT0qm2Ts7vyMIpVzxENw2qOgatAe9jTARVnliO5v/u9ZI+Zy
         yQz52jltvSFH5dDcIUFIleJ/jykll4+GBeZZSjwg=
Date:   Sun, 16 Aug 2020 10:36:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 07/15] iio: sx9310: Use long instead of int for
 channel bitmaps
Message-ID: <20200816103638.4669f841@archlinux>
In-Reply-To: <20200806193057.163e2363@archlinux>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
        <20200806193057.163e2363@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Aug 2020 19:30:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon,  3 Aug 2020 17:58:07 -0600
> Daniel Campello <campello@chromium.org> wrote:
> 
> > Uses for_each_set_bit() macro to loop over channel bitmaps.
> > 
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>  
> Applied,
> 
> Thanks,
> 
> Jonathan

0-day sent a rather silly warning on this, but in the interests of
suppressing noisy warnings I've fixed it...

> 
> > ---
> > 
> > Changes in v5: None
> > Changes in v4: None
> > Changes in v3:
> >  - Added static assert for number of channels.
> > 
> > Changes in v2:
> >  - Changed prox_stat to chan_prox_stat bitmap.
> > 
> >  drivers/iio/proximity/sx9310.c | 39 ++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 127b1ba79e2dea..f78500b8a5841e 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -119,6 +119,7 @@
> >  
> >  /* 4 hardware channels, as defined in STAT0: COMB, CS2, CS1 and CS0. */
> >  #define SX9310_NUM_CHANNELS				4
> > +static_assert(SX9310_NUM_CHANNELS < BITS_PER_LONG);
> >  
> >  struct sx9310_data {
> >  	/* Serialize access to registers and channel configuration */
> > @@ -130,7 +131,7 @@ struct sx9310_data {
> >  	 * Last reading of the proximity status for each channel.
> >  	 * We only send an event to user space when this changes.
> >  	 */
> > -	bool prox_stat[SX9310_NUM_CHANNELS];
> > +	unsigned long chan_prox_stat;
> >  	bool trigger_enabled;
> >  	/* Ensure correct alignment of timestamp when present. */
> >  	struct {
> > @@ -140,7 +141,8 @@ struct sx9310_data {
> >  	/* Remember enabled channels and sample rate during suspend. */
> >  	unsigned int suspend_ctrl0;
> >  	struct completion completion;
> > -	unsigned int chan_read, chan_event;
> > +	unsigned long chan_read;
> > +	unsigned long chan_event;
> >  	int channel_users[SX9310_NUM_CHANNELS];
> >  	unsigned int whoami;
> >  };
> > @@ -283,15 +285,16 @@ static const struct regmap_config sx9310_regmap_config = {
> >  };
> >  
> >  static int sx9310_update_chan_en(struct sx9310_data *data,
> > -				 unsigned int chan_read,
> > -				 unsigned int chan_event)
> > +				 unsigned long chan_read,
> > +				 unsigned long chan_event)
> >  {
> >  	int ret;
> > +	unsigned long channels = chan_read | chan_event;
> >  
> > -	if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
> > +	if ((data->chan_read | data->chan_event) != channels) {
> >  		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> >  					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
> > -					 chan_read | chan_event);
> > +					 channels);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -532,6 +535,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
> >  	unsigned int val, chan;
> >  	struct sx9310_data *data = iio_priv(indio_dev);
> >  	s64 timestamp = iio_get_time_ns(indio_dev);
> > +	unsigned long prox_changed;
> >  
> >  	/* Read proximity state on all channels */
> >  	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
> > @@ -540,24 +544,23 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
> >  		return;
> >  	}
> >  
> > -	for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
> > +	/*
> > +	 * Only iterate over channels with changes on proximity status that have
> > +	 * events enabled.
> > +	 */
> > +	prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
> > +
> > +	for_each_set_bit(chan, &prox_changed, SX9310_NUM_CHANNELS) {
> >  		int dir;
> >  		u64 ev;
> > -		bool new_prox = val & BIT(chan);
> > -
> > -		if (!(data->chan_event & BIT(chan)))
> > -			continue;
> > -		if (new_prox == data->prox_stat[chan])
> > -			/* No change on this channel. */
> > -			continue;
> >  
> > -		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> > +		dir = val & BIT(chan) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;

cpp check is moaning about no brackets around
val & BIT(CHAN) so I've added some.

> >  		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
> >  					  IIO_EV_TYPE_THRESH, dir);
> >  
> >  		iio_push_event(indio_dev, ev, timestamp);
> > -		data->prox_stat[chan] = new_prox;
> >  	}
> > +	data->chan_prox_stat = val;
> >  }
> >  
> >  static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
> > @@ -714,13 +717,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
> >  static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
> >  {
> >  	struct sx9310_data *data = iio_priv(indio_dev);
> > -	unsigned int channels = 0;
> > +	unsigned long channels = 0;
> >  	int bit, ret;
> >  
> >  	mutex_lock(&data->mutex);
> >  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> >  			 indio_dev->masklength)
> > -		channels |= BIT(indio_dev->channels[bit].channel);
> > +		__set_bit(indio_dev->channels[bit].channel, &channels);
> >  
> >  	ret = sx9310_update_chan_en(data, channels, data->chan_event);
> >  	mutex_unlock(&data->mutex);  
> 


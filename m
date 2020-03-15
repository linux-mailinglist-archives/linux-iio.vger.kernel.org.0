Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF9185D8D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgCOO3W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 10:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgCOO3W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 10:29:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE30120637;
        Sun, 15 Mar 2020 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584282560;
        bh=g/XtiFcOCpMkRNCNiifg/OxT7Kfc4B6UI+/R+2CYprg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eAQM1Rz6tSOFG6y6/5qN5vQUUlf7zHJPhBBHR49hB83mzPpJfbHaTC5lFBRjkEJwj
         NhsmFHpyE+JZWHzk0A4JT/PNP4tYG2PE6fh21JrkJdgEEuz6th7i6g+CZYEKtYshq+
         pkdVvfJf1T6DJOVg5xR4m7QVRXsRlDOzxwFsI4YU=
Date:   Sun, 15 Mar 2020 14:29:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200315142916.25ffa24f@archlinux>
In-Reply-To: <20200315140512.GA3260@icarus>
References: <20200313120057.GA17812@syed>
        <20200313165102.GA5024@icarus>
        <20200315120904.2475a9c1@archlinux>
        <20200315140512.GA3260@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 10:06:56 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Mar 15, 2020 at 12:09:04PM +0000, Jonathan Cameron wrote:
> > On Fri, 13 Mar 2020 12:51:02 -0400
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > On Fri, Mar 13, 2020 at 05:30:58PM +0530, Syed Nayyar Waris wrote:  
> > > > Add lock protection from race conditions to 104-quad-8 counter driver
> > > > generic interface code changes. There is no IRQ handling so spin_lock
> > > > calls are used for protection.
> > > > 
> > > > Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
> > > > 
> > > > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>    
> > > 
> > > Thanks Syed, this version looks good to me.
> > > 
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > 
> > > Jonathan, if you have no objections please pick up this series.  
> > 
> > One question.  Why not a mutex?  If there aren't an interrupts involved
> > that would normally be preferred.
> > 
> > Jonathan  
> 
> I don't think a mutex would be appropriate in this context would it?
> We're just executing some basic port I/O operations and briefly
> accessing shared data. Because everything we're doing is very
> short-term, there's no need for a mutex and adding one just adds the
> chance of putting the thread to sleep which would be a larger latency
> than simply waiting for the spinlock to be unlocked.

The mutex should only put the thread to sleep if it's contended.
Here that should be extremely rare.  The question of how large the
latency is comes down to how contended we might be.  I guess we pretty
much assume we aren't actually contended here unless something weird
is going on.

> 
> (We don't necessarily need raw_spinlock_t since interrupts aren't
> involved, but I think the more generic spinlock_t is fine.)

That does allow the RT sleeping spin locks to work fine, but in that
case might as well just use a mutex in first place and have consistent
results.

Usually I'd be looking to use a mutex unless it was absolutely required
to use a spinlock. 

I'm not that fussed though and it's very unlikely to make much difference
in this case.  However, the statement in the patch title that we use
spin_lock as no IRQ calls is very confusing...  Note that I'm fairly
sure spin_lock and raw_spin_lock are currently the same thing unless
you have applied the RT patch set.

Jonathan

> 
> William Breathitt Gray
> 
> >   
> > > 
> > > William Breathitt Gray
> > >   
> > > > ---
> > > > Changes in v4:
> > > >  - Shift review-comments section so that its not saved in commit message.
> > > >  - Add spin_unlock calls for deadlock avoidance.
> > > >  - Change parameters of quad8_preset_register_set.
> > > >  - Few changes related to assignment statements.
> > > > 
> > > >  drivers/counter/104-quad-8.c | 194 +++++++++++++++++++++++++++++++++++--------
> > > >  1 file changed, 160 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> > > > index 9dab190..88decab 100644
> > > > --- a/drivers/counter/104-quad-8.c
> > > > +++ b/drivers/counter/104-quad-8.c
> > > > @@ -44,6 +44,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
> > > >   * @base:		base port address of the IIO device
> > > >   */
> > > >  struct quad8_iio {
> > > > +	spinlock_t lock;
> > > >  	struct counter_device counter;
> > > >  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
> > > >  	unsigned int preset[QUAD8_NUM_COUNTERS];
> > > > @@ -123,6 +124,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
> > > >  		/* Borrow XOR Carry effectively doubles count range */
> > > >  		*val = (borrow ^ carry) << 24;
> > > >  
> > > > +		spin_lock(&priv->lock);
> > > > +
> > > >  		/* Reset Byte Pointer; transfer Counter to Output Latch */
> > > >  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> > > >  		     base_offset + 1);
> > > > @@ -130,6 +133,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
> > > >  		for (i = 0; i < 3; i++)
> > > >  			*val |= (unsigned int)inb(base_offset) << (8 * i);
> > > >  
> > > > +		spin_unlock(&priv->lock);
> > > > +
> > > >  		return IIO_VAL_INT;
> > > >  	case IIO_CHAN_INFO_ENABLE:
> > > >  		*val = priv->ab_enable[chan->channel];
> > > > @@ -160,6 +165,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
> > > >  		if ((unsigned int)val > 0xFFFFFF)
> > > >  			return -EINVAL;
> > > >  
> > > > +		spin_lock(&priv->lock);
> > > > +
> > > >  		/* Reset Byte Pointer */
> > > >  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > >  
> > > > @@ -183,12 +190,16 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
> > > >  		/* Reset Error flag */
> > > >  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> > > >  
> > > > +		spin_unlock(&priv->lock);
> > > > +
> > > >  		return 0;
> > > >  	case IIO_CHAN_INFO_ENABLE:
> > > >  		/* only boolean values accepted */
> > > >  		if (val < 0 || val > 1)
> > > >  			return -EINVAL;
> > > >  
> > > > +		spin_lock(&priv->lock);
> > > > +
> > > >  		priv->ab_enable[chan->channel] = val;
> > > >  
> > > >  		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
> > > > @@ -196,11 +207,18 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
> > > >  		/* Load I/O control configuration */
> > > >  		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> > > >  
> > > > +		spin_unlock(&priv->lock);
> > > > +
> > > >  		return 0;
> > > >  	case IIO_CHAN_INFO_SCALE:
> > > > +		spin_lock(&priv->lock);
> > > > +
> > > >  		/* Quadrature scaling only available in quadrature mode */
> > > > -		if (!priv->quadrature_mode[chan->channel] && (val2 || val != 1))
> > > > +		if (!priv->quadrature_mode[chan->channel] &&
> > > > +				(val2 || val != 1)) {
> > > > +			spin_unlock(&priv->lock);
> > > >  			return -EINVAL;
> > > > +		}
> > > >  
> > > >  		/* Only three gain states (1, 0.5, 0.25) */
> > > >  		if (val == 1 && !val2)
> > > > @@ -214,11 +232,15 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
> > > >  				priv->quadrature_scale[chan->channel] = 2;
> > > >  				break;
> > > >  			default:
> > > > +				spin_unlock(&priv->lock);
> > > >  				return -EINVAL;
> > > >  			}
> > > > -		else
> > > > +		else {
> > > > +			spin_unlock(&priv->lock);
> > > >  			return -EINVAL;
> > > > +		}
> > > >  
> > > > +		spin_unlock(&priv->lock);
> > > >  		return 0;
> > > >  	}
> > > >  
> > > > @@ -255,6 +277,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
> > > >  	if (preset > 0xFFFFFF)
> > > >  		return -EINVAL;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	priv->preset[chan->channel] = preset;
> > > >  
> > > >  	/* Reset Byte Pointer */
> > > > @@ -264,6 +288,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
> > > >  	for (i = 0; i < 3; i++)
> > > >  		outb(preset >> (8 * i), base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return len;
> > > >  }
> > > >  
> > > > @@ -293,6 +319,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
> > > >  	/* Preset enable is active low in Input/Output Control register */
> > > >  	preset_enable = !preset_enable;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	priv->preset_enable[chan->channel] = preset_enable;
> > > >  
> > > >  	ior_cfg = priv->ab_enable[chan->channel] |
> > > > @@ -301,6 +329,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
> > > >  	/* Load I/O control configuration to Input / Output Control Register */
> > > >  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return len;
> > > >  }
> > > >  
> > > > @@ -358,6 +388,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
> > > >  	unsigned int mode_cfg = cnt_mode << 1;
> > > >  	const int base_offset = priv->base + 2 * chan->channel + 1;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	priv->count_mode[chan->channel] = cnt_mode;
> > > >  
> > > >  	/* Add quadrature mode configuration */
> > > > @@ -367,6 +399,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
> > > >  	/* Load mode configuration to Counter Mode Register */
> > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -394,19 +428,26 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
> > > >  	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
> > > >  {
> > > >  	struct quad8_iio *const priv = iio_priv(indio_dev);
> > > > -	const unsigned int idr_cfg = synchronous_mode |
> > > > -		priv->index_polarity[chan->channel] << 1;
> > > >  	const int base_offset = priv->base + 2 * chan->channel + 1;
> > > > +	unsigned int idr_cfg = synchronous_mode;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	idr_cfg |= priv->index_polarity[chan->channel] << 1;
> > > >  
> > > >  	/* Index function must be non-synchronous in non-quadrature mode */
> > > > -	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
> > > > +	if (synchronous_mode && !priv->quadrature_mode[chan->channel]) {
> > > > +		spin_unlock(&priv->lock);
> > > >  		return -EINVAL;
> > > > +	}
> > > >  
> > > >  	priv->synchronous_mode[chan->channel] = synchronous_mode;
> > > >  
> > > >  	/* Load Index Control configuration to Index Control Register */
> > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -434,8 +475,12 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
> > > >  	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
> > > >  {
> > > >  	struct quad8_iio *const priv = iio_priv(indio_dev);
> > > > -	unsigned int mode_cfg = priv->count_mode[chan->channel] << 1;
> > > >  	const int base_offset = priv->base + 2 * chan->channel + 1;
> > > > +	unsigned int mode_cfg;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	mode_cfg = priv->count_mode[chan->channel] << 1;
> > > >  
> > > >  	if (quadrature_mode)
> > > >  		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
> > > > @@ -453,6 +498,8 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
> > > >  	/* Load mode configuration to Counter Mode Register */
> > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -480,15 +527,20 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
> > > >  	const struct iio_chan_spec *chan, unsigned int index_polarity)
> > > >  {
> > > >  	struct quad8_iio *const priv = iio_priv(indio_dev);
> > > > -	const unsigned int idr_cfg = priv->synchronous_mode[chan->channel] |
> > > > -		index_polarity << 1;
> > > >  	const int base_offset = priv->base + 2 * chan->channel + 1;
> > > > +	unsigned int idr_cfg = index_polarity << 1;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	idr_cfg |= priv->synchronous_mode[chan->channel];
> > > >  
> > > >  	priv->index_polarity[chan->channel] = index_polarity;
> > > >  
> > > >  	/* Load Index Control configuration to Index Control Register */
> > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -589,7 +641,7 @@ static int quad8_signal_read(struct counter_device *counter,
> > > >  static int quad8_count_read(struct counter_device *counter,
> > > >  	struct counter_count *count, unsigned long *val)
> > > >  {
> > > > -	const struct quad8_iio *const priv = counter->priv;
> > > > +	struct quad8_iio *const priv = counter->priv;
> > > >  	const int base_offset = priv->base + 2 * count->id;
> > > >  	unsigned int flags;
> > > >  	unsigned int borrow;
> > > > @@ -603,6 +655,8 @@ static int quad8_count_read(struct counter_device *counter,
> > > >  	/* Borrow XOR Carry effectively doubles count range */
> > > >  	*val = (unsigned long)(borrow ^ carry) << 24;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	/* Reset Byte Pointer; transfer Counter to Output Latch */
> > > >  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> > > >  	     base_offset + 1);
> > > > @@ -610,13 +664,15 @@ static int quad8_count_read(struct counter_device *counter,
> > > >  	for (i = 0; i < 3; i++)
> > > >  		*val |= (unsigned long)inb(base_offset) << (8 * i);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > >  static int quad8_count_write(struct counter_device *counter,
> > > >  	struct counter_count *count, unsigned long val)
> > > >  {
> > > > -	const struct quad8_iio *const priv = counter->priv;
> > > > +	struct quad8_iio *const priv = counter->priv;
> > > >  	const int base_offset = priv->base + 2 * count->id;
> > > >  	int i;
> > > >  
> > > > @@ -624,6 +680,8 @@ static int quad8_count_write(struct counter_device *counter,
> > > >  	if (val > 0xFFFFFF)
> > > >  		return -EINVAL;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	/* Reset Byte Pointer */
> > > >  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > >  
> > > > @@ -647,6 +705,8 @@ static int quad8_count_write(struct counter_device *counter,
> > > >  	/* Reset Error flag */
> > > >  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -667,13 +727,13 @@ static enum counter_count_function quad8_count_functions_list[] = {
> > > >  static int quad8_function_get(struct counter_device *counter,
> > > >  	struct counter_count *count, size_t *function)
> > > >  {
> > > > -	const struct quad8_iio *const priv = counter->priv;
> > > > +	struct quad8_iio *const priv = counter->priv;
> > > >  	const int id = count->id;
> > > > -	const unsigned int quadrature_mode = priv->quadrature_mode[id];
> > > > -	const unsigned int scale = priv->quadrature_scale[id];
> > > >  
> > > > -	if (quadrature_mode)
> > > > -		switch (scale) {
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	if (priv->quadrature_mode[id])
> > > > +		switch (priv->quadrature_scale[id]) {
> > > >  		case 0:
> > > >  			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> > > >  			break;
> > > > @@ -687,6 +747,8 @@ static int quad8_function_get(struct counter_device *counter,
> > > >  	else
> > > >  		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -697,10 +759,15 @@ static int quad8_function_set(struct counter_device *counter,
> > > >  	const int id = count->id;
> > > >  	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
> > > >  	unsigned int *const scale = priv->quadrature_scale + id;
> > > > -	unsigned int mode_cfg = priv->count_mode[id] << 1;
> > > >  	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
> > > > -	const unsigned int idr_cfg = priv->index_polarity[id] << 1;
> > > >  	const int base_offset = priv->base + 2 * id + 1;
> > > > +	unsigned int mode_cfg;
> > > > +	unsigned int idr_cfg;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	mode_cfg = priv->count_mode[id] << 1;
> > > > +	idr_cfg = priv->index_polarity[id] << 1;
> > > >  
> > > >  	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
> > > >  		*quadrature_mode = 0;
> > > > @@ -736,6 +803,8 @@ static int quad8_function_set(struct counter_device *counter,
> > > >  	/* Load mode configuration to Counter Mode Register */
> > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -852,15 +921,20 @@ static int quad8_index_polarity_set(struct counter_device *counter,
> > > >  {
> > > >  	struct quad8_iio *const priv = counter->priv;
> > > >  	const size_t channel_id = signal->id - 16;
> > > > -	const unsigned int idr_cfg = priv->synchronous_mode[channel_id] |
> > > > -		index_polarity << 1;
> > > >  	const int base_offset = priv->base + 2 * channel_id + 1;
> > > > +	unsigned int idr_cfg = index_polarity << 1;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	idr_cfg |= priv->synchronous_mode[channel_id];
> > > >  
> > > >  	priv->index_polarity[channel_id] = index_polarity;
> > > >  
> > > >  	/* Load Index Control configuration to Index Control Register */
> > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -887,19 +961,26 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
> > > >  {
> > > >  	struct quad8_iio *const priv = counter->priv;
> > > >  	const size_t channel_id = signal->id - 16;
> > > > -	const unsigned int idr_cfg = synchronous_mode |
> > > > -		priv->index_polarity[channel_id] << 1;
> > > >  	const int base_offset = priv->base + 2 * channel_id + 1;
> > > > +	unsigned int idr_cfg = synchronous_mode;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > > +	idr_cfg |= priv->index_polarity[channel_id] << 1;
> > > >  
> > > >  	/* Index function must be non-synchronous in non-quadrature mode */
> > > > -	if (synchronous_mode && !priv->quadrature_mode[channel_id])
> > > > +	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
> > > > +		spin_unlock(&priv->lock);
> > > >  		return -EINVAL;
> > > > +	}
> > > >  
> > > >  	priv->synchronous_mode[channel_id] = synchronous_mode;
> > > >  
> > > >  	/* Load Index Control configuration to Index Control Register */
> > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -964,6 +1045,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
> > > >  		break;
> > > >  	}
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	priv->count_mode[count->id] = cnt_mode;
> > > >  
> > > >  	/* Set count mode configuration value */
> > > > @@ -976,6 +1059,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
> > > >  	/* Load mode configuration to Counter Mode Register */
> > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -1017,6 +1102,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
> > > >  	if (err)
> > > >  		return err;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	priv->ab_enable[count->id] = ab_enable;
> > > >  
> > > >  	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
> > > > @@ -1024,6 +1111,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
> > > >  	/* Load I/O control configuration */
> > > >  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return len;
> > > >  }
> > > >  
> > > > @@ -1052,14 +1141,28 @@ static ssize_t quad8_count_preset_read(struct counter_device *counter,
> > > >  	return sprintf(buf, "%u\n", priv->preset[count->id]);
> > > >  }
> > > >  
> > > > +void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
> > > > +		unsigned int preset)
> > > > +{
> > > > +	const unsigned int base_offset = quad8iio->base + 2 * id;
> > > > +	int i;
> > > > +
> > > > +	quad8iio->preset[id] = preset;
> > > > +
> > > > +	/* Reset Byte Pointer */
> > > > +	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > > +
> > > > +	/* Set Preset Register */
> > > > +	for (i = 0; i < 3; i++)
> > > > +		outb(preset >> (8 * i), base_offset);
> > > > +}
> > > > +
> > > >  static ssize_t quad8_count_preset_write(struct counter_device *counter,
> > > >  	struct counter_count *count, void *private, const char *buf, size_t len)
> > > >  {
> > > >  	struct quad8_iio *const priv = counter->priv;
> > > > -	const int base_offset = priv->base + 2 * count->id;
> > > >  	unsigned int preset;
> > > >  	int ret;
> > > > -	int i;
> > > >  
> > > >  	ret = kstrtouint(buf, 0, &preset);
> > > >  	if (ret)
> > > > @@ -1069,14 +1172,11 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
> > > >  	if (preset > 0xFFFFFF)
> > > >  		return -EINVAL;
> > > >  
> > > > -	priv->preset[count->id] = preset;
> > > > +	spin_lock(&priv->lock);
> > > >  
> > > > -	/* Reset Byte Pointer */
> > > > -	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > > +	quad8_preset_register_set(priv, count->id, preset);
> > > >  
> > > > -	/* Set Preset Register */
> > > > -	for (i = 0; i < 3; i++)
> > > > -		outb(preset >> (8 * i), base_offset);
> > > > +	spin_unlock(&priv->lock);
> > > >  
> > > >  	return len;
> > > >  }
> > > > @@ -1084,15 +1184,20 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
> > > >  static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
> > > >  	struct counter_count *count, void *private, char *buf)
> > > >  {
> > > > -	const struct quad8_iio *const priv = counter->priv;
> > > > +	struct quad8_iio *const priv = counter->priv;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > >  
> > > >  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
> > > >  	switch (priv->count_mode[count->id]) {
> > > >  	case 1:
> > > >  	case 3:
> > > > -		return quad8_count_preset_read(counter, count, private, buf);
> > > > +		spin_unlock(&priv->lock);
> > > > +		return sprintf(buf, "%u\n", priv->preset[count->id]);
> > > >  	}
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
> > > >  	return sprintf(buf, "33554431\n");
> > > >  }
> > > > @@ -1101,15 +1206,29 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
> > > >  	struct counter_count *count, void *private, const char *buf, size_t len)
> > > >  {
> > > >  	struct quad8_iio *const priv = counter->priv;
> > > > +	unsigned int ceiling;
> > > > +	int ret;
> > > > +
> > > > +	ret = kstrtouint(buf, 0, &ceiling);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Only 24-bit values are supported */
> > > > +	if (ceiling > 0xFFFFFF)
> > > > +		return -EINVAL;
> > > > +
> > > > +	spin_lock(&priv->lock);
> > > >  
> > > >  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
> > > >  	switch (priv->count_mode[count->id]) {
> > > >  	case 1:
> > > >  	case 3:
> > > > -		return quad8_count_preset_write(counter, count, private, buf,
> > > > -						len);
> > > > +		quad8_preset_register_set(priv, count->id, ceiling);
> > > > +		break;
> > > >  	}
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return len;
> > > >  }
> > > >  
> > > > @@ -1137,6 +1256,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
> > > >  	/* Preset enable is active low in Input/Output Control register */
> > > >  	preset_enable = !preset_enable;
> > > >  
> > > > +	spin_lock(&priv->lock);
> > > > +
> > > >  	priv->preset_enable[count->id] = preset_enable;
> > > >  
> > > >  	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
> > > > @@ -1144,6 +1265,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
> > > >  	/* Load I/O control configuration to Input / Output Control Register */
> > > >  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> > > >  
> > > > +	spin_unlock(&priv->lock);
> > > > +
> > > >  	return len;
> > > >  }
> > > >  
> > > > @@ -1429,6 +1552,9 @@ static int quad8_probe(struct device *dev, unsigned int id)
> > > >  	quad8iio->counter.priv = quad8iio;
> > > >  	quad8iio->base = base[id];
> > > >  
> > > > +	/* Initialize spin lock */
> > > > +	spin_lock_init(&quad8iio->lock);
> > > > +
> > > >  	/* Reset all counters and disable interrupt function */
> > > >  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> > > >  	/* Set initial configuration for all counters */
> > > > -- 
> > > > 2.7.4
> > > >     
> >   


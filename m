Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F11C2706
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEBQhq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 12:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgEBQho (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 12:37:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 788B621775;
        Sat,  2 May 2020 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588437463;
        bh=mp5eWd3dyWdSRPKPSqE5UHQ/nRbmvCuR2K27RMW+TEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wFlzp2KYHyJ0SreeC5LPUYMuCiUW6igSwpQvJwLoY37XaNuVW8UoWPdU2chdNDnqc
         pKGiZhsxfYz180T3HzX0mhyIbgRMXbwOQsL0ts5NFkVysBjGu+JudjRJaST4XQwPr+
         YPvACyT2FvNRq7Pgx5n8Qhy6nRnybwcVxG8/nK90=
Date:   Sat, 2 May 2020 17:37:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
Message-ID: <20200502173738.66dbc888@archlinux>
In-Reply-To: <20200428075101.GA6908@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
        <20200422141135.86419-2-tomasz.duszynski@octakon.com>
        <20200425195534.2ac91fe6@archlinux>
        <20200428075101.GA6908@arch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 09:51:01 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> On Sat, Apr 25, 2020 at 07:55:34PM +0100, Jonathan Cameron wrote:
> > On Wed, 22 Apr 2020 16:11:30 +0200
> > Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
> >  
> > > Add Sensirion SCD30 carbon dioxide core driver.
> > >
> > > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>  
> > Hi Tomasz
> >
> > As you've probably guessed the big questions are around the custom ABI.
> >
> > Few other things inline.
> >
> > Jonathan
> >  
...

> > > +static int scd30_read_meas(struct scd30_state *state)
> > > +{
> > > +	int i, ret;
> > > +
> > > +	ret = scd30_command(state, CMD_READ_MEAS, 0, (char *)state->meas,
> > > +			    sizeof(state->meas));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(state->meas); i++)
> > > +		state->meas[i] = scd30_float_to_fp(state->meas[i]);  
> >
> > We have previously discussed proving direct floating point channel types
> > for the rare devices that actually provide floating point data in
> > a standard format.
> >
> > I'm happy to revisit that if you would like to.
> >  
> 
> Thanks for reminding me :).
> 
> In that case I admit that some float helper in iio would be a good thing to
> have. Especially that there will be at least 2 sensors using it.
> 
> I'd work on that after this driver makes it into the tree.
> 
> How does it sound?

The problem is that, if we do it in that order we have ABI for this
device that we should really maintain.  We can probably get away
with changing it on the basis the channel type is self describing anyway
but it's not ideal.  

So probably fine but not best practice...

> 
> > > +
> > > +	/*
> > > +	 * Accuracy within calibrated operating range is
> > > +	 * +-(30ppm + 3% measurement) so fractional part does
> > > +	 * not add real value. Moreover, ppm is an integer.
> > > +	 */
> > > +	state->meas[CONC] /= 100;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int scd30_wait_meas_irq(struct scd30_state *state)
> > > +{
> > > +	int ret, timeout = msecs_to_jiffies(state->meas_interval * 1250);
> > > +
> > > +	reinit_completion(&state->meas_ready);
> > > +	enable_irq(state->irq);  
> >
> > So this is just 'grab the next one'?
> >  
> 
> Yes, grab the fresh one. Moreover enabling interrupts only when necessary can
> limit pointless buss traffic. Reason being irq is acknowledged by reading data
> from sensor.
> 

As mentioned below, it seems to me that we should really be starting this
device only when we want a reading.  Hence any interrupt (subject to possible
races) should be valid.  Hence we would not be enabling and disabling the
interrupt controller mask on this line.


> > > +static int scd30_setup_trigger(struct iio_dev *indio_dev)
> > > +{
> > > +	struct scd30_state *state = iio_priv(indio_dev);
> > > +	struct device *dev = indio_dev->dev.parent;
> > > +	struct iio_trigger *trig;
> > > +	int ret;
> > > +
> > > +	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> > > +				      indio_dev->id);
> > > +	if (!trig) {
> > > +		dev_err(dev, "failed to allocate trigger\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	trig->dev.parent = dev;
> > > +	trig->ops = &scd30_trigger_ops;
> > > +	iio_trigger_set_drvdata(trig, indio_dev);
> > > +
> > > +	ret = devm_iio_trigger_register(dev, trig);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	indio_dev->trig = iio_trigger_get(trig);
> > > +
> > > +	ret = devm_request_threaded_irq(dev, state->irq, scd30_irq_handler,
> > > +					scd30_irq_thread_handler,
> > > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > > +					indio_dev->name, indio_dev);
> > > +	if (ret)
> > > +		dev_err(dev, "failed to request irq\n");  
> >
> > I'm guessing this is a device without any means to disable the interrupt
> > being generated?  In which case are you safe against a race before you
> > disable here?
> >  
> 
> IRQs can be actually disabled by telling device to stop taking measurements.
> There is dedicated command for that. If irq fires off before being disabled
> nothing bad should happen as everything necessary is in place already.

Hmm. I wonder if we'd be better off starting it on demand - or only when running
with it as a data ready trigger. That would make the the polled read a case
of starting the sampling for one sample rather than just 'picking' one from
the stream of actual samples.

> 
> Another thing is that without disabling interrupt here we would get warning
> about unbalanced irq whilst enabling trigger.
> 
> > > +
> > > +	disable_irq(state->irq);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > > +		int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> > > +			       u16 arg, char *rsp, int size))
> > > +{
> > > +	static const unsigned long scd30_scan_masks[] = { 0x07, 0x00 };
> > > +	struct scd30_state *state;
> > > +	struct iio_dev *indio_dev;
> > > +	int ret;
> > > +	u16 val;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	dev_set_drvdata(dev, indio_dev);
> > > +
> > > +	state = iio_priv(indio_dev);
> > > +	state->dev = dev;
> > > +	state->priv = priv;
> > > +	state->irq = irq;
> > > +	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
> > > +	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
> > > +	state->command = command;
> > > +	mutex_init(&state->lock);
> > > +	init_completion(&state->meas_ready);
> > > +
> > > +	indio_dev->dev.parent = dev;
> > > +	indio_dev->info = &scd30_info;
> > > +	indio_dev->name = name;
> > > +	indio_dev->channels = scd30_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(scd30_channels);
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +	indio_dev->available_scan_masks = scd30_scan_masks;
> > > +
> > > +	state->vdd = devm_regulator_get(dev, "vdd");
> > > +	if (IS_ERR(state->vdd)) {  
> >
> > This is very noisy if we have deferred probing going on.
> > Either explicitly check for that case or just don't bother
> > with an error message in this path.
> >  
> 
> Okay.
> 
> > > +		dev_err(dev, "failed to get vdd regulator\n");
> > > +		return PTR_ERR(state->vdd);
> > > +	}
> > > +
> > > +	ret = regulator_enable(state->vdd);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable vdd regulator\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = devm_add_action_or_reset(dev, scd30_exit, state);
> > > +	if (ret)  
> >
> > This should match exactly against the item above it. Whilst stop
> > measurement may be safe from here on, it is not easy to review
> > unless we can clearly see where the equivalent start is.
> >  
> 
> Well, naming might be confusing. The thing is that sensor after being
> powered up reverts itself to the much the same state it left.
> 
> If we have real regulator then scd30_exit would disable regulator and
> that's it. But, in case of a dummy one and sensor starting in
> continuous mode we waste power for no real reason (for example 19mA
> at 0.5Hz).
> 
> So it's explanation for doing 2 things inside early on but not excuse
> for unintuitive naming.

I'd rather see two devm_add_action_or_reset calls one handling the regulator
and one handling the register write.  Then it will be clear what each
one is doing and that there are no possible races.  Basically it lets
a reviewer not bother thinking which is always good :)

> 
> > > +		return ret;
> > > +
> > > +	ret = scd30_reset(state);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to reset device: %d\n", ret);
> > > +		return ret;
> > > +	}

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4576B1E96E4
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEaKQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 06:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaKQZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:16:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F8120707;
        Sun, 31 May 2020 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590920185;
        bh=nbhATkfY1Uk+aTiFvmH+nFFiyv7NRdgxPRwZRVWZmsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=igluf4Z+4F7b0f2oe2kF1N3eTtGvXebXFRnyz6kjj9tf96/YfE0OAnM6RLXnLq0oD
         cFNnSZjzF8JubdvS030sxvnhC+g4mhkDUixT9nIOtM1JMOdzDGRXTvnyNtGzzn1FxV
         zAxErYMLGWnsoIR/8nJ3/xnCLyfLQfSd8f/FlNtY=
Date:   Sun, 31 May 2020 11:16:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200531111621.034cf3cd@archlinux>
In-Reply-To: <20200531105840.27e17f3d@archlinux>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
        <20200530213630.87159-2-tomasz.duszynski@octakon.com>
        <20200531105840.27e17f3d@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 May 2020 10:58:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 30 May 2020 23:36:27 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
> 
> > Add Sensirion SCD30 carbon dioxide core driver.
> > 
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>  
> 
> Hi Tomasz
> 
> A few things inline.  Includes the alignment issue on 
> x86_32 that I fell into whilst trying to fix timestamp
> alignment issues.  Suggested resolution inline for that.
> 
> Thanks,
> 
> Jonathan
> 

Update below after looking at the way this works with the serial dev.

> > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > +		scd30_command_t command)
> > +{
> > +	static const unsigned long scd30_scan_masks[] = { 0x07, 0x00 };
> > +	struct scd30_state *state;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +	u16 val;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	state = iio_priv(indio_dev);
> > +	state->dev = dev;  
> 
> Doesn't seem to be used.
> 
> > +	state->priv = priv;  
> 
> What's this for?  At least at first glance I can't find it being used
> anywhere.

Ah. Used in the serial module.  Maybe add a comment to the structure definition
about that.

As is the dev etc.  Is it possible to use the 

> 
> > +	state->irq = irq;
> > +	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
> > +	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
> > +	state->command = command;
> > +	mutex_init(&state->lock);
> > +	init_completion(&state->meas_ready);
> > +
> > +	dev_set_drvdata(dev, indio_dev);
> > +
> > +	indio_dev->dev.parent = dev;  
> 
> Side note that there is a series moving this into the core under revision at
> the moment.  Hopefully I'll remember to fix this up when applying your patch
> if that one has gone in ahead of it.
> 
> > +	indio_dev->info = &scd30_info;
> > +	indio_dev->name = name;
> > +	indio_dev->channels = scd30_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(scd30_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = scd30_scan_masks;
> > +
> > +	state->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(state->vdd)) {
> > +		if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		dev_err(dev, "failed to get regulator\n");
> > +		return PTR_ERR(state->vdd);
> > +	}
> > +
> > +	ret = regulator_enable(state->vdd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(dev, scd30_disable_regulator, state);
> > +	if (ret)
> > +		return ret;
> > +  
...

Return-Path: <linux-iio+bounces-12086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9D9C2E13
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484E11C20DE4
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667219B5A3;
	Sat,  9 Nov 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXxT9Vrk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81719AD7E;
	Sat,  9 Nov 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165305; cv=none; b=BLgKv2fZdNjPDOcvtsGEG8rcOoaud3WST/0hamyFWlbmLW69AnUndpMGwK2DsEkQxn9AaF0PgEizlVN5O1r04fFkgfMndRhYvTqv1ctQqw2e/4cDACpwhNqlz0OW2vK14//P9sYWCoLj208rf997gNH1dsl0X9NVxg4L4kIx0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165305; c=relaxed/simple;
	bh=8f1c5mNv3+NJAY1JwbfChWKIkFVD0uidxRZPWElAnKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6ma+hiKLT053lUBIWYQMwxJhoc+ni6TRQAwS9zdp7ji18HF4CLzDOavkKJeywQXnanT+m2SCic2VgWJcUoBpWOx6IxwmCNbHOWIBHPDEhbRLeDRLHLf0xcghSvMO3j5vgyhRCTVR9UqlXsnD09fN/8vDIf9dV6xABmulJ9XiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXxT9Vrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E773C4CECE;
	Sat,  9 Nov 2024 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165305;
	bh=8f1c5mNv3+NJAY1JwbfChWKIkFVD0uidxRZPWElAnKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXxT9Vrk9MLHFyxZvixdNuf602y3HcDFoHPqo2j0vzKKmMUjMdqdHiDqrxLoPKShH
	 nR8zhgq8OWTyTDO/m3q2ODE7O7/Gw9EP3KxBY3SEfRG5mvs/1pdZwiwLSKlZUIAuu1
	 dtKMDF13ddhQ5buESiCE9RhbB945l8SGI4DpvWwAgA6AbcEyqoZkO2RhbkJb882Zh/
	 i+QhjcZamsM3OGVm3hi5blOthfILZl3+sqPyr3R/X5Exz1fR2pw893BZQXpcgxHYsj
	 hfJ2DvW11MBwBWybVozZqo9bJ/dLM0u8xab1m9Lg6Ki1skumsvg0ZvVTtUyZFGYPpQ
	 3Hpr3tiyL56AA==
Date: Sat, 9 Nov 2024 15:14:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: add support for triggered buffer
Message-ID: <20241109151459.57abf2dc@jic23-huawei>
In-Reply-To: <8c9b1e43-f47e-46a5-9189-fbe73b16ff7b@gmail.com>
References: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
	<20241109132729.1459cf0a@jic23-huawei>
	<8c9b1e43-f47e-46a5-9189-fbe73b16ff7b@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Nov 2024 15:32:45 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Hi Jonathan, thanks for your feedback.
> 
> On 09/11/2024 14:27, Jonathan Cameron wrote:
> > On Thu, 07 Nov 2024 21:22:45 +0100
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> All devices supported by this driver (currently veml6030, veml6035
> >> and veml7700) have two 16-bit channels, and can profit for the same
> >> configuration to support data access via triggered buffers.
> >>
> >> The measurements are stored in two 16-bit consecutive registers
> >> (addresses 0x04 and 0x05) as little endian, unsigned data.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > Hi Javier,
> > 
> > Some comments inline below.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >>  drivers/iio/light/Kconfig    |  2 ++
> >>  drivers/iio/light/veml6030.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 86 insertions(+)
> >>  
> 
> ...
> 
> >> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *iio = pf->indio_dev;
> >> +	struct veml6030_data *data = iio_priv(iio);
> >> +	int i, ret, reg;
> >> +	int j = 0;
> >> +
> >> +	iio_for_each_active_channel(iio, i) {  
> > Given you've set the available_scan_masks such that all channels are on
> > or off, you should be able to read them unconditionally.
> > The IIO core demux code will break them up if the user requested a subset.
> >   
> 
> What I wanted to model is that both channels (ALS and WH) should be
> accessible, but allowing the user to request a single one, as the ALS
> channel is usually more relevant. It seems that in that case I should
> leave available_scan_masks as it is, right? I don't want to keep any
> channel from being accessible.
Ah. No that's not what it is for.  If you don't set it at all, any
combination of channels may be enabled.  If you set it you are restricting
the choice of what is enabled to particular combinations.  In the simple
case this is used when you want to enforce (at the driver level) that
'all' channels are always captured - usually because there is an efficient
bulk channel read.

The IIO core will then pull out the data for the channels the user actually
requested.

In a case where the reads are independent just don't provide available_scan_masks
at all. That matches providing  0x3, 0x2, 0x1, 0x0 here  So any combination of
channels.

> 
> > If it makes sense to allow individual channels (looks like it here)
> > then don't provide available_scan_masks.
> > 
> > A bulk read may make sense (I've not checked register values).
> >   
> 
> In my interpretation, I thought that I could read a single register if
> there is only a single active channel, instead of using regmap_read_bulk
> unconditionally. the data registers have consecutive addresses, and a
> bulk read is possible, though.
> 
> What approach is preferred in this case? Reading and pushing both
> channels at once without any loop, letting the IIO core demux do the
> rest, or reading only the active channels as it is done here?

It depends a bit on the device. People tend not to want one axis of an 
accelerometer, but here a single channel is a likely case to optimize
for, so just don't provide available_scan_masks and it will all work I think.

If it's is a significant saving you can always figure out if a bulk
read makes sense in your driver and do it if both channels are enabled.
Probably not worth the complexity here.


Jonathan

> 
> >> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(i), &reg);
> >> +		if (ret)
> >> +			goto done;
> >> +
> >> +		data->scan.chans[j++] = reg;
> >> +	}
> >> +
> >> +	iio_push_to_buffers_with_timestamp(iio, &data->scan, pf->timestamp);
> >> +
> >> +done:
> >> +	iio_trigger_notify_done(iio->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}  
> 
> Thanks again and best regards,
> Javier Carrasco
> 



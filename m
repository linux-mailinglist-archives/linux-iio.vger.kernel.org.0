Return-Path: <linux-iio+bounces-8754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B995DD6A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 12:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0151F22433
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433E156C74;
	Sat, 24 Aug 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxwd75/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0764A;
	Sat, 24 Aug 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724496072; cv=none; b=VwDqztz2JmxBnTzJ16XDkpdgTl6hHs9SPRKJUYuVwn1vK/BXS2+px9Xcvg+QrUHFLjW5ulnQqo6kceAUJdOnqIqDTZR0jiVAO0Ql+GI5UXrS08s8WueUF0bkxWRjSxIitGIqMwbSV0DKBzyG2Ayri5aAwy9N67Bn5tkr+r8elqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724496072; c=relaxed/simple;
	bh=Sw6ssWz76bNUiz1sR2gCJ9kpZ02UDmWeAIGzuz15ArY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPfjfEeWgUjGCrjeEzzt+TsEtU87vOJESHn7NK81Zbm72hCSHr1DQtKauAZ6HphVZea4ekCfiw6WN6vRBEFa44gjOOyhGD9bifyguVG7IUIubsOdaLXqKpA4tTY6xb61hcq26Fz96HmV2HAnQHLXm+MZmv6BWIHlVyVZBYnAuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxwd75/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A58C32781;
	Sat, 24 Aug 2024 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724496071;
	bh=Sw6ssWz76bNUiz1sR2gCJ9kpZ02UDmWeAIGzuz15ArY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sxwd75/Pviu13mPghtPVh9kkLiaQHTeQl3ymJBYO2ZHXEsVDog1fgGtZBXP/YZS+7
	 w47/1KTt6o5ycvMl8+fPFS/YJXlD6EJmPHIa1eU05Uld4IdJvOzQ1z6ReUrDnviilE
	 szPDzWkgjaTU6qfW0qx/cFq5FTbaS//OJlq+U2Y0I34E3f7NOMlyI/cVNbFmma02Rz
	 4kxs8NJ2t/H4HmdSYKJVEYFfhp2tbGwosPyAISzHBb4n9hMfV/8YvdqfJzZ3+NZN9v
	 gvzD0iURaWhF3V6LyZQPd3p8se3Ul/OvN4Mj9aH6i0J1u0FDLF316BmaWbJc6ni36b
	 tYAcPwGzHMi5g==
Date: Sat, 24 Aug 2024 11:40:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240824114027.4ad9c99c@jic23-huawei>
In-Reply-To: <28fa2ba9-9b02-43ac-b070-85a173a5db60@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
	<28fa2ba9-9b02-43ac-b070-85a173a5db60@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 14:39:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/22/24 7:45 AM, Esteban Blanc wrote:
> > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> > 
> > The driver implements basic support for the AD4030-24 1 channel
> > differential ADC with hardware gain and offset control.
> > 
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

A couple of comments on comments inline mainly to point out
one 'lazy' alternative that is very common for the IIO_VAL_INT
write case.

> > +static int ad4030_single_conversion(struct iio_dev *indio_dev,
> > +				    const struct iio_chan_spec *chan, int *val)
> > +{
> > +	struct ad4030_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = ad4030_set_mode(indio_dev, BIT(chan->channel));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4030_exit_config_mode(st);
> > +	if (ret)
> > +		goto out_exit_config_mode_error;  
> 
> Looks like we could just return ret here.
> 
> > +
> > +	ret = ad4030_conversion(st, chan);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	if (chan->channel % 2)
> > +		*val = st->rx_data.buffered[chan->channel / 2].common;
> > +	else
> > +		*val = st->rx_data.buffered[chan->channel / 2].val;
> > +
> > +out_error:
> > +	ad4030_enter_config_mode(st);
> > +
> > +out_exit_config_mode_error:
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return IIO_VAL_INT;  
> 
> This can be moved before out_error:, then we can just have
> return ret here and leave out the if.
I'd assume not quite because we need to go back into config mode
even on error.

I'd be tempted to have separate error block and just duplicate
that one call.
> 
> > +}

> > +static int ad4030_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int val,
> > +			    int val2, long info)
> > +{
> > +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +		switch (info) {
> > +		case IIO_CHAN_INFO_CALIBSCALE:
> > +			return ad4030_set_chan_gain(indio_dev, chan->channel,
> > +						    val, val2);
> > +
> > +		case IIO_CHAN_INFO_CALIBBIAS:
> > +			return ad4030_set_chan_offset(indio_dev, chan->channel,
> > +						      val);  
> 
> Need to add .write_raw_get_fmt to struct iio_info below to set
> IIO_CHAN_INFO_CALIBBIAS to IIO_VAL_INT. Othwerwise, the defualt
> IIO_VAL_INT_PLUS_MICRO is used and val2 would have considered
> for handling negative values.

Lazy approach is 
	if (val2 != 0)
		return -EINVAL;
We do this a fair bit in drivers to avoid a very minimal write_raw_fmt
callback.

But 'right way' is to tell the core that it's an int.

> 
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	unreachable();
> > +}

> 
> > +	indio_dev->name = st->chip->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &ad4030_iio_info;
> > +	indio_dev->channels = st->chip->channels;
> > +	indio_dev->available_scan_masks = st->chip->available_masks;
> > +	indio_dev->masklength = st->chip->available_masks_len;  
> 
> indio_dev->masklengh is marked as [INTERN] so should not be set by drivers.

It will now give a compile error if you try this on linux-next or
the iio.git/togreg tree.




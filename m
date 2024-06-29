Return-Path: <linux-iio+bounces-7068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C191CED6
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F5C1C20E83
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15887139D0C;
	Sat, 29 Jun 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnfyZREM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353C2032B;
	Sat, 29 Jun 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719689222; cv=none; b=SrrJ0oXln9Jm/MlvNwpUxHmAtHet+s2eNbPUA6UpgXvvdbhNmMGQvG4+MZ5wXf2e8/ICsZS0u2kF+Pu8xpJdOzNkkQn1acvxz1SZX2GfeL3PoMsNFnnJko769Fti/tjhEareOjpMkNk+Gbtv4GYd1xBxenNtBMQuKzcrumvMuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719689222; c=relaxed/simple;
	bh=5KGeK61hekuM2DL4N6jka1C8+Duo42iFnEkFlYpnIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+ZziPYxRboseh9NlVp3lideO5za7xzugH7REDTXR+VVrujwT96Ragrr+kVDHV8TYI09vVFF0YddAfERcX5qkG2lVA0Fyk211WlnLBFXx84B1hmxdU4SqLnb1k+MBEaAaNW39EqtwUXhxt/iTminathGguGvkRp0vzUquXalNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnfyZREM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E0C2BBFC;
	Sat, 29 Jun 2024 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719689222;
	bh=5KGeK61hekuM2DL4N6jka1C8+Duo42iFnEkFlYpnIpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnfyZREM0d9EjHczaxm7+jr4aTjM+8EeWwXp9f1+sV2WCzKWJ8TVXOCD5cMjlczJw
	 xChe8Rfq/zaLEI4S4uG68PKMyR7gjxFu/jcZFboP8C3Vyn+3xBOUp5AYo0GvrgEM8P
	 /H8+5ghHehX4bes9RVBT61bsVWO75+bQK9Ai6AN9W3UOrmFCGh9CoSSOkuhcVtjFhF
	 6Q16GDmAPNYjJIZyn36YZamA349hlCns3Dj+IQh6xEiiQdM7fAGhJ4AOdV2prNEzKB
	 oL+Y7SUwsjKyQFN/v99++8omYK+a4KRJAS2kAvPh8j9e53+iIygHUljN86EhgHTVFa
	 rgCGk1F0mqOPg==
Date: Sat, 29 Jun 2024 20:26:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
Message-ID: <20240629202653.7285acb5@jic23-huawei>
In-Reply-To: <1jr0clgdpt.fsf@starbuckisacylon.baylibre.com>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<20240624173105.909554-3-jbrunet@baylibre.com>
	<04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
	<1j4j9hift4.fsf@starbuckisacylon.baylibre.com>
	<190ccd62-0803-46fa-87ee-0f9cef5a784e@baylibre.com>
	<1jr0clgdpt.fsf@starbuckisacylon.baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 18:59:58 +0200
Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Tue 25 Jun 2024 at 09:52, David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 6/25/24 3:31 AM, Jerome Brunet wrote:  
> >> On Mon 24 Jun 2024 at 17:51, David Lechner <dlechner@baylibre.com> wrote:
> >>   
> >>> On 6/24/24 12:31 PM, Jerome Brunet wrote:  
> >>>> Add support for the HW found in most Amlogic SoC dedicated to measure
> >>>> system clocks.
> >>>>  
> >>>
> >>>
> >>>  
> >>>> +static int cmsr_read_raw(struct iio_dev *indio_dev,
> >>>> +			 struct iio_chan_spec const *chan,
> >>>> +			 int *val, int *val2, long mask)
> >>>> +{
> >>>> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
> >>>> +
> >>>> +	guard(mutex)(&cm->lock);
> >>>> +
> >>>> +	switch (mask) {
> >>>> +	case IIO_CHAN_INFO_RAW:
> >>>> +		*val = cmsr_measure_unlocked(cm, chan->channel);  
> >>>
> >>> Is this actually returning an alternating voltage magnitutde?
> >>> Most frequency drivers don't have a raw value, only frequency.  
> >> 
> >> No it is not the magnitude, it is the clock rate (frequency) indeed.
> >> Maybe altvoltage was not the right pick for that but nothing obvious
> >> stands out for Hz measurements  
> >
> > I'm certainly not an expert on the subject, but looking at the other
> > frequency drivers, using altvoltage looks correct.
> >
> > But, we in those drivers, nearly all only have a "frequency" attribute
> > but don't have a "raw" attribute. The ones that do have a "raw" attribute
> > are frequency generators that use the raw attribute determine the output
> > voltage.
> >  
> >>   
> >>>  
> >>>> +		if (*val < 0)
> >>>> +			return *val;
> >>>> +		return IIO_VAL_INT;
> >>>> +
> >>>> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */  
> >>>
> >>> Shouldn't this be IIO_CHAN_INFO_FREQUENCY?  
> >> 
> >> How would I get raw / processed / scale with IIO_CHAN_INFO_FREQUENCY ?
> >>   
> >>>
> >>> Processed is just (raw + offset) * scale which would be a voltage
> >>> in this case since the channel type is IIO_ALTVOLTAGE.  
> >> 
> >> This is was Processed does here, along with selecting the most
> >> appropriate scale to perform the measurement.
> >>   
> >>>  
> >>>> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
> >>>> +		if (*val < 0)
> >>>> +			return *val;
> >>>> +		return IIO_VAL_INT_64;
> >>>> +
> >>>> +	case IIO_CHAN_INFO_SCALE:  
> >>>
> >>> What is this attribute being used for?  
> >> 
> >> Hz
> >>   
> >>>
> >>> (clearly not used to convert the raw value to millivolts :-) )
> >>>
> >>> Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
> >>> so far, that has only been used with light sensors.  
> >> 
> >> I think you are mixing up channel info and type here.
> >> I do want the info
> >>  * IIO_CHAN_INFO_RAW
> >>  * IIO_CHAN_INFO_PROCESSED
> >>  * IIO_CHAN_INFO_SCALE
> >> 
> >> I want those info to represent an alternate voltage frequency in Hz.
> >> I thought type 'IIO_ALTVOLTAGE' was the right pick for that. Apparently
> >> it is not. What is the appropriate type then ? Should I add a new one ?  
> >
> >
> > The documentation at Documentation/ABI/testing/sysfs-bus-iio explains
> > what the combination of a channel type and info means.  
> 
> Oh missed that, Thx
> 
> >
> > For example, out_altvoltageY_raw is defined as it used for the frequency
> > generator case that I mentioned above. in_altvoltageY_raw is not defined
> > which means probably no one has needed it yet. But it would still be the
> > voltage value, not the frequency.  
> 
> Got it. So the type I picked is wrong for sure.
> So, maybe I need something new to measure a frequency ?

Yes. Seems likely we need a new channel type to me.
In theory we could abuse an angular rate channel but that's nasty so
lets not do that. :)

Jonathan



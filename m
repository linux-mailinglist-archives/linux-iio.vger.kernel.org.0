Return-Path: <linux-iio+bounces-5714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C478D8AB3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245B21C22306
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DB113B297;
	Mon,  3 Jun 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF6ixkfd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3A46A4;
	Mon,  3 Jun 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445272; cv=none; b=WD7qxMBLOJwm7P7u2lR2Rht60Li3Xw8NmEJPgekKlNtZaav8tgNheEfdW6pU4We9y5yZ+wgbWV1jCyVoWNiWcC76Kf3blL0qbrBlv80xYbwP3NotkN6IbiRcYP4Jr4PSbJaklehnMOm+Ujh4BKG37/nYK7bWcsIw7ZLCKEuk4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445272; c=relaxed/simple;
	bh=xbP3NEx923MmK1rOGQkQZGfcDONB0sYHOQ7X3kICkbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ90zojiUPbSJ627NnAMBvzko9AHmOmmORtNjlbQ+ddGIulkoy8hxIXRR3w6Aj4mokdVG2OapeJ+WzUBuG6STbWY0S6pK170o17AbJJLLskBIU9VwnSnNP/r7ZhfadppKvAgvSDGrJWHrlCLyPc794WIXtS8h7B9NRRP1IYuQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF6ixkfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66D8C2BD10;
	Mon,  3 Jun 2024 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717445272;
	bh=xbP3NEx923MmK1rOGQkQZGfcDONB0sYHOQ7X3kICkbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eF6ixkfdNG3aSUtnYDQ+Hr0Niz083LutVFYg5zYucMgoEnG37y4QDmQVAZAM3PmLc
	 EIkLwBJ6pdcWxGOiNsTvmFaT9zeQVnkrZ8PIR1XlxH/cURC+/VK9SZQZ4+1VAZ5R8V
	 OdheL7QY48b/DWwbfCvS1hx7CKY/Ve0gY1cHqv48YR/dL9wbWhUQ46FOkUph1X0YbJ
	 Nmvmq94Eu/SzRMJFiZKh9Mtz5vVGvzCWezgLeY2GIJpmXD06sN6Z9sIEHrZesPL9AQ
	 iDy0inifqx+eGmUILYOi2OTX/05+Nm/PUG5639trow7w1dueju5tBBKBlLeXKRsINL
	 WVrpDKFKWk8pw==
Date: Mon, 3 Jun 2024 21:07:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: adc: ad7173: Add support for AD411x devices
Message-ID: <20240603210738.3880f1cc@jic23-huawei>
In-Reply-To: <93ebe75b-5a7d-4d69-9515-7cbeb66c8e7e@gmail.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-6-64607301c057@analog.com>
	<20240601201912.32fe3524@jic23-huawei>
	<93ebe75b-5a7d-4d69-9515-7cbeb66c8e7e@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 13:11:33 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 01/06/2024 22:19, Jonathan Cameron wrote:
> > On Fri, 31 May 2024 22:42:32 +0300
> > Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >   
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> >>
> >> The AD411X family encompasses a series of low power, low noise, 24-bit,
> >> sigma-delta analog-to-digital converters that offer a versatile range of
> >> specifications.
> >>
> >> This family of ADCs integrates an analog front end suitable for processing
> >> both fully differential and single-ended, bipolar voltage inputs
> >> addressing a wide array of industrial and instrumentation requirements.
> >>
> >> - All ADCs have inputs with a precision voltage divider with a division
> >>   ratio of 10.
> >> - AD4116 has 5 low level inputs without a voltage divider.
> >> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
> >>   shunt resistor.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>  
> > Hi Dumitru,
> > 
> > A follow on comment on the validation code.
> > Also there is some good docs for the sampling frequency but are they
> > actually related to the rest of this change?  They also raise
> > questions about ABI compliance that we may want to deal with as
> > a follow up patch.
> > 
> > A few other trivial things inline.
> > 
> > This is looking pretty good, so hopefully we'll get the last few corners
> > sorted in v5.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> >> ---
> >>  drivers/iio/adc/ad7173.c | 336 +++++++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 307 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> >> index ed8ff8c5f343..91ff984eedf4 100644
> >> --- a/drivers/iio/adc/ad7173.c
> >> +++ b/drivers/iio/adc/ad7173.c
> >> @@ -1,8 +1,9 @@  
> >   
> >>  #define AD7173_INTERFACE_DATA_STAT	BIT(6)
> >> @@ -125,26 +132,46 @@
> >>  #define AD7173_VOLTAGE_INT_REF_uV	2500000
> >>  #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
> >>  #define AD7177_ODR_START_VALUE		0x07
> >> +#define AD4111_SHUNT_RESISTOR_OHM	50
> >> +#define AD4111_DIVIDER_RATIO		10
> >> +#define AD411X_VCOM_INPUT		0X10  
> > 
> > AD4111_VCOM_INPUT . Looks like one wildcard escaped an earlier edit?
> >   
> >> +#define AD4111_CURRENT_CHAN_CUTOFF	16
> >>  
> >> @@ -736,6 +918,21 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
> >>  		return ret;
> >>  
> >>  	switch (info) {
> >> +	/*
> >> +	 * This attribute sets the sampling frequency to each channel individually.  
> > 
> > frequency for each channel?
> >   
> >> +	 * There are no issues for raw or buffered reads of an individual channel.
> >> +	 *
> >> +	 * When multiple channels are enabled in buffered mode, the effective
> >> +	 * sampling rate of a channel is lowered in correlation to the number
> >> +	 * of channels enabled and the sampling rate of the other channels.
> >> +	 *
> >> +	 * Example: 3 channels enabled with rates CH1:6211sps CH2,CH3:10sps
> >> +	 * While the reading of CH1 takes only 0.16ms, the reading of CH2 and CH3
> >> +	 * will take 100ms each.
> >> +	 *
> >> +	 * This will cause the reading of CH1 to be actually done once every
> >> +	 * 200.16ms, an effective rate of 4.99sps.  
> > 
> > Hmm. This is a bit unfortunate as if I understand correctly that's not really what
> > people will expect when they configure the sampling frequency.  However I can't immediately
> > think of a better solution.  You could let userspace write a value that is cached
> > then attempt to get as near as possible as channels are enabled.
> > 
> > Still this looks like a documentation enhancement of existing behavior
> > in which case any functional change can be in a future patch.
> > However I don't think the docs update belongs in this patch unless
> > I'm missing some reason for it?
> >  
> 
> Well, it would seem like this exact behaviour is already documented:
> 
>  "
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
>  What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
>  KernelVersion:	5.20
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 		Some devices have separate controls of sampling frequency for
> 		individual channels. If multiple channels are enabled in a scan,
> 		then the sampling_frequency of the scan may be computed from the
> 		per channel sampling frequencies.
>  "

I guess we've hit this before and added very specific documentation around this
that I'd forgotten about.  Thanks for pointing it out!

> Does it still make sense to keep this comment here? But if kept, yeah, a different patch
I think there is no harm in having the additional info.  Not as if everyone will
check the ABI docs whilst trying to understand the driver code. I didn't for one :(

Jonathan

> 
> ...



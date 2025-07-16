Return-Path: <linux-iio+bounces-21711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F13B06F4D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1009E3A7ECB
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A7263F52;
	Wed, 16 Jul 2025 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKpGWvRD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A417D2;
	Wed, 16 Jul 2025 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651938; cv=none; b=tnIGGc1ezFezjV6DdmOtJvl7RTTD4zHGSUybaWd58wP5yd6U35VUcls5XCg/7bGVLHHC8E8I5Vnf3qljYqh68r7uWXmV22ho3O0zNRiYt/oeN2eGvSSOTgSbfo3QIyZmckKxNI8fP7FDKNU09KelzJcU+yxXwrL9DkbgvtJP37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651938; c=relaxed/simple;
	bh=ggvd9ZmR+n+qNcsErbcs+/uxwtG7PkhkvsBTNhvDvVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cf76CDDEfZPtG8H/x16YSOAjVq6tlNw2KlhRAjQbFdMkmCpqzB1VWg0Ya4Xohn1SRDRIkt08URsTQnn8oFS0D9uGtdGKN57TNyfQdbJcRHkZHjHox3M5b8WwD4+8ldcSg7pExzPlUPCndiwWNsoqo2x+8KzWsHK6yoVJEtmoXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKpGWvRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E25C4CEF0;
	Wed, 16 Jul 2025 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752651938;
	bh=ggvd9ZmR+n+qNcsErbcs+/uxwtG7PkhkvsBTNhvDvVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CKpGWvRDZUOdNjw5gFFtGcpbdUv6WDXcCsr9RYGbiZKBCzxIJtcmlnpmrhP327r5F
	 X9GPsrOEqtoUbddEHHVyW9qGf75asD5wU3DSWAMrWdWD7oN13MnYBx7ZXLi+CUm3C3
	 WD0Ql3O69vSsiiJGlYld7UXFWN2kKxfOVyAFsQXgzsUJwUs8trzk69ORBpdk+7+6eJ
	 vpkjjrrZPGe8l5NnF4tR0XH+ZhsRMO0ct2SNXFl7bU26FoqpPVuD9SmwzGcGjnxyQS
	 J+G3MeYDz2uzpYpCKHo73PDLED43x7RqMz5zUuo7SxPCG1M/g5Yfzy0/GvQu9Htziq
	 2WQ/ymqjqlW9Q==
Date: Wed, 16 Jul 2025 08:45:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: fix setting ODR in probe
Message-ID: <20250716084530.50000920@jic23-huawei>
In-Reply-To: <20250713151450.3816a9c0@jic23-huawei>
References: <20250710-iio-adc-ad7173-fix-setting-odr-in-probe-v1-1-78a100fec998@baylibre.com>
	<20250713151450.3816a9c0@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 15:14:50 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 10 Jul 2025 15:43:40 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Fix the setting of the ODR register value in the probe function for
> > AD7177. The AD7177 chip has a different ODR value after reset than the
> > other chips (0x7 vs. 0x0) and 0 is a reserved value on that chip.
> > 
> > The driver already has this information available in odr_start_value
> > and uses it when checking valid values when writing to the
> > sampling_frequency attribute, but failed to set the correct initial
> > value in the probe function.
> > 
> > Fixes: 37ae8381ccda ("iio: adc: ad7173: add support for additional models")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Applied and marked for stable.
>
 
Given I've been very slow to send a final fixes pull and the cross dependencies
with some of the stuff for the merge window + all the fixes I currently have
queued are for the ad7173 or ad_sigma_delta, I plan to drag the lot across
to my pull request for the coming merge window (so the togreg branch).

Sorry for the hassle that might occur in getting these backported and the
delay in getting the fixes merged. Crazy period for one reason and another
so I've had less time to focus on IIO for a few weeks than I'd normally like.

Jonathan

> > ---
> >  drivers/iio/adc/ad7173.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..ef074b41332ed912fb281c0903f6cc52077accb4 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -1574,6 +1574,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
> >  		chan_st_priv->cfg.bipolar = false;
> >  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> >  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> > +		chan_st_priv->cfg.odr = st->info->odr_start_value;
> >  		chan_st_priv->cfg.openwire_comp_chan = -1;
> >  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
> >  		if (st->info->data_reg_only_16bit)
> > @@ -1640,7 +1641,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
> >  		chan->scan_index = chan_index;
> >  		chan->channel = ain[0];
> >  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> > -		chan_st_priv->cfg.odr = 0;
> > +		chan_st_priv->cfg.odr = st->info->odr_start_value;
> >  		chan_st_priv->cfg.openwire_comp_chan = -1;
> >  
> >  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> > 
> > ---
> > base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> > change-id: 20250710-iio-adc-ad7173-fix-setting-odr-in-probe-915972070e8a
> > 
> > Best regards,  
> 
> 



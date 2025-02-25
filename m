Return-Path: <linux-iio+bounces-16045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6DA43A53
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F0D3B4F3C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D5262D1B;
	Tue, 25 Feb 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nQQEd6gE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288F26157E
	for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476986; cv=none; b=NMMZrl2pWRdRl+m0LEiCFB5roubAu7LXEwj669+Kv75LL8RzRKSvt95UfRs8L9yuu3V7Mx9jKGWa09ub58LpHTLAVj+9yNVi/DgAU6mwCO4ED+ynbGzPpStKVJSlZ4qqS3oIcC4yEMLGofNNG3amTE3ezmgsOSYIMeD+OUK5ilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476986; c=relaxed/simple;
	bh=wL3PdThfznU+ssmT8Zjs11BbPOAuu8A4VcaI5t/5CWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxXvfge6zCMEbWhxBmJeUzzDPDfN8ey/kArWeRcDrmowihFQifnDAbLwrYR10/WFY8EplK6+U+OA0XvIPGdy6+OWVy0RLQTLdQs7SKNPSDi8GB9q17FxC9n7YLr8RcehAEUzT4PUpLygI6mt9HK6YurRPA/QgEnP2TThWhVhKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nQQEd6gE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso33454725e9.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740476981; x=1741081781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly0Mss/tFEwBQunMihP20nUWX/1m9yFcz2xqz8x9JMw=;
        b=nQQEd6gEAxfzhwduJyEbJWZX32s2iln8wnFHQmmX8o402q5Gbx2xptjupc1ux5OPAV
         a76FXeIcHsJwE1aSEN9P2HJPy4qWN0r2R+CtYOtSPqCBAadLHCoaxmliYDoBKnI2iYDs
         cYUVEaE+euRUcdvHut6ZUTD849lv82hnonATR3n///whbrqlMek7gEHYvPS4GE74XKBF
         Ok6/gPPcRg7qkoONHwP6aI1eutOn6BFg4qCxGlQLe71WuW95+y/4/pA4m3CPZUXlVEN1
         Rlyq/k+qZhGKNraRt2s4dHKuval/LtGmHwVtAqEjHzPSBK+lyFpG5yjLDtbqdYb3KNmI
         x1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476981; x=1741081781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly0Mss/tFEwBQunMihP20nUWX/1m9yFcz2xqz8x9JMw=;
        b=X6tHXfuA/G/O0gMLnRcLn5jzzz+qV4v/O4y2mF9OJfOUuuU2TH3ZQXu+ByE/9Goymp
         Eb8PhM6G2NtggWntfQF43ucy+uT3CK8ziEBl9EIiV7Rofuet2mstr0D+qWYlBctVKa0a
         oBsJsBs9ACJ34y3a07mHmpH9E8x9n2jtoCVSsZquiRclt6dsG8d+Djj5qIuqUNWb0C57
         r/sUfA/S343W+zbObfKHuvAqNVgwsC9vAq1djaXLcNvPzNsDP7Y0Ydt5CpXzTn8luKoe
         1jEECIjd4GirJirYag6v5OYeSFVuCXXkonlQUND6soTGhiVGZKlUD5ig19czahe7Wk3g
         5ZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLzwT2Nr0zFq1tvSe89pMB1tvYFiTA8juugA7gWO0PevJkdGc8neVufqSqq05v1ujCNItwQ9qHJfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAJxSZqQ0kQtZRVjAF8zt7uCLHcjbyFOQaB7z3cZVPMoWPxXg
	7z9UcVcnj1sP7e7vPW/eHcxNCPvd4WzlYcWVkgk7Gye6wFZVwwXs2oMhTJ6EpHTexiFx5PFMxN9
	s
X-Gm-Gg: ASbGncssy48aOq1G0J2IH6ONSrBihUUZqWb8HrDLABoeNWdSr/DmT6teoyUn3ds58Hc
	cRPkMIFA5kxmTd8nq1d+SVKnAcZEhV8BVXG7acJkIIs0KyoJn0EoJX7Oxg3cwo5PoDb6HZozS+v
	DKTLBBIs+Okiua121rpNMHBaLxeVaGNx1TWmADKCeGXc6ZWJShtsoOyA0La7sf12P1dTJLxAbtU
	WXgzEJXX0V6AafXcifIjiwV5qe6jvvrK1+2P4OIUswYgpHz73u+DuMqTIor2rvNfnsNQHxlGju6
	JQWZPGruKblf1x2ZBkhkV0Dc6mlh0SEOUILebOA2fiWmXd7DCcYCB4L6Q7MJZmw=
X-Google-Smtp-Source: AGHT+IHDpACS1MnrA3tOIvm+mE84/YCNTQv6apljqfHYR6JMn0FuV3pFbWZzIk6oKljI24iAYt3pig==
X-Received: by 2002:a05:600c:4e8c:b0:439:932c:e0d9 with SMTP id 5b1f17b1804b1-439ae1e62efmr151996865e9.10.1740476980709;
        Tue, 25 Feb 2025 01:49:40 -0800 (PST)
Received: from dfj (host-79-54-50-21.retail.telecomitalia.it. [79.54.50.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce651sm133990665e9.8.2025.02.25.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:49:40 -0800 (PST)
Date: Tue, 25 Feb 2025 10:48:25 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
Message-ID: <ypaiae3flszokbvrk773pzcqxx53j6amjnhbkwq3oeopnmlyv5@2b3wfzqlpqtd>
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
 <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>

Hi,

On 22.02.2025 11:31, David Lechner wrote:
> On 2/20/25 12:03 PM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add support for SPI offload to the ad7380 driver. SPI offload allows
> > sampling data at the max sample rate (2MSPS with one SDO line).
> > 
> > This is developed and tested against the ADI example FPGA design for
> > this family of ADCs [1].
> > 
> > [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> We forgot to also update Documentation/iio/ad7380.rst. We can follow up
> with a separate patch later though.
> 
> >  drivers/iio/adc/Kconfig  |   2 +
> >  drivers/iio/adc/ad7380.c | 509 +++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 475 insertions(+), 36 deletions(-)
> > 
> 
> ...
> 
> >  #define _AD7380_CHANNEL(index, bits, diff, sign, gain) {			\
> >  	.type = IIO_VOLTAGE,							\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> > @@ -237,48 +335,123 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
> >  	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
> >  }
> >  
> > +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
> > +	.type = IIO_VOLTAGE,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
> > +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
> > +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
> > +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> > +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> 
> Not sure if this is worth troubling with, but it might make more sense to make
> IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
> at least in the case of the single-ended chips.
> 
> This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
> would typically be the right thing to do here. However, the single-ended versions
> of these chips also have a multiplexer, so there are 2 banks of simultaneously
> sampled inputs. So the effective sample rate as far as IIO is concerned would
> actually be 1/2 of the sampling_frequency attribute value.
> 
> Since we have a channel mask restriction where we force all channels in a bank
> to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
> info_mask_separate where the reported sampling frequency is the conversion rate
> divided by the number of channels in a bank.
>

so if i understand properly,

for ad7386/7/8 i should use info_mask_separate, so that if a single bank
(called st->ch in the driver) is enabled, user can control that specific
bank sample rate. But user can also set the device in sequencer mode, so in this
case the sample rate is unique. So we could find 2 different sample rates in use
and the management of this seems probably unusual.

Could have sense to stay as we are now ?
 
> > +	.info_mask_shared_by_type_available =					\
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> > +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> > +	.indexed = 1,                                                           \
> > +	.differential = (diff),                                                 \
> > +	.channel = (diff) ? (2 * (index)) : (index),                            \
> > +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
> > +	.scan_index = (index),                                                  \
> > +	.has_ext_scan_type = 1,                                                 \
> > +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
> > +	.num_ext_scan_type =                                                    \
> > +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
> > +	.event_spec = ad7380_events,                                            \
> > +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
> > +}
> > +


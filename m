Return-Path: <linux-iio+bounces-10403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4A998F25
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155B928A3B0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDCE1CF5D2;
	Thu, 10 Oct 2024 17:59:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1FE19D89E;
	Thu, 10 Oct 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583177; cv=none; b=q7fg4GFcT4juuvske4R61UsFHC8zxQvAFr+fY/SSvQ1Nu4bI6cx/adVPKJxy09jAlqSUKYVCbLqIyuPNr1Uz99ZE+bEWNxLYD/UAs4+onALQSZFqXbPTubJr63A/BauwNVHR1NAnNdPqX5tUwE5+snEWOr8EEg5VMK/zZA1ML8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583177; c=relaxed/simple;
	bh=1gGbuD2zQB9hadLSmAdeixSVFXtTIIIno/flnOJvm5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6HZYyQz5jbZ3fPCSscVMeNz+4yyNlw8P/25IBeDQT3ZcZ8GFFupzkufkrdqktYh9GUkQF0AShz9F+axvBMkyreWj6NMgI3HDm/gMCYiL287MFoWRE8SgM4JhxuLmZze+LjtjjfoZyPIGc1ViivaZWSVwelarkDKW/UYGO4uedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Z2RnOjFzQmWbeuzh/ENTZg==
X-CSE-MsgGUID: cw+urGtERz+Yd8Kz6Iy1lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="15586636"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="15586636"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:59:36 -0700
X-CSE-ConnectionGUID: jnPqD4YURz65FiPn5RDGWg==
X-CSE-MsgGUID: c6t/WL0HRKWNHQsTOZelNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="100003386"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:59:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1syxRh-00000001czV-1HSt;
	Thu, 10 Oct 2024 20:59:29 +0300
Date: Thu, 10 Oct 2024 20:59:29 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <ZwgWAV7SQwV02ott@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-4-ramona.nechita@analog.com>
 <ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
 <DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 02:32:49PM +0000, Nechita, Ramona wrote:

...

> >> +struct ad7779_state {
> >> +	struct spi_device *spi;
> >> +	const struct ad7779_chip_info *chip_info;
> >> +	struct clk *mclk;
> >> +	struct iio_trigger *trig;
> >> +	struct completion completion;
> >> +	unsigned int sampling_freq;
> >> +	enum ad7779_filter filter_enabled;
> >> +	/*
> >> +	 * DMA (thus cache coherency maintenance) requires the
> >> +	 * transfer buffers to live in their own cache lines.
> >> +	 */
> >> +	struct {
> >> +		u32 chans[8];
> >> +		s64 timestamp;
> >
> >	aligned_s64 timestamp;
> >
> >while it makes no difference in this case, this makes code aligned inside
> >the IIO subsystem.
> 
> I might be missing something but I can't find the aligned_s64 data type,
> should I define it myself in the driver?

Definitely, basically the rule of thumb is to create your patches based on
the respective subsystem tree. In such a case this is IIO tree togreg branch
(in some cases testing should be used).

There is the mentioned type been introduced.

> >> +	} data __aligned(IIO_DMA_MINALIGN);
> >
> >Note, this is different alignment to the above. And isn't the buffer below should have it instead?
> >
> >> +	u32			spidata_tx[8];
> >> +	u8			reg_rx_buf[3];
> >> +	u8			reg_tx_buf[3];
> >> +	u8			reset_buf[8];
> >> +};

...

> >> +static int ad7779_write_raw(struct iio_dev *indio_dev,
> >> +			    struct iio_chan_spec const *chan, int val, int val2,
> >> +			    long mask)
> >
> >long? Not unsigned long?
> 
> I copied the function header directly from iio.h, shouldn't it be left as such?

Oh, this is unfortunate. It should be fixed there, indeed.

-- 
With Best Regards,
Andy Shevchenko




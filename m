Return-Path: <linux-iio+bounces-5452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C28D3A65
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66339286153
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3117DE0D;
	Wed, 29 May 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5MuwJyg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1115B97D;
	Wed, 29 May 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995501; cv=none; b=gcuBB76n0Efa03P/Av/HXZJdD68KB5ycN/5gyI9Dlz5MLsktKFy1JlRUe4bwxZOpL6XysRY/aRnacx+AIpwj7VeQoKC5GhHhO+dqLDR4ZT6DAW62og43xonUsb6RZoedAq6xLUzmtpuBQSQSw1nQrelcejn4AI3qHfeEKQfZDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995501; c=relaxed/simple;
	bh=U9XeYahFP5qM1pI2/zD/me4C9iA60afmuetgFSYYx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDFpsStGOBDf4Tyb/V0ON5Kqpssumzp6viety5IYz+ujbfSbQpGbS+CGE1IOoG/AQmzjVwiq1NmmnxKegRFCG6OXoGjRtjLK1j9fWKI0hXjsNGs4iqbL5rKkvll58D6XzFuYHtv3LiadMvCcWbY0gTaTiIpKQ2b5ZtpGz5WdWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5MuwJyg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716995501; x=1748531501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9XeYahFP5qM1pI2/zD/me4C9iA60afmuetgFSYYx1w=;
  b=d5MuwJygq5PwoDohvXHbkdRkzN9IOVx6ATbmUXoocbLN/0ldXiYrQu3W
   LM7/7CoWbc+D0SpRSEA6D6RAVpajBysHN1pVBPrtVF48cx4IXJZ3INEqL
   bZAG0fXwNWD1O1hMAFtG6j/WJb45KRbWB/F2I/SoIUoGie4YACR7LrBqe
   c9xGVaevLNJOs6M0dqhYscKAwy2vWnAtsIFoJ8jC2Vu5/hHpaaVLZDBAU
   dozncKKxjV95uE1IFeH6xifo8FRylLk0Ne/ghayVNGb+jcEflUz8DKZeb
   xxqkycwl6Bd3m7AYSm7XzJ/QznpkDREN6UGlCp2zvIPquCV/tLHnJm9lj
   w==;
X-CSE-ConnectionGUID: SvinpZOpSUG46xRgkZF9Hw==
X-CSE-MsgGUID: OO4tg4/CTWCP+20mYAWqHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13355611"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13355611"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:11:40 -0700
X-CSE-ConnectionGUID: gVD+VuWSRr2FON0PRyAeAg==
X-CSE-MsgGUID: 56ZQbB1sTfqsJkbc/Le1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35556268"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:11:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCKxh-0000000BqBg-1tq8;
	Wed, 29 May 2024 18:11:33 +0300
Date: Wed, 29 May 2024 18:11:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: adc: add support for ad777x family
Message-ID: <ZldFpSQPAmAhbW2I@smile.fi.intel.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
 <Zk3-qxCb0zfR440Q@smile.fi.intel.com>
 <SN6PR03MB432071701D6A19C3B4C0C33FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR03MB432071701D6A19C3B4C0C33FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 29, 2024 at 03:01:06PM +0000, Nechita, Ramona wrote:

...

> >> +	/*
> >> +	 * DMA (thus cache coherency maintenance) requires the
> >> +	 * transfer buffers to live in their own cache lines.
> >> +	 */
> >> +	u8			reg_rx_buf[3] ____cacheline_aligned;
> >> +	u8			reg_tx_buf[3];
> >
> >> +	u8			spidata_rx[32];
> >> +	u8			spidata_tx[32];
> >
> >These will not be cache aligned. Is it a problem?
> 
> No, it should be fine without the alignment.

I.o.w. it means that only reg_*x_buf are supposed to be in the different cache lines, correct?

...

> >Btw, can't you use regmap for IO?
> 
> Unfortunately, I don't think regmap could be used, because of the crc and the
> fact that data is shifted out on the SPI SDO line in the interrupt. I
> consider perhaps adding regmap to the mix might complicate things a bit. 

Can you add this into the comment area of the patch?

...

> >> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
> >> +	if (ret)
> >> +		return ret;
> >> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
> >> +	if (ret)
> >> +		return ret;
> >
> >Can you use 16-bit writes?
> >Same Q to all similar LSB/MSB write groups.
> 
> I cannot do 16-bit writes due to how the spi functions on the chip and
> because the registers for MSB/LSB are at different addresses.

They are supposed to be on the different addresses.
You mean the distance between them > than stride?

...

> >> +	ret = devm_add_action_or_reset(&spi->dev,
> >> +				       ad777x_clk_disable,
> >> +				       st->mclk);
> >> +	if (ret)
> >> +		return ret;
> >
> >So, what's wrong with the _enabled() API?
> 
> Sorry, I am not sure what you mean here by _enabled() API, is there a
> different mechanism that can be used for this type of operations?

devm_clk_get_enabled()

-- 
With Best Regards,
Andy Shevchenko




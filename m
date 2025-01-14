Return-Path: <linux-iio+bounces-14342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EDA102E0
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7BD1683A1
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A551D555;
	Tue, 14 Jan 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kgiZomqQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225AA22DC5B
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846423; cv=none; b=nvjaaVQbRmaf3+VsKPFyg0wkveGd4vyynzDunTif1iBSeWncQ455xjX0oxdr55Qhp3g7RSJDZj9mOgqjLM+4jUU0cl/P8V6Fm+LW9w42G5px71vz7SACbzdRwCz1DU4TeROAgaE+9eQ4BINKFeHwjFHBMN8S2EzJx3W3j28QYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846423; c=relaxed/simple;
	bh=OBPZPLcBvvv+FPtuZw6TxdJYu3adeFP5S8YVoxDGk2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaxObPIh7wZiaQv5AfeA1UCk+/P03aE0nQZtdQ3UG2D2uducv1I4QH30lCurYJ4Q+Yxjb+IMctiw9R5XbrahDmW6nTdrbnxEpGpENPkvKwXcRt2cdMpEq6TIVP774dgbrD7JN8HTdnLdsoUM0wyeXeCAmvd3bkqUB5NB7KqjI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kgiZomqQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38be3bfb045so121345f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736846418; x=1737451218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/37c+Yttj941r4ynJDw+1uBoN4FX9MnFiq4zkIVGSDE=;
        b=kgiZomqQwxMlEko+jXGCkImgZ58oXMtnDHZb/Kmu6sN5UjzyMzSa3sXli5ydaXG/mx
         z7mIKjeEXRxEtWEimnJ8J7cvbsKzMLSUBuoU5B/nz/wYDAlV18KWxBQMnfT5ROW5Rbx8
         oYLsG3IYeWIPdyLhDoLgw0ucSZd49VdRSKQZAnP9MA4uLBu3RGt9+EdrxLDWUMGKTm3Y
         5WNfbon29trrnBBiIMwA3VSXrQxpajVEFQ7PLCQUQK767NUbtWKeUnUOPax+mJZ9KlHz
         i6adG2PUXuzV79LTBAlHPQF92qmxCEnL0ZwKrgO3jZeQZDYmf1yY+98TM5Ds2IuWXheE
         0yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846418; x=1737451218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/37c+Yttj941r4ynJDw+1uBoN4FX9MnFiq4zkIVGSDE=;
        b=dt2ZJ6Na34ia5oPZkXzXix2WzQuCCk4VEVPzsaPKXpkYtMTRwyshKTx1+fENHbKYlL
         BsMx6XzQG6jYv/usXMoYAjJxD3wGnjoyoWEakLyNbBgU/jNDwd7uHkpj0ITO6yQj3ew/
         IbZtVc6ZOiPGeUcsTc54aLEfMglP5F3yI741cWvg5XWGslv2bVUlIFZ59lclxh4+14mK
         K4vi/bnyf384Bfwd0IFlk53GRHcr6wYdRjqPRbO9CH9bKsd13HFwPF7hm7sca/SRgHES
         sofZPFulQWNQLdLIf94te2zVP+M332K6UZ7iKCNDO02poemYe2aKHF3JREd9Ihms1c3F
         3h9A==
X-Forwarded-Encrypted: i=1; AJvYcCX99OS87ITPefwqxA0ti7Ud91kt5yyL4op28FDt8Va7ybGMY4MKPCow0/6MV15I3OF49rCqQi54yyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKY+UW5S8n58Vpyjnx7WIPQzWXZza3eBfWsCjvUmskbrzKsV4J
	iwKj6qNMvt1FTyizl0uj+D5ax+om++Ph7EJxujG/23jDY1XBYQ2Yc7kf97n3+3Q=
X-Gm-Gg: ASbGnctbBi/aqUmTRwYI08uGxxETrqTAS0n4T4Y/Rk6mOGqpXQE4bX8783j+OsP4lzA
	htCEwyLN/iiuzYCUJTL4ZRK/muAfC0u71jPIifY8C9RRxEjz98d0UdA4ZGtkC3363UXTP44aqCM
	s0twXILhm5XY0GSfQFa8kMUpme6fsmBIh4bMFbmYpVvBwP3SaFzaNVrrha1/uTdLr+gT222wkEO
	hkZPAlOY9XxduYNzUbRa1fK4Bqm321iDHB0FVxLIAZugPkz
X-Google-Smtp-Source: AGHT+IGaa+sNWAqrycJgtnsyPSAWKNevGyL3SE2O0qaxJxzOSWFDdgE/Hr3mVrZrZ8dcvujn+PxVgA==
X-Received: by 2002:a5d:6daf:0:b0:385:e986:416f with SMTP id ffacd0b85a97d-38a8b0c7109mr16363674f8f.10.1736846418486;
        Tue, 14 Jan 2025 01:20:18 -0800 (PST)
Received: from dfj ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89fc3sm205063495e9.30.2025.01.14.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 01:20:17 -0800 (PST)
Date: Tue, 14 Jan 2025 10:18:54 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Mihail Chindris <mihail.chindris@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
Message-ID: <7io6a2nrxpedkd75ovdlcb6miqwwfrnxx3mhrzv7l65vgf2qz7@h2rkoacsxtx2>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-8-2dac02f04638@baylibre.com>
 <20250112143614.732e53ca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112143614.732e53ca@jic23-huawei>

On 12.01.2025 14:36, Jonathan Cameron wrote:
> On Wed, 08 Jan 2025 18:29:22 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > A new fpga HDL has been developed from ADI to support ad354xr
> > devices.
> > 
> > Add support for ad3541r and ad3542r with following additions:
> > 
> > - use common device_info structures for hs and non hs drivers,
> > - DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
> > - change samplerate to respect number of lanes.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> 
> One question inline.  I also wonder if you can easily add checks
> that mean any spurious (bug) read in DDR mode would get an error
> print to tell who ever triggered it what went wrong.
> 
> Jonathan
> 
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index bfb6228c9b9b..5995bab6a9b1 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> 
> > +
> > +static int ad3552r_hs_set_target_io_mode_hs(struct ad3552r_hs_state *st)
> > +{
> > +	int mode_target;
> > +
> > +	/*
> > +	 * Best access for secondary reg area, QSPI where possible,
> > +	 * else as DSPI.
> > +	 */
> > +	if (st->model_data->num_spi_data_lanes == 4)
> > +		mode_target = AD3552R_QUAD_SPI;
> > +	else
> > +		mode_target = AD3552R_DUAL_SPI;
> > +
> > +	/*
> > +	 * Better to not use update here, since generally it is already
> > +	 * set as DDR mode, and it's not possible to read in DDR mode.
> > +	 */
> > +	return st->data->bus_reg_write(st->back,
> > +				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> > +					   mode_target) |
> > +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> > +}
> 
> > @@ -319,6 +479,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* HDL starts with DDR enabled, disabling it. */
> >  	ret = iio_backend_ddr_disable(st->back);
> >  	if (ret)
> >  		return ret;
> > @@ -352,6 +513,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
> >  			 id, st->model_data->chip_id);
> >  
> > +	dev_info(st->dev, "chip id %s detected", st->model_data->model_name);
> > +
> >  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> >  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> >  				      AD3552R_MASK_RESET_STATUS, 1);
> > @@ -364,14 +527,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = st->data->bus_reg_write(st->back,
> > -				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > -				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> > -					   AD3552R_QUAD_SPI) |
> > -				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> > -	if (ret)
> > -		return ret;
> > -
> This is the call you just added to ensure we end up in instruction mode.
> I'm not seeing another place it is now called so is this an accidental revert?
> If it is intentional then break out a patch that deals with that change
> before the addition of new parts.
> 
> I was expecting to see a call to _set_target_io_mode_hs.
> 
>
The above was only related the IO mode, it was set for QSPI. Now the mode
is kept as simple SPI for all the configurations, moving to DSPI or QSPI
later for streaming.
 
> 
> >  	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> >  	if (ret)
> >  		return ret;
> > @@ -528,6 +683,9 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
> >  }


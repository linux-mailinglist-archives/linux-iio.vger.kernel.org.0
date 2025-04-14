Return-Path: <linux-iio+bounces-18122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C0A88CA7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 22:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB8617BA85
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C651DE3BB;
	Mon, 14 Apr 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kZfvKh6g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194E1EF380
	for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660847; cv=none; b=T98efO8CCID+0BiKEbSVRuG6Ce4VTyCAOTXHFpdhuUNkhsYU78eEp8Dds3BhtnGilcrNTLX/EJC8Siu4p1P87DYLl756Kbkj+MjvynhZ7FHrJlIgppY2uu005LuEgpHzxo2AaTiWBNLLKjssauXUAIKp/GcLuXSE5otVjTmemCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660847; c=relaxed/simple;
	bh=Nw0LcWGPT7ovb/UapvxLHTltKihzzl3S+Aj3yFzA+Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3B18cVxr/D1RtkTTbsLTpDqzwmetBmSk8Fyd04APWguaQg+TalthCyu3fASAhwvSbu2BOGbmUw35xdj0TnDNmvhhxDK4FL+R49lmt734SSAA/bK0i5h1Mi0V4gcUVf8DkFzgGrFhgK7revAyA4ihnZIqelraK1itfRJaZfepRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kZfvKh6g; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3043669f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744660844; x=1745265644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+dr467YMrCXRlo27LgBCAnCDb+4zH3txMsyWAkJpXA=;
        b=kZfvKh6gMXpNUV6sClVyHYdPqfb+wW1IM/qlKhhPFRHyQJb+GhloSOAV896kTNzjmI
         gd9Ea/2REUYl8wgmFykz0blSSxnOb99j6LJKDleNlqMckgjXDITuoUiZ10P0VinxdNa7
         N8MhKxnfjxVOg6I+JUMbGtzDPwjvSz1J21m5hH2mzJ3Ms9i4a9VMruNKWBDKq95P3eTx
         dSLT3X0lFjab/jQMZeT3N9c9H4vHGLDuFr5rFl2ZM3IVr4Cau+YYIo06CZXq/2bZipue
         We8DMpHIzYN4P6kgGcovvr9o9+rdRI7T6SfUlLyMvKBYIhlXjcVVYtAY7Menu4IZ+Hl4
         aBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744660844; x=1745265644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+dr467YMrCXRlo27LgBCAnCDb+4zH3txMsyWAkJpXA=;
        b=akjSijQBH+6t4Rgx3pBqnvG3I9doniorZC8q5gBEoETTtmrVIcvMNy9aoAhAGfJfsY
         JxzdnPLuYGSU72BF/XqJSfWRdlZlZMZm7xj4/fEwTS3eNJPRM5JwaitnVskzd7eydtW5
         rIgMG4Uqh4At0OyUIvjmWJtb6MgNhRapHhvarVPNpmGQYEUIVAjGhqGY8xsQ+vN2GMUE
         /E78DVfE0dohyHchhE2g/eVKJOe45toP+yaK6bNtxWJfcxJiRUrzB6EduW93UWlmY2xh
         7w5gdOxDLoRtTbsIAYx//8Dt1Mh5qMvBMTBljjF27akPtaeVeBUMdlGnHhKN6k/2TPhv
         lTag==
X-Forwarded-Encrypted: i=1; AJvYcCWL0aNAMHoZXHhvlc0BFy3lnaDIRDrJ4Ov2xSj1EnCUDKnhLF7pXgvpqUo45/kDczXyT9ZpjnIF/9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlwOx5V3qjkMWfTHoWPeCGZGkMbOukCokA8Xg8IJo7HDqUGQpu
	MWhEaCuYbk/V+tKu2hcamHS5pg5f3dcrGdxAPdiWl+Cq1Mf9NFvhLDI6mLEitk8=
X-Gm-Gg: ASbGncutrK/u2AY/jwgQph0/zc58UFhCWXirTiCEYnBhUMElYS13vRDX/WcBAWedpBc
	8g3qfiyEPYv48qtiaE26sxaJSLCiwkBNGpLzYCv+ZtUJ4tHDMJUZiMaLlk9SNX1IIOOuH02solT
	WuJThNy+KASnuJV8yfH3nY069sm9xnCfaDo43PVlmC5/OlIMldDYb8qC/C26vcSAH5bn9eHN/Fu
	/T0lcKeaDjo+lQAgOTUy0gaRTOmnw9iMZBtu2imtmzKFmskijmFhFXPIY3seSbSYO6MwFz+QEmP
	Zf4IJ/qRVrWxCVXmer8KiapbRmCQa34wYM069jzTEtHNnib460F0e77CUuNhNOivDYDyb+gstUL
	cnMQkbpMr+M3XhXVKt88b+mU=
X-Google-Smtp-Source: AGHT+IG6KMFrnxI51KOYugO7FGCSBaq/lcvpClmyxP06XlPfwq97MevV0T43qHWbhAawMclBkpDoXg==
X-Received: by 2002:a5d:6daa:0:b0:39c:310a:f87e with SMTP id ffacd0b85a97d-39ea51f59eamr11814936f8f.16.1744660843596;
        Mon, 14 Apr 2025 13:00:43 -0700 (PDT)
Received: from archlinux (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640a9sm11987383f8f.10.2025.04.14.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:00:42 -0700 (PDT)
Date: Mon, 14 Apr 2025 21:59:16 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7606: add SPI offload support
Message-ID: <alstwly2ya6qtb3usscpwavofzpinakmtx4dugt3aoey3fyjqz@sfnxwjt72jjj>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
 <20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
 <20250414192422.039817b7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414192422.039817b7@jic23-huawei>

On 14.04.2025 19:24, Jonathan Cameron wrote:
> 
> > +static int ad7606_spi_offload_probe(struct device *dev,
> > +				    struct iio_dev *indio_dev)
> > +{
> > +	struct ad7606_state *st = iio_priv(indio_dev);
> > +	struct spi_device *spi = to_spi_device(dev);
> > +	struct spi_bus_data *bus_data;
> > +	struct dma_chan *rx_dma;
> > +	struct spi_offload_trigger_info trigger_info = {
> > +		.fwnode = dev_fwnode(dev),
> > +		.ops = &ad7606_offload_trigger_ops,
> > +		.priv = st,
> > +	};
> > +	int ret;
> > +
> > +	bus_data = devm_kzalloc(dev, sizeof(*bus_data), GFP_KERNEL);
> > +	if (!bus_data)
> > +		return -ENOMEM;
> > +	st->bus_data = bus_data;
> > +
> > +	bus_data->offload = devm_spi_offload_get(dev, spi,
> > +						 &ad7606_spi_offload_config);
> > +	ret = PTR_ERR_OR_ZERO(bus_data->offload);
> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "failed to get SPI offload\n");
> > +	/* Allow main ad7606_probe function to continue. */
> > +	if (ret == -ENODEV)
> > +		return 0;
> > +
> > +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to register offload trigger\n");
> > +
> > +	bus_data->offload_trigger = devm_spi_offload_trigger_get(dev,
> > +		bus_data->offload, SPI_OFFLOAD_TRIGGER_DATA_READY);
> > +	if (IS_ERR(bus_data->offload_trigger))
> > +		return dev_err_probe(dev, PTR_ERR(bus_data->offload_trigger),
> > +				     "failed to get offload trigger\n");
> > +
> > +	/* TODO: PWM setup should be ok, done for the backend. PWM mutex ? */
> > +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
> > +							     bus_data->offload);
> > +	if (IS_ERR(rx_dma))
> > +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> > +				     "failed to get offload RX DMA\n");
> > +
> > +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> > +		rx_dma, IIO_BUFFER_DIRECTION_IN);
> > +	if (ret)
> 
> should be ret;  Thanks to 0-day for the report and fixed up.
> 

thanks for fixing it.

Regards,
angelo

> > +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> > +				     "failed to setup offload RX DMA\n");
> > +
> > +	/* Use offload ops. */
> > +	indio_dev->setup_ops = &ad7606_offload_buffer_setup_ops;
> > +
> > +	st->offload_en = true;
> > +
> > +	return 0;
> > +}


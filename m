Return-Path: <linux-iio+bounces-17731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD4A7D6A4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137523BEB7D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D7225791;
	Mon,  7 Apr 2025 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uh1FIZEH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AB221F12
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011770; cv=none; b=nEjoQgZGb9hyCIIV6n10Ui5787WJScfF6Ac6YrPkohiBzmzTesh5lO77D4Sg2JYaYdH/QOwZ1WXvetfTZu8DhhBU9QyCz7wLebABBRkzDzjL7hUodY4hjlahHtzYbE4mwZciPanaKSKLoRZUEyTnB9w0fCi3fC0Jq7ZudAMLJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011770; c=relaxed/simple;
	bh=TT2CwatyE3PScxA6aGzLKHWl9XyGLFx6ZMSmhaOgntY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwVA7ywPiseghKs6IlymTTIKuj6AQiS921AcXZlFQgYbGDyWTgLMtc5RxY+HxM1fT+fZgf9YrPaUoQZo715JeGQAh2f7KZ+iFfZ2B8EX0c1zTL8yHgfki2LZrr1f4Z7+PJslAnllB2lSoa/NTdWoIzAj13HyQP5NmMuEfBriZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uh1FIZEH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf257158fso27008065e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744011765; x=1744616565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SH50cqVXDjMtrk7e8ugGB2VmAlt5N0M4eNdMhk4w28=;
        b=Uh1FIZEHmLO0ydh4g3L1wDcEVKdGWwgWXtbRPV/o+Oj0BJqWxxkySgzxioEXA952tN
         piNPrlYHsPuQrSqhi2xn75UocRDQWCrvy8Ne4q6+V+FIKf8+9zMItUcK5M/ObxggDXmv
         AOAK3h/yzTGb76Ma/1SmYr17oDYo5CYTDZm8eFip5o7WN1bRgcXERAhKm1In8/Z1T22H
         HR8bTogDpOw19JMVITLhPd4FOL6fZaPMYnYIyzKSAuqBbXFT2JTus6h20i8Lc7w6Z6Xo
         VS/VkYtqO01JKldyu82WcqHTaDn5kyOQ9vqYYpfWofh/Xcf2ow609LpulSCLEy9+VYPi
         19yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744011765; x=1744616565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SH50cqVXDjMtrk7e8ugGB2VmAlt5N0M4eNdMhk4w28=;
        b=Z0Jzrkpg9hSBeihJe3sH15CScd3yhW2QYsI3TCWWt4dOt8/FCtPsxIawXJEtHSapGz
         ztRHQOm73sYehq2WBP0xiVBSP5vidUmWfKTEkvDDTH/dt81pUqtQU8gp/vXzDYQOmavC
         eputVV9IXbM2SBmEVTyCbVIWd0YW2wNW0i7lJb6X9ClOI1SBKynV6EzxPwovikX8Tcy+
         N+d9LWTup3WtAoVf5eF+DqvlDaBawnMGawMYnH+VbidvrG+rhHsZV7aYCTA9gtnX71p2
         QapPLB05E7lUr8IXLvRCjpJK6Xa66Je7gXXOhpYEtGkzCRgOBoAcnzmvbFW0pl2pm5GY
         PB9g==
X-Forwarded-Encrypted: i=1; AJvYcCXgyEZo8rxoiPyw1Fi9Zv574F9i0meLmOciBF30NSICIwCr2R2l6B6iiJIzfUtRYoNwnfkv6MHy3Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzww0HiWKRM4Jck0HUlOupfD/LATthOR8pJGZh0ohzD3dV74VKm
	hSbuPJst4VLbMWp49tdmwkMGRUtqkmIhFnPOkrbt/MDG3pqbN0eTISd1oJZcz2Y=
X-Gm-Gg: ASbGncsAZHSTbpfOknYwzI9swtXXH1RsbUB/EV88wSWKtuqW8AZ9CymCZQOanyEVGLW
	DElCmiQUJZUvq6gRJjPWgzDV4eHAPFjOCZd99bnJQd1v7qaOBBH+/WnYjKi5YpXiOHj36uKE9Y+
	TBqlFjRTz0G8tIGRCDvx/n01nidW8+YFi1LgT4OWqQg1z16SD3H805OcJDjvMDQ/l56fQDA0gbd
	bpyoogWxVlWw7ErTC3I60g9I3cY2lAGU3bpyuhx3eJvo6vWupBaoAHmQ1nup07HnKeechCUYe+G
	FX7qiYmmrlK45XZgRlp8prorRpXGyCXnPAImN8ykHEd1YwXay3QGwKERlJBxnrxHh54kcQqEVbx
	xB7VknsBbXAAUn4Dx
X-Google-Smtp-Source: AGHT+IGj4oFOpbFlCSYKH70mEMH5XLqpGaZABBghjAnvaw9bAjEggbo9aAX8vuvntuy/p28yBQRuZQ==
X-Received: by 2002:a05:600c:4f46:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43ecf86a5f9mr108047395e9.12.1744011765391;
        Mon, 07 Apr 2025 00:42:45 -0700 (PDT)
Received: from archlinux (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630de9sm124012395e9.1.2025.04.07.00.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:42:44 -0700 (PDT)
Date: Mon, 7 Apr 2025 09:41:32 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7606: add SPI offload support
Message-ID: <vjxnpbxvvh2vdjsamdznhrmrwwfwt5tjhugqik3ktueopajv6l@wmehdnowjvjq>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
 <20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
 <20250405164041.7d2e586b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405164041.7d2e586b@jic23-huawei>

Hi Jonathan,

On 05.04.2025 16:40, Jonathan Cameron wrote:
> On Thu, 03 Apr 2025 18:19:06 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add SPI offload support for this family.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Hi Angelo,
> 
> Code looks fine, but there is a TODO I'd like to know more about
> as it sounds 'ominous'. 
> 
> Otherwise this needs a dt review for patch 1 before I queue it up.
> 
> Jonathan
> > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> > index b2b975fb7fea4d1af6caef59e75ca495501bc140..b086122497eb22042171580878160334f56baa23 100644
> > --- a/drivers/iio/adc/ad7606_spi.c
> > +++ b/drivers/iio/adc/ad7606_spi.c
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
> 
> I don't understand this todo. Perhaps some more details?
>
it was just an initial comment i did, when i started the things
was not clear.
Let me know if you can remove it, or i can send a v2.

Thanks a lot.

Regards,
angelo
 
> > +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
> > +							     bus_data->offload);
> > +	if (IS_ERR(rx_dma))
> > +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> > +				     "failed to get offload RX DMA\n");
> > +
> > +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> > +		rx_dma, IIO_BUFFER_DIRECTION_IN);
> > +	if (ret)
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
> 
> 


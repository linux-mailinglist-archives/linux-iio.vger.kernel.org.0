Return-Path: <linux-iio+bounces-569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319968031B4
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00BA1F20F60
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9522F0F;
	Mon,  4 Dec 2023 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYZOekNS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670E171C5
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 11:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99456C433C8;
	Mon,  4 Dec 2023 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701690391;
	bh=i1+VKeSNTBMfL+Jw9GhDsIITBUtuYP9Ee/ts7oDwFgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYZOekNSEYjZHt0q1vMfNanrbaTZwFa3bfc1jqH/fiIipmhRFHY14gN7d2UaeUqYR
	 kFmE4PSCKESYlxK6Ze6RMrI+/P8eaVT0khlLEZkpqzVBn6lL58zjooUFS/uIj++YGJ
	 sfFo884yHwHHXfkZDfNcdrcNgoB7Y1nkyB0NcsxM9rztyQHw/ylE4SM6CmK9+QVI7W
	 Kwqgs8iKN6wGgJMqa+1YUa/g2dXrPqBJa+McF/UNmMDY8+3OABYdYctiN0A2DEaVce
	 LJpLJB1f8JHUBDKKqtImQ+k1vnFcqt7aehSxnSl/FYyFQQI/BfvYBYB+ls9WaiDz6d
	 OA5xATpMcvLGQ==
Date: Mon, 4 Dec 2023 11:46:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <20231204114623.3aaa98d2@jic23-huawei>
In-Reply-To: <ZWtU836_yYWgMYZp@sunspire>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
	<20231126183334.625d2d8b@jic23-huawei>
	<ZWX55o_-WT5BQlo-@sunspire>
	<20231201182453.00005673@Huawei.com>
	<ZWtU836_yYWgMYZp@sunspire>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Dec 2023 18:01:55 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello!
> 
> On Fri, Dec 01, 2023 at 06:24:53PM +0000, Jonathan Cameron wrote:
> > > > > +static int hsc_spi_probe(struct spi_device *spi)
> > > > > +{
> > > > > +	struct iio_dev *indio_dev;
> > > > > +	struct hsc_data *hsc;
> > > > > +	struct device *dev = &spi->dev;
> > > > > +
> > > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > > > > +	if (!indio_dev)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	hsc = iio_priv(indio_dev);
> > > > > +	hsc->xfer = hsc_spi_xfer;  
> > > > 
> > > > Also, pass the callback and spi->dev into hsc probe. Easy to use
> > > > a container_of() to get back to the struct spi_device *spi    
> > > 
> > > I'd rather simply pass along the client struct.
> > >   
> > 
> > I don't like the fact it has to be a void *
> > 
> > The core code has no idea what is in there.  At least we constraint it
> > somewhat with a struct device.  
> 
> but ...
> that is the nice part. the core code never needs to know what exactly is behind
> that pointer, since it only gets used by the i2c/spi module that provided that
> pointer in the first place. I've never seen a better use of void * :)
> 
> I could define a
> 
> struct client_handle;
> 
> in the .h, use a pointer to that that as function argument, do a lot of
> castings, but I feel like it's still a void * with extra steps.

Usual trick for this is either use struct device and container_of or
an anonymous union wrapped up in a struct.

struct hsc_client_handle {
	union {
		struct i2c_client *i2c_client;
		struct spithingy *spi_client;
	};
};

Then assign appropriate element and pass the containing struct around.
No casting needed.
Aim is to define it as a constrained type that can only take one or the other of
the types in the union. 

Jonathan


> 
> cheers,
> peter
> 



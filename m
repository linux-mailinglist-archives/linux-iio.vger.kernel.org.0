Return-Path: <linux-iio+bounces-550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B065801D9F
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341FCB20C32
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5A1BDE3;
	Sat,  2 Dec 2023 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="uLhAajAA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEB94;
	Sat,  2 Dec 2023 08:01:59 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 1AE6628EE6F;
	Sat,  2 Dec 2023 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701532917;
	bh=jB8oEC6mjeL2dllM2of5rXMFZjB7XW3eFIvJcBkpmWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uLhAajAAo+TjG7a0Fh4VrOH3X3D00QY7UL9uAav0gJvvnLaWnpNacmHpqxFxUXsNE
	 Frbs/MOfShNfXMJhQVRY7C+R6lxpcvjHqPbEgvS7fc+fTMUx6nw8y6HD1ASYgg3tru
	 g2Q3f4/tJEmfJqzo9XwfRcH9tuoBlk7mqjnwWrWk=
Date: Sat, 2 Dec 2023 18:01:55 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWtU836_yYWgMYZp@sunspire>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
 <20231126183334.625d2d8b@jic23-huawei>
 <ZWX55o_-WT5BQlo-@sunspire>
 <20231201182453.00005673@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201182453.00005673@Huawei.com>


Hello!

On Fri, Dec 01, 2023 at 06:24:53PM +0000, Jonathan Cameron wrote:
> > > > +static int hsc_spi_probe(struct spi_device *spi)
> > > > +{
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct hsc_data *hsc;
> > > > +	struct device *dev = &spi->dev;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hsc = iio_priv(indio_dev);
> > > > +	hsc->xfer = hsc_spi_xfer;
> > > 
> > > Also, pass the callback and spi->dev into hsc probe. Easy to use
> > > a container_of() to get back to the struct spi_device *spi  
> > 
> > I'd rather simply pass along the client struct.
> > 
> 
> I don't like the fact it has to be a void *
> 
> The core code has no idea what is in there.  At least we constraint it
> somewhat with a struct device.

but ...
that is the nice part. the core code never needs to know what exactly is behind
that pointer, since it only gets used by the i2c/spi module that provided that
pointer in the first place. I've never seen a better use of void * :)

I could define a

struct client_handle;

in the .h, use a pointer to that that as function argument, do a lot of
castings, but I feel like it's still a void * with extra steps.

cheers,
peter


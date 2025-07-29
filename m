Return-Path: <linux-iio+bounces-22134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DDB152E5
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8435602E9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0E253B40;
	Tue, 29 Jul 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYFEMwMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130825394A;
	Tue, 29 Jul 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814252; cv=none; b=cB77IZjEKfrdzrK7GiSygLf3S3YA6OdCS+gZ46ptrjEfXMcn6EzQHBT4b47VadUmxNEjQp2BR75Sy50JmlSAUBgOkN4pZ12jm9TC21gyEkKR2Nb9yx3AR+zjHKl5Mhay2TR9iyyuVC07Nq7Ak0CKXJ9oNj6qcdQb7MReXTizcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814252; c=relaxed/simple;
	bh=e/kMLxQK/nFx235KhbR4QiP5CRSJuobxUh+x8nD52uM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xobec+IMHwOJUdLfeRjVzTYrTfVqbNUYr41umPnyLlx4Vqt0WlPs0st7tgVdxQKCL2hhdL9+CP3ICmlY4vKMCWh4HweQ0LpDBY1oyJvbn2/lnZ6RW9iHmm3i0sn7gxD01iANutHg+aSXn0uCUi+Fx/m2e0gIUz0e93oc2dnZnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYFEMwMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CBC4CEF6;
	Tue, 29 Jul 2025 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814252;
	bh=e/kMLxQK/nFx235KhbR4QiP5CRSJuobxUh+x8nD52uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYFEMwMmqgwFqvyvF5VyDhLbjiSWHkf6C33ICaY7JC8F+y/O9ze39pGGszYuDru8i
	 ujHr2wQoqKRQju2A2Ms4fEQmX+lwTWdzqjnJvFxQ/02b5fh+/FbEjmvs5Tjn9jtQ2f
	 GabiVGlUjpokE3pvPZ7NCO5BnPlUlVBXOcWCMd/PPmA00eyCKRZ6GlG3H1OfDkUrqs
	 9e/elFFYlySjPe1kqCCSPAOXwevgehUzKrifeI9sHHtiqYtaGR8XPcdvP1Jm6u21Sv
	 M3dmta1hXt9zed7mwxncYBPWdF11/ZHzz7o59lm7bc/3YiwkivVTaAbBhN9nnvgQPL
	 6y2qnQL8uyyJQ==
Date: Tue, 29 Jul 2025 19:37:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 6/7] hwmon: iio: Add min/max support
Message-ID: <20250729193723.5f0d784e@jic23-huawei>
In-Reply-To: <099a8ce2-0837-4d79-8e58-8f7af0a0ff7d@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-7-sean.anderson@linux.dev>
	<20250727173542.46680071@jic23-huawei>
	<099a8ce2-0837-4d79-8e58-8f7af0a0ff7d@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 18:32:43 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 7/27/25 12:35, Jonathan Cameron wrote:
> > On Mon, 14 Jul 2025 21:20:22 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >   
> >> Add support for minimum/maximum attributes. Like the _input attribute,
> >> we just need to call into the IIO API.
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>  
> > 
> > Similar comments to previous. I'm not keen on the blend of allocation of
> > attributes and registration.  If we can break that link I think it will give
> > cleaner code.
> >  
> >>  static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
> >>  			   ssize_t (*show)(struct device *dev,
> >>  					   struct device_attribute *attr,
> >> @@ -123,6 +171,40 @@ static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
> >>  	return 0;
> >>  }
> >>  
> >> +static int add_event_attr(struct device *dev, struct iio_hwmon_state *st,
> >> +			  int i, enum iio_event_direction dir,
> >> +			  const char *fmt, ...)
> >> +{
> >> +	struct sensor_device_attribute_2 *a;
> >> +	umode_t mode;
> >> +	va_list ap;
> >> +
> >> +	mode = iio_event_mode(&st->channels[i], IIO_EV_TYPE_THRESH, dir,
> >> +			      IIO_EV_INFO_VALUE);
> >> +	if (!mode)
> >> +		return 0;
> >> +
> >> +	a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> >> +	if (!a)
> >> +		return -ENOMEM;
> >> +
> >> +	sysfs_attr_init(&a->dev_attr.attr);
> >> +	va_start(ap, fmt);
> >> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
> >> +	va_end(ap);
> >> +	if (!a->dev_attr.attr.name)
> >> +		return -ENOMEM;
> >> +
> >> +	a->dev_attr.show = iio_hwmon_read_event;
> >> +	a->dev_attr.store = iio_hwmon_write_event;
> >> +	a->dev_attr.attr.mode = mode;
> >> +	a->index = i;
> >> +	a->nr = dir;
> >> +
> >> +	st->attrs[st->num_attrs++] = &a->dev_attr.attr;  
> > similar comment to the previous, though here I think we'd
> > need to pass in the channel to an iio_hwmon_alloc_event_attr() as ideally we'd
> > not be messing with st at all in here.  So maybe it doesn't work out.  
> 
> Well, I used to have
> 
> +               if (iio_read_channel_label(&st->channels[i], buf) >= 0) {
> +                       st->attrs[attr] = create_attr(dev, iio_hwmon_read_label,
> +                                                     NULL, 0444, i, 0, 0, 0,
> +                                                     "%s%d_label", prefix, n);
> +                       if (!st->attrs[attr++])
pushing attr off the end is not a good idea even if we know we don't use it
any more.
> +                               return -ENOMEM;
> +               }
> 
> but even with a shorter function name, all the parameters are starting
> to get bunched up on the right side. And if we make it longer as you
> propose it starts looking like
Using a local variable
			struct attribute *att;

			att = create_attr(dev, iio_hwmon_read_lanel,
					 ...
			if (!att)
				return -ENOMEM;

			st->attrs[attr++] = att;
helps but still ugly.
> 
> 
> +               if (iio_read_channel_label(&st->channels[i], buf) >= 0) {
> +                       st->attrs[attr] =
> +                               iio_hwmon_create_device_attr(dev,
> +                                                            iio_hwmon_read_label,
> +                                                            NULL, 0444, i, 0, 0,
> +                                                            0, "%s%d_label",
> +                                                            prefix, n);
> +                       if (!st->attrs[attr++])
> +                               return -ENOMEM;
> +               }
> 
> which is IMO really terrible-looking.

Fair enough. let's leave it as is.
> 
> Maybe we should just stick everything in an xarray and linearize it at
> the end of probe...
If it looks nicer - feel free!

J
> 
> --Sean



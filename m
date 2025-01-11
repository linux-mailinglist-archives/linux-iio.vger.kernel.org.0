Return-Path: <linux-iio+bounces-14129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BCBA0A3B4
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9510169591
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D519F131;
	Sat, 11 Jan 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkWo5q6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6B24B23A;
	Sat, 11 Jan 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736600192; cv=none; b=FPG0jUJCJ7m7Sq89R0WUsf8vhyp2rcNNLUizH09qdUwJ4KbTmQCG2j1clSVH890sL673iC3zdWnLBwk4dkTXW8gEuRiLFFQId69kL/zkNqqOyBvO0UIHr44xIZm/NhL/SfLWuo3WNsTR7yRQrKOXxOglf8Zio2DfwE7orVM5DPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736600192; c=relaxed/simple;
	bh=LhZdJ42sMqFKGDmGiTMv1PLug74O089BpN8CgVbPYBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrOf2RKHAB6WyJH+li+/m7oV4vh0ap8EPhoWXDzQY78/GzeATcrYc7Fx22IbQWib8vGBNfrim1PqkY8+OFmhDu1lrIdv4igXrz97tYDrvYeYSya9hzBjV9zti1HKUwpWq8O3wDbO4APkevxsWz8jnJfW4HwfOD9BHlq1VbKhKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkWo5q6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF68C4CED2;
	Sat, 11 Jan 2025 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736600191;
	bh=LhZdJ42sMqFKGDmGiTMv1PLug74O089BpN8CgVbPYBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lkWo5q6nB1BMYay3bfUHadpZckebW9PR1fQLv5VW4ytwZYsWPFBkYDklHf3zOGJdH
	 /53bPXtalkRP5EcE4ev8NVijCBucSpJ9SyWU/mv3TFZ3i5nWQq2v000ku8fn7NnORO
	 aHLpbO4T2gaZK7ehC8mt/O24TFRFsyHkTmVGIpyUnOuYw/xa8Nk9fdQD8qlP6RKS8o
	 uhZ16J0PIUIJEeR5eIs64Y0TN4KyRq6RH+9b9bv/LpCeHfIEMc5bgnaipTJx31o6s1
	 KkcITkxKuSltO2aJ3l6VkOxX3YpS1nGpK35v5z8DzMmM5+IRt70DM1bqDgnmFgzC3P
	 UWrsBTRPm6W/A==
Date: Sat, 11 Jan 2025 12:56:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, mitrutzceclan@gmail.com,
 tgamblin@baylibre.com, matteomartelli3@gmail.com, alisadariana@gmail.com,
 gstols@baylibre.com, thomas.bonnefille@bootlin.com,
 herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add Nuvoton NCT7201 ADC driver
Message-ID: <20250111125616.2b12f03e@jic23-huawei>
In-Reply-To: <CA+4VgcKK1Hfz08paYjDCV=YL-C4bsWCNCRdH1Q8=4=hjEuYC9w@mail.gmail.com>
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
	<20241226055313.2841977-3-j2anfernee@gmail.com>
	<20241228133531.5e98357e@jic23-huawei>
	<CA+4VgcKK1Hfz08paYjDCV=YL-C4bsWCNCRdH1Q8=4=hjEuYC9w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


<snip>

> > > +
> > > +     /*
> > > +      * After about 25 msecs, the device should be ready and then
> > > +      * the Power Up bit will be set to 1. If not, wait for it.
> > > +      */
> > > +     mdelay(25);
> > > +     err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> > > +     if (err < 0)
> > > +             return err;
> > > +     if (!(value & NCT7201_BIT_PWR_UP))
> > > +             return dev_err_probe(&chip->client->dev, -EIO, "failed to power up after reset\n");
> > > +
> > > +     /* Enable Channel */
> > > +     guard(mutex)(&chip->access_lock);
> > > +     regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> > > +                  NCT7201_REG_CHANNEL_ENABLE_1_MASK);  
> >
> > Check return value.  This is over an I2C bus, not the most reliable of
> > transports!
> >
> > Consider doing this differently and using a bulk write for the larger
> > case.
> >
> >         if (chip->num_vin_channels <= 8)
> >                 ret = regmap_write();
> >         else
> >                 ret = regmap_bulk_write();
> >
> > However as you read ENABLE_2 unconditionally below, can you instead just
> > always use a bulk write here?
> >  
> 
> We can't use regmap_bulk_write() due to the chip's limit.
> regmap_bulk_write(chip->regmap, ..., ..., 2) ,
> the first byte is well written, but the second byte don't changed.

Find out why.  You may well need to set a few more parameters for
the configuration of the regmap to ensure the correct form of bulk
write. 

> 
> 
> > > +     if (chip->num_vin_channels == 12)
> > > +             regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
> > > +                          NCT7201_REG_CHANNEL_ENABLE_2_MASK);
> > > +

Jonathan



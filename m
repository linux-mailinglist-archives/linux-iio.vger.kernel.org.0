Return-Path: <linux-iio+bounces-26236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4EC6090C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6F2B4E05B9
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20333019C1;
	Sat, 15 Nov 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERIfl9vp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835D29D266;
	Sat, 15 Nov 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763226905; cv=none; b=ZAf0PUufZ+uX053lAL6DmjcRF0QMcDN2idvjmUmIAIt2ZU9yoZf43ugRIC58lOZkOHgRIdfBD7du51V6AvZZnvgIMUeNMuzmSQVC4n0q7kLsT51iq8MMIV0rxQeEuV0Ob9DY54vY/Zd/WJUZ7NwLMj0hp+5+okD/nGoH5UxK9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763226905; c=relaxed/simple;
	bh=G8p5uIKnd4m2qEyr7vhda7kF/1+pz6nM27ncchlWb9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oneX3F9A1fIA2weKufgkovsWFxBU5lKD7Ibg4RPE1TpgpFVPXRpMPZkJtTmpYfQF7OyR4KhxUPifKNMqIZFCAGP9TdNmqy1NzThsSliIfOtamAtY9WVguDzWaB3WYqMg5xBY5XhYfPB7y+DP9duGaavMxQYbzTz7KVRyQ6DYMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERIfl9vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8527C4CEF8;
	Sat, 15 Nov 2025 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763226903;
	bh=G8p5uIKnd4m2qEyr7vhda7kF/1+pz6nM27ncchlWb9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERIfl9vpGnA546eguEqFISaAxrQij9/CNTslDtAkKUXyIj6eTQmvcVBKbRPWokw12
	 up4Yy2by6+vhg6whZPPE8VccLKyM625Qaal8wbjYWHsJZrud8j5UoWUL3xdAmHXUFV
	 fxFcXEQNBpHMNPFUmejzjIPvnTaiEK9cj28xQL7FcCv3wOk492xSVhoUF6ogXrXZUu
	 GRyfKJZa4DyAeVIjvyEyZJ22MZsEgs5lA3L89/i02SWaMEAxVikaqBtKX3Wapo6o+S
	 2zfueJ3KhZEU6YpPPSTMLRri/4MUdR0ZVNpqDdIhGmoWHUIvWHG5CE1e80MNzNX0XO
	 r1dS3Ueya6big==
Date: Sat, 15 Nov 2025 17:14:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@suse.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] iio: adc: ad7280a: handle spi_setup() errors in probe()
Message-ID: <20251115171455.7564a367@jic23-huawei>
In-Reply-To: <aRdYWJ1jMT8oLxp8@debian-BULLSEYE-live-builder-AMD64>
References: <20251114151302.2255348-1-Pavel.Zhigulin@kaspersky.com>
	<aRdYWJ1jMT8oLxp8@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 13:27:04 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/14, Pavel Zhigulin wrote:
> > The probe() function ignored the return value of spi_setup(), leaving SPI
> > configuration failures undetected. If spi_setup() fails, the driver should
> > stop initialization and propagate the error to the caller.
> > 
> > Add proper error handling: check the return value of spi_setup() and return
> > it on failure.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System")
> > Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>  
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> As patch suggestion, we could also have
>   spi-cpha: true
> in ad7280a dt-binding.
That would make sense as a follow up.

Applied this to the fixes-togreg branch of iio.git. Given point in cycle
this may well wait until the merge window.

Thanks,

Jonathan

> 
> Thanks,
> Marcelo
> 
> > ---
> >  drivers/iio/adc/ad7280a.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> > index dda2986ccda0..63fceb239bd8 100644
> > --- a/drivers/iio/adc/ad7280a.c
> > +++ b/drivers/iio/adc/ad7280a.c
> > @@ -1024,7 +1024,9 @@ static int ad7280_probe(struct spi_device *spi)
> > 
> >  	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
> >  	st->spi->mode = SPI_MODE_1;
> > -	spi_setup(st->spi);
> > +	ret = spi_setup(st->spi);
> > +	if (ret < 0)
> > +		return ret;
> > 
> >  	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
> >  		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
> > --
> > 2.43.0
> > 
> >   
> 



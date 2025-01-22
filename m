Return-Path: <linux-iio+bounces-14528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA568A1915C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CE3A6140
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EBD21171D;
	Wed, 22 Jan 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI5DTmod"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C81B4236;
	Wed, 22 Jan 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548801; cv=none; b=tlA6picIlRqj+Ax9gjaDlKrmtvDJzvf5ORBFWtQ0SfcmnnuPKYddVdw61GMq3TGB2h8CLUgnMWL9U//xHdLXV7LoOU44HU6ms888kQkbVZbfSoEIOXFUdiax49yD5hfijouQsda04TVfS0iDwI0TlVMU6BBn5VEZKHKQ0PH6GoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548801; c=relaxed/simple;
	bh=iKnQL9RTOnngz0SMm/tnOumQudKJ8f4AEQgbPrAmeV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLarnBbF5NPTb+peGdghA7UnNAZ7JZrHgHz0HiixzX2aPLmy9W4nHM7SxHV4fIrJtb6D5Mn/11eyct3QkaqXvEY1n6OElwHIzVpzW4E5dGkaesL5dz4zE7spo2eaq1xpYnJ1RjWeWeOiBLuCvvQiapzm7T/fA0jmQtrbdMVe0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI5DTmod; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38be3bfb045so538763f8f.0;
        Wed, 22 Jan 2025 04:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737548798; x=1738153598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXeLILa28168MOtKXkW5zQ7hgk+QivJpytOZsjgGYMU=;
        b=KI5DTmodaWGX5oqf0FGtNNiIfx9CsIrBprtGQC2TVHgP++O3y3Si+tueVf1m63XOd3
         gCVTeis8yKMTDen/g80FlUBDfXmxREOJ358JYa57QGTRyKWjtVmeILHdr9AXC1/n27Vx
         ZWSvNGixyq3iWkrhSTA7vgVNx1TBS2ooXGNW8CdyH9bYhiw+lRKo7HlGh2zhPtUlk+b+
         RyIKlsDyZ4dPFx5Dy9TZSahH1xWzgQ6QgMLGqI6rRJvbmxLIP8MHj5opLTJh0GWuWLFs
         HMRHESPTU4KCVKxPU7AK2yiLVWZNb/RqeLb7uqryQGwVcwdDNvscRUaEBfdIPV/+hk9m
         TWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737548798; x=1738153598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXeLILa28168MOtKXkW5zQ7hgk+QivJpytOZsjgGYMU=;
        b=lPVnagVvjWKMwkRxFHDwVuXRYScVV+LzVIZiuvAlrF/46xB+/Nvp2G0KV9gUTFSR4X
         q3iV6UzMvYpeHv8g2uXIr869pgX29EVJtVzLEhy9stLaUOoBc6vOguzUTCKeMY6yShuC
         TaWFsSXl4XlV3UQuO1XmaeTseHaiOOVXW1mkWRdDQhFFD0K6AZXQSIVgYcEZ4LCYVUmO
         /iiT917Jv7VIeB8Oh6gtS5OfKQcfRafXIbtdEsAHeeIlib4lvWSbjGglk4jFRdADSz1n
         epIAKcFeGIEih2ckmJfF1D2A0C2MLQMYrDEkFuTIuskKGD1VafAVYnLiHEG2wd/KtmjO
         xBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwlefaJZdY4J8H2PZdsMfpWaGypsGxMMjOYRFwyLxjggev+pNRdWz1i9EuIBlf7hGnSwZJBNz82M3u@vger.kernel.org, AJvYcCVoZnPXn+mzOzk28k+2Frsi/IXdA++ePtApPK0LaA0dgSHKm6ReM11Bh/5lbG63LYHk6FirIoVLWQIag114@vger.kernel.org, AJvYcCXv+EmN+7vtIg/dNV52sEyXTIpptjbAl3AVN5gZo5nmByUQpNMhg4hFB5Xz+zI9yHKdhJHMVx+/7iZW@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqKXgfoKQDhEfq11g0utd8AGKSPa7XJIFoY/9WeRIUp8o2xhN
	w2GthJ7YRcKdnZq/M4qkUZMw5wRPj/p4++IHsdv5ujeI9LHaSFS1
X-Gm-Gg: ASbGncuB7vX9HS3R2bCjAJXrg60HcUAxGmee09yGispoCe2i9LdZxv/Pc5eblF/t89M
	zbeg0KS7s1XgP8A1AnFEI061b24X1JDYILfFJTpOJ49OjdPJABdrqgHLjIRorF5QbZLA+px1lya
	/1r9qzQ/rRZTRJ++vjCkpHOyUkNz1ek1lyflqmqqfZLXCVnAM6KJjDln1vasyGulBRwJVnIQmqp
	zJQ2YsaWv7ttUf0obt/jtGzGW03JTt1Ip6vjJovJKLshkWc6WnTRlSOqSpp5Q==
X-Google-Smtp-Source: AGHT+IFBm6umciYWXfrLBy/c5j/Ooxh0Z7aohIdgPsyRX2QXlNlXa886fspf+BIaC1/+BRtYTE8SpQ==
X-Received: by 2002:a05:6000:188e:b0:38b:f4dc:4494 with SMTP id ffacd0b85a97d-38bf5b0b89fmr19411156f8f.26.1737548797592;
        Wed, 22 Jan 2025 04:26:37 -0800 (PST)
Received: from spiri ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3288f79sm16042697f8f.100.2025.01.22.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:26:37 -0800 (PST)
Date: Wed, 22 Jan 2025 14:26:34 +0200
From: Alisa-Dariana Roman <alisadariana@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] iio: adc: ad_sigma_delta: Add CS assert function
Message-ID: <Z5Dj-jiLuuBp8KhN@spiri>
References: <20241221155926.81954-1-alisa.roman@analog.com>
 <20241221155926.81954-2-alisa.roman@analog.com>
 <20241222180713.64f27040@jic23-huawei>
 <Z49qgvy0ZVKJ0h0W@spiri>
 <d9828b7b-facb-4b42-aec2-427e68352a94@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9828b7b-facb-4b42-aec2-427e68352a94@baylibre.com>

On Tue, Jan 21, 2025 at 04:32:56PM -0600, David Lechner wrote:
> On 1/21/25 3:36 AM, Alisa-Dariana Roman wrote:
> > On Sun, Dec 22, 2024 at 06:07:13PM +0000, Jonathan Cameron wrote:
> >> On Sat, 21 Dec 2024 17:56:00 +0200
> >> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> >>
> >>> Some sigma-delta ADCs, such as AD7191 and AD7780, have no registers and
> >>> start conversion when CS is asserted. Add helper function to support
> >>> this use case by allowing devices to assert CS without performing
> >>> register operations.
> >> Hi Alisa-Dariana,
> >>
> >> I had a look at the ad7191 datasheet. Given this description,
> >> I was expecting to see it do a pre pulse of the chip select to trigger
> >> the acquisition.  However, what I see is a power down line (which is more
> >> or less a chip select) but it just has a specified t1 delay before the
> >> DOUT will change to the state for the first bit and the host
> >> can start driving the clock.
> >>
> >> That can be done by setting spi_device->cs_setup to whatever delay is
> >> needed.  The text is spi_device docs are a little vague,
> >> but I'd take it as t1 + t2 (maybe t3 to be safe).
> >>
> >> That is going to be more reliable than trying to hold the cs across
> >> messages / spi_sync() calls, particularly if the bus might not be
> >> locked (which the code below suggests).
> >>
> >> Jonathan
> >>
> >>
> > 
> > Hello Jonathan! I am grateful for your and everyone's feedback, as
> > always!
> > 
> > I got a bit stuck on this part. The motivation for adding this function
> > is as following:
> > 
> > int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
> > 	const struct iio_chan_spec *chan, int *val)
> > {
> > 
> > ...
> > 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> > 
> > 	ad_sd_enable_irq(sigma_delta);
> > 	ret = wait_for_completion_interruptible_timeout(
> > 			&sigma_delta->completion, HZ);
> > ...
> > }
> > 
> > I noticed that adc drivers need to call the ad_sd_write_reg function in
> > their callback set_mode function, in order to keep the cs line pulled
> > down before waiting for the interrupt (if I understand correctly). But
> > since this component and AD7780 have no register I just copied the
> > functionality of ad_sd_write_reg without actually writing anything.
> > 
> > Should I change the description/name to more accurately present the
> > functionality? Or would it be a better idea to not use the single
> > conversion function and write something from scratch leveraging the
> > cs_setup?
> 
> If the RDY interrupt handling wasn't so tricky, I would suggest to just
> make a separate function. But to avoid duplicating that tricky code I
> think using the existing function would be best. I think you have mostly
> the right idea here. Here is how I would try to do it...
> 
> 1)
> 
> 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> 
> In the implementation of this callback, call spi_bus_lock(), then do
> the SPI xfer with no data that has cs_change set so that CS does not
> deassert (using spi_sync_locked() since we manually control the lock).
> 
> 2)
> 
> This is the main part of your question, I think. In this part of the
> function...
> 
> 	if (sigma_delta->info->data_reg != 0)
> 		data_reg = sigma_delta->info->data_reg;
> 	else
> 		data_reg = AD_SD_REG_DATA;
> 
> 	ret = ad_sd_read_reg(sigma_delta, data_reg,
> 		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
> 		&raw_sample);
> 
> I would add a new flag or create a sentinel value for sigma_delta->info->data_reg
> (e.g. #define AD_SD_NO_REG ~0U) that indicates that this chip doesn't have registers.
> 
> Then modify the if statement a bit so that if the chip has registers, call the
> existing ad_sd_read_reg() function or if the chip doesn't have registers, call
> a new function that reads one sample and has cs_change set on the last SPI xfer
> so that CS still does not deassert.
> 
> This way, we don't have to mess with modifying ad_sd_read_reg() to not read
> a register and avoid the naming issue. :-)
> 
> 3)
> 
> 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> 
> In the callback for this function, do an empty SPI xfer so that CS finally
> deasserts. Then call spi_bus_unlock() to release the lock that was taken
> earlier.
> 
> 
> ---
> 
> Also, thinking outside the box, could we use a GPIO instead of connecting
> SPI CS to the powerdown pin? The DT bindings already have a powerdown-gpios
> binding for that. The could simplify things a bit.
> 
> With this, the set_mode callback would just be poking the GPIO instead of
> dealing with the SPI CS line. But otherwise would be the same as above.
> 

Hello, David! I really appreciate your suggestions! Things look a lot
clearer.

Regarding point 2) I looked a bit further into the read function and the
ad_sd_read_reg_raw() function seems to handle no register components as
you suggested:

...
			.cs_change = sigma_delta->bus_locked,
...
	if (sigma_delta->info->has_registers) {
		data[0] = reg << sigma_delta->info->addr_shift;
		data[0] |= sigma_delta->info->read_mask;
		data[0] |= sigma_delta->comm;
		spi_message_add_tail(&t[0], &m);
	}
	spi_message_add_tail(&t[1], &m);
...

So I will handle the AD_SD_MODE_SINGLE and AD_SD_MODE_IDLE cases in the
callback function by doing empty SPI xfers as you said. The bus seems to
be already locked before all the ad_sigma_delta_set_mode() and unlocked
after, so I think I can skip this part.

I will follow with the second version as soon as possible if this setup
looks alright!

---

I initially used a GPIO for the powerdown pin, but the first interrupt
was somehow always getting lost.

Kind regards,
Alisa-Dariana Roman.



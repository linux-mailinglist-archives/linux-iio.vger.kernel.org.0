Return-Path: <linux-iio+bounces-20747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7DADDBAA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 20:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20AA3BFBC4
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 18:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56F2E54A8;
	Tue, 17 Jun 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS7CaFXV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC12EF9D4;
	Tue, 17 Jun 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186341; cv=none; b=NUG9YtyZu30XAvUmunTrSzjlJ6UO0pmr38zJEF5nPN+fmOQccurxosCS5McXy8AitHUvvpOZvm0tM2A5ploVJw+/hbhFXGcPY0iKSpHb3VVDKo4LFeOYLhPlyaHtC0H7i+Q4ozdyl5PxAfNiUBuzpRq/gkUw8hv/hp0OIpp1V2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186341; c=relaxed/simple;
	bh=qlusW2sr4sVU2uXJRPIMCSXV7SxcfJyTdbN5C74eRL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx9jIPMZpNPfG5ux5QiJe7sHd/y2xfAITBeBcYtOX6BM1Jgob5ms3zaHENkwC6K+ML+Am0X5kHYQSDB9M5rfYWaZKiG60Zhuq7ZjKAJigTvrMhEYPlI9DqFBqebQkUKWZ7CB3RenJYtOWCmWSafLwnKiEaYeWCOAVnoI08wcs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS7CaFXV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23649faf69fso60441425ad.0;
        Tue, 17 Jun 2025 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750186339; x=1750791139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrjM2YpDGiy0ALMLMuxjn2ko9PVZeOACLyeqPzUnd5A=;
        b=CS7CaFXVpPoowWtJiHDw3RuJ3q+zsPORiTN3ZUcMmRv7wDCg7rUyaoO5K7Abv1KCJS
         lmz08A8uQk4hjGSKG3SedYF6+QUEjB60+htWfHJvHWMpDuM/v23Qvn8rvSoo7ieEleoN
         vubjKw/YPqG/siV7M8FvbX229O4XIclvRZ4pH2+iGPAvcRJruwFnQshYxX19q2xDlirY
         mDN5sFX/m5gW6p4nxvsFVhHyBoosu/EvIdOXkzjq+wHvPzamtNqNcPJFDeKC/Bo1MO8O
         VDs9xrfxjrHlLoueLGGs+fNjNPFFUW6gzPrc7sGugJzV898YMxAXU2dI23hB8xUsKibc
         IjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750186339; x=1750791139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrjM2YpDGiy0ALMLMuxjn2ko9PVZeOACLyeqPzUnd5A=;
        b=HrEQTRsvR2fgZIJ7KIdfkYpas2l628XcFBxsetlVC2RaqQ5SiaTdXMdYY6dRpsWUBb
         J9QLr2eX9Vn2jmAtN93CZ6RP2+n21X3KfaDBTBeh9fFxFojPWvOMni+SNV1eG741vWAg
         tcGOayiGPJSzjlaT3zhQwcCw6g/yE3RIxK5o2IlNd9KEDPaEOKmzIW0urOKm3SgKjuM7
         MZrREhEFS/LP6AsgI4+I7BTtG6TQsioOooz2gOIAs8hXwDIjRuSsFg9iugMVSPOW5Mv9
         RfxZn2Rn6/frKBJHmNLlj7q07gdqv9aDWhsyr1RuwlLORRf3iJ7Bq8HFd+iwWHw+CFrT
         Fh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbsSMIWpZ5/Xn02UWVRQB2dJqglAMj5taBiD3uXA03tSsU/6Ey/1joSbjWdQLcji+4io1bOplTjjWJWQ==@vger.kernel.org, AJvYcCV6QQ9Ca5dBLsbP64kV7bu7rMQw/JQo03KLdyIaozNqylwJpa5aAJv19hWR0KO0Nagbzw8dliSZlGMX@vger.kernel.org, AJvYcCVOBJ0bmT25E0wZhSkVfPrq76UCPD6xKmY4JrspRNPYhj6qg1ShANoiH0Kg2rV3Mz3pjX2ytKAH+os9OIQn@vger.kernel.org, AJvYcCXml1NQ+hXKvJP33XkebY144cKHWYBMCkJk9+a8tnijOg17+rquIfCcBsyusQheMIeUsdr2kFqt8n19@vger.kernel.org
X-Gm-Message-State: AOJu0YxocRwehglKhzCHG90riSR5LQLEikGUiBhnUB+Lk4kIyh3qpend
	2PlpNF4Dy00KUmGxn3abfOj+MyZpg0HCyNZYexezmBz/BsVEMYbyEmSK
X-Gm-Gg: ASbGncsgr9RJIN7hbbyNT1kT/Q18om1Ush4b9s9/TQm6tw1FuFqZRGNaSgKvYbv51VC
	UNw9GkGKVzdGRb1zTd6ty0SCsBvpmFLuCde2IBxqAk1Em9aAE1taCcCRNOcUEWIETMTWCRX9n9e
	DNWuisvm1Z/P327DuMQqOzpw3cqJ99e2naZ8a5ip4LG+Fp6acRIQB+3PjIbpelGKbRIFLgrl59I
	5bQZfXUOerBiT4Dp1/QAepUEPnfEo7hPJ5LoHtmb/KR5SsE/2mue6vKXxWqdtSqRKXRurGhIBbt
	Abxr3zd1OjwckLwgPOcK+zXRl5EXRYSFg/HQ7C0j4uoFbk2NPoH5Um4RqgQYGm2mQj7LmCR/8q4
	f/NhOZg==
X-Google-Smtp-Source: AGHT+IEbxeRsrV9v0cFZpm/JNC9Jn+xijTCUioEIcN6OlyBZRQCnX9DQlgMFOHdhLztTsnPvJxpk4Q==
X-Received: by 2002:a17:902:d552:b0:234:d7b2:2ab9 with SMTP id d9443c01a7336-2366b005cd2mr247602865ad.12.1750186339109;
        Tue, 17 Jun 2025 11:52:19 -0700 (PDT)
Received: from localhost ([2804:30c:4000:5900:b4c4:6073:1a92:4077])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365e0d0ab2sm84238655ad.246.2025.06.17.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:52:17 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:54:06 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aFG5zufl_znUw3xL@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
 <c29feb5b-2699-411a-87dc-249f5b9ff6c0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29feb5b-2699-411a-87dc-249f5b9ff6c0@baylibre.com>

On 06/16, David Lechner wrote:
> On 6/10/25 3:31 PM, Marcelo Schmitt wrote:
> > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > 
> > The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> > analog to digital converter. The AD4170 design offers a flexible data
> > acquisition solution with crosspoint multiplexed analog inputs,
> > configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
> > digital filtering, wide range of configurable output data rates, internal
> > oscillator and temperature sensor, four GPIOs, and integrated features for
> > interfacing with load cell weigh scales, RTD, and thermocouple sensors.
> > 
> > Add basic support for the AD4170 ADC with the following features:
> > - Single-shot read.
> > - Analog front end PGA configuration.
> > - Differential and pseudo-differential input configuration.
> > 
> 
> ...
> 
> > +static int ad4170_fill_scale_tbl(struct iio_dev *indio_dev,
> > +				 struct iio_chan_spec const *chan)
> > +{
> > +	struct ad4170_state *st = iio_priv(indio_dev);
> > +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> > +	struct device *dev = &st->spi->dev;
> > +	int bipolar = chan->scan_type.sign == 's' ? 1 : 0;
> > +	int precision_bits = chan->scan_type.realbits;
> > +	int pga, ainm_voltage, ret;
> > +	unsigned long long offset;
> > +
> > +	ainm_voltage = 0;
> > +	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ainm_voltage);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to fill scale table\n");
> > +
> > +	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
> 
> From what I read in the datasheet, it sounds like if adi,reference-buffer is
> precharge, then the PGA is bypassed, so there would only be 1 option in that
> case (gain = 1).
> 
Although not explicit in the datasheet, looks like there are two precharge
buffers. One precharge buffer is used with the voltage reference inputs and is
associated with the adi,positive/negative-reference-buffer dt properties. The
configuration of that buffer is set through the REF_BUF_P/M fields of AFE
registers. The datasheet doesn't mention the PGA on the section dedicated to
describing reference and reference buffering features.

The other places a precharge buffer is mentioned refer to it as 'gain = 1 precharge'.
My understanding is that the PGA bypass precharge buffer is a different buffer
that is only used when PGA option 9 is set in the PGA_GAIN filed of AFE reg.
The PGA bypass precharge buffer would be used in the analog input path while
the reference buffers would be used in the reference input path.


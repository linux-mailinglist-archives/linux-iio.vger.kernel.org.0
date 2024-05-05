Return-Path: <linux-iio+bounces-4827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C998BC4C1
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 01:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC020B20C98
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5B14037C;
	Sun,  5 May 2024 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeCvafA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30B13FD67;
	Sun,  5 May 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714953481; cv=none; b=nYT4K0SOzsEaXQJrkV9mS8oz1aIgN5mfzcGlGGlvICbXbvD/cto7XG6xMPqVxsIM7Fnn0mtKfStND4USnLoZ1q4o85LDKnsvVowxJG7oK/a7NTXEueHWiyedCJbOvSp5Nq5+VGzRIYc2ZJC5Zk4a+dcHPHpEoPkMl0oE1LPOCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714953481; c=relaxed/simple;
	bh=b1zrhgEjIW1V/tyF4jLYofu+SGbMESlcMEYDzQ9v/5g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDXtqCtmj3AUibj5dXVrUjh8sslGH1jjZGK/qbH4ldBYQTTPX2tMbVDeDNCFgfGVxMJsoqL4B+WJbWhR+uf9KTwQl6dq0tzj6bni3rzT5kXgyGA88qjn869S4Hn6P0MRdildj/HljXg+hSvf/Urt1ZUtOO5sAg8bMMHHl1BlNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeCvafA0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so79180666b.0;
        Sun, 05 May 2024 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714953478; x=1715558278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCigQMUMjJ8cQenG2NG0LIcpKtuyuICC//O7hgI+kEA=;
        b=FeCvafA0mlsN1qh2S+VWdq+2fdpwFSzK1CYBAw2NtToqTFPVG4Khooxvo9BEFy/O3I
         PwPA/HbXuSIxhZzU8R2kxcWojRh4IcBxg4KlZZ2AQwQYOk1ke6xsqAWGnn7L25vfp/NQ
         uDhEv3xydQ5y0DKV/VPJkejEH9Jpqm8UCliRQlAluRvwX+i07aHE1ATEwzTTFjCba402
         98ICN5nt4AOs0oeNMa7x3f5NWt9WqCfPpqTfKgHLuEvQa6SeTc6fN5HZul/znk8lkNo/
         TQCJEv2RW8Wfl/lUVLCPt/85fuqYfbiUFgtLNP2BOfLe/URN32QHhs/csaJjC8LYMfx0
         d3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714953478; x=1715558278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCigQMUMjJ8cQenG2NG0LIcpKtuyuICC//O7hgI+kEA=;
        b=B6Srnj2Ms+VQJjQGQ2eme87Yem608s6Vh7tBzzgVOqU+37f8KAkmhyPVN0iQwLyV5P
         jC8exewasIZC1iGdLXDn2Bzd+hfW4jahy5+ifrsc4ZcLXMPMBEMLltdPESRULaXbuSqT
         5DlabCqC9eulHYIJO8McT4z+4iVKmsJOUcq5fzcf0dxZZM7CRotKrwbRIqZw1Vo1M53W
         1CxPEHwGahcs7gDK4S/egXqb4VRZDXRybHC5PzNOejRaQs5sPztEnjn1X17liB9FHsoE
         339Uk0kOTuHJahCk2nub4BVPoBGRDo2JU4eyZY8AJpsaTaXbzT08pOHNBKeD+z4qY/ia
         Y5PA==
X-Forwarded-Encrypted: i=1; AJvYcCVQxhN7BybbtCeqM6B6RyvKCSERQA9zGiIGC/kYNuzRwKX3rKvdTkxN4WVw+Gw/uE/aSxAIhqjhcsC2vXEdArh2oBXHOC9pDtU6MXf3B9xPPzZEtFxLPjkHtz57dzW1YcYnntl1eElm
X-Gm-Message-State: AOJu0YyR1gAOLAVQijn9b+v3FCPuq/7CCr/3IF5Dzg9LxXwOAmiUHrtK
	mZDJQKiIUGRTOFRGE5ZaPj7dky2WIP+J4CsYV95mus6Lb407lzu7
X-Google-Smtp-Source: AGHT+IE2qAwqkaMPBRFcNP84zoQgW0vZpwdywom40b5zvFemSqWuoAbvTMCrAGZfq8NtL6pEGNpcxg==
X-Received: by 2002:a17:906:d0d5:b0:a59:a938:d926 with SMTP id bq21-20020a170906d0d500b00a59a938d926mr3014220ejb.25.1714953478116;
        Sun, 05 May 2024 16:57:58 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:7a5f:ec16:256e:4660])
        by smtp.gmail.com with ESMTPSA id js10-20020a170906ca8a00b00a59adf9d8c9sm2026550ejb.204.2024.05.05.16.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 16:57:57 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 6 May 2024 01:57:55 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240505235755.GC17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
 <20240429190046.24252-11-vassilisamir@gmail.com>
 <20240505203456.0c4c0c90@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505203456.0c4c0c90@jic23-huawei>

On Sun, May 05, 2024 at 08:34:56PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Apr 2024 21:00:46 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> > temperature, pressure and humidity readings. This facilitates the
> > use of burst/bulk reads in order to acquire data faster. The
> > approach is different from the one used in oneshot captures.
> > 
> > BMP085 & BMP1xx devices use a completely different measurement
> > process that is well defined and is used in their buffer_handler().
> > 
> > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Hi Vasileois,
> 
> Just one question on this inline. (patches 8 and 9 look good to me)
> 
> For v6, only need to send the patches that I haven't already applied.
> 
> Thanks,
> 
> Jonathan
> 
> >  
> > +static irqreturn_t bmp180_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	int ret, chan_value;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = bmp180_read_temp(data, &chan_value);
> > +	if (ret < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	data->sensor_data[1] = chan_value;
> > +
> > +	ret = bmp180_read_press(data, &chan_value);
> 
> So I 'think' that after all the refactoring you end up reading the temperature
> twice.  To avoid that you need to pull the read_temp() and read_press()
> function implementations here and only do the (currently duplicated) steps once.
> 
> You seem to have done this for the other case, but missed the bmp180?
> Maybe I'm missing some reason it doesn't work for this one!
> 

Hi Jonathan!

So, I didn't miss it. This is an old sensor and in order to get data out, the
procedure is much more constrained. As you can see in the datasheet [1] in page
11 there is a well defined process on how to read the data out. It's not
possible to make a burst read here. Hence, the strange bmp180_measure() function
in order to wait for an EOC before reading the values. Indeed I am reading the
temperature 2 times which is not optimal but in order to read both of them I
would have to:

a) either get the temperature out of the bmp180_read_press() function
(which would ruin a bit consistency with the other bmpxxx_read_press() functions)

b) make a bmp180_get_sensor_data() which would look like bmp180_get_press() but
also gives temperature (which won't look that good).

That's why I didn't touch it. If you think it makes more sense to do it, I can
follow one of the 2 approaches, whichever you think would make more sense.

Cheers,
Vasilis

[1]: https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf

> > +	if (ret < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	data->sensor_data[0] = chan_value;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}


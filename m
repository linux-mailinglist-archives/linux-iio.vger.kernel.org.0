Return-Path: <linux-iio+bounces-14115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE3A09E13
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 23:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C737A169EBD
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A820218ADB;
	Fri, 10 Jan 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Vt+yoJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749020966B;
	Fri, 10 Jan 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548323; cv=none; b=RTIuwAaX7N3GCKaEdeVTHiwgO4lpnpl/VV/9XUzcG/KNeoMMa3Gzjyc7ZVkdum4ueD3Ayj3DXZV+KRsv3+Vy+o/oq0Ld7k1oe1TkXVnQXrMWqXpW4eKa7PaQq4gExBpgWfstGszsYd+cTM8gZSkBkuwU7gTIqQeCoxb8UY40GKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548323; c=relaxed/simple;
	bh=lFjvjHdVpUhNz1TeotEMqAdD8Q4o3NUHLP0wkWOhTn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXN/OGI2hVjFule1wKn09gsNrI7hqSF1IhlkozalEeoqpEEH6XhnSWPX7bOJkNR8iiy9XBVzL+9poe8oQDGyI1YjjHtWWWP0cdGwY3k56BDKqxaAzWNedvlpPWN/jtxfUIg8U6wGaZKdoSLN7KlIo/YkTNEO2fHM9uaPolzMvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6Vt+yoJ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85c41442fdeso777235241.1;
        Fri, 10 Jan 2025 14:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736548321; x=1737153121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nytOiv6Smj9uJxu4IjGWdF0jKbPu/gh6DeQn13yAQCc=;
        b=l6Vt+yoJvp70b606xg6FhZLKBcQKCgaWFgEkU7PmfwMUj5eqqRDXnulwehnYQ/2b20
         Ighei1kDDhZvUFzzGk/0b+MLt4L7epmyesW5M0E3ucoM/p4Y6nmYBl5ICmMU5LAeexMi
         CCDBmKN7MT3Vfsa/z9z0/pb1jPH3lkUtDtBKprplPXr1PlwNhpoDEcUKdCIc46rqDXA4
         Pxn71d+PZCE86QqkVGVCju0bcB4Tb7Ujxzw80txHBB2wPaYAPmEgexhHo+9pefPBIlrN
         MmvEhC7xQ2+J/5q6Uq3LD3S8szFlGmjId24UnWDS7o6Sa1VamyQS40ztcZ347KNaNSxy
         vjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548321; x=1737153121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nytOiv6Smj9uJxu4IjGWdF0jKbPu/gh6DeQn13yAQCc=;
        b=jeBiI10iuJkxmQ+HeyIHNR04IC4NBGp3yO0Q1T78oU1QWWrKAJ4jM+OvMvCUnwh7V4
         Mr2vhTWrlzGF265+R3TZLalyeQ1RaM6Q6imgGpLupL1JnIkYwm8GpzXX/b9O+1SmY13Y
         Xfy1y1IX6DFhGfNraTKOJXtKVwEtPbY9ScyU8kVd1wweGJ+JsWKHOZfM0SjPpbPQsZqO
         WVMjuZRHvkdgteMHVEKMIsh3Th9bgfose+on6D3AxgBRAJroYiKmoaQxiTY4XQlXFs42
         dYsOhDknvEAz/1XrQDlA/zIqnvRolZuT7i8/Lw3EWU1K0SngOL1DPO+uneOh/wvhjtqk
         8RDw==
X-Forwarded-Encrypted: i=1; AJvYcCV0SYHtpXk3W27mGlIcX8s8k/KBiGjfEg/ij6src4fZKGh/yWHLud8/okh29mVfU3bfiaPCy/OUNDah@vger.kernel.org, AJvYcCWUawmNA+0m47VusPLO86rryBjz85dIY3oRtHeyQhpHPLScS6fHxQj7XgusyMKdImy5fBSDjI2rzuaQS8Jo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3cJ/5q2N3+2CknwmRhSD4y0F0zqr6dgrsTHMv+zYtd8mGms3
	klU1nfLV52v0V8m/cl4P7IR6Ct+DVK68dDuKWqj9MlZ7LteFmUJ8
X-Gm-Gg: ASbGncvTwXawtb8hUefDTjILuZJ2PvFhCksg27veC0xXaupc8wa1K8cIOMEZg9McUjS
	OBmXOmaFKms8LWyzW30Lqvy7Q/ngKoVFobRXmoNt9uW0+TLgAlplJVFQN6nVh97oAzzq5yrLkZX
	5mynMAW2e+iKjVgtvlHb0azDpnUpPOYpB8apGQZWwyo9/EWVlwXmY7qYiw2KqFAwLepn/hphosL
	k4Tw/D+uz/F5Eht1E/63nDPTmPxHiT8sG1wsZy6zR64ztP9XTJXRWFeVZWSRjkuM+k=
X-Google-Smtp-Source: AGHT+IHL2APnt72+5UC3M20FseD04FEYhj2Sd772lWQjN5dkpflFeR3w0TbxOySGR4B1Td8OE1Btqw==
X-Received: by 2002:a05:6102:148f:b0:4b2:4877:30bd with SMTP id ada2fe7eead31-4b3d0f979dcmr13229343137.12.1736548320105;
        Fri, 10 Jan 2025 14:32:00 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86231233532sm3544973241.0.2025.01.10.14.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:31:59 -0800 (PST)
Date: Fri, 10 Jan 2025 19:32:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	PopPaul2021 <paul.pop@analog.com>
Subject: Re: [PATCH v1 15/15] iio: adc: ad7768-1: add filter type and
 decimation rate attributes
Message-ID: <Z4GgABhZUG4Aacjw@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>

On 01/07, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables SINC3 and WIDEBAND
> filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating a decimation attribute,
> users gain finer control over performance.

If not going to use -3dB ABI instead of decimation rate thing, maybe throw the
formula for the sampling frequency here (or near its use in the code) to help
make the relation between samp_freq, master clock divider, and decimation rate
clearer?
Is it samp_freq = mclk / (mclk_div * dec_rate) ?

> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features.
> 
> Co-developed-by: PopPaul2021 <paul.pop@analog.com>
> Signed-off-by: PopPaul2021 <paul.pop@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 429 +++++++++++++++++++++++++++++++------
...
> +static const int dec_rate_values[6] = {
> +	32, 64, 128, 256, 512, 1024,
> +};
> +
> +static const  int sinc3_dec_rate_max_values[4] = {
> +	20480, 40960, 81920, 163840,
> +};
sinc3_dec_rate_max_values unused?

> +
> +static const char * const ad7768_filter_enum[] = {
> +	"sinc5", "sinc3", "wideband"
>  };
>  
...
> +static int ad7768_configure_dig_fil(struct iio_dev *dev,
> +				    enum ad7768_flt_type filter_type,
> +				    unsigned int dec_rate)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	int ret;
> +
> +	if (filter_type == SINC3) {
neat: switch (filter_type) { ?

> +		ret = ad7768_set_filter_type(dev, SINC3);
> +		if (ret)
> +			return ret;
> +
> +		/* recalculate the decimation for this filter mode */
> +		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
> +	} else if (filter_type == WIDEBAND) {
> +		ret = ad7768_set_filter_type(dev, filter_type);
> +		if (ret)
> +			return ret;
> +
> +		/* recalculate the decimation rate */
> +		ret = ad7768_set_dec_rate(st, dec_rate);
> +	} else {
> +		/* For SINC5 filter */
> +		/* Decimation 8 and 16 are set in the digital filter field */
> +		if (dec_rate <= 8) {
> +			ret = ad7768_set_filter_type(dev, SINC5_DEC_X8);
> +			if (ret)
> +				return ret;
> +
> +			st->dec_rate = 8;
> +		} else if (dec_rate <= 16) {
> +			ret = ad7768_set_filter_type(dev, SINC5_DEC_X16);
> +			if (ret)
> +				return ret;
> +
> +			st->dec_rate = 16;
> +		} else {
> +			ret = ad7768_set_filter_type(dev, SINC5);
> +			if (ret)
> +				return ret;
> +
> +			ret = ad7768_set_dec_rate(st, dec_rate);
> +		}
> +	}
> +
> +	/* Update scale table: scale values vary according to the precision */
> +	ad7768_fill_scale_tbl(dev);
> +
> +	return ret;
> +}
> +
...
> +static ssize_t decimation_rate_available_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int len = 0;
> +
> +	/* Return decimation rate available in range format */
> +	buf[len++] = '[';
> +	if (st->filter_type == SINC3) {
switch (st->filter_type) { ?

> +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MAX);
> +	} else if (st->filter_type == WIDEBAND) {
> +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MAX);
> +	} else {
> +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MAX);
> +	}
> +
> +	buf[len - 1] = ']';
> +	buf[len++] = '\n';
> +
> +	return len;
> +}
> +


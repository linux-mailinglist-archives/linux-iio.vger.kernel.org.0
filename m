Return-Path: <linux-iio+bounces-18936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0CAA5F46
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C699C0923
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528A1AB6F1;
	Thu,  1 May 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9WLwoj8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596A2EAE5
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746106627; cv=none; b=gv034YzC4IQIXHxWv4htjgXbM5HCmzhrS6s+QUeYv9GJM8S4lUMyy7PxJTvxVWQfg0DRHcZjQXhYlmCsYeasbpimEa2a8itJoLexqV86+QojJIROYQoOb9yY5Leb7Bu0ywMVG5hTOvvum3NDMwxYYAIwSfXUYafmfrzA0dKTYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746106627; c=relaxed/simple;
	bh=9MNpS1gJG0qyHRf2FJfHx17kDP9N8N1hNQWavkpaHFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6LAdhxDgQTdovz5JpvYff+0f/HHXEvI/we1K2DxqADn7ud/731Y3bLWLS+Z8SfVZxug/vsXbacpKhSUTmt837MbNuJKCOZZNP8tEvT918yr4piEbl1+dhlQu8duPbaAplNTFAYGqBsiPUNRVmPl8QxS8s7RVgUOxgBwNcXrBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k9WLwoj8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39bf44be22fso664514f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746106624; x=1746711424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVJu0wRzEXe69H/pIntKvn73bqLsL3OYyEuqMHp/wd0=;
        b=k9WLwoj8R6Lwcqz8gF+6ASnsAu/MSALdgx9WrG7GAztAPHAXuifA36BrtNaEqwNeVx
         jOq98QYeOogpKM+RxgPfn6qEvZj1ONay/gPPMjP2Pd4oSoF1RH2zXRObgZ+zxxlIWphv
         p52Zi/mNOV8CU6hsCN/AA745wOP9JhcFPWv275wbTTtim9xK/Bi2RN6wnDEDxDGUZ877
         n30rzLFy3iik00p05fObBKweioObXk51GzGOc0yM5bYb20wVUVilW289iEorJhrK+YWa
         gKOe9rxYja73bfLTAtoPU84KWztj33O+8pUtdRxz4XXDtWu829kwto1QwN3Eyhy3Naex
         9U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746106624; x=1746711424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVJu0wRzEXe69H/pIntKvn73bqLsL3OYyEuqMHp/wd0=;
        b=lad6fkaM4/gsdhdQHQzO2KKrBMeDFLkeEhT8MOh7lenPcg/XK/4YrogE+jMfE5MYHc
         QLvDOshIUQmubyVm82cKyvo3ZLkv/k+YvM4ysyoLFT79jtW2BR4R581CGHIrrx8cSWsf
         KSrujV0vlXfSTwDkWAoyzLk4IwFwwwIiSmxNkI6KOdExjQYjmWmUU6BTpJxokbTduwpq
         rFWGD5NPHLaHQ5Q3+RIkQ3BZMA4lc+PaXOYjm8p3wmu+56KiiRBzcmDA3659m0JYIIGe
         IU0PZLWp4tTUxrp31Ro4bW21d3l8O8MC7QGv2qmwszQCxorHiDVh9pk8cVliJc3Ze/Db
         Kmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWaGB02SlJUeayBCIz8fG63SShd2BQV5L7h2HBezXDqteSuAHVMA3cMYHGBIjjaXwYqiaS+bF9C8tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYt/4RPXN0ucTLYHR7/c0IoeEXkZq28VUw+DuIhaYYhs5mCS5P
	/4XIy8BTyClE4UkECHr5XVNRrPFCy1lkrxM0PZcB4uB03Dg3W2+0GX1qm39UPss=
X-Gm-Gg: ASbGncupYAeZhs8BdKghq9ccfUkN20kTsp7QPD9MeEOhQepNb/ciAMeYUNtLZbwfOZ8
	S9+fa7owVd2gaIUXbVpMqo5ss/dV+ZeeekmcPNzaE8J5wisZTJHR2NhfdJm+Lf9ZOOLo/BvQpCJ
	2gbSqHGt7DVtGLrwFu7HAjA8tvRMEB68LLOhGqqtYkopJnZyx11pLPD1TkIc2oP+umlXjrH0CUe
	Wj6/CI6K67P+jgScR9aIvi+Xa82mzpR306R3VKtRAygMwn1fEQE3U782aVMp+1F2BfLy7ejCfIG
	Q/1XmopkLq/jwcRn9KyZXdVIiuHwC3m0cUaeTrpQqy0PuT8pxdDF+37roQRLxyh1QlhSErJGhbV
	klnkYoJE=
X-Google-Smtp-Source: AGHT+IGdPBuoaPeINXPNqsaOhchsX0XkfzRa1+uOWIy0i9ZUyGPNCW3n5dd65l40+aOPl7d3QgDt+g==
X-Received: by 2002:a5d:5f44:0:b0:3a0:8465:43 with SMTP id ffacd0b85a97d-3a093073423mr2527425f8f.43.1746106624153;
        Thu, 01 May 2025 06:37:04 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a88250sm843781f8f.80.2025.05.01.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 06:37:03 -0700 (PDT)
Date: Thu, 1 May 2025 15:35:52 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <y6hss7bo25hiwzzplbbhmdodpmqbgpkarqvemn3tn3fig26tb2@753sxtygndaz>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-5-eb4d4821b172@baylibre.com>
 <0677db3c-9c36-4f34-93c0-5c53d702c4bd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0677db3c-9c36-4f34-93c0-5c53d702c4bd@baylibre.com>

On 29.04.2025 17:46, David Lechner wrote:
> On 4/29/25 8:06 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> 
> ...
> 
> > +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> > +					struct iio_chan_spec *chan)
> > +{
> > +	struct ad7606_state *st = iio_priv(indio_dev);
> > +	unsigned int num_channels = st->chip_info->num_adc_channels;
> > +	struct device *dev = st->dev;
> > +	int ret;
> > +
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		int reg, r_gain;
> > +
> > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* channel number (here) is from 1 to num_channels */
> > +		if (reg < 1 || reg > num_channels) {
> > +			dev_warn(dev, "invalid ch number (ignoring): %d\n", reg);
> > +			continue;
> > +		}
> > +
> > +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> > +					       &r_gain);
> 
> Instead of...
> 
> > +		if (ret)
> > +			return ret;
> 
> ... we need:
> 
> 		if (ret == -EINVAL)
> 			r_gain = 0;
> 		else if (ret)
> 			return ret;
> 
> Otherwise driver fails to probe if adi,rfilter-ohms is missing.
>

Correct, i changed this before sending and could not catch it.
But not totally sure of applying a 0.
We are here after chip reset. So conceptually, would not apply any default,
ince it is already set after reset. What about:

		if (ret == -EINVAL)
			contnue;
		else if (ret)
			return ret;
 
> > +
> > +		if (r_gain < AD7606_CALIB_GAIN_MIN ||
> > +		    r_gain > AD7606_CALIB_GAIN_MAX)
> > +			return -EINVAL;
> > +
> 
> Also, return dev_err_probe() on the returns above would have made debugging
> easier.
> 
ack

> > +		/* Chan reg is 1-based index. */
> > +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> > +					  r_gain / AD7606_CALIB_GAIN_STEP);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +


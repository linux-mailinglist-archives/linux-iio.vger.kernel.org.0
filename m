Return-Path: <linux-iio+bounces-23651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2043B4082C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E69F4E564F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD932A806;
	Tue,  2 Sep 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZKncvsJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B531AF1B;
	Tue,  2 Sep 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824737; cv=none; b=q/Rz19pNZ/SrF+bTFoXAVo6k6iTHDYj6jwKSkuE4qZqdhFaLHdUYTwprL7+FldC3tdG0/spx2taOLMOWLLVwPSmzntmydVywkaczx+p5EWXGK4YBFC1PVXooO/MTYk44pjn6KF7LEqlwaRssqD4SSGuqZcMT68pHALwFYKxB5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824737; c=relaxed/simple;
	bh=1gKz/CeqPyjga8H6PURJ9psp+tC0vHzZKYP9TtgcoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIL2s2HzVBWY8EO2Qn+wlMRzXWI/xECetp26PljJLln30F5ruxU3tHy6XFD3KP1vn93GGxp3+YenBwd2DCOtCD5nKyd/yxr10a+7YMn7cx28UJcgMf3mEP3TfH8t7qn0KYFTU9rpMGzWZoSwve975pPkAz9W3v4O4jv+zlvqcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZKncvsJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so4861666b3a.0;
        Tue, 02 Sep 2025 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756824735; x=1757429535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krojoMmx1kmmnqCI+gJOfxK13xA7Q4Ni7Uv9DM8FYMw=;
        b=nZKncvsJE4ycHUC7SC34Vt0aM0ppjOM4FlUkyxxr8U1U9Bwz/SoVoYHD9Lk+bPKZxO
         pxBxtdSMAmiq698nhS5X+/h2iEFijZsptG/OlGXuQskhgAwWvLd7OMSqx/zeJvkvawJK
         y9Q+UlE07FGILcXb6Cy7fGBV+eEV65xzIzqqXbPFWEwmnQ0nTvoqn0d0cEEkHi2S2cx9
         oMBgBl8odmOW+gD7PNokgE1nZ73WNAkh5gEjjnPbmQLqwvp6GB16usdDMTZDhkFg78T5
         t1wtqiDfuQOCr1xOH0mvBnnE2C5xcD/BbDYv0BhpZ63YEuFkvMWDE1lf6JmRsnYG2Uh1
         Alyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824735; x=1757429535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krojoMmx1kmmnqCI+gJOfxK13xA7Q4Ni7Uv9DM8FYMw=;
        b=CsU5VoEh4ArugM6sRhukdV1CNitrgVqiN1BIH3xwsDGzOtKfqLdkbodh7BckrWuQzB
         E84BzKm3XuVP9kevp/2eXh2Kz4/EJnQzylDxJldFP8F1R84e454qDTM3EoXDL2M5R1t2
         UXuX2o8Ah6z4wTAwOCGt2nMg5FLJk8SQ7C5ylLWVIWOrpC2tpRb4VFVPFYb3cPRrkQRE
         KoqL+FOYgDQgWnHG5Xurnm3GMDhm4V5Pm/jKH4B/tMZHpyYIA4+e218YRqDynzg0L8HR
         5cKJ6Td1p9oksXHuUy2D/tex/EG7o69n21pZvhe2nLH7gXx8hsNNacEy84dD4TEnUm1J
         kvnA==
X-Forwarded-Encrypted: i=1; AJvYcCU/wxDuwvXCL5kAQtF9i4e9gSAsXL9iOyzy759PYlE7peuspPvJuTt8uT/2wlf/C9HTOJvQKRPYQrG3@vger.kernel.org, AJvYcCV2ifyOa0RjjUZoSlfIkhAlt0uEBMDKkLdnOLBzinhZbHPpvV8CVQAOprv3Qwh9XxSJjeCOZaVO/j6B@vger.kernel.org, AJvYcCV8NX8NSGtDtOEY4DKYem0C7yivW/1k37pnxWr9FznJutuoECJ2r5ejTvlYvvJR7XLxpeP7R0znRG0gAZ9Y@vger.kernel.org, AJvYcCVAbGmO0K+yREMZ+Z3Nn4nOqqFSxR1vzAdRw1Ihw8KY1BjGeMEdWuyAsy5MNSdrjSMETF77BR8zZlOm@vger.kernel.org, AJvYcCVhG5EYpdUVdsuEitn/rANpl6rKtQqBBTh39e1iMR/gYZvUcPb9hZ58vgMMYMjrAT/rAICW/29TMgQt@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKG2IJtwOiTM1SO5JD/5qi3RUTQvyKVBYnSey4pBQdOOHwHJi
	ln4Hyk47efLBCdfXvVCDXfTYAjohtU/BZgw6+AioyW1h5m59jXNqYzYp
X-Gm-Gg: ASbGnctnwEYfCePKhyf/1pJ20GKwIU+dO7nAvkCnZdvRJuCDqGq2t1bZvqXjY25OISO
	xb3hdT71v5ixGyIT4hcPUabBoecIO/LfWE37prnWSSwMnnngv64f9HWzGafaeY6tSkPEDulskAw
	5yiXJ/JeK1+3SDHF4dlALz5iuFh2udvIRt7nDGtOlmbOXcAvvkRFeXdNKiJ1oJDvM8ZhuOd+A72
	deG++5ATWkz4Pw9UdpqS30XS86yhMrkJQRful3bfCCadrNLK09sWOz1AGJqpQZGz1N7QUfTjoW/
	SusaSpOQCpsiIGTGz1wo+nuHIqRzaNouSJ6jBFCRucU3QIr55fIGFDzrqmLdvUZ2AzNLl/mTlrt
	dnsLEbTYglQ3iNajQjvZT5Xci0jj7k2S2CghlPPtX6FEZg/2L0WVd
X-Google-Smtp-Source: AGHT+IFdyjggY3wIGK1mZ+QKQxD0gAMm0SbeMxk7gQcQQm4er/Jmj3WDdrLOtCKXXQrKMByB7c5t7w==
X-Received: by 2002:a05:6a20:938c:b0:246:5be:ca90 with SMTP id adf61e73a8af0-24605becdb2mr239744637.10.1756824735234;
        Tue, 02 Sep 2025 07:52:15 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4cd3670e5csm12088974a12.53.2025.09.02.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:52:13 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:52:46 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	broonie@kernel.org, Jonathan.Cameron@huawei.com,
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com,
	sergiu.cuciurean@analog.com, tgamblin@baylibre.com
Subject: Re: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
Message-ID: <aLcEvmwbysTaEprV@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
 <b024bd46-f1bd-4d9f-9d91-15ba18b9864f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b024bd46-f1bd-4d9f-9d91-15ba18b9864f@baylibre.com>

Hi David,

On 08/30, David Lechner wrote:
> On 8/29/25 7:42 PM, Marcelo Schmitt wrote:
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve
> > such high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates.  Add SPI offload support for
> > AD4030 and similar ADCs so to enable ADC data capture at maximum sample
> > rates.
> > 
...
> > +
> > +static int __ad4030_set_sampling_freq(struct ad4030_state *st, unsigned int freq)
> > +{
...
> > +	do {
> > +		conv_wf.duty_length_ns = target;
> > +		ret = pwm_round_waveform_might_sleep(st->conv_trigger, &conv_wf);
> > +		if (ret)
> > +			return ret;
> > +		target += 10;
> > +	} while (conv_wf.duty_length_ns < 10);
> > +
> > +	offload_period_ns = conv_wf.period_length_ns;
> > +
> > +	ret = regmap_read(st->regmap, AD4030_REG_MODES, &mode);
> > +	if (ret)
> > +		return ret;
> > +	if (FIELD_GET(AD4030_REG_MODES_MASK_OUT_DATA_MODE, mode) == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
> 
> Since this depends on the oversampling ration, we need to defer this
> until we start a buffered read. Otherwise if someone sets sampling
> frequency first and the changes the oversampling ratio later, then
> the PWM period will not be correct.
> 

Yes, that's one of the problems I noticed when testing yesterday and probably
the reason why I initially thought the scale was buggy for averaging/oversampling.

> Alternatly, we could update this both when sampling freqency and
> when oversampling ratio are updated. This would allow returning an
> error if the oversampling ratio is too big for the requested
> sampling frequency.
> 

Sure, this sounds to be the best way of keeping track of the sampling frequency
and oversampling ratio combination. Otherwise, unadvised users (like me) could
set the oversampling ratio then run transfers without the driver being able to
update the CNV trigger waveform according to the number of samples to average.
The result of that is the device doesn't do oversampling (despite the
oversampling attribute value).

I also see your comments to this and other patches and I think I agree with them
all. Will re-spin to apply the requested changes and provide support for SPI
related stuff in a separate series.

Thanks,
Marcelo


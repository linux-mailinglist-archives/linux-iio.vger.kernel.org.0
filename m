Return-Path: <linux-iio+bounces-7053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE21691CE85
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002061C20E70
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EBF13213D;
	Sat, 29 Jun 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELGz/RRi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD827456;
	Sat, 29 Jun 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684706; cv=none; b=jfB63HTXkYCXyuxDpSolns1909GP6Ux0QCEL2uPGWpsZNKpM8IjvyiBT19xe83tsIqXwqsmIKOLLky4SAlBXAdtq3lY9UiA2u2MNJxB4cHqiqBRHljpaW9NGgb2o9IiAPYI8Vu5/OaeK6fxgsm8mBAa2rGTQQwDNuEP1Rcqa0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684706; c=relaxed/simple;
	bh=tz3SKuYexgtUihcjaPEZeu7MBxvWXn5SdFKAiRy3CVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBtwkQR+56smoZiaAgstei5gCGtFYVCQBmZ5gi51Gn0qoT0DqLK4PtrUIKiLfNq/zQg2rQNWKjqhXwOnMLZP+nvGwhP7QGMoV6s16iJcZIU4B31Vgk8SykfxsqJQpfLrK7OpDEC36l3A6gCFhB6jgAVt+RGgAfNelY8bdKtmAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELGz/RRi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7a6da20f2so1033125a91.0;
        Sat, 29 Jun 2024 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719684704; x=1720289504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRsddKz7fNayJoW8Hb8xICvDepxKNe9Z9WcgTCfnYFM=;
        b=ELGz/RRijsn4pno97pqwG9hXipe8nJG61x9uFZKPQ1ahgkwrWYDjXq7DGMzbLzBayQ
         nptmSmHqjbBgWah2HGLV0q9vAKl2xbI1mjamH3swkZf1dWsBI2xu94rLa1BLF2L/RKPL
         j7v53itc3TZ2D65X/euI9KLt3IQ7LIF9R1t/FWi0aEklU6acPYrKGgwzywBjO4GoKmwA
         h43KrW7Df+emAml7ekFjdlQk1/TK1IJj9yt43tz+b8WmqOmhDZrduQqOoHdlOYnuyYc9
         0BwnliwwXuhtYC0GmKHq56yUYSAhWfpZj1jqWU4RyrMf8k57KIL8GnFjUQzH3m4x4j38
         KWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719684704; x=1720289504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRsddKz7fNayJoW8Hb8xICvDepxKNe9Z9WcgTCfnYFM=;
        b=tScgpSutAeL7nO/7shcDGbELRYCo15slquxgJ7mi7zCn7AgTsj35KzSqjYtsR0OfiL
         3lXY9G2+E0kSPX7/V7XEVZnbf2UG5FY1GNF9crZuiJvllIVAS9VtXLF2o1p6IgyFZYNy
         DIG7WLWbnH+TW6w4yedNdTksvTuO6/jyoAwjvKKvcBmn6n36dkzHSCKpsFaa3xhqYdFo
         DRTanp6KM4X5dE4PXTnwlccEXoYTsPmjeK7SltxlW8pwPlzFdWwMNRHrns3JqLT17c18
         geruVK4ftUeuHAFBSTmBAiccf6mh1Wx2LETxF/pAdf7oA5Owss1xfg0te0wPJcz7eHKn
         p5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTYQk4sCSCn382XDJpMfswRwNA8EW7M3eyDkFAzYeJ8BYLhblf9BPOPzJmA2AXJ0UQEoqslqtVhIav/19UUyU5g9dfYMyXBAfGEr7DT2f/dydyamUCLewYzw+JDxy4I1IFrv4T4n/WmKAtGXMUD9uHmRD1GBpnUjFrECckgTUwiMH2FKIRg+LONU+eDespgcuPt9UHCdbdcy/VQ3W5rPrdQMaKc4fVZu1nnT0d7DJRbj280il93kHDmw==
X-Gm-Message-State: AOJu0Yw9OtaWTzxpa/oHUU4EgLqYvM2uzD4S0j4bII6KjF1tKkR4nbl4
	kQSsAeEIvlhOrAirAbCbRZxAgl8YbMWWT3+OKS5FVc+Z27aMjYaN
X-Google-Smtp-Source: AGHT+IH0TBPlhcstNpRUy2EGgt6s+ZqfbFk+FYi6/fv8UZr8Xe9rKGN/T2QJIKmEezVX4EygiVYU5g==
X-Received: by 2002:a17:90a:fa03:b0:2c8:ec4c:436 with SMTP id 98e67ed59e1d1-2c93d767652mr823050a91.33.1719684703772;
        Sat, 29 Jun 2024 11:11:43 -0700 (PDT)
Received: from localhost ([2804:30c:165e:de00:82ea:ff72:ead3:4367])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bcb25sm3631826a91.37.2024.06.29.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 11:11:42 -0700 (PDT)
Date: Sat, 29 Jun 2024 15:13:10 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
Message-ID: <ZoBOtm_xwT1UrIfH@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
 <20240629190538.46b5fc90@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629190538.46b5fc90@jic23-huawei>

On 06/29, Jonathan Cameron wrote:
> On Tue, 25 Jun 2024 18:55:27 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Add support for AD4000 series of low noise, low power, high speed,
> > successive approximation register (SAR) ADCs.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Hi Marcelo,
> 
> You've clearly gotten some good review for this version so I only
> had a quick scan through.  One thing did jump out at me though.
> 
> > +
> > +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				    struct iio_chan_spec const *chan, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	default:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	}
> > +}
> > +
> > +static int ad4000_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int val, int val2,
> > +			    long mask)
> > +{
> > +	struct ad4000_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_val;
> > +	bool span_comp_en;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		mutex_lock(&st->lock);
> > +		ret = ad4000_read_reg(st, &reg_val);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		span_comp_en = val2 == st->scale_tbl[1][1];
> > +		reg_val &= ~AD4000_CFG_SPAN_COMP;
> > +		reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> > +
> > +		ret = ad4000_write_reg(st, reg_val);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		st->span_comp = span_comp_en;
> > +err_unlock:
> > +		iio_device_release_direct_mode(indio_dev);
> > +		mutex_unlock(&st->lock);
> 
> Lock ordering needs another look. I'm not sure we an trigger
> a deadlock but it definitely looks problematic. 

Oops. Oh, that's inddeed back lock release ordering.
I've changed to scoped and guard for v6 and will send the updated version soon.

Anyway, thanks for having a look at it.
Marcelo

> 
> J
> 
> 


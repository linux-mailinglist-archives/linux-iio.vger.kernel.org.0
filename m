Return-Path: <linux-iio+bounces-24598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BFBAE1D0
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8511D32575D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2230AABF;
	Tue, 30 Sep 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDOOVdKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FB26981E
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251679; cv=none; b=He+/OguAJZMjMTAhrphAAfOBgISj62S0sDNRWsKM9OtpTo64N1nS9IyFIEy6zJqWY2xkO2/R3WIawYXKGbqyTFFrOLKohvJ3Qe1onJJhibK8hMo9tbjqgqlqwu6eoCrIxU1kD23heOL0OlN53B/EGFLxVfIdOqP4m0oFgW1GfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251679; c=relaxed/simple;
	bh=AmHuuzpem5111casgiRIX7q6S2eHy1ZsEGaomvXBWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F85zE0/U11F7279flQO0i+jsWj49n0EdBQzU2J39LTkLtSUwz2ux9JltshoQZdrvyNi3tQXK/gyQrjf7b4qnhJVFxUvgMWAQvYc4D7BQJrzS0FAAsWm+QNGxt5sjXgoSxr89eTLm9vghO8Zp1c3V3VF5BlO1XWppMc6mF67EnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDOOVdKu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so3139456a12.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759251677; x=1759856477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qn5VqRWJrpHDhx/xNpBlaLWgEArGVytxgRrr8Ys9no=;
        b=bDOOVdKukdiUsInRLL7W1Mr6ucwZPG0GVJ9putQ/fM8dB38/e4znvgFd8TqWdPOWv7
         BkASLLEnQeFq+XOOQdBnVo9SiMm3cq4HzJ76ZdqA2O/vA32XeO03ELa0lNFJO53IQ/yX
         YZM2YnBIUmufFZ0YLh1lphgiEQtMMcMW3NJO50GhlAxvWXQ9O417oWxylwiivmiBQ+uM
         xm5QOfpmFwMsfD0hSlU9O4ytHgUQOFB/KIFUkhR7dNVoFFg5YfdZUiGx2MPuhozQWSjd
         sJk4b+/kPzLR+ZIW6iJwSdjI+5oBC6lhIFYZylIynEqutbXMFgtwNpLlh7P6e7WbVeaR
         Og/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251677; x=1759856477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qn5VqRWJrpHDhx/xNpBlaLWgEArGVytxgRrr8Ys9no=;
        b=r9FwRabrm3KZ5JdxxgHZlq0sIiuHJ/HMHMSMqEhdMDGWqJSIclOETPPTfmm7H9+6zf
         V7/bk2xtgOfbWs+OK5AXGXqmDoqnln1Jj7kYmPnPszXB8jvIu6BVYkVgZJ2YheTQOylv
         PgfW/rL06pGdsQ+c/lZSRZng9yThaJdVhbopGJbQ9Tzq2/PAMbaNjrGwfKcyj+3Cb/Si
         6Hz89A79C36Tg3gkcj2MUdk0aaIGs6BomP6DLaRnILZb19/Oqc1IOMZGETDmx2JoaOXw
         0I2bSmznVwz8PuswwEziGKr5SlPoh5NewClnkAcDMXXr48/imwOs+E1gwbbd9HqKpKZK
         RhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjeuZv1ilW483qkPiMiD/xOAu8ET4WvCFfc7B2bGKpayDFGjR3sXYasQHFmX4YgwmmA4jfkq0bbYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZyutiwyotrqADTBeuqGVPF3iprKQwDeXt+IA+wo2PI5glFpK
	XFN9UNy/IjhZRRw5qbinW1VvkpQuKQcgVrFb/PpmBZcrTgJQvEe5Qhe+
X-Gm-Gg: ASbGnctA4/C8J2nD/OL3DD+xtPfapluIBreq8GqZIbnVLTNHYOiwIV2SWJAgLyGpG9P
	aerTAxLsO+BEjTU57H673d2i9UWOTMcOJEFyn3AV2mhW8q0WSITKnj402GayOfObCbjc6BZmRaL
	TuFfMSou1cMsJXtSl/kjDPaJiU8k+3cUjpuckDQ5DS8PTZp92/52hap3S2HloWg3ZpB1Kkcu/02
	cu8RKoDmErlnVGAdhi9gBPBP+b9hH0dPq3ENeqA27xYjfST9QD6R1fBN1foJ833ZTuB8WzYYNUV
	0K5ZFB8Qn1cFZpW6DRa7L8fZjju/tbV/1zMI/0+BGNjCavElOGQbZzREiudOf0p56uVyC0/LV93
	yXxf01eJK2f9iRYIG8V4pG2x00PohRdqa8ZM6dd87KYsnw6YoP5WNT0ASRpqreDo+FA==
X-Google-Smtp-Source: AGHT+IGy446EO1dFvrwF+hn4zw2/euRdjV/W41f6FxDTzzbhNgbS5i0TkYtI/qkAdJxguBsSMF5Bfg==
X-Received: by 2002:a17:90b:4ad1:b0:334:18f9:8008 with SMTP id 98e67ed59e1d1-339a6e28289mr264935a91.8.1759251677221;
        Tue, 30 Sep 2025 10:01:17 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3399ce47d7csm974066a91.10.2025.09.30.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:01:16 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:02:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aNwNEHHZ4RXyz92r@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
 <20250928111955.175680cb@jic23-huawei>
 <20250929143132.GA4099970-robh@kernel.org>
 <CAMknhBHzXLjkbKAjkgRwEps=0YrOgUcdvRpuPRrcPkwfwWo88w@mail.gmail.com>
 <aNvtfPh2JLdLarE5@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvtfPh2JLdLarE5@debian-BULLSEYE-live-builder-AMD64>

...
> > > > > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > > > > PGA (programmable gain amplifier) that scales the input signal prior to it
> > > > > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > > > > and A1) that set one of four possible signal gain configurations.
> > > > >
> > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > ---
> > > > > Change log v2 -> v3
> > > > > - PGA gain now described in decibels.
> > > > >
> > > > > The PGA gain is not going to fit well as a channel property because it may
> > > > > affect more than one channel as in AD7191.
> > > > > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> > > > >
> > > > > I consulted a very trustworthy source [1, 2] and learned that describing signal
> > > > > gains in decibels is a common practice. I now think it would be ideal to describe
> > > > > these PGA and PGA-like gains with properties in decibel units and this patch
> > > > > is an attempt of doing so. The only problem with this approach is that we end up
> > > > > with negative values when the gain is lower than 1 (the signal is attenuated)
> > > > > and device tree specification doesn't support signed integer types. As the
> > > > > docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
> > > > > Any chance of dt specification eventually support signed integers?
> > > > > Any suggestions appreciated.
> > > > >
> > > > > [1] https://en.wikipedia.org/wiki/Decibel
> > > > > [2] https://en.wikipedia.org/wiki/Gain_(electronics)
> > > >
...
> 
> Though, the above is still relying on GPIOs which is not a requirement from
> ADC peripheral perspective. Also, if GPIOs are available, one can just provide
> them through pga-gpios and have full control over the signal gain with the IIO
> driver. It boils down to just telling software what are the logical levels at
> two pins on the ADC chip when GPIOs are not provided.
> 
Though, as mentioned, the state of A0 and A1 pins defines a certain gain applied
to ADC input signal. Because signal gains seem to be usually described in decibels,
the proposed dt-binding allows to provide the gain value in decibels and then
software figures out what A0 and A1 logical levels are from the provided decibels.
The actual levels of A0 and A1 then have to be set according to the provided
decibel gain.


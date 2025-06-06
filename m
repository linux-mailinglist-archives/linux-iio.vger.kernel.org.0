Return-Path: <linux-iio+bounces-20279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84CAD08BC
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 21:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F3D7A3525
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC421324D;
	Fri,  6 Jun 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1PmQOYr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74166BA38;
	Fri,  6 Jun 2025 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238681; cv=none; b=DHZIxItXsGnbRrAPPDLm2n82McLLhHXnCNbUGt6tWgHUuhj+3grdzhycJWsZJUeoThhzncJ59R9WUCPvmZiGtZUz4kKj+tI8q6+hzmekk1gNIvdPnFzgwBt32m3SIVrFRRvsHDqQipMLjieUK/S6SBp8wlXZ+rXPltimT1LYJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238681; c=relaxed/simple;
	bh=ir1jj3w7RASgWM822FlUDrELte1gttYXfu3fuSt+TRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGFf83z99bA2txmwirVr2xJgZqXWZrKPJKd0niiVE6A++skaQLfatIIIaN0gpAWV7qLeZnXLW8Tu0TnJPWGpEK5WJqTyc2aj5oy9AVLnCtxcKOo4tPPfxZZmzHoYGeeZB8rikFi0Y6Z8TDKTvb3rKG9ItgCTc4WWlfYt3o/DaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1PmQOYr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d094f67777so32226585a.1;
        Fri, 06 Jun 2025 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749238678; x=1749843478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjtqGF5ZOGFFta8PvepE2weuvIOQh6h102Lg69MuG00=;
        b=M1PmQOYrOZqs/ZXc+EftvF9Li7hm5QzK+rGJU6HXl1Rsq7eMlR/mGs2UCQupvczXr3
         34jZiqah5TL3qDbEwU0axGvaYUwWb7exUaLrx3wBkideKiQrrEUJ58Jt9mgi0wSzvlVD
         lfLEJJ92pQoKRupQ7oQXaDNhib3/jkcyz3FkSgvw38KhYXqbOF0adjGV1aknKGo/ZNg1
         wckMN5MCAGgGVGEIn8FFDa2Uq5yI5DcVkoMQjzoYFpsPXABbqqRgyLbTaeeY1sk7lkvX
         B2oTosRutbj7vg49OxB5nbJ4t0tvPFG2l3v4aNYybC9t97kn8ZjD8FOsi1aYQqb+gCbb
         9cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749238678; x=1749843478;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjtqGF5ZOGFFta8PvepE2weuvIOQh6h102Lg69MuG00=;
        b=IsnYuj3h4/DjyoBENzkKmDxNAsjWX7pBfe+Z8ZLp/okwky3A+0wIqm368P49d8q0EF
         8SK83KIgwDTy+foaXdxWvuro7dYuABzo3rrUmasOOKWnPOfmrlKQcuoBpKRCKlmMTAOa
         dCPNuwxuQW+/6RZwZKm5KwvwX4CT6w/7J93dsotMwkbBEjPn6NNbN7mB412RpbVRl2iC
         iDbxXahPhFa81RoYG32jtZY1gkN2wXizmf8zD1k45+Rg8CXwCI16bKFA6xG1ytezP39r
         4yZRzivQyDMFDBntLtKjYTA0EGWdiuhR6bk7tgraHMh0LmpL1SWapw/6WPmNfD2mwfwm
         lXxA==
X-Forwarded-Encrypted: i=1; AJvYcCU9iBNMCcQQkZU0jaJdI7nktnWvLTljdGEm001wa2KA5FmIbciD9e6e6lQ5HLYLCdLIeW5tgMdPbuTn@vger.kernel.org, AJvYcCUdeiRxVfKIwXBnl5U9DmrKFiF3hi4+bH9hQaC0w88M81F3ZyhS/cx6cjBYbobXo2TwVWJPdNmqWIlJC4A9@vger.kernel.org, AJvYcCVdR6VbRL1H04UwCG/6OTwqx5Uo+uTmC2FS6ZNFCUqMfgVxQIGXgUk11MXDOC0nzSadWMmKnRvGzZQFuA==@vger.kernel.org, AJvYcCVxVTm0dubaRJvjN9w6HlVhT0b5+qiaL5PBvZJipEb+Tzs6UUJw/bFiVXRCf7iBazg1D8YcA6SjlSr0@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8lGe9PGSuET0EcvZbjv6UFFRGvbX3kf6a5V4q8q2J32acoTd
	waW7C91kaQE3boY8BvOLD1RxlyZSYLR4HKoPj4yheTULDiqAnWMvM94v
X-Gm-Gg: ASbGncudofg+20vpson3niUDhcMu3OFfhTqVl1Qbgl7H2xU54B/pmAfGR++5wOqDCXw
	H8K/klmJW0c3BsgYgOkrR+uCe6vWMOjxZENe5/IazM6w8tZA83Cd0Z6JP9YmRzgESQStouZ4m1A
	qFYWe7xLZ3o4mTnYUbXI5wHk7K2M4S0WNsn5XQDjzhqnpsXT2UHxwxk0z16VpCSenKgF7dPXJbE
	2CIs6mkjC1kSbXWtB9uY8Mw4FZmur/9r+6JC3VRIR6VJFKQ0JE2bE2BJMAmADM3Zwy1BATdXJhH
	QiW6KVFhS9TUt+kzhlhOgcyD9ibcuvVdX9QXZKAU32VjAGEu+X3QTkvt0VNnius2uRZuDKXnuwA
	DNmhkwzQ=
X-Google-Smtp-Source: AGHT+IEr9PlpC7XQYPZn1E4QW5BFOw1Jgh0MjQScfApeePZX6yvxVkPL5XAuiClICqHeds9T6gToDg==
X-Received: by 2002:a05:620a:40c6:b0:7c5:75ad:5c3a with SMTP id af79cd13be357-7d22996b0b4mr272770585a.8.1749238678242;
        Fri, 06 Jun 2025 12:37:58 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61b03fsm175643485a.92.2025.06.06.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:37:57 -0700 (PDT)
Date: Fri, 6 Jun 2025 16:37:52 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v10 07/12] iio: adc: ad7768-1: Add GPIO controller support
Message-ID: <aENDkMN597fGsTL0@JSANTO12-L01.ad.analog.com>
Reply-To: ddb448f0-1cfc-497b-ac1f-9f3d9e9fcc3a@baylibre.com
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
 <eb48ea5f11503729b15a36ef00c89de3dd37bcc3.1749063024.git.Jonathan.Santos@analog.com>
 <aEEzZjfLVUW1kyC9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEEzZjfLVUW1kyC9@smile.fi.intel.com>

On 06/05, Andy Shevchenko wrote:
> On Wed, Jun 04, 2025 at 04:36:43PM -0300, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > The AD7768-1 has the ability to control other local hardware (such as gain
> > stages),to power down other blocks in the signal chain, or read local
> > status signals over the SPI interface.
> > 
> > Add direct mode conditional locks in the gpio callbacks to prevent register
> 
> GPIO
> 
> > access when the device is in buffered mode.
> > 
> > This change exports the AD7768-1's four gpios and makes them accessible
> 
> GPIOs
> 
> > at an upper layer.
> 
> ...
> 
> I haven't seen in the commit message nor in the comments why GPIO regmap can't
> be used. (No need to resend, just reply here, but keep in mind in case of a new
> version of the series.)
>

We did discussed this, see [1] and [2]. It would need a few tweaks on
the gpio regmap driver, but I will keep that in mind, thanks.

[1]: https://lore.kernel.org/linux-iio/7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/ddb448f0-1cfc-497b-ac1f-9f3d9e9fcc3a@baylibre.com/

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


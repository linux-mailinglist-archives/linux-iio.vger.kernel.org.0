Return-Path: <linux-iio+bounces-10478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD899AC70
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60609286033
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D51CB317;
	Fri, 11 Oct 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwQZHENH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6E1BDAA7;
	Fri, 11 Oct 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673736; cv=none; b=Vea7S+v05PDRlvaPdK8OV12fB21NLcCjmafFqr3GbDO/YyvZf7wlHXIQy2PsM0TeLgYHmsstOgfU2wm9TpBFgf2koWDalT4QlFglPgLg/k99mAsWxNkv08GB3XCUP1SmvVDjDqFWUdLDjjia/ohRxi9nbk9mnqN/ZCQfbO3H2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673736; c=relaxed/simple;
	bh=Jd1Y34/j3tpJW7rG0tckaZLKTfi3GtsA1wBtCJgYtFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDLZvpv1+WDljqbgfQPQYs2hJrZerDBlzhuFbisXSKNfN40jq1Fk6RsAjmYreDkLFBUeeyOyuUQ5z77sFqtfgHN8lejy4VddeI+9WZ473Hnq9VgsVr12kNq7ir7PuoaKlLCGvtYq7eSzb78rJA4ii9gUlU2f4fgsAlbuglsGqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwQZHENH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-430558cddbeso15505005e9.1;
        Fri, 11 Oct 2024 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673733; x=1729278533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zz1WekoT+K59oVc5HCdNd3N/gx+iU50t2zbre263N5w=;
        b=BwQZHENHSg2M8rYJqzzED1M/L9J3DeJus3uwZDFcKZF75WuC1dgPyjzozyA4tP8K2/
         Bfj3f46QvjdE6bRNKCIqim5UkNFUKRCtIxYCeMcIpMqwqbLYYTo4jYjky7InCOqkSZEY
         RCJEGl19lQvnN2IfMSN+uuTE6NEQ9Z96LZ0WjfyV9h7Su3FxAM7QTKD1B35HLbmEQKD7
         m3aYT9SOizdaZ5SpdrCcaj0wsLjlZgJHMhwxulzBlYA4ucTUThpqmBvmG94fhPorytAO
         8L70+Mys8Fuq3SAxvFPX9dYOMwWP0igc21jmKObYlog0wRt6AK+2DxUar27gJmUXMKuH
         r2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673733; x=1729278533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz1WekoT+K59oVc5HCdNd3N/gx+iU50t2zbre263N5w=;
        b=c2G/tTj0HJShTmz9UHbOWwwpZywZV7Gy9OuJ/9BmxzfElM/EGKjUlPBoZ4t+M4Gbe0
         ZBcKVZTucru+sWk2FCAKj9QPrKtMhPFKceeb7bzg4Z3eKWtlmSJgZ8bxDQ/5gcJOdLzq
         yaciZ8cY+HWuzcDIcJtCxkh+bRBuLdfQVoSo+ilG9Ad9cpVeXoDsJPd/xu8TMrHrOL9S
         v8vBcJD5ESQE8ZabimorgZbWKkMRfnHLlKrdHq8qU7QbGU8PL0A2Ajmk49ShIXaqdTbd
         azDvol7X36fRtchnSBkdekAG1mkU9ZnJoTSh5RC/O+nm85cHjsqXbtgwVDpMKA3eyf8p
         x0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrWjzy7O6l8EBWJX+7YGBEjhbDvmhVoyIl6CwUs/h2dZGLCGvfNtpQyXG+/hh9aApCbtyo/Pktf27x4rS/@vger.kernel.org, AJvYcCX5ibQenMuSdZevcXmYEZMDXwW1N0iAztjYRTramSYK0jImbilZc+FD8f8xD6OibvCPm+Qvpe/5Xwds@vger.kernel.org, AJvYcCXvKkDGq1sSBYOcw1ew/QHM9XRdF4moDuKY1EoaT8Z3ZIolDCeFgr30yoYsyJpjzAi7ocgl2X9h9AsB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97WaPDZWUWqb+VTDCR9DQWe2QOtTg7qoO/sC6RiJPaWgM7ZnL
	LWetfUDXIyGwmDf+5hlIuy9JEmG+UbJZLzuuu/fvXWCEgMaBfKei
X-Google-Smtp-Source: AGHT+IFJ/K5PyB5o1YqUH9GG/hvf0rLF7JeP7OUjXqRnXOVbr8sQJ2OLYXqvgc3PafxIe22YhKgN7w==
X-Received: by 2002:a05:600c:1c1d:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-4311d9037demr32709925e9.9.1728673733251;
        Fri, 11 Oct 2024 12:08:53 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd8asm48652415e9.16.2024.10.11.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:08:52 -0700 (PDT)
Date: Fri, 11 Oct 2024 21:08:51 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/13] iio: chemical: bme680: Add support for preheat
 current
Message-ID: <Zwl3w_lwdfqNRYK_@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-14-vassilisamir@gmail.com>
 <ZwkAYSvmYyu1F5dU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkAYSvmYyu1F5dU@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:39:29PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:30PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Add functionality to inject a specified amount of current to the heating
> > plate before the start of the gas measurement to allow the sensor to reach
> > faster to the requested temperature.
> 
> ...
> 
> > +	data->preheat_curr = 0; /* milliamps */
> 
> Instead of the comment, make it better to any appearance of the variable in the
> code by adding unit suffix.
> 
> 	data->preheat_curr_mA = 0;
> 
> (yes, capital 'A').
> 

Hi Andy,

I used the comment here because it is exactly like this above and I
though it is more consistent if I do the same. But I guess repeating a
not so good design choice for consistency might not be the best
decision.

Cheers,
Vasilis
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


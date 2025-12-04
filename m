Return-Path: <linux-iio+bounces-26777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD94CA5874
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 22:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2A9130C113A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F2328B45;
	Thu,  4 Dec 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU5E5+uB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D31DD0EF
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884296; cv=none; b=qIhlVY0YMq+CsKRE5oFx11bdPcquI2cjyKKgYj3JnsqOSgv5LhnbhTphAYNaVRyVLoWndYzlM2UZjv8DCXfzU+AYvwkEXh1lbuH6w8Tpcq7cUZMvfZR15WLdRuQ6+uhKfutKLkFAvqB1Z5es0D8YYN3yD9MCDSJQXX2+OPYNPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884296; c=relaxed/simple;
	bh=L4eVou4mnYQUG/UzsPI7gS+5ep+GikN3qodkQgoZhBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsvdcsah+G7CLQwpBsrswa3Lc8icFmzp6lusZKNxT+xQXXxEI90zPG8Lrt9RE65iEEToPDwWyIV/EHm/oopOima1iviUCRnNbbbKZiyppI1YtDmvqi0lqLZVk8SJt30npdPb5pzhLGJ6OdMwdAEsgH+jttNE6Jzwe8h4HKDvmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU5E5+uB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso11633535e9.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764884292; x=1765489092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mm6l97ck6f+cFwXpsqrIp6tyKZ6pKb6s4YtI3pshjeU=;
        b=VU5E5+uBEpBZ6qid/v//cuPtqdQpbm4zDId/C2Uk8RTbGwMsIJ4vNEBIz3E4VsqH+T
         SQVFBR7wHSfk4/c2d3tjFQIbku4IZ9BKG7XWCl/ZVXbEMxNpnMW9Pd/hczAGM7sylQJ2
         rOXLjcOfJnHC5lB7WTAkF5oOyT31cpcZRuRk3pG5NoxuPTNAH5Rk7s5KSrVx8kbTGV7+
         06yMYHuAd76o7RSIrwKbTg3EoYxznAvZYfQj/LOAVYNE1DLQQ2lU0kCsce0L9Wj0zhhy
         Q4xWLzFkGrtFgHSDv0LliJVtEWwGbfQ/IJaq669LJ5Ihtp9FZWxQ6G4/2gAkecpPJRLg
         WlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764884292; x=1765489092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm6l97ck6f+cFwXpsqrIp6tyKZ6pKb6s4YtI3pshjeU=;
        b=WKhS8z4zPGu0PjrRYhb1Q5ILvoOoC+KB+aLf2aXw0tiVWF+U5br7ayeB4XClINPgFg
         mLyMwqV0muw1WkLEq3+W6+chdJxJ1Ma6TdvY7KF3Z1LNpmIrI89AF04IXUGaUyT7dZOy
         WwD5AAJePAc/DtXoeMfrOMY1YnVSSs6UTCll1dscfR9D2SEOGijgOgGp+rSFfrkZGogW
         qQF8og3A+SGKWekPLvWJ50IP8SIpAR+z10TTz+dVFbwF7DSK7UIJNJ9WWNCUTO+0zpKf
         UhR7HewHjMfNQzQZPh4pZA2YFVEDgawLbwmhzqW7gRAqd9wRyx5BLPv6fKq5jxuc6dCK
         wKlA==
X-Forwarded-Encrypted: i=1; AJvYcCX9qHKtY+sMOzJFGktNqA7/URAGBBWge/Znk51acZRrHAa+vbUx2/RKvXyOXd9R8BxAmC3MsZYduFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0ROJzc3GFejvGVbSoSfYfrBlb8T71Asb9hheWrGbBy8S5GRW
	8dZa6vx2rEatz/IPsUovd7aO42w21eVcUzg2AaCFccZwb4rAsVfBka5e
X-Gm-Gg: ASbGncvbqN9ztuHTKENKMFVfTz9tdI6zlHM0H/9JPl3W0NByEU2od/axXJDiDpNYDMr
	dyCIW/Z9zk5fxbssnj8q6EkCWoqBLUZ2bupQMMmdy8Z3XqoplpTp1TyudJTD4Q7tU1tTFJWpAFF
	9fZp40HiWCSR+Dy2xjPWlfeBMVyVcG7EaBMdL8t7Bb4JiIkjZ/MkKlKSj2zPSVEVU5SnOHu2Ofq
	1yvR/DxcLEAF8DJbUoT2aANz06abBhb6elpeCUIF2tMGqXKz7vSBB6I4WfoJUkZO8zAJBbqgo02
	kmOuVKFHVnIk0uu+bpKsAvV5zxmpJNQBskO3WK6GhRM55WZTT+vsuriwtOMfraIpoDioyA6Bz63
	qTa6ahn428CyX0R/NOdkaqTtHxPTYtzWy7zqW5VkDfA5D5mjpaUfYK+XadbEPoMbeZtRtTuKlt0
	jg36Y0qoEtib56TEh2en/h1GCUfYZTrKtDaYMYJ6suRWRp3IJr8pHEuAXE+OoklEoLXQhIIcVYa
	c8FdQ==
X-Google-Smtp-Source: AGHT+IH8ugyBgLjQicx0MP6NuWuCkhdVxkxU6CJstaiV1Q1kNTrPrj9Ah5wqiygJFcZLBbyBfbjuwA==
X-Received: by 2002:a05:600c:a0b:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4792aef23dfmr77036955e9.13.1764884291757;
        Thu, 04 Dec 2025 13:38:11 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:9c51:c3b7:65d6:48d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222484sm5276484f8f.24.2025.12.04.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:38:11 -0800 (PST)
Date: Thu, 4 Dec 2025 22:38:09 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
Message-ID: <3izg5lyxjye24pvzoibk4tmnxbdfokr53abkpbjo5epqjoz55j@6wc7i4wsgwkt>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
 <aSQ2JUN05vmMQC1I@smile.fi.intel.com>
 <rk4hmupbrb5ugxft6upj7ru43x3z7ybrobax45rorpwbcwleh6@vzxrr3m7r6ep>
 <aSgX9nMBwBtAlSyj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSgX9nMBwBtAlSyj@smile.fi.intel.com>

On Thu, Nov 27, 2025 at 11:20:54AM +0200, Andy Shevchenko wrote:
Hi Andy,
> On Wed, Nov 26, 2025 at 04:55:41PM +0100, Jorge Marques wrote:
> > On Mon, Nov 24, 2025 at 12:40:37PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 24, 2025 at 10:18:08AM +0100, Jorge Marques wrote:
> 
> ...
> 
> > > > +	return reg_val == AD4062_GP_STATIC_HIGH ? 1 : 0;
> > > 
> > > 	return !!(reg_val == AD4062_GP_STATIC_HIGH);
> > > 
> > > also will work.
> > >
> >  	return reg_val == AD4062_GP_STATIC_HIGH;
> 
> Hmm... This will include implicit bool->int. The !! guarantees values 0 or 1,
> but I don't remember about implicit bool->int case.
> 
> ...
I don't think the implicit bool->int is an issue, grepping `return .* == .*;`
matches a few methods that return int.
Experimenting with the _Bool type (gcc 15, clang 19, any std version),

	int main()
	{
	    int a = 1;
	    int b = 2;
	
	    return (_Bool)(a == b);
	}

with
gcc -Wall -W -pedantic -std=c23 -c test.c
clang -Wall -Wextra -Wbool-conversion -std=c11 -O2 test.c

also doesn't raise warnings.

> 
> > > > +static int ad4062_gpio_init_valid_mask(struct gpio_chip *gc,
> > > > +				       unsigned long *valid_mask,
> > > > +				       unsigned int ngpios)
> > > > +{
> > > > +	struct ad4062_state *st = gpiochip_get_data(gc);
> > > > +
> > > > +	bitmap_zero(valid_mask, ngpios);
> > > > +
> > > > +	if (!st->gpo_irq[0])
> > > > +		set_bit(0, valid_mask);
> > > > +	if (!st->gpo_irq[1])
> > > > +		set_bit(1, valid_mask);
> > > 
> > > Why atomic bit set:s?
> > > 
> > Not needed, will use
> 
> Note, bitops are xxx_bit() -- atomic, __xxx_bit() -- non-atomic,
> that's what I had in mind.
> 
> > 	if (!st->gpo_irq[0])
> > 		*valid_mask |= BIT(0);
> > 	if (!st->gpo_irq[1])
> > 		*valid_mask |= BIT(1);
> 
> Can't it be rather something like
> 
> 	for (unsigned int i = 0; i < ...; i++)
> 		__assign_bit(i, valid_mask, st->gpo_irq[i]);
> 
> ?
> This shorter and does the same independently on the length of the bitmask
> (and effectively the array size of gpo_irq)
> 
Sure, just
 		__assign_bit(i, valid_mask, !st->gpo_irq[i]);

"Set as valid gpo if not used as irq"
> > > > +	return 0;
> > > > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
Best Regards,
Jorge


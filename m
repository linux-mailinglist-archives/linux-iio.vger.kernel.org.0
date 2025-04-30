Return-Path: <linux-iio+bounces-18921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BCAA58A6
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AF69E1643
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75B229B29;
	Wed, 30 Apr 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmIbHHp1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D034545;
	Wed, 30 Apr 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055455; cv=none; b=aZExynqsFIQAHSxlltXuy6D/KzZAyLKuqm8irW0b+tUdLeHvAcgnFar2LFGshhEN9UX2G9HXe7z9gYiQJy4MIE/BdR70pwoiBzBaIyQSLgd9dE9RWTGIRMSsXzaXcmRLmOmz6aqm7jtiF6+sQQ7AH9lB5Ub3617bv+65HrK5T4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055455; c=relaxed/simple;
	bh=tc20sQFbQ8SUugz2cW6mF+BRvDm6qDynr07fAX7iz0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEz7BYBWLE6kXWs5DaBWuEBpKqaWoIv97ug+2IuLEnsHzWe24e8BmaFDzkPGanX+ylM7RwwtChD50xRQKchLy+HWB4CEVWTxNZaEJ50RrmWIvgcoPoPqlL1kQHaFeJIdXtAqNtDgX9IRzF3ucq1t3PNQYObtB7vSlDh/i2ySU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmIbHHp1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so568756d6.3;
        Wed, 30 Apr 2025 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746055452; x=1746660252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7OGUFsBaaFGDg5Er+LmFFX/Hm+5kapCAxsBx1islgk=;
        b=BmIbHHp1cq5UuF8hKVcWQa4DSvkCwZqksHSKSPu+ofkFgzBowZ1EOneANmnZLMRU3/
         ytlyHVr0yeUbsrH2stv21OxA6SuTRVQ7VvX5K3xd5Z7KtuGI09gemjuXgo5QpLKfD/1W
         bOCh8XxUuUhimUZgpDm3Y+Bx9/LMi1mMNzdIcIWGo4EHkYZueF8gZ1Xh9jptxFvX7Gey
         MoKaMkFXWGF57c8S9fnFQmM85ZKAF755m4FOEAxRy/KAER+58vHcTUqDRKf5+6doaxoO
         IcbR6M9k6rW0bTNfYWllQ67Kuzwu34ejldHig0FUr+UuAW8W/AgMHFQtFaWI6ULcrmvB
         hMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746055452; x=1746660252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7OGUFsBaaFGDg5Er+LmFFX/Hm+5kapCAxsBx1islgk=;
        b=WpioTyRcOJlywqOczrvrJm0H9CiyCPE78P1r8AaeKAeysQYoZbEAAL+H0+TPO+ZZ/2
         /sw5H/somKKvbsw9I5F+Knwk2URK/2SpbTwTxtleQBTGgynSlqtZQX7zSXLoEq2iZreK
         l3d4JnNQgzPO9Oigt+ihEX9JgyI6gu5EjamLCwUp/2jDc29GUZ9FYtzDdWeQg0IYZv/r
         D9A2J/jPDR981IFrYbQne6wWQHkvmSyP3MQrQcCHgbjlRGDX1Prau7bqZybyvhwong4d
         qwF3Q09q98fIzHWTQoOSoPtCP7tyY+eaHTKTSMEESKeD6BqyhJ61M9Hv7pC1z/F9Uo4O
         8uGA==
X-Forwarded-Encrypted: i=1; AJvYcCUHw/PZxZJGn1WxtAlhaQmsLzde1172NOWYBBx8DJC6LeYdrt6YGJuelNv6PgdC6FpwG4rjZcw+l2Hs@vger.kernel.org, AJvYcCV45BRUS7g0U79dy8dhAs+Kij/jzFWOhSvCQgVeRW++a2JtXbUVN0snlPkPcPanmzEn/y0+0xzjZW9aIA==@vger.kernel.org, AJvYcCVUBZnDp0u5r+IFOPtDejw8N6TZWhJuAa/7sawgKEE8cTG1MCTKiGjhxTu2bXRwARvdP9DDllMIp5F9@vger.kernel.org, AJvYcCWqsIEHDrk4CT3ujRsvS/3n2d6llxNDnSgroFzQxN9EU74kwjPaW4UlWFeM1C6dLhTMWHboXWVRRflYD9G3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Yhm1BEaQy0tpwfyeZ2G8nIwMP9a9frd4e+5uV//HARWyZKxb
	D3RMmH6yVhO3xal/G8hciwU/ngilrD42B8y7FOE43MiQCCarIl/j
X-Gm-Gg: ASbGnctbG7t8Rg64O1+h/fqHgHvwjsXuDjoIWv2GcZvg/0Fwmn6+VhBsHUufIu+ndrF
	Dnxsyis1erF2XuTH9BYZrkFbhEh+BihpCX9LGfzEe1v0YjrKyZYNYUInK5vFwNAfwnGv5AXMSmp
	dNLWbzPz82ZyZAlj97p8j08KLsGidHxJxfpaLilRYAsiI8YeF04tjjh9jdf+xIWZ/j+lKuX0GGO
	vm9T9ops1gKoeNA0WpVz6KDQSxlUodesAwLaWvimqXAtuM4kZBDtIjh7aw6zipzt3bHV/xspnc+
	ZytdfsqeO8EwPADUsFNbmAouJm1a+W42OS/jNMxNwJ6AGnjVl7mvhvmSAkpfFA==
X-Google-Smtp-Source: AGHT+IE862y0az6oFJm+4yszQuxoFzydInMLM/t6RNobxLsJwfhPlRYUITfUdSu7uC4z2pLnEi2Tmw==
X-Received: by 2002:ad4:5c46:0:b0:6f2:af37:d877 with SMTP id 6a1803df08f44-6f4ff314cacmr27311246d6.3.1746055452367;
        Wed, 30 Apr 2025 16:24:12 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe6abe85sm14170276d6.25.2025.04.30.16.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 16:24:12 -0700 (PDT)
Date: Wed, 30 Apr 2025 20:24:06 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v6 05/11] iio: adc: ad7768-1: add regulator to control
 VCM output
Message-ID: <aBKxFuKFYDWdDlh7@JSANTO12-L01.ad.analog.com>
Reply-To: CAHp75Vciw_ivdKFsqo=FML64zUL_cDCzjuhmdVC3V_Whnatqwg@mail.gmail.com
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <8a04f8f1e9c14d57b1db2f38a8433a0367c0c9dd.1745605382.git.Jonathan.Santos@analog.com>
 <CAHp75Vciw_ivdKFsqo=FML64zUL_cDCzjuhmdVC3V_Whnatqwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vciw_ivdKFsqo=FML64zUL_cDCzjuhmdVC3V_Whnatqwg@mail.gmail.com>

On 04/28, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 3:13 AM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> >
> > The VCM output voltage can be used as a common-mode voltage within the
> > amplifier preconditioning circuits external to the AD7768-1.
> >
> > This change allows the user to configure VCM output using the regulator
> > framework.
> 
> ...
> 
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> 
> Why?
>

I was using of_match_ptr() before, but forgot to remove it, sorry.

> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/regulator/driver.h>
> 
> ...
> 
> > +static int ad7768_vcm_enable(struct regulator_dev *rdev)
> > +{
> > +       struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
> > +       struct ad7768_state *st = iio_priv(indio_dev);
> > +       int ret, regval;
> 
> > +       if (!indio_dev)
> > +               return -EINVAL;
> 
> Isn't it a dead code? Or i.o.w. under which circumstances can this be true?
> Ditto for other functions with the same check.
> 

Yes, you're right. Since I defined the driver data below, there was no
need for the check.

> > +       if (!iio_device_claim_direct(indio_dev))
> > +               return -EBUSY;
> > +
> > +       /* To enable, set the last selected output */
> > +       regval = AD7768_REG_ANALOG2_VCM(st->vcm_output_sel + 1);
> > +       ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> > +                                AD7768_REG_ANALOG2_VCM_MSK, regval);
> > +       iio_device_release_direct(indio_dev);
> > +
> > +       return ret;
> > +}
> 
> ...
> 
> > +       return clamp(val, 1, (int)rdev->desc->n_voltages) - 1;
> 
> No explicit castings in min/max/clamp, please. This may lead to subtle
> mistakes. Also, don't forget to include minmax.h.
> 

Okay, thanks.

> -- 
> With Best Regards,
> Andy Shevchenko


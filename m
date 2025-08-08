Return-Path: <linux-iio+bounces-22447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD27B1E7FF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9E6189A1A8
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7842275B0A;
	Fri,  8 Aug 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc5gjKcm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FF275AED;
	Fri,  8 Aug 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654867; cv=none; b=iFO6zDFLXKodQdOGTnqCFuns7TwlZdoiPOoUbWxfPRIH43YxT/3MyM9Z/R7iee3ulV/OPffdg1Yg5/ENwo0sCSwEkl5qn35SiYIXTRANupMljR9EJcgLutr76ijus8NWq7mqsrlpuPrErkjM3JHS/qiu498a0cpiUP/mVj912MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654867; c=relaxed/simple;
	bh=gkm1xokB6YY97ZDghDx+AKktsyHqM5RGh/YEvHQ7hR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFy5wuhgdA2D6e53AzupvXtBm30wIhbrKY7OxFlfR9mqULe9U1G8CMK583/01hEkGhVf3AQrKI05OvPVjfxEE/c6ztRr/dNeutr2GGW+GhDIg8wxQeY3NLdWWCQer/LjEJTczq9iHIGmJpy1QIQkJqGRfPd47sS8gzq4b+ZuSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc5gjKcm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bc55f6612so2021000b3a.0;
        Fri, 08 Aug 2025 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754654865; x=1755259665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZBIZYsrIZwkPh2NpgyN0QOqsc6es9z91CJLJZP4f0xI=;
        b=Xc5gjKcmp+X1Hozl8XMSMqnvTsFi0DVTJuzAa65L8YGT1OzGOAK2/eVghfhnXsF2bc
         x9wVZnHrBF8nTV4iIJGn248o/o10sIA0j4wJzc5Pjppi/jHmmIoFhfDxxoZKbLP04p23
         j+HqZs4k2h32GmK4aVLFN+bfDeNr7tBx5sZJ2p+ofKviTgLqe0ypsWfKirByGq+9s3q6
         E/dZWLVfeueVWvw1376nvvnnW1o/v5T1sVVF9PrN+Ux/VjcLiIEGiI5EewXYhDMDdkI+
         sCC70UGm6OMl4f+r6X0HzMFE5irLzIF9njtQmevgL1dchmzxB36eyTRq7w1agpM4p6fo
         4sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654865; x=1755259665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBIZYsrIZwkPh2NpgyN0QOqsc6es9z91CJLJZP4f0xI=;
        b=CuJXBt3WWIGeqYwPvKk7LSgBmIlUN8I9EfAqkGYW8jYz/TlTp2mJwc7pyjxTxdpEfy
         RFcuA6mxp/x5FCYq4ZUcjBAB/C7LurT1xzaOb7cgUL0GFWVheKmvVWOGAI09MJGECuzm
         rY6iTuZTQEP9zp3Av31z6I7HIxcbhlw8Vby3N/Ii+viqdbpPVUl5hIDqnwSIS3+7rhtF
         /CdUFbb26rbNlTXnZQSA5wIh8bvuuPjbr1MkVX7ReNyL3WYJaz3by1MPuYV+qJ7rUp84
         48e4G4kHlTFz4+4K/d4K8R/CHn8eHe6isAPjJlCAobQGrH73qWVA/+cs/JmeNabCCtCE
         hPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqmO6qrrBYpoj0ufEQTpKfO2GUs5lelanJtCey2PQkxsKroBWqAhjNqFxII4dZk4qOifQBg/9T2G8=@vger.kernel.org, AJvYcCWc83U914HapH2swfQfDXTPKhTbZESiGEOW5SBwHmzj9os6Ng+sO9OZiAuKshqg+rLUidHDEgdAJkRzCdKK@vger.kernel.org
X-Gm-Message-State: AOJu0YznahW/5BtR85EWeBjxEl5kpgeZypIYfb1SsIv+bi7zZOEFD08t
	fkgqT8qEiMSQnTxaz5iiun+eWGOznUjvi8y7n89nb1SkjpK4Si8u/9Pn
X-Gm-Gg: ASbGncsJmebjmFDbRPyvrbmKnlYbjzB3b2B6Y7rCydr/lP8XQa5caFV4a5cWXcoyxND
	yuMUFYDrScIyRPu625IjNDZCu+P4QlFsdGujX20y4N56oFbNcStPFye0nZv6dKEPzu+AwNVUD4o
	V8twsduaFrhKxAgiQvT4H169oKTXftvC000n03oHJW4p0fmJEUwx+cWWkw5rQxiPrl3Ml5UX/SV
	Xrz2tJ9s06vhC7ytADmfWrQASUjW5od40wv81PcFmDrdEhWll/qdhSq5Nf3js/LKkGh32WOcXD2
	rXqFryqbq3SFbr1frv97f3vgQKdhXqd8Xc80AgHkRXcLap5JgPS6YW6OLiN2rrZxCcesOY6f15Q
	pXrd9w/CMXz7Wgqvwo7VVk/WgWZi72iI=
X-Google-Smtp-Source: AGHT+IEUgoognfH4T35qzDeYE/ur7/imxcUnnkxBI4asXUVUIqsjl7U00He03is+G+VGC5MyvMEJdw==
X-Received: by 2002:a05:6a20:3d82:b0:23d:48fc:652b with SMTP id adf61e73a8af0-24055662df5mr4065832637.12.1754654865197;
        Fri, 08 Aug 2025 05:07:45 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bf067e310sm15368419b3a.25.2025.08.08.05.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:07:44 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:07:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
Message-ID: <aJXonEh2W8NNDMZU@debian-BULLSEYE-live-builder-AMD64>
References: <aJReTh-t5D45aZNV@pc>
 <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
 <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
 <CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com>
 <c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com>

Hi,

On 08/07, David Lechner wrote:
> On 8/7/25 4:02 PM, Andy Shevchenko wrote:
> > On Thu, Aug 7, 2025 at 11:01 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Thu, Aug 7, 2025 at 6:03 PM David Lechner <dlechner@baylibre.com> wrote:
> >>> On 8/7/25 3:05 AM, Salah Triki wrote:
> > 
> > ...
> > 
> >>>>       ret = __ad4170_read_sample(indio_dev, chan, val);
> >>>>       if (ret) {
> >>>> -             dev_err(dev, "failed to read sample: %d\n", ret);
> >>>> +             dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret));
> >>>>
> >>>>               ret2 = ad4170_set_channel_enable(st, chan->address, false);
> >>>>               if (ret2)
> >>>> -                     dev_err(dev, "failed to disable channel: %d\n", ret2);
> >>>> +                     dev_err(dev, "failed to disable channel: %pe\n", ERR_PTR(ret2));
> >>>>
> >>>>               return ret;
> >>>>       }
> >>>
> >>> Interesting, I didn't know we had this format specifier. But I think
> >>> this is something we would want to do kernel-wide or not at all to stay
> >>> consistent.
> >>
> >> I'm sorry but I didn't follow. This is a kernel-wide format specifier.
> 
> I meant that it would be strange to make this change just in one
> driver and not do the same everywhere else.

Casting error values to pointers is already being done by many IIO drivers
if we consider the use of dev_err_probe().
__dev_probe_failed() does the casting from within dev_err_probe()
https://elixir.bootlin.com/linux/v6.15.9/source/drivers/base/core.c#L5026

Thus, I think this patch makes the error messaging from ad4170
more consistent and, because of that, I also see this as a good change.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Though, I'm also totally fine if maintainers prefer not to take this change for
whatever reason.

> 
> >>
> >>> And if we are doing this in more places, it would make sense to have a new
> >>> format specifier for integer error values instead of casting them to
> >>> pointers.
> >>
> >> Will _very unlikely_ to happen. This has to be a C standard for that,
> >> otherwise you are suggesting to always have a kernel warning for each
> >> of these cases. The only way we can customize specifiers w/o
> >> introducing a compiler warnings is to continue (and still carefully)
> >> using %p extensions.
> 
> OK, makes sense.
> 
> > 
> > And to be clear: I am not in favour of this change exactly due to a
> > bit weird (for the reader) castings just for the sake of use of %pe.
> > 
> > 
> 
> 

Best regards,
Marcelo


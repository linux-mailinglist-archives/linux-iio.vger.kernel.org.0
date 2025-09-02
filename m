Return-Path: <linux-iio+bounces-23653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E57B408D1
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7827E202207
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85B31A041;
	Tue,  2 Sep 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjmqJuu1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD12FE068;
	Tue,  2 Sep 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826514; cv=none; b=qS5JRRftIbDI5OK2+FyyAcVxn/NvI9O8KW7ks3Hdkj4BCHjEpRBeelITFJ1Co3JCWTACAug9hBBKRrXqmRezDWyk4EdTTRFgMOzJXFtBVEGw4fDeTOLxLxXFVDXJ6/3VOb03GDO3rdJYNGlY1H2Zswl1OJAyDKBGcEezlhxxCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826514; c=relaxed/simple;
	bh=rhmHOETPUB80MeODBzKkC4z8z37xTyz2AMhtaliS4hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkH6T7tykk6dd/GbfBq2bAqOuQMHOWYH7CBluhD0OSkLc9aJYE8LDlgVhR9Vt42PTSKSNGrti8R0QtR4/qYf8L6WPs1ReUsnx/gHDfHa21fqYtkh/o1iTEQ31UVXtt4m5LV0SkuhqZ5DDhuFSd3jCuR/pbLWtGTUsCK7N9RTq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjmqJuu1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso3014270b3a.0;
        Tue, 02 Sep 2025 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756826512; x=1757431312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gw3ssi4bmma7i1rZNi65std+RGG6lQ5EditfjZ933j4=;
        b=kjmqJuu1wnVz9SCd9faDNDyQJZrtaiMCLZ7RW71pmMRo1bvvkozcnfevaZ7xFNpBvd
         d2bjM3YuH7Aq5mZG4zQHV8thNM9wvgaWLjqRssJJjY9accs9wlf60e6uig7/ra1q8VwN
         gEhKfjsvvyMwxvcuNOl1E+TJo2i5QRSgAQ7EKt62r57HAWAU+dR3pAedlMPdXorx0xS6
         gZzP60QlKfN4Z2vPJlJlf8zkaTY1lwdSLG1yU2yKHDQxeXwx0Dw3dtctoOofPALv8OIp
         xXO7HSyOXmb273K6WQnR8AvFkVyLsnoeqIqIhskfRPM8knZMBilKyVJaMinbmzW5E+bu
         jY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826513; x=1757431313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw3ssi4bmma7i1rZNi65std+RGG6lQ5EditfjZ933j4=;
        b=jVAv52OVsTlA4TGoI/doR6nNXVkY3dAeZH6GCyzmpIsYDuw/f+eJAv7HusExz6RWS2
         3dmMTJWHdI7EjldOE5xX1r/lZIaFYtyF0XFV7mbfMhEOWIeBb+7IqNcPJ6lBdjTaF2U7
         vHS1aEMGnzQojbxHbZfmXwgOoh6vRTLMj0XvFH9K66md2Hv1nJosYt6CcCmsTC9l95Rh
         NQRPcIZF+4mMRBe/8wRYGqj57Nu6zxOTroz5QUvqN6jLrUHV7P9IswEQZKuheJihDdN0
         AnGlk8yKEjNXqv8iGvTbLE4qy4lsxveD/jLcEpwva3fQjp+OQcwVz1V0AQOIEybynbfX
         O+LA==
X-Forwarded-Encrypted: i=1; AJvYcCVYOM3RieJ8SNAoHHEMW/EwhR4xDearMeNqMkP+y/nc0zrTYnTrpOBMtYa7uOIWxWp7aiIoqyboUbFl@vger.kernel.org, AJvYcCWWSVFxK30HqOMUOki+oXBp/F1HIV7RxndEzWz6X7StL8Uu8Cf+KS/PB+G/OXKxg5NMbNHVfw/eLzc3@vger.kernel.org, AJvYcCWhzskM8Vt4HYnrugDLPqRpHYzXg4GeAVoT5PAcrRR9N02PTPDdBHTYcwPLNTyqWQG19SUhFi01USaA@vger.kernel.org, AJvYcCWp/SCdOivxU+YRvFmUxNHeJypVgOBLpk1kCXxYdGSBjsdcFoPQMGmPfOrKFefh2pHHOFFg24iL2lkJ@vger.kernel.org, AJvYcCWwFZiHahKQ5yCZvQolsmaW6gmv/b4gtulnS9BpOWFR43YTj4Fg919mWRboKaG4jxUnfrqE4gOmibCCrQ7d@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzPLxISE+Yr9G5k8sU38xkSpcXuMzdGyLgaN9GrJ41Gr4xQIW
	9WqWj8A+gIJU4kvUagx2ZG0IAPrPQUNuqcWGT9VNdG9FVBrxZtde6ifp
X-Gm-Gg: ASbGncupPEbc2f9nx0kD4aZRisxtBJmReSTJLfOWN7gujFnGzOcOznumLCVnl7HqAFD
	8boNzY7nc1dAvF0VxDrgTEAk0/bgu0g6tXq1lhqbXjX0Sn1x3YKcmW6nYPfcFZ/MzicuWcSz4mp
	+FNQO7b6iQ0VFvF4tI+Wy/H08Xw/s4mDxuuJzZpoabwzD4WGmYPH4OY+KVkETla8RFO4+RDjD2E
	ssiH7irgLcRb5WPgYOiBZutY19O1LOnUmnOZlYiRmRSpuai7cRD1l+EJQwsGCEMzYeY6VVyi7eR
	bs+0bfQMnugDqy++5UrXXVaDq5Bh8sx5pGhCvvhd/ynixaSO9H00Hv0nsb+cKXCt6G95d+LSCoE
	1M3ayVo5xRZ+p0SWk0BzTUGGy/CkBu+E=
X-Google-Smtp-Source: AGHT+IF/e24Rcl4OaU3SdP4MK+Vzqmqenz5g+ZRwy+5rwpsp7l+XLoGC3ieQOzGmDmipIH0UtCwd+A==
X-Received: by 2002:a05:6a20:3d07:b0:243:c2e8:f4d1 with SMTP id adf61e73a8af0-243d6e6d928mr18303803637.26.1756826512533;
        Tue, 02 Sep 2025 08:21:52 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4cd073c1fasm12063938a12.15.2025.09.02.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:21:51 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:22:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org,
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
	ahaslam@baylibre.com
Subject: Re: [PATCH 15/15] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
Message-ID: <aLcLr8H3QbL_A565@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>
 <CAHp75VdeSqwVecJHx+jXn9++zgN+CBH56OGUYX5kBbdc0AFKSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdeSqwVecJHx+jXn9++zgN+CBH56OGUYX5kBbdc0AFKSA@mail.gmail.com>

Hi Andy, thank you for your review.

On 08/30, Andy Shevchenko wrote:
> On Sat, Aug 30, 2025 at 3:46 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> > that scales the analog input signal prior to it reaching the ADC. The PGA
> > is controlled through a pair of pins (A0 and A1) whose state define the
> > gain that is applied to the input signal.
> >
> > Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> > through the IIO device channel scale available interface and enable control
> > of the PGA through the channel scale interface.
> 
...
> 
> > +/* HARDWARE_GAIN */
> > +#define ADAQ4616_PGA_PINS              2
> > +#define ADAQ4616_GAIN_MAX_NANO         6666666667
> 
> Can we use calculus instead (people can't count properly after 3 :-)?
> Something like this
> 
> (NANO * 2 / 3) // whoever in the above it's 20 and this puzzles me how
> something with _NANO can be so big :-)
> 
Yeah, the max gain could be expressed in MILLI, but maybe I'll just do 20000 / 9
(or equivalent) as you suggested below and drop ADAQ4616_GAIN_MAX_NANO.
I'll also comply with your suggestions to this and other patches.  

Thanks,
Marcelo


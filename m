Return-Path: <linux-iio+bounces-12678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94FC9D98E0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8137F284913
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E21D0E26;
	Tue, 26 Nov 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMk31KA4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D551D5141;
	Tue, 26 Nov 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629117; cv=none; b=DVy4DI9HzkQXMjhdVoo7RV2W5RJtsg9SWL5E5/3y6fg7yuwJ7SaMOB02CUBqesxXrQ8OjQynpGmIwX99baqPqUQ4bSBShQXrV8MuBuRapLM73mrxLgMu934+/Yb+Y7IgTLZuyft+1x6ImUd9ihMrcInHIrt/Iz/GauUanAqvmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629117; c=relaxed/simple;
	bh=sKrvlOPesv77TlSL9413G4Rac8qAXlk2aa10I1b2xyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVylXAqHGTYYn7uRrzRPBcgbYopM7SVUfMrH8g0fIJ5ywmltGAn8hEqLt5nFwj0g1zpyzZ5XJMPHA4OesSIlIaiklBQNhUQ6DNqES9LhwYKbeNegmOt3MdUYx/gfZ13DM7UzUa7jfLfg04CRxjncA7E5xs75jqofsaKaFE8IqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMk31KA4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e387195210eso778473276.0;
        Tue, 26 Nov 2024 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732629115; x=1733233915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sviPRUSfrka/SQ3zY8lPjm+9lMwQh6QA6YYYw9K4wuU=;
        b=iMk31KA4eS+bQAK0oigz+sjxX9SEy7FQP5Cgs5JWR4n09B8oYW7jV+1fLhHqT549db
         aBvNfpzUHyMuv/iGVHyOE8QdyYml6pVbuQ9kKLqYdRjq+PLYHML5FbhAHY/L1o5RMc7y
         KrBhxR1PIZx2T3jTWOkUm20PK5Zxi4nEKPfM7/oY3s0QeoD4k+KhrUYGW0uWJcFTLWeQ
         gtL/77secRvXPHwqW9ToMO9+9TGTAYuY31GJVGkXAmfpa2aTo2+jW/5tEciiC+nGss/p
         8EXYcmV2WpKIo+5Ac6X0FNHHma88vrhOBbovuoaLbX9X8QDc5P01eJ3Qc3de6gI8BzFx
         P7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732629115; x=1733233915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sviPRUSfrka/SQ3zY8lPjm+9lMwQh6QA6YYYw9K4wuU=;
        b=ZZVnC5nm2QGqITz8itljtAkPUkUEsmFVpTPGVuACsKN1qpptse0FtMzJ5xPnBoh/kI
         7pfmPPqFvSXXULGB/LDCgK7Fct7DUaHufOm8entS0GjWKKBKjaUx4/gcBYyRNbBtTbVZ
         v5h/jz/+J7M1kD0ECFM8fW8lDVQjYMDs2Qo1Asr/oz+5bP04F0SknOK823WA8jP0WAil
         C7DCw7akwhWhN3ZA4EN6UgcJ8kHoa4lRk0ezCz7dSh1wX7HfErS8Q+Cf6EJJXsAHZOSh
         8iDfS5OX+v1yDzIccC1TzxRvY0jwkVRZkFFxAwn1wg9G1DjWrxdINjPM2bDCf7bdOcYN
         VLzw==
X-Forwarded-Encrypted: i=1; AJvYcCW7em9AIUI4fzo47upUShiHhqjAdJK0Hy6xVS2RlTVruocCOMcR1Zq2xm/Cu6p7JVVEdcZmX2ANuaLxeYyn@vger.kernel.org, AJvYcCXkL/nUQKuicTNgqvrgYmxwRgpFVHIYjSi7Lp81wBDum4bCP/I5LA2zXFIgRx8Kc0mFqzyIUE0++zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Yo1+d0qqfzT/gcsyY6kor0k4O7T9rttSbzY8FTcdf4k+5EJA
	TCSUfOvluR6UazSnoHpMyX1BUy9wzjjZPdGom6FB4/aURG06srEAERZhs1wdvguRxK75ClpOS0R
	wEvMYkatC4GkCNW3ens+srejDMNI=
X-Gm-Gg: ASbGncuquN3peg5b6Vs6rKlVrPZnNGsy+0JA8FgcwOavWTlgAxFMflhCHyjYhlmX3Kr
	goTHABxegZmTMC91b5HCqgbkK9qUzhrU=
X-Google-Smtp-Source: AGHT+IFVYU9X+d8m5ZR2n8v9ncMCmGTgOGxMQIgqcc/5jxtWKiqMBm2lmpnCHSrpEPd/XKz5lE2YrO4Y+mG1zUXaH+o=
X-Received: by 2002:a05:690c:2b93:b0:6dd:c5d4:8ad5 with SMTP id
 00721157ae682-6ef22795e6emr12757467b3.2.1732629114933; Tue, 26 Nov 2024
 05:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117182651.115056-1-l.rubusch@gmail.com> <20241117182651.115056-6-l.rubusch@gmail.com>
 <20241124180733.2925eaa7@jic23-huawei>
In-Reply-To: <20241124180733.2925eaa7@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 26 Nov 2024 14:51:19 +0100
Message-ID: <CAFXKEHZdp7cSnE8fj8y9ek0x6zev3Up918B-Ox=WS0bv9KhviA@mail.gmail.com>
Subject: Re: [PATCH v2 05/22] iio: accel: adxl345: measure right-justified
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear IIO Mailing-List, Hi Jonathan!

Thank you so much for the review. As you probably saw, most (all?) of
my commits have a huge invisible question mark attached. Most of my
questions you answered clearly. On particular topics I'd like to get
back, though. Generally I will try to apply the requested changes to
best of my understanding.

On Sun, Nov 24, 2024 at 7:07=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 17 Nov 2024 18:26:34 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Make measurements right-justified, since it is the default for the
> > driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
> > the data becomes right-judstified. This was the original setting, there
> > is no reason to change it to left-justified, where right-justified
> > simplifies working on the registers.
>
> Surely this can't be changed independent of other changes as it will
> change the format of the data we are processing?
>
> Each change must stand on it's own so that I can apply up to any
> point in your patch set and have everything continue to work.

This is probably not quite clear. Originally the driver was
right-justified. One of my last commits
(f68ebfe1501bf1110eebf5e968c4d9186cba8706) changed the driver to work
with left-justified measurements. So, I feel changing the orginal
behavior is wrong, and here I try to re-establish the original driver
behavior.

When looking at the datasheet right-justified data seems to be easier
to handle, but I don't have any personal preference.

Lothar

[...]
> > ---
> >  drivers/iio/accel/adxl345_core.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 2b62e79248..926e397678 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -184,8 +184,13 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap,
> >       struct adxl34x_state *st;
> >       struct iio_dev *indio_dev;
> >       u32 regval;
> > +
> > +     /* NB: ADXL345_DATA_FORMAT_JUSTIFY or 0:
>         /*
>          * NB: AD...
>
> is the multiline comment style all IIO drivers use (and most of the kerne=
l
> except for networking.
>
> > +      * do right-justified: 0, then adjust resolution according to 10-=
bit
> > +      * through 13-bit in channel - this is the default behavior, and =
can
> > +      * be modified here by oring ADXL345_DATA_FORMAT_JUSTIFY
> > +      */
> >       unsigned int data_format_mask =3D (ADXL345_DATA_FORMAT_RANGE |
> > -                                      ADXL345_DATA_FORMAT_JUSTIFY |
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> >       int ret;
>


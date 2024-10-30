Return-Path: <linux-iio+bounces-11644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDB9B6C06
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146EA1C23D8C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F41CB333;
	Wed, 30 Oct 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTIS6BbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB161C6882;
	Wed, 30 Oct 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312610; cv=none; b=XjcQBUFLcKxlqsWukqyuipQIY+q2alcx/Tgh92cJ11Yrti+EiMtLci4RPHTzqLWjjE2BqQ2YCD3N56YPxGO/1W1GpHD+jBx0asBUmeIH1gkUNaCyBEKmKeykJr3L05c/IF0IRq/p5r46gL9s3oLtRN52M6aaHrdaumRIJAWeUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312610; c=relaxed/simple;
	bh=UpafUuBFTrMsWIBnqEUYBI1K0lVwV0sEiSv0e+WT6GM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=A+5D/GxDXX7riAg7ytQVQ1YjWlF7XUc1c+OceWUF1OJRwwSonJff1s0CeoDYAJTsN/iK0lwU49+FfGILfo8hTwA+/awTejuXdZLTVXB2SHaOlOIijDCFOTxrtW3oAMTtwIqBkcYZYP+Kg8P3GFzRUCsXu1d3dCeWBgpZpBhzfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTIS6BbG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so900555e9.3;
        Wed, 30 Oct 2024 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312606; x=1730917406; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TADLeOOFvbCsr2nx+51bEXXXPmsK4FMPMLQQn8enb8=;
        b=LTIS6BbGq6vlZKneYw87YxleuhKA+asRnQOmqkSQrrgDy3G0Tusw/D6YvGw1K29yui
         aTbNnZpAiTxkRrioGWUh3ZyuSkMd0W6INZBNzbJL/OlQc92tLNcTZauNaBM3kI4ABc2s
         dUPMflg+f+cnuuekNaUFHfABjIfMNrpi8/IwYka6hCGbGD8Sx6S4os69M6dUu4QFiI7M
         R2cS/smFRkN9s0KLxI3/Tm1ajZQX+D0D3kNJJds0cQEtsNpVIWaSTfJvdBmKo0Dr+fQw
         fDYfWDcAtEPgjiiW1dho4WKQ0EOuw0xsZUDCny2KCsB9BOKk+Xxj1vhdoV2ApjFOlOu7
         thbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312606; x=1730917406;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TADLeOOFvbCsr2nx+51bEXXXPmsK4FMPMLQQn8enb8=;
        b=fLgCZGQ+nYXIhjAjB31I8fKVU6VzLIQkJUTqBNo2jVg+pWM2AiroxA4x8HVPsqzJO+
         bIrIrh0koc80Qy4QKpNllHTwkf+3uPHI0g8JRWEViP5ttVsxBA+aj9YgmjRxAwdeCU6Q
         emAqVA07nBvKoq7BdETIONxBKUyeCCZ2mTc7Zl4ZAP+oqeb74l/SjZHn88IjsM6m3uBK
         v70jOEWePT7OENfvzw52V5A/OSqV3/skULvYnhxmgmQKGkUSa9KuVrMEsVkNHNmAGBtc
         nN/a3W2u16fLiM9bKRd3346gxrneO8czE8ZUiVzm8KIDI1EF8e5twbuyYVb2hCUkXoW+
         gqfA==
X-Forwarded-Encrypted: i=1; AJvYcCU+pBKtkyUY+mUwAttGJ8CFtlALhngmHqYaDiLGaYFJLwb2NHKuiXnrX9X7bdLoQH9cCw9XwUHN7VA=@vger.kernel.org, AJvYcCVFY6yksRvOybCGGwV3pw5PEDPuetFWyp/VP/rCogHfK8dz/gHxPjcLOctXbO4WJFh3BS0i3Y0djEMxrBqd@vger.kernel.org, AJvYcCVlvfUcKinrHMjkDqmN33qbS7Qqte5N8f6AMhFxZ/DPdA5jHXY7xKkK14h5c/H3rupkBXV8GreG13ADeA==@vger.kernel.org, AJvYcCXRX8d7/NDNsu0db/ZCdjzsQPwuQ2ShHrduZEJUGayJYsV9Zy2BK8qSmMDbmptcpr2JMF0lgOVn1sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYQ30/APYZCrnzEZr1ovj7JPla+cNCM+E8jP9qhPTtzmt+TnC
	EeYHMc79QnI/TSNNCGeyy3VMRbFIkIVOCFXAV6uHSh8JQcZoC06j
X-Google-Smtp-Source: AGHT+IFa/usD7ZeOcHhDzlKCYij3gJcMtoMlBhi8yutM+nCN14bgxOw7OaYkPYBKbl0kidfI8s9Rig==
X-Received: by 2002:a05:600c:3c8c:b0:431:251a:9dc9 with SMTP id 5b1f17b1804b1-4319ad166femr143396085e9.25.1730312605816;
        Wed, 30 Oct 2024 11:23:25 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm28748925e9.30.2024.10.30.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:23:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZyJHFp6vbQ7deLFs@black.fi.intel.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com> <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com> <ZyJHFp6vbQ7deLFs@black.fi.intel.com>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from producer to fix race
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Wed, 30 Oct 2024 19:23:21 +0100
Message-ID: <173031260171.39393.109639772708550094@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Andy Shevchenko (2024-10-30 15:47:50)
> On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:
> > Consumers need to call the producer's read_avail_release_resource()
> > callback after reading producer's available info. To avoid a race
> > condition with the producer unregistration, change inkern
> > iio_channel_read_avail() so that it copies the available info from the
> > producer and immediately calls its release callback with info_exists
> > locked.
> >=20
> > Also, modify the users of iio_read_avail_channel_raw() and
> > iio_read_avail_channel_attribute() to free the copied available buffers
> > after calling these functions. To let users free the copied buffer with
> > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > but stores the available values in the returned variable.
>=20
> ...
>=20
> > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > +                                         struct iio_chan_spec const *c=
han,
> > +                                         const int *vals, long mask)
> > +{
> > +     kfree(vals);
> > +}
> > +
> >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> >                             struct iio_chan_spec const *chan,
> >                             int val, int val2, long mask)
> > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio=
_dev,
> >  static const struct iio_info dpot_dac_info =3D {
> >       .read_raw =3D dpot_dac_read_raw,
> >       .read_avail =3D dpot_dac_read_avail,
> > +     .read_avail_release_resource =3D dpot_dac_read_avail_release_res,
> >       .write_raw =3D dpot_dac_write_raw,
> >  };
>=20
> I have a problem with this approach. The issue is that we allocate
> memory in one place and must clear it in another. This is not well
> designed thingy in my opinion. I was thinking a bit of the solution and
> at least these two comes to my mind:
>=20
> 1) having a special callback for .read_avail_with_copy (choose better
> name) that will dump the data to the intermediate buffer and clean it
> after all;
>=20
> 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.

Could you elaborate more about these potential solutions? Maybe with some
usage examples?

If I get it correctly, in both cases you are suggesting to pass ownership
of the vals buffer to the caller, iio_read_channel_info_avail() in this
case, so that it would take care of freeing the buffer after calling
iio_format_after_*(). We considered this approach during an initial
discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
to let the driver keep the release control through a callback for two
reasons:

1) Apparently it's a bad pattern to pass the buffer ownership to the core,
   maybe Jonathan can elaborate why? The risk I can think of is that the dr=
iver
   could still keep the buffer copy in its private data after giving it awa=
y,
   resulting in fact in a double ownership. However I think it would be cle=
ar
   enough in this case that the copy should be handled by the caller, or ma=
ybe
   not?

2) Some driver might want to avoid allocating a new copy of a big table if
   the race does not occur (e.g. with additional checks on buffer access
   code) and thus wouldn't call a free() in the release callback.

>=20
> In any case it looks fragile and not scalable. I propose to drop this
> and think again.

I see your concerns, I am open to reconsider this in case we come up with
better solution after addressing the points above.

> Yes, yes, I'm fully aware about the problem you are trying to solve and
> agree on the report, I think this solution is not good enough.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20

[1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/

Best regards,
Matteo Martelli


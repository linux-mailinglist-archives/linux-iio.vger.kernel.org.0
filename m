Return-Path: <linux-iio+bounces-10913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B359A9976
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 08:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29EA1C246F7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4BD14A4DC;
	Tue, 22 Oct 2024 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lGY53Q9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF2145A19
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577399; cv=none; b=rnC/tHojXcW0PJDhHDBweQc+IpiyODr8tcwBW8jeC8hI1r7gdpqQFBCN+sYKQDY8FnZ7TVPcqJW4tKEbGzPpHLek8pOxLFwLQzr/kKOVVQZ8PdhGnnkOtP+ZqRbpbR9SkneTczIIVFfdIizNEc8o64VD9+sP5GZyBguwtFSPxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577399; c=relaxed/simple;
	bh=RYNViOPjs0qfwljodNXQeGyiOsVETWKj6+tpPo0gw3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lal6ArbH/7IvdHyMQaBIzOE2vkZLtLlgmOulHwmGA0whhZDNnLjP+HQVaoSLDDLkOYxBID0eipA9M5YrKwGiwI/24+S/mlpdfIPWgIr3cHTdJah75LrEnbmUqG0kpbGPTKxmZw7mGkTULt12o3sv9s5zQUb129VeMVm7pLpOQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lGY53Q9h; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50e08caccaaso432209e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729577395; x=1730182195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oPA1++gLWQWFvzTYpeR6sYF2qQIZ9tBVu8CJKZGcRQ=;
        b=lGY53Q9haZmTB+kT7pjemn/Xkt6Lv8H+3aBzAHycjYEHUjQXXgzJIXtSKFkEKK+TGS
         TRvwxaddsmCnTVe9JjfxNzNep/iJUNn2Pnd9NSNlKFa52RKjiH3KN7OAfroOw+x74wlP
         ub1bi1+t9P7JtCCX705o7iKrDuTUu9/+fVPKdr4M4FnazksB4H7EmRibcFSHsDfRd5aB
         LxDNwwgcLGh9Oc6MfgJ2YOciZM3KqtGXWJBCDmvgalAbIQqfyLwSf30TeICIxm9hG5Ha
         EMB9ZmO7wKYbpkbRHti7kc3eXsireoj0OWjxcMamZ3Fbx+TQES+4NztvkvGkAbG9rYab
         zyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729577395; x=1730182195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oPA1++gLWQWFvzTYpeR6sYF2qQIZ9tBVu8CJKZGcRQ=;
        b=Iq5xvs5fEncsQv97+DwOBqcpRM7Soc4DCnj3hmg66swDkEfmuR/raqvenutS8x9Dbb
         9iNhC5Oqhj4+Bsmiy5umMNrGQ0D1yDyUDWF6GINYbBaE+o6rCzSAn0NNc+8b4v6eLxnc
         Ki+Rz/4H4Ng5vwqwXNFmPem4QHMw5u8fIw8z1gW3r8/dhAlNXHhx/ZCEDrftPg0TsTAQ
         kuIPjh0QmNDcV92cAuY+qjVwWtEDKOWmL5vJwAhmlSehQi8HUk0VJGucKTERXXBdt7GY
         YOx0B1kxow1EHt0kwE/cpRh87YNl9gJbWATWwgcG3clrWGDElTnp2/rM2VdExdvkOwMb
         balg==
X-Gm-Message-State: AOJu0YzXv1Q1zEJJpE04I+e3sUjDM7Ct/cuXRWGA5Hzy9rwIiSfeVtJb
	4OJywSSufOTWo8mlYkoNzFztH3MhwjYuacdD/dh80P2ZeRwCDwS9h63+GAhlZhu4WLDPpHdUFPV
	F9k30Lg/Ap/XkdKP3IxSJ+JngA7aw1DplChu0mQ==
X-Google-Smtp-Source: AGHT+IE3wc+LCKuHli2wuMbRdahOui7PqfSTzFfrH+tmjl9a3NTlUglV7xXSsSlrCqlm17xHnQ5uDRj+5ZkjFmjANCc=
X-Received: by 2002:a05:6122:169e:b0:50d:8d89:9f4 with SMTP id
 71dfb90a1353d-50fb2707490mr2701901e0c.3.1729577395133; Mon, 21 Oct 2024
 23:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021130221.1469099-1-aardelean@baylibre.com>
 <20241021130221.1469099-4-aardelean@baylibre.com> <f319c8bd-1edc-451b-aeb2-27ec529267a3@baylibre.com>
In-Reply-To: <f319c8bd-1edc-451b-aeb2-27ec529267a3@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 22 Oct 2024 09:09:45 +0300
Message-ID: <CA+GgBR-eKUir7FGOfimv0rE2yP3P3awMZSG8=6t202GAthi=Mg@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: ad7606: use realbits for sign-extending in scan_direct
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:19=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 10/21/24 8:02 AM, Alexandru Ardelean wrote:
> > Currently the 'ad7606' driver supports parts with 18 and 16 bits
> > resolutions.
> > But when adding support for AD7607 (which has a 14-bit resolution) we
> > should check for the 'realbits' field, to be able to sign-extend correc=
tly.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7606.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index d0fe9fd65f3f..a1f0c2feb04a 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -568,7 +568,7 @@ static int ad7606_scan_direct(struct iio_dev *indio=
_dev, unsigned int ch,
> >                             int *val)
> >  {
> >       struct ad7606_state *st =3D iio_priv(indio_dev);
> > -     unsigned int storagebits =3D st->chip_info->channels[1].scan_type=
.storagebits;
> > +     unsigned int realbits =3D st->chip_info->channels[1].scan_type.re=
albits;
> >       const struct iio_chan_spec *chan;
> >       int ret;
> >
> > @@ -603,15 +603,29 @@ static int ad7606_scan_direct(struct iio_dev *ind=
io_dev, unsigned int ch,
> >
> >       chan =3D &indio_dev->channels[ch + 1];
> >       if (chan->scan_type.sign =3D=3D 'u') {
> > -             if (storagebits > 16)
>
> I think it would be simpler to keep this if statement for choosing
> which data.bufXX to use since there are only 2 choices.
>
>
> > +             switch (realbits) {
> > +             case 18:
> >                       *val =3D st->data.buf32[ch];
> > -             else
> > +                     break;
> > +             case 16:
> >                       *val =3D st->data.buf16[ch];
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
> >       } else {
> > -             if (storagebits > 16)
> > +             switch (realbits) {
> > +             case 18:
> >                       *val =3D sign_extend32(st->data.buf32[ch], 17);
> > -             else
> > +                     break;
> > +             case 16:
> >                       *val =3D sign_extend32(st->data.buf16[ch], 15);
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
>
> We can change this to:
>
>         *val =3D sign_extend32(st->data.buf16[ch], reablbits - 1);
>
> Then no additional changes should be needed to support 14-bit chips.
>
> And similarly, we could avoid the need to use the more verbose
> switch statement.

Ack.

>
> >       }
> >
> >  error_ret:
>
>


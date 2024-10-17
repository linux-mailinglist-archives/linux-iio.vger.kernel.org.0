Return-Path: <linux-iio+bounces-10683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E09A2052
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7792C28A88A
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B21DA10B;
	Thu, 17 Oct 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmcosAp1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA81D27A6;
	Thu, 17 Oct 2024 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162169; cv=none; b=hKhIR7yIsXTO6Zobg2PEFPBvv8A3ZrpFsb9rdaQXRXECPgCG1VwX1hR/BQHSbZf8QkPRHkiGtR5HmWdmT+2Sowk2QNPm5BTRNZy+O6FUIl4moieDytPTcC8d9AWsxfx8G/DK4K15zUJMYCxzukfXxy2Jd3Hx23cA0XXof4m/kvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162169; c=relaxed/simple;
	bh=/DPOLscSfouYu/AH66QRdKoEo5IRYqSPfeB7ZKt7B9Y=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=P0ny+LVsu+vkvSP1Ww8391LKDhgqyRqABrfrownmIyHYn6mjS+Y/OR/0xrDmxWzXYH6aytKPVYNBy6buBAV3a2jmhqdSuyxBEP2sk4YBOuiYKZA5ezJQu0eYQHthqkdsrbtsf6WcHJwel0VlPsuZ6Pd3S4zIxTtAjZMonaQs0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmcosAp1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43155afca99so8156805e9.1;
        Thu, 17 Oct 2024 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729162165; x=1729766965; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u95ZFAnBjpKr6vjss6HYOhy5TzfTV9aDj/vEX3amD0o=;
        b=NmcosAp1j/yrNuQy7A13HfZc+jV77EbGP8Z0RxGR3zlhk71vmcTmrtgzuDPtS01SSQ
         r31aKDpo8bkTXqNk0kgzafeb4eLCfmVdFrZPb+C/iXxYPzB6KLva2AyvhaIz3eXkG8sJ
         nOBnxZCMJT26mkExoFd20rP+tUQltzcDhR4m8bVVtjmQKcOwiJNjaaazDTeYaGhRqAm8
         d/2ZMPh8lu6iPbBc+EnU0MICAHV3l/gFE+HVchfDvQjs32NyXJEOkoq08gyIm+YqCg0Y
         YALrl3++YGvAp6jWMNlGgHfn7jTMnV+moI6yG+qABZNA3z+I/CuyL693QWnTDrX0O2oy
         vDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729162165; x=1729766965;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u95ZFAnBjpKr6vjss6HYOhy5TzfTV9aDj/vEX3amD0o=;
        b=Q2L3r0fqv7ibbwzBlrLK55x+ILUV8Bn9qb8fL1PHtsatjL9nNy7H55iIZan7dhnTjm
         KsR4IX6CWpbuuUF0cvqYoG+jIOrsUmQ1NRNwIKE0UlKZjP0vFJnLM2oyUDHgL1S7i5rZ
         tl2iu1xrqRl36cNQglkbqLt3ujaXW/Q2Sd3VtE40PSF4NtUCG6NF82/SX/xb+R4oAB+3
         h4fXldUgm7tvonf2vQZY9K1VcY670f849JhLcuQUagi49vA5Q8Bo47yNfmWmhQyNg43s
         XFwkwOQ2Q/8rhVOCeBLdruWYvnK0rq/+TDbxGxRvjTfSoMKABnIC6egyjfxTz83RXtVE
         jvQg==
X-Forwarded-Encrypted: i=1; AJvYcCV2GbbFNlut2JdRSp3sftd9VrvOUJuK3UZSsc9Ok/5mOkHsfRJgiiawE62k6/loXn1+UgMfyNI3fKUnDA==@vger.kernel.org, AJvYcCVJIZ4DNmuolCHRiTDvXOUeveM6Sb3f8mInVyRwmzO8DXhVlLIpzA+CmozwaPB2DXtTZOIQAFg5gjIe/o4h@vger.kernel.org, AJvYcCVcJMB+g06WtZnpfv+Ozt96RPHoF13+XIG9HHQy1gKUg8WaRbMQF9G6E3X09GnNFZkp4FAotlqanOM=@vger.kernel.org, AJvYcCWLTlSYv9ac1+eymCXoPJGoVfBElQbQtrR8zAbGM+538gUVPYlRAkcMyW0mBvQkZbIYP4w/h8SJsgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1zUXEAK+2Zc4m1SJd9Vh5g9g69yQ0VipjRvRE27amAsGBaif
	zcKuLo2vH3ah1Whp2KMy6S6XRDt7anKSmxK2ThpTew2JxbBWZx2o
X-Google-Smtp-Source: AGHT+IGGUQ+VzAg13N5jeYirbt4WsJHpq6JBFIFDHXPJJP95TiTfPNsutECzweKscP0z/rdyGZHWng==
X-Received: by 2002:a05:6000:1379:b0:37d:39ff:a9cf with SMTP id ffacd0b85a97d-37d93d43c9amr1713905f8f.5.1729162164991;
        Thu, 17 Oct 2024 03:49:24 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314f1c3197sm38400115e9.0.2024.10.17.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:49:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7qvxz3fuwcjeq2ewv3nterlf72wbymt7np5nnjitzkt6smzh7v@737455c4xapy>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com> <20241015-iio-read-avail-release-v3-2-ac3e08f25cb3@gmail.com> <7qvxz3fuwcjeq2ewv3nterlf72wbymt7np5nnjitzkt6smzh7v@737455c4xapy>
Subject: Re: [PATCH v3 2/5] iio: consumers: copy/release available info from producer to fix race
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Oct 2024 12:49:23 +0200
Message-ID: <172916216326.53359.1590082756395527593@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Sebastian Reichel (2024-10-16 23:08:30)
> Hi,
>=20
> On Tue, Oct 15, 2024 at 01:06:35PM +0200, Matteo Martelli wrote:
> > Consumers need to call the producer's read_avail_release_resource()
> > callback after reading producer's available info. To avoid a race
> > condition with the producer unregistration, change inkern
> > iio_channel_read_avail() so that it copies the available info from the
> > producer and immediately calls its release callback with info_exists
> > locked.
> >=20
> > Also, modify the users of iio_read_avail_channel_raw() and
> > iio_read_avail_channel_attribute() to free the copied available buffers
> > after calling these functions.
> >=20
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > ---
> > diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/sup=
ply/ingenic-battery.c
> > index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..3db000d9fff9a7a68196313=
14547b3d16db7f967 100644
> > --- a/drivers/power/supply/ingenic-battery.c
> > +++ b/drivers/power/supply/ingenic-battery.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/property.h>
> > +#include <linux/slab.h>
> > =20
> >  struct ingenic_battery {
> >       struct device *dev;
> > @@ -79,8 +80,10 @@ static int ingenic_battery_set_scale(struct ingenic_=
battery *bat)
> >               dev_err(bat->dev, "Unable to read channel avail scale\n");
> >               return ret;
> >       }
> > -     if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL=
_LOG2)
> > -             return -EINVAL;
> > +     if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL=
_LOG2) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > =20
> >       max_mV =3D bat->info->voltage_max_design_uv / 1000;
> > =20
> > @@ -99,7 +102,8 @@ static int ingenic_battery_set_scale(struct ingenic_=
battery *bat)
> > =20
> >       if (best_idx < 0) {
> >               dev_err(bat->dev, "Unable to find matching voltage scale\=
n");
> > -             return -EINVAL;
> > +             ret =3D -EINVAL;
> > +             goto out;
> >       }
> > =20
> >       /* Only set scale if there is more than one (fractional) entry */
> > @@ -109,10 +113,13 @@ static int ingenic_battery_set_scale(struct ingen=
ic_battery *bat)
> >                                                 scale_raw[best_idx + 1],
> >                                                 IIO_CHAN_INFO_SCALE);
> >               if (ret)
> > -                     return ret;
> > +                     goto out;
> >       }
> > =20
> > -     return 0;
> > +     ret =3D 0;
> > +out:
> > +     kfree(scale_raw);
> > +     return ret;
> >  }
> > =20
> >  static enum power_supply_property ingenic_battery_properties[] =3D {
>=20
> It should be enough to declare scale_raw like this at the beginning
> of the function and otherwise keep it as is when you include
> <linux/cleanup.h>:
>=20
> const int *scale_raw __free(kfree) =3D NULL;

Nice! I wasn't aware of it, thanks! I'll try it and submit it in next versi=
on.

I think that also fits for the similar usage in iio_channel_read_min() and
iio_channel_read_max() as well.

>=20
> Greetings,
>=20
> -- Sebastian

Thanks,
Matteo Martelli


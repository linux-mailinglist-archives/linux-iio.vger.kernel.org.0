Return-Path: <linux-iio+bounces-14235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11360A0AAC6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803F07A38A3
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1A1BD9CE;
	Sun, 12 Jan 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFLKlBKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8A1BCA1B;
	Sun, 12 Jan 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698354; cv=none; b=LyUrBOzA8KkHYXhSOvVUbMMOISaZZH0GjzfVG1lASG3kvyiMGASAACB0yq5gSaHOg8XjF7r0W0GVZHfctB4gdw4l41lzvEqZLqzkkpmv7ydMcAVHP600Oe/q861CTV7wtdJiT4tNSRDQGrAUOnGuVFOUX7TehSpCuNz18xdR220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698354; c=relaxed/simple;
	bh=q63YvK4iBENbAeHSZsEAb5vPQMA5gSawKUPkyUHpG2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skDmbZKlQgWJTUl8prjiUt07tqaSL9XoehC2Z6YNtIstVPFIuPtwaIuJ/CLPlYDEVSW0jXmO+KF8AeT3fqhViB7nUDtoKr7GgDDMwQgQyJFFC48r1d+D8fTQDxSGjYZYEF+fG3gkL7IjKF9I6VMt+cGlD5UlcPb2iy3zJVQ5Oho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFLKlBKN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso696147666b.2;
        Sun, 12 Jan 2025 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736698351; x=1737303151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjjU3i3gpyhzdX79lQJF+2BTYAs1dOQ9qBS7DpdO14M=;
        b=jFLKlBKNN4SHt6mV4/rfsUoeSOhRpE0QGg1O+oZDEOP4O2pm4HGm706cRcuBH/+Zf7
         dLplCA5N2g2ojzam3mLl1fm3sWNotohXfGTd3FNysdSrLueO8YKLeVWaF9jN44CuI+UD
         0pHGZAEhm6mDLTqRcVXCNcdgbmFyFceAfaPJRIUXJ9oeTZrlleX4jI+pLlJX5ecO/m6A
         IXtnFPqflj3d4dpYstfeu7e9enCvfUcKdeYt9hZ+nyL0HaSThU8caEJc9/dVhXhsWsE5
         cuTwKqb5G6/EK2xsSrFPlPVK3wmHb0QSMU86uebSJKU5JePxsKvydVJSCirzKGTsx8bq
         x2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736698351; x=1737303151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjjU3i3gpyhzdX79lQJF+2BTYAs1dOQ9qBS7DpdO14M=;
        b=PW47rYJcFA0EJD9ha/uz2EkpgBYjwW4J9g1q9JzL2iGBgHopch8B9YYmuHE0ShgPC1
         aT6MFykVRO2LAWbI2pXTBulK1UV7+EP26PcW/wZgr0YZg7IXVsQRlRxhX9nCwABmXgAE
         YF5zNWnSpyYasHftf1YD2mLWVce96D43v4h2wMZX+Yw/kQhYb7bxv4xMZpD5NqHXG7dx
         gkoWWjjP/vvTE2cCTmRlNBD+RWSfOo2H7MeMUeHY2iq/LDVuI3PiGK+cVgXAlUe31aYW
         IzV0zVVwlLbjhV1vYYoui3rE+FPTSpuHzvGkmA/2SgPNkAGpi0wML/s8VKbKwfLHqI10
         /ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCURF6mSTr8WHZzQNF6XW4QnF8hCGC5wOznpCmt53S2ZCvfqq/I6gKO49qDPs79CBZeTebCehftUPv0=@vger.kernel.org, AJvYcCV2ZR9PQAqhCmbZBblz4mohIO9+lyyRbAjW7L+RJzzYyJRXx3WHrqZ9Xx4KpbdiSGMmOj3iQqEr5eHFlm6L@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgdTm04ipsl3qF8AvZkMbogU4NZwWIJyB2OOomzDVn3fujUSg
	+B+2DTA1p9o/j7xxWxFcegM7KxSqHtovhKpXRMZ6gAf/cwC+KayOosg4XIkFqnjHxrRH8pbaK07
	pyGbXu0fNWBLszSNxcwMEDM/BVFM=
X-Gm-Gg: ASbGnctxsd2d7BgG5TzEy/v+qu/vBjGbY1UYb1NihSI3gwX3hYaJkCmVvmVooSScJLF
	YBiIj42ZbH/qrWgtutIFNI/LRpj1ZVFJCQzbNJQ==
X-Google-Smtp-Source: AGHT+IHP3JF5ID6VnxEKAdMW0B8qS2IAkNFsL8UFyOr/ANy0mS5vba27COrX+b2F3cn2IWplp2kQ1f1ItZR7qx9i1bY=
X-Received: by 2002:a17:907:6ea9:b0:aae:869f:c4ad with SMTP id
 a640c23a62f3a-ab2ab6a85c6mr1447843266b.7.1736698350735; Sun, 12 Jan 2025
 08:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com> <Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>
 <D7082ZE34NTT.DHC0Y5220527@gmail.com>
In-Reply-To: <D7082ZE34NTT.DHC0Y5220527@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:11:54 +0200
X-Gm-Features: AbW1kvYm6qL0Eo7zWuFY5r8xzfoVh8c4C69VyX99KnXdcnviWx4N7szSffK9Gwg
Message-ID: <CAHp75Vd5LdP7+ndresVv5STN2zrC3S5puDhcACyEk7MbLA0hgA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 6:07=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> On Sun Jan 12, 2025 at 4:18 PM CET, Andy Shevchenko wrote:
> > Tue, Dec 24, 2024 at 11:59:02AM +0100, Javier Carrasco kirjoitti:
> > > The configuration and ID registers are not volatile and are not affec=
ted
> > > by read operations (i.e. not precious), making them suitable to be
> > > cached in order to reduce the number of accesses to the device.
> >
> > ...
> >
> > >  static const struct regmap_config veml3235_regmap_config =3D {
> > >     .name =3D "veml3235_regmap",
> > >     .reg_bits =3D 8,
> > >     .val_bits =3D 16,
> > >     .max_register =3D VEML3235_REG_ID,
> > >     .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> > > +   .rd_table =3D &veml3235_readable_table,
> > > +   .wr_table =3D &veml3235_writable_table,
> > > +   .volatile_table =3D &veml3235_volatile_table,
> > > +   .cache_type =3D REGCACHE_RBTREE,
> >
> > Any specific reason why this is NOT a maple tree?
>
> Hello Andy,
>
> I followed the most common approach in IIO (52 RBTREE vs 2 MAPLE),

But it's historical and can't be taken as an argument.

> assuming that the "low-end systems" comment for the different REGCACHE_*
> applies well to the typical systems that will make use of this driver,
> and many others under IIO. I considered that *possible* performance
> advantage for low-end systems above other considerations, like the
> general rule about using maple tree.

https://elixir.bootlin.com/linux/v6.13-rc3/source/include/linux/regmap.h#L5=
8

"Any new caches
 * should usually use the maple tree cache unless they specifically
 * require that there are never any allocations at runtime and can't
 * provide defaults in which case they should use the flat cache."

Can you reconsider?

--=20
With Best Regards,
Andy Shevchenko


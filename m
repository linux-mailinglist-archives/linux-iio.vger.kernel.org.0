Return-Path: <linux-iio+bounces-2550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5438854C63
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7D11C20CC5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA45B691;
	Wed, 14 Feb 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PruywErL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E55B5DB
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923751; cv=none; b=ZPFc481z7OkOrI0bpzK/xCVdZ1/Oth0z6UfyVBIT8x7z4umE5pyHlDid932GFWZt+vb5QSEH3xZvbnisP8G9yaUnbU+fLLRYo338xE9xd9innNmuytucUxM70I/QfCjXd7EE+No+aIrteU86wnmTzWUg60j6IYjCrvx8f+JGYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923751; c=relaxed/simple;
	bh=umW6mivE7pHeU4oXSrO8moJD1kj9i0rDBU111pZBDac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AduWSBn5+iPGfrQK1nK8EJfkcIw3CvFDgJhuqGPkYytyBIyWuPD5OYGTtZeRbFDalcD8INCES4nS2yM32W/3X+R+gMrSKGLcuNBZf70LhUNGb1M9qWfWdm9y4mwVA8UWPut53k7PDVMpaYR3PMgJOc9QQlAEp0fp0LGO4xp/EO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PruywErL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d731314e67so15371635ad.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707923749; x=1708528549; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORoEVJs8yviVtWCdFlkEpyS57KSWIL8L/KeQIJPQx/E=;
        b=PruywErL9ibUFaHhf/Ho8gLZDD4Hsv1LvHcK+nvp1X3AD67i9dqWtWwsesYS7nk1m1
         cGLSKF3EPz6MMoF6ME+2mk25LiTOwAytE3VlEdAK2v3xyxzgfx9BsKLlK2gOI3h7rhEB
         v23qPESjRghO29NppOhiJc+44m3GGVbfC1F+J9f2SXOszK8sE6SyGsApZMxuHPDqzwh/
         SY4hc+TJ0iknvvCfFHsxjTCSJ8gRjHcAqIcjmfcBXHWJxC3E7z899dYc/CQLbK53fEl0
         bfjrYBZOS3qg/EoIyI2pvUmf1VUZNX21OnbN8l3daTpABfRYlKH5RM4GBxyEZRNux0hU
         eTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923749; x=1708528549;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORoEVJs8yviVtWCdFlkEpyS57KSWIL8L/KeQIJPQx/E=;
        b=TI1AhCvimTNz3qIyj690exGWkBk5/p+8Lce1P/YsPLJ0ck/JvjY3cshUf/MZm5FD7u
         rDzOqkYDZhCESple+LyKdoNfCjligyrwmvGyvC8nvtl9i/Nk/wryW3AKFxWDhFW4l3t6
         drcmrcYK9AsSj2jv+H5WbeBb8cV3GcIYZu1m3x5TChPgNnNBiKSpFV7cjC7eSLlQRuy5
         Wg6RRYvhMkmHOo9zWdS8XgnUJVw9yK0MGifwf3iNOjOVvtWB/6AS1VEtTK6XLUvXkZQq
         sbSthCzy2BFmCyvaiYUXmvpMi6aVG1R4qAXaxBAzNMM248y+CKTPeV/3LTkvAMJP3+1i
         04RA==
X-Forwarded-Encrypted: i=1; AJvYcCV7OU4yyQnZxLEivIi7bO3VEw7FSH8EqukkdjpzCjgges1z4Y9GJTwN8NxX/38Jd+GU1939ZIqfaiw1GOv0E1y53zVPmhw8PFwp
X-Gm-Message-State: AOJu0YwZIH9sTe4slobephEd8j+68Tgj960zbHCQJRV7LxaWIP9oNg2k
	WUX4dCxxnkwUKRa1/oubBjgPbFTVuTChIrDvpyKS/2L8py1vnMzW
X-Google-Smtp-Source: AGHT+IHJ29XcR7MiLdplx6pc5z47Q3kqJt+oksOOA6e7Z6vk4J655KyuZlUuvTOH6mAMDeSU4wA5DQ==
X-Received: by 2002:a17:902:d507:b0:1d9:5cfc:ac6a with SMTP id b7-20020a170902d50700b001d95cfcac6amr3096846plg.69.1707923749501;
        Wed, 14 Feb 2024 07:15:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBwcwd/rZMfQ4hPVLeZFNcez4jhH0xXsJXOUDg941Z2X5QREB++aZ3nWeS6Mk7ewB4WSzRg0PocwuiP1y/lFhNfyq9H11aVxwEuDCSLz5ooBTVQR/Pl10htGEamwJiUuo+FdoueDY6GefFklj8sbAnzDZR2e1EgDJt889A9gis9TlvK1wCUCZClQ/97w+1qQInQLBi1/DiWj17epMI2jSLAaYeisgmnPhGXVLwovrdfoKIwOLn7TdTn18C9neBd8l+wXdNf61glBCVWxPO0Ujg8ygWvWOE6y9o11iU4GXpXPpdd+m0jF2GDRLV
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id y20-20020a170903011400b001d9d4375149sm2975962plc.215.2024.02.14.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:15:49 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Wed, 14 Feb 2024 07:15:46 -0800
Message-ID: <2192956.irdbgypaU6@nobara-ally-pc>
In-Reply-To:
 <CAHp75VermmAb3J8D1h-PkyAJ0ZH64vzB3vvQFZzRsr4Nr3o7+g@mail.gmail.com>
References:
 <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <20240213223910.27127-1-jlobue10@gmail.com>
 <CAHp75VermmAb3J8D1h-PkyAJ0ZH64vzB3vvQFZzRsr4Nr3o7+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13471005.uLZWGnKmhe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart13471005.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 07:15:46 -0800
Message-ID: <2192956.irdbgypaU6@nobara-ally-pc>
MIME-Version: 1.0

On Wednesday, February 14, 2024 1:39:19 AM PST Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 12:39=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.c=
om> wrote:
> >
> > This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi3=
23
> > driver with an ACPI match of "BOSC0200".
>=20
> With the remarks below,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> (carry the tag if you send a new version)
>=20
> ...
>=20
> The below comment...
>=20
> > +/*
> > + * The "BOSC0200" ACPI identifier used here in the bmi323 driver is not
>=20
> s/ACPI//
> s/in the bmi323 driver//

I will fix the first sentence in the comment.

> This seems different wording to the other one. Have you looked at the
> code if it's indeed the case? Because we may not rely on the module
> load order.
>=20

Yes it's slightly different wording intentionally. I am able to test that
when the bmc150 driver starts loading on the ASUS ROG ALLY with a bmi323
chip that the ACPI match happens, the driver attempts to initialize but
does correctly fail at the chip id check portion.

I do not own a device with a bmc150 chip in it, but the same should be
happening in the reverse situation where a device with a bmc150 chip
starts to load the bmi323 driver. There is a chip id check in the
bmi323_init function where a bmc150 device should fail at, and the driver
should release the device. Without a device, I am unable to test that
this works correctly or not. Logically the code looks similar between the
two drivers.

> > If and when a different driver (such as bmc150) starts to load
> > + * with the "BOSC0200" ACPI match, a short reset should ensure that the
> > + * device is not in a bad state during that driver initialization. This
> > + * device reset does occur in both the bmi323 and bmc150 init sequence=
s.
> > + */
> > +
> > +static const struct acpi_device_id bmi323_acpi_match[] =3D {
>=20
> ...should be here (and indented accordingly).
>=20
> > +       { "BOSC0200" },
> > +       { }
> > +};
>=20

Depending on Jonathan Cameron's preference about where to put the comment,
and if he wants a v3 or not... If we want to make a v3, should I create a n=
ew thread for that?

Best Regards,
Jon LoBue



--nextPart13471005.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXM2SIACgkQ4obKiQwb
1x1mxwgAoCw+vqqP4l3oEDpfXIRrLKf5QMRagcC7GDSOdFWOQmtAQasepOkp4AiI
915FM0w713r+65nIPLzXD71Wh/F16yOYg4GVVHQZUJ/yZpBIYlID+k4O3smzkfRR
7SUMGokLDKsNMOz3hzlYT9XqZb9SPambv5ZdWRR/RwtQbUlkCRRIJBKTu3YJu8Zl
3ndFN9KHiyYzb2Pe+jdv9yiWvKMcoL8rghXxslMaDB4aKGOExxGUht/XuIu89IyV
d8l7ApFJlTkMlzpEm08WkbRymS4kyJQJP36H23eIcaLujFXS602GfhROeNBSedmw
mgW40d9eHTXMTBvBbmpwTeA195k8EQ==
=zXCm
-----END PGP SIGNATURE-----

--nextPart13471005.uLZWGnKmhe--





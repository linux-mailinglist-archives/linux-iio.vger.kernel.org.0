Return-Path: <linux-iio+bounces-2549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B904A854C2B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD161F2A908
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C010B5B671;
	Wed, 14 Feb 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4lC3ZUq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE85A7B4
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923255; cv=none; b=RY0S6VXEjc1GcHR/V/fSxOo7VCbcQ87sj5hWi376Nhm5di/+bbMyN8yaUcehWLKkbKrU9XF3UNtOnJbB1JUDUGvDhdOeVlZAPDEWRLnp2W7XWx3EfVjVjdheRsPJnCw6UAYADjkfuv7UYYbGq0RqJuua0bSKmBV25kKYsMN5R+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923255; c=relaxed/simple;
	bh=PMsrn3Hhk4WE/qsiiANcQcXtgvFT7HZ4IBUlTPxdWAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBmKImjwbdMIwbW9UE57gGOhEhDBpwNYNc03vPScZcU7qrEhzhXJOyb24ArXuAseTqiZ8jJuaN4j1uxlIxQH29HwLnrbFn6g4DmkdNlltke3q7/HrNfS/pFbAGhni+zYw64Ht7X/QzNnnZ7AU+rWQ/liYatPTEDrszlvi5yAAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4lC3ZUq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e104196e6eso1349734b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707923253; x=1708528053; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgCqwyxBYe6OEJ7wvcZM34kxVFlLGGF6Aosa4uTV3Vs=;
        b=N4lC3ZUqAR69FSGJ85gDxoee4qlYAMhtczlhu5f9xgFlTvGZRxIquhespZuHezl6tD
         WnXSCEUulLo4v3K4OLl2PHQCGmlcH22X7A179ygiP3a6myfdoTKOY0dIDtuLc452K6l1
         zvCUXkHNChAhlCpDqotWT3ofDsVb9qDe4A6I8r+oMhXDpW0RR9s2y26VgA4uWJtDAXqR
         VUwj/KfmpMByGc4pDLM2R36xNIoYUuwWVkwtCcH6e4915V7foxP59EgAm3/4A6WVLQOs
         nTuyUN8kdI+6pommg135PwQMmsJsDPxxeapcIvBFRMtQ6n3Gl8No3BdkOPJw/Rv11HUb
         nGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923253; x=1708528053;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgCqwyxBYe6OEJ7wvcZM34kxVFlLGGF6Aosa4uTV3Vs=;
        b=LA4OGhE5qXJqEaG671bMTxi7oxBLscoTkMhbhMydZZtH1ppN6vx8tnT0sActtYVku7
         DhQIM2+HWnUzTxxJmRiVq/Hg4Nnzz7sDZnPMNfyvQxLwLwQfUdSt3PH57crrHA3LSPuP
         C5bu4dtl7MkK7eOq4HaX3Qc7zD08ylGHOFJvvGxGYdijXHc0PUifkgADcoaKqYxuwTnP
         BJhdkD7AlDkWe/zZf+sHvQWPRpU69pytKdk71ZRmV+RodHHXTLPM8ESsS1OclcL4R4dr
         4LKQCfl3M4BO0ddx5QB7OPnvV3i4Yzz5LG3rp7cJLatkFbLvZ/kkLtc+Pa4p4+wEbZN9
         tv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGn75Yt8tWYIJoWyAk+kiELN1Wjzs9AzC2bAmNGkGUe6MEXVygOtRZrb5nOSOP5mggMKfS48JZ2PcBlSpLW6jHv2mVwDSDln/P
X-Gm-Message-State: AOJu0YwuyIEEJNRjXVfUw7qKBJSI/MMt+8/YVA/S+qOQ9kPk9ghpDqdP
	S2N17NN3UD2bkZRKfRn1m4QLwfpEWfRtamKXqKWtqpETvwdyNSLc
X-Google-Smtp-Source: AGHT+IG262f3ZoO89wGAUYP7RPrsvl6xS4jqQvJ4z6R85dbQafM3G4AKOOUxsztO3ZgCnZTc57qYEw==
X-Received: by 2002:a05:6a20:86a3:b0:19e:aaec:833a with SMTP id k35-20020a056a2086a300b0019eaaec833amr2185139pze.55.1707923253073;
        Wed, 14 Feb 2024 07:07:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaVDoz991svGbLG/bUqjD+5K8sBr2BjcKsO3EimAwtk8E7LjprnkZcV7YMEG4nv6Twf7sQ/K7MTZtUjo/4+Bu87qkBXef+gUsjkRr6u77EzQUttjh7QDR59TVcnf/ZGzEbGlp7H9NjUQuFIumZHzut5sLm/rEHaZ++zkLvZgRPWfuwk5fEjF0xu2HaLh4dTOywra5fbrexJ8kgJbPSyg21f4iVfwlN5JREpKme6hJ+cabUHbUCX+81jG7a3C529HBEHM4oQK8fJS6LIBtJ3IjbQN+OBrElD4284M8hyBxWV7FE+i5uM/G/jexm
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id z29-20020a637e1d000000b005d8be4c125csm4384050pgc.80.2024.02.14.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:07:32 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v2 1/2] iio: accel: bmc150: Duplicate ACPI entries
Date: Wed, 14 Feb 2024 07:07:31 -0800
Message-ID: <5773370.DvuYhMxLoT@nobara-ally-pc>
In-Reply-To:
 <CAHp75VdyQxpy5wT=X+0TKnd5x4uJzqcSJikHs2Mx-VOEzbnv9g@mail.gmail.com>
References:
 <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <20240213223806.27056-1-jlobue10@gmail.com>
 <CAHp75VdyQxpy5wT=X+0TKnd5x4uJzqcSJikHs2Mx-VOEzbnv9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6036601.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6036601.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: bmc150: Duplicate ACPI entries
Date: Wed, 14 Feb 2024 07:07:31 -0800
Message-ID: <5773370.DvuYhMxLoT@nobara-ally-pc>
MIME-Version: 1.0

On Wednesday, February 14, 2024 1:35:56 AM PST Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 12:38=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.c=
om> wrote:
> >
> > This patch adds a description of the duplicate ACPI identifier issue
> > between devices using bmc150 and bmi323.
>=20
> With the remarks below,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> (carry the tag if you send a new version)
>=20
> ...

Will do.

> > Comment describing the duplicate ACPI identifier issue has been added
> > before the "BOSC0200" entry here.
>=20
> Hmm...

You asked for a changelog after the cutter, although it really seems
unnecessary to me here as it's repetitive in nature with comment above.

> > +/*
> > + * The "BOSC0200" ACPI identifier used here in the bmc150 driver is not
>=20
> s/ACPI//
> s/in the bmc150 driver//
>=20

So update the first sentence in the comment to be:

The "BOSC0200" identifier used here is not...
?

> > + * unique to devices using bmc150. The same "BOSC0200" identifier is f=
ound
> > + * in the ACPI tables of the ASUS ROG ALLY and Ayaneo AIR Plus which b=
oth
> > + * use a Bosch BMI323 chip. This creates a conflict with duplicate ACPI
> > + * identifiers which multiple drivers want to use. Fortunately, when t=
he
> > + * bmc150 driver starts to load on the ASUS ROG ALLY, the chip id check
> > + * portion fails (correctly) and a dmesg output similar to this:
> > + * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
> > + * This allows the bmi323 driver to take over for ASUS ROG ALLY.
> > + */
> > +
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] =3D {
>=20
> ...it should be here. But don't resend, let's Jonathan to decide in
> case he won't amend this when applying.
>=20
> >         {"BOSC0200"},

This seems to be a stylistic preference on whether or not to include this
long comment inside of the ACPI match table or not. Stylistically, my
preference would be to include it directly above the match table and not
inside of it. I will wait for Jonathan Cameron's comments about what to do
here.

Best Regards,
Jon LoBue

--nextPart6036601.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXM1zMACgkQ4obKiQwb
1x0ccAgArv3qWkWt6UH5uifiZtCLza91N4WMXFpI8nRo4Fra0QbXUC1G+AXoXEXw
cd4tSDQWwG8ZEjYHvC29+bHEI7xHkbC+e24+2CtW+1mcp49tnpvyA91IYcDL8gq9
oYodN5UI09Qz80EmMuJoMm9gTmwtkADWsLM9C4SY51KGhoFKS+bhDMX0GY0ysSxE
Lzjj2VTNN5b+EGyCnLQKNbOmKaS95i6dSTFyfIJMk222rDSIlCaqPSiGg/wrmYlX
pbL8CqacIi7t7N1ZwDSFpYzwyXe5547YrA77MrichtQOii/Wb6q/y9X+kEa/YnzW
lrezQHzW/5Iyg97cSC193wgWw2E8Mg==
=fSFP
-----END PGP SIGNATURE-----

--nextPart6036601.lOV4Wx5bFT--





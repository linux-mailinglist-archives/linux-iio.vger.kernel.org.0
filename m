Return-Path: <linux-iio+bounces-2553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF45854D19
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE891C21E8A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17B5D49E;
	Wed, 14 Feb 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFV+jlNV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF4524D2
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925233; cv=none; b=PouuTK/szjz5Xr6mmY+JQm4ZqFPMb5LMSr4t/1YwqlyA0/Ovl38kfETcV2CLXGyExsWKxVo3zYnOP/9oltRp79o4hdsZaH7g/f5CxoDLG0Pm6GySnKVaSYhn+QxEFt5bLftmvXdKE4cSJSA4qs2XNWnjiA2xLXAKAcvvTmCKhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925233; c=relaxed/simple;
	bh=jQDUXQK7NPRc3i9OcZbpeNbfjzPHIR509SWZJu+p0ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT0GqmuvOkBAXhQhzVIzExcpEIHuP1lan5bCD9nBRgkstC7cPnUhYf7f2CuVPkDEurRZQfUkta75G4xpp1ID2Aigu/bf2ujV7LyTqWFcKswOgjJ5HCVaQPW2YXYzbPjN8gW5Zr/ntxK2lJk+lkI0cxhNaBgxFrdZ9acL/SGtMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFV+jlNV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d484a58f6so104549866b.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707925229; x=1708530029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2iuDChr47jJlJ4lNfkaPh0dfTbnZUl4fNmncYCJNHw=;
        b=FFV+jlNVp0ZWUB0eEKxkQsjPP1YDnMENFkhHyVHntXhV5uhkMVaWmd2/YfkTL5oSc8
         KnTeWZ2RCn0+vlnXOotInIuLqPrkLXDInzOTQiUYkMmRt3R3Xi+rbwsM55tzBrFENRER
         D2aq5QdTsX33ZgKy9icqbvHkM4O7IPYiFfbh9QIXOH3Q1O24cuTxO+GObl+wuggp+xRw
         Q2ufMeLaeaxjcXHn8HAUr0nGIiEVxEr+qyQ9hUmF+j4IYMu7cyUNrU8ZDefcfs3z1Zs5
         YJmEgRSHKkYqut5QWEUaT070VLeb38jvluNwD9H8m7x4eP9qMn5SS7Wnjs0AEHcnX0ao
         XBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925229; x=1708530029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2iuDChr47jJlJ4lNfkaPh0dfTbnZUl4fNmncYCJNHw=;
        b=s/97kD2Pz6O0MT5YKPT8jghm+Czeyx+DYZRlNYmajLfQPw6Cgt9CatBEG4Tg58snF1
         qaXDrOlh/2uFUA29BM4Qs+SWQc4nsKNxr8lkmBNKa9ItS/cDjc+IDM+VbNd0GLdTCC55
         oO37lnzhyRmXO6rc0i+vP4+nFmKR/aA+Y4xYf9uKoaHW0kvmEDzoU2ElNj81+bjU4N4F
         deu0K3CTGUlmyWBmtn5wQLelZyRvbrJ/WdjZUK2iVaaZ5izHJHEttr0MdRlArfXrBsi/
         WhqMD5NnzGkI9ejSrbE5LIE2CCyC0T/c+cbn1eTQI3z31sqVzzKMUEBl9Ihz76VYPmsQ
         wo6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw8GTOS7I4cR3+sh1Q0IsHQpkddh0DrQRwxH3p1rlhBiwVTXdlrjfV3nMxPJKBU/i09H1/lzRY+Gqu+XUjCUZdiTgcm9fo98KF
X-Gm-Message-State: AOJu0Yx5ksHzN/FTaOwafldlcYNZWpC1U0/VSNIG7JXI7bDTqUX/Gb9O
	uh8yr2vaQ8x9n8Tqsmh50NoNVDIRiQJBWGFygeZE6PEUx3y7SUYZWBcF5R2MWSqSiCZyFiWm1Mm
	yC9/tHbhEAl9N9zHBrhGIiciqrBY=
X-Google-Smtp-Source: AGHT+IFr+5eTbLXY6Pl9BKFC0BPF8Sstinir3h4tbZf3WHOtOEsoBZDeJN6YPVfnKPXWWh3YnSQYNqA7pzHgBo7fXBU=
X-Received: by 2002:a17:906:5596:b0:a38:7015:fc01 with SMTP id
 y22-20020a170906559600b00a387015fc01mr2060227ejp.2.1707925229170; Wed, 14 Feb
 2024 07:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <20240213223806.27056-1-jlobue10@gmail.com> <CAHp75VdyQxpy5wT=X+0TKnd5x4uJzqcSJikHs2Mx-VOEzbnv9g@mail.gmail.com>
 <5773370.DvuYhMxLoT@nobara-ally-pc>
In-Reply-To: <5773370.DvuYhMxLoT@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 17:39:53 +0200
Message-ID: <CAHp75Vf4kMPevMvdi8rApe9PEf2AdhCfTAdVW_6OCp_f3jSPGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: bmc150: Duplicate ACPI entries
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:07=E2=80=AFPM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
> On Wednesday, February 14, 2024 1:35:56 AM PST Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 12:38=E2=80=AFAM Jonathan LoBue <jlobue10@gmail=
.com> wrote:

...

> > > Comment describing the duplicate ACPI identifier issue has been added
> > > before the "BOSC0200" entry here.
> >
> > Hmm...
>
> You asked for a changelog after the cutter, although it really seems
> unnecessary to me here as it's repetitive in nature with comment above.

This is fine and needed. My comment was about the actual placement of
the comment (should be immediately before the ID entry and not
detached from it.

...

> > > + * The "BOSC0200" ACPI identifier used here in the bmc150 driver is =
not
> >
> > s/ACPI//
> > s/in the bmc150 driver//
> >
>
> So update the first sentence in the comment to be:
>
> The "BOSC0200" identifier used here is not...
> ?

Yes.

> > > + * unique to devices using bmc150. The same "BOSC0200" identifier is=
 found
> > > + * in the ACPI tables of the ASUS ROG ALLY and Ayaneo AIR Plus which=
 both
> > > + * use a Bosch BMI323 chip. This creates a conflict with duplicate A=
CPI
> > > + * identifiers which multiple drivers want to use. Fortunately, when=
 the
> > > + * bmc150 driver starts to load on the ASUS ROG ALLY, the chip id ch=
eck
> > > + * portion fails (correctly) and a dmesg output similar to this:
> > > + * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
> > > + * This allows the bmi323 driver to take over for ASUS ROG ALLY.

...

> > >  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] =3D =
{
> >
> > ...it should be here. But don't resend, let's Jonathan to decide in
> > case he won't amend this when applying.
> >
> > >         {"BOSC0200"},
>
> This seems to be a stylistic preference on whether or not to include this
> long comment inside of the ACPI match table or not. Stylistically, my
> preference would be to include it directly above the match table and not
> inside of it. I will wait for Jonathan Cameron's comments about what to d=
o
> here.

In my p.o.v. it's not stylic as we refer to the exact ID and having
comment detached is, besides being unusual, may go outdated too
quickly as code is being grown and developed. So, I really want it to
be closer to the ID entry.

--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-iio+bounces-23423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B3B3C7EC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 06:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51011C254B5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 04:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BEB276050;
	Sat, 30 Aug 2025 04:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw5BH9fV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FD42049;
	Sat, 30 Aug 2025 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528688; cv=none; b=Cax6bY8tJZge4hmxRT8jmBw9+l02zobn8JtI0fJGbXBM9pPF/iMgxZJJ2u3ByJbCNfLBqfoN5UvgVHDMLzvpZiOMDykbeRVHah9nsAdIeFEFPI1tdK1zY1VZkJeV3t0nDFXQf4o/SxhxWApqxFuxV2dcAHCeqfzce+VC8YlqPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528688; c=relaxed/simple;
	bh=Fg1XXRJfbl1l37kH/YMOXuLyqrJ1TGAsZzOqunGv2Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCjTMTrGS1+qgWMX0BnpQ8p31sIUJY2KfUQ/9IYWw74avNZx+AoBTbodxgPGvU+XUWpFlyer8Gk/y9Kh7H8ixVK07nzg9Mgz3BzcipE9X64GWD4Q5og1vp9hdmarNpIOtTODfPReDDJIwPY+fCpZkzsrwfQCg9nagL88L5MzQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw5BH9fV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afec56519c8so465281366b.2;
        Fri, 29 Aug 2025 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756528684; x=1757133484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHncOGfoYp51fcEegAzjH4ijPtOyZmnx03RBNti0bPg=;
        b=Qw5BH9fVklTYkdgrRjy6jL1aK4+g0SNO9PC8tQu7xN+rC96lcIibXTGeZB+eFclUH3
         oMa90I5Bt+Y6/1bSEZq9ePaC/g30CJEHWQ1TIxrEQaN3v1O9u+IqDHfCx9UmMCes/zN+
         37ro0abs6PupHKs76O6/hCYDfcJdLj3UkjJU65Rma4fVUH+n/bgtwDV2k8gan01MBU3O
         NlbOGBKSyjMwLLxFaIW/sWMMVQhrpzTXCsRYALnZi4k45q51OsLoqbTZ1E+UGJ7pRfcv
         lh/paWZ+u5+mo4iTkCD7D6tfXuyeo1qiPvwkiqpErpRIpjqElC88DwE0WEekvLtRAccU
         NmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756528684; x=1757133484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHncOGfoYp51fcEegAzjH4ijPtOyZmnx03RBNti0bPg=;
        b=J6Vp9LLa08W/K5G+FC2uIwMRyAXA08X2/psEnQ+vbTzySxzNG0xSgqlvU+VE+PuV4I
         tJKp7pd+QCJGp1mLlBrMcEMwt7RqBmxkMEJaKsWBdRhSDyF3Q6D3808KoKwkSpOU2iwg
         Th7dCdo0o3feBBN5Z5kk09lsawPxrtJzNJTj2Kz62+nYTP4ijq1D1CMXxH3QOJMCIPNv
         UsKAdymck9F4CGG1IP/Z5j0ZrMeBseZOJnlPuUySvuFMB2dCcdkzHbVLKpdfbJZCCJYL
         tJQaWn8UZAwN1ypOoDTKbe95eldA5xKBXNsyIkefRnfCh7oubJCtDKur9ESrK/qXy7py
         7Tkg==
X-Forwarded-Encrypted: i=1; AJvYcCUuWU29KugOWiRC5/SJKDTrP3TjXUVZIhMvjpDtGerz47SWRM3law525KAFsfTcu6T57JxXqR/Tm4T/zCfu@vger.kernel.org, AJvYcCVRyY1SxkJ2zafs1B0KYH9oimoxmgU9U6G6Auzj6q/RozKl8FGPqvPj+2K7jRk0yUNjoRZH8wH+tQAKstQ=@vger.kernel.org, AJvYcCVebE8BHI3CIGkCjjpdNodgziXEC8ZZ0QNo+vn0mFxUEbzO9NeR+AdvWAN26vLKlsZBlCzJOnOQdSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6Aef6ekZAgabvD/8bjAl8muAOQNdyHeKtmGitLsB9cjbp3Mr
	OdGW4vFrpOebjKXXpBUDvoxtt/enp0KZssknKluIFIo4Xm3QPuHvMYfHEVvDfbhR6MqK3afw+wx
	ztkDp2l8vGikphw7RxocvANM3PZIyJHE=
X-Gm-Gg: ASbGnctSBmp71eLIIR2geCqa0td1TWHWrAfmSqDXht2bMJALFs6mcJAaT95I2IysdrP
	65p0BeQCt3sk/jXJsFRVEDnRNb+owErYsTv9LOO/vXKoVb0iO69y8FutyauCYsvTd53Gn3WtPcr
	Rl7DAHusmyfezZ6LSb3hQmEa8rQHSV/8tQhQW8hSPM+3I26+xH5NfDmRDerKoBDiOHH5xGIHcgP
	kw1tHFuhO0aZX15gA==
X-Google-Smtp-Source: AGHT+IFIxPV3XHMI1B+KQRgPWec6qgPzuoKMj57cqmdE5/UIcQ42YrOS78E0bhtCdRVRHoo7R+1xrr3RlFcSix1Rwe8=
X-Received: by 2002:a17:906:9fc6:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-b01f20c2808mr74433366b.56.1756528683773; Fri, 29 Aug 2025
 21:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz> <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
In-Reply-To: <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 07:37:27 +0300
X-Gm-Features: Ac12FXxI4Ad7UEZ5m_Rq5R88CJhV7qFlTNI40RdEocvqaV6YPiPKw6vP0NWO2Y0
Message-ID: <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:

...

> > +#include <linux/device.h>

See below about kernel.h, TL;DR: with device.h check carefully that
you are really using it and not something from linux/device/* and/or
linux/dev_printk.h.

> > +#include <linux/i2c.h>
> > +#include <linux/iio/driver.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/kernel.h>
>
> We usually try to avoid including kernel.h because it includes too much.
> There are some recent-ish messages on the iio mailing list discussing
> include-what-you-use with some tips on how to pick the headers that are
> actually being used for inclusion.

+100

In new code no driver should use kernel.h. Use proper headers from day 1.

> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/mfd/88pm886.h>
>
> Odd to have this one not grouped with the rest.

Actually it's fine, as it is almost private to this driver, but for
the sake of consistency I would also like to see the linux/iio/* be
grouped.

...

> > +     u8 buf[2];

Can't we use proper type, i.e. __be16 here?

...

> > +     ret =3D regmap_bulk_read(*map, regs[chan], buf, 2);

sizeof()

> > +

Redundant blank line.

> > +     if (ret)
> > +             return ret;
> > +
> > +     val =3D ((buf[0] & 0xff) << 4) | (buf[1] & 0xf);
> > +     val &=3D 0xfff;
>
> This line seems reduandant as mask was already applied in previous line.

With the previous suggestions this will be as simple as

be16_to_cpu() >> 4 no masks needed at all!

...

> > +     if (adcnum < 0 || adcnum > 3)
> > +             return -EINVAL;

in_range()

...

> > +     for (int i =3D 0; i < 16; i++) {

Why signed? What is the magic value here?

> > +             ret =3D regmap_update_bits(*map, reg, 0xf, i);

GENMASK() or even better to have a definitive constant.

> > +             if (ret)
> > +                     return ret;

...

> > +     raw =3D gpadc_get_raw(iio, chan->channel);
> > +     if (raw < 0) {
> > +             ret =3D raw;
> > +             goto out;
> > +     }

Instead just assign to ret and if okay, reassign to raw.

...

> > +     const u8 config[] =3D {0xff, 0xfd, 0x1};
>
> IIRC, IIO subsystem prefers spaces around the braces.
>
>                         { 0xff, 0xfd, 0x1 };

Also make them fixed width, i.e. 0x01

> Also, could use some macros to explain what these values are.

...

> > +     /* Enable/disable the ADC block */
> > +     ret =3D regmap_assign_bits(map, PM886_REG_GPADC_CONFIG6, BIT(0), =
enable);
> > +     if (ret || !enable)
> > +             return ret;

It's implicit that when "!enable" we return 0, this should be written
explicitly because it's a special case.

...

> > +     iio->dev.parent =3D dev;

> > +     iio->dev.of_node =3D parent->of_node;

It's incomplete and IIO already does it for you. IIRC the parent is
set also, but please double check that.

...

> > +     devm_pm_runtime_enable(dev);

Why use devm if not checking for the returned code?

...

> > +config 88PM886_GPADC
> > +     tristate "Marvell 88PM886 GPADC driver"
> > +     depends on MFD_88PM886_PMIC
> > +     default y

Really? Why tristate then?
I would expect default MFD_88PM886_PMIC instead,

> > +     help
> > +       Say Y here to enable support for the GPADC (General Purpose ADC=
)
> > +       found on the Marvell 88PM886 PMIC. The GPADC measures various
> > +       internal voltages and temperatures, including (but not limited =
to)
> > +       system, battery and USB.

Please, add a line about the module name if one chooses 'm'. Or see
above =E2=80=94 drop the "tristate" and explain why this driver may not be =
a
module in the commit message.

--=20
With Best Regards,
Andy Shevchenko


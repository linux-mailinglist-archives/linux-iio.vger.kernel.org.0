Return-Path: <linux-iio+bounces-22163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB840B16EF3
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D687B48CE
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E924293F;
	Thu, 31 Jul 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6H1Zc5F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA2EAF6;
	Thu, 31 Jul 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955232; cv=none; b=YKUkUjz3yFf+VJHEpJAIT3/vxazKR5kAyRBoMgWMbl0Lscz4EiUHz925xPCEckPkNwKLCKX1BpN/+MembnxWsdHWu9HUlShoCFFVNySrBqMHPlz5EYxmwBP3h8XYore/3qRtv7H6aN9SjPgO6noNSDbSnubKZMpjjWpc06vth2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955232; c=relaxed/simple;
	bh=R+1bOSzZEqjFRCaNxT2wWiERvGTBCi+5k0ZAbCRUBUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1VqSSj06/9E3FBd3+f0rzbPrbH+j4v3R+bTN7331zBsyU/cjQrgQGgaHHHPuqSMDZbUxaR4SRYeih3QKq924ZAGe/DeBG0GeE4Lq5UvwZ5DOTpydy1/duUVMYN8zzSJkYVuG+ITH5HUZvIvv/nvfqZQrAnKOdry8ynGWq7QCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6H1Zc5F; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af8ffa04463so128846566b.2;
        Thu, 31 Jul 2025 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753955229; x=1754560029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8kXnSi2qDjtJhPZO3//zalJFhKJqhERDRrBw8g/t2Q=;
        b=C6H1Zc5Fd8buGagEwEOb8XF7E2FHFQ48AkzVtcUnafQCf0jjsbY67MartWTy52fg+t
         +/HfzDgzlkvBe0iaUKgNNLJFZgaSxZZo7lqcZToEjC3tWGP2nUiOvCWPInstyrKXwsDT
         ibQ4SA+UmRqxTH48MLsWVUETq7uPz9D6Xvy24WgbP5XW7VEqD4IZlDelf7bcPioG1RWA
         P47/zBLGCwQXRssYwgv5Ubmc59u1vt2meX59HpENTS3HMBpWv1ovodE1eWBnW4lZJz9w
         hx7JBMeghaFeSbyW9yo0QBjAGaZnBpsdHnJssGCKaMm7DP9YcWcgFCw/e1QBPJg3ks4V
         V7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753955229; x=1754560029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8kXnSi2qDjtJhPZO3//zalJFhKJqhERDRrBw8g/t2Q=;
        b=RjcrPCIdMiHRdKIOMr8bDvqIrBISpQaHJuUlV1YRCTSYawPfbpUFM+ncXPfm5E6/gg
         RjmJu9qtl87yqpWIgCGsfk3gf4H7tTC56Lfbk35baAM3aYVvxpLdc1tu2/nTkVBS2deQ
         Sujzq5JMIGEHn/WhH7h5bTcOwQkmccSs7JcTd90eygvCyiS6Tfata7Wh1z+jUKTW2eZI
         pgU6oVgqpVhTlNKan9wC1XHNjP7luOz5V4w37OWxQEkjz9qxwSzn1O3HRm40MwLraYZU
         eoRJ91CEeV+/kjxdrfQPp805qnFzbTrw9voJMwW7DYzJGbBHhSW6d1CMo+Mbquv8fvJP
         QRbg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2NjeURraGgeSWllQ8M5LBYlaKvBlVxOA7utc1ZAqjfXMoxEAf+osfneWmsiq1B2xTNKVxChMYeA=@vger.kernel.org, AJvYcCWVDtYw0cuJNjCf0EaXYX4gr/v3s25v7I2ctyBjgmyTB4gZzkqcJJN5qK96xi6W6qnc/hvmjEEBd8sj8tfg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eaFFM/Mhv41IRl/8V/m5pO9/cKBy/LDV4ZPoI26QT+LlS0+6
	xFm4e3O1ho/AmyJHm+eAg2ecBKnyE1c4+eWH2FUGFQrHRQMbYCiSpwjaBdw3rceVrAjLkeNQMG0
	cUIUsI9yzSiAh5wlOYMkmwMGgh5OBcjQ=
X-Gm-Gg: ASbGncseZtoz355olgqChO82N16K2Ox/6vk4x5NbMDBR4oybZNUXtoCoSWOWyHtsNbJ
	3QthZpCeJ9MSF54ZQ8E/9x2nMqXGIZuCwaWUtdfRWx2BBeJVZ5302fYNUwDbSDwgsT9mTSbFaXp
	F/2qvD1qXn/7CFaQDAt8sAuqVVPD7S+eS8bTqJCx4Nei6pGpaLlLqI7SLznNESSY3t8p2tzUhhP
	AlaLzoflQ==
X-Google-Smtp-Source: AGHT+IGd53bTbRTN2ktOmG30+LUtJwMrDXeN2lT3oxeRZupwIyA9V2Vf0XZ7qlLMiLHm8VHmYyIvDkxm5Pt+Dxhwk3s=
X-Received: by 2002:a17:906:7951:b0:ae0:b49d:9cd with SMTP id
 a640c23a62f3a-af8fda128f6mr783942666b.58.1753955228206; Thu, 31 Jul 2025
 02:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
 <CAHp75Vc2K3AmPhwme3+7cCGwDTA6V+4Ug8f++iFr8gCThCOnQw@mail.gmail.com> <8C57A7CCEBFAEA59+b36cfd0d-2cd9-413e-b658-e82938f9d947@uniontech.com>
In-Reply-To: <8C57A7CCEBFAEA59+b36cfd0d-2cd9-413e-b658-e82938f9d947@uniontech.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 Jul 2025 11:46:30 +0200
X-Gm-Features: Ac12FXx5V893iJMc7AvTeeQ6CM-nzlKlyoj-bP22QpfuRTUdxPh0XqJuY983hHU
Message-ID: <CAHp75Vcr2nVHAgvegW=t70bBFhhk3w23HkT_Y+MZM00nkziZSQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD firmware
To: Cryolitia PukNgae <liziyao@uniontech.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>, 
	Jun Zhan <zhanjun@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:06=E2=80=AFAM Cryolitia PukNgae <liziyao@uniontec=
h.com> wrote:

First of all, please do not top-post!

> Thank you for your reply. I apologize for the confusion regarding the
> PNP VID assignment - you are absolutely correct that "BMI0260" is not an
> official Bosch PNP ID. Let me provide a more detailed context.
>
> GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
> When they switched to BMI260 sensors in newer hardware, they reused the
> existing Windows driver which accepts both "BMI0160" and "BMI0260" IDs.

This part is missing in the commit message.
But the question is how many DSDTs we know that are using it?
I have checked

- https://www.catalog.update.microsoft.com/Search.aspx?q=3Dbosch%20BMI0260
  (no results)

- duckduckgo.com gives many links, one of which is interesting, i.e.
  https://treexy.com/products/driver-fusion/database/sensors/bosch/accelero=
meter/
  that gives the list of the IDs in I assume Bosch issued drivers.

Can you find the link to the official Bosch sensor driver for this
family of sensors with the ID list provided (line on that link I
found)?
This may give us a reference and actually make it more clear in the
future (also this makes an evidence for these IDs to be
official which I was asking for during review of
https://lore.kernel.org/lkml/20241020220011.212395-1-justin@justinweiss.com=
/.

> Consequently, they kept "BMI0160" in DSDT tables for new BMI260 devices,
> causing driver mismatches in Linux.

No doubts.

> Current Situation:
>    1. GPD updated BIOS v0.40+ for newer devices to report "BMI0260" for
> BMI260 sensors to avoid loading bmi160 driver on Linux. While this isn't
> Bosch's VID:
>    2. Bosch's official Windows driver uses "BMI0260" as a compatible ID

Yeah, please provide a link.

>    3. The ID "BMI0160" already exists in mainline (drivers/iio/imu/bmi160=
)

Yes, I know, and that is a problem, but we can't solve it as that boat
already sailed.

>    4. We're seeing real devices shipping with "BMI0260" in DSDT

Can you list them in the commit message?

> Given the challenges we've faced in communicating with GPD regarding
> Linux support, it seems unlikely that we can push for another change;
> they are solely focused on ensuring compatibility with Bosch's official
> Windows driver. Unfortunately, I do not have the means to contact Bosch
> and urge them to abandon the use of these non-standard IDs.
>
> Given existing devices use "BMI0260" and Windows drivers validate this
> ID pattern, I propose temporarily adding it to bmi270_acpi_match as a
> compatibility measure. This would immediately benefit already existing
> users.

Right, but the problem with the fake IDs that already existed in the
devices on the market is the justification when adding them to Linux.
I also request to have a communication between vendors of the device
(HW) and platform that uses that HW with a fake (wrong) ID to make it
clear that this is a clear abuse of the ACPI specification. And next
time they should be aware of this.

> I'm happy to provide DSDT excerpts from GPD Win Max 2 2023 devices
> showing the "BMI0260" declaration if needed.

Yes, this is a must (but not limited to, see above what else is required).

> Thank you for your time and guidance.

> =E5=9C=A8 2025/7/31 04:57, Andy Shevchenko =E5=86=99=E9=81=93:
> > On Wed, Jul 30, 2025 at 2:56=E2=80=AFPM Cryolitia PukNgae via B4 Relay
> > <devnull+liziyao.uniontech.com@kernel.org> wrote:
> >>
> >> From: Cryolitia PukNgae <liziyao@uniontech.com>
> >>
> >> Some GPD devices ship a buggy firmware that describes on-device BMI260
> >> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> >> let's match the correct ID to detect the device. The buggy ID "BMI0160=
"
> >> is kept as well to maintain compatibility with older firmwares.
> >
> > No, it's not true. See below why,
> >
> >> ---
> >> Some GPD devices ship a buggy firmware that describes on-device BMI260
> >> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
> >> let's match the correct ID to detect the device. The buggy ID "BMI0160=
"
> >> is kept as well to maintain compatibility with older firmwares.
> >>
> >> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0=
.41.zip
> >>
> >> [1]. See the update nodes in the archive file above
> >
> > Yeah... I think you need one more attempt to fix it right.

It looks like BOSC0260 is also listed in the driver. Why can't you use that=
 one?

...

> >>   static const struct acpi_device_id bmi270_acpi_match[] =3D {
> >>          /* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
> >>          { "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> >
> > Unbelievable! How is the above supposed to work? Do we have DMI quirks
> > in both drivers (bmi160 and bmi270)?
> >
> >> +       /* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
> >> +       { "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
> >
> > For the record this is incorrect ACPI ID, nor PNP ID for Bosh, unless
> > I missed that https://www.bensonmedical.com/ is bought by Bosh or part
> > of the groups of the companies.,
> >
> >>          { }
> >>   };
> >
> > Can you work with Bosh to resolve this as soon as possible and use a
> > real Bosh ACPI ID (BOSCxxxx) or PNP ID (BSGxxxx)?
> > Also, each ACPI ID adding patch (when it's incorrect) must provide a
> > DSDT excerpt in the commit message to show this. Ideally this also
> > should be confirmed by the vendor of the device (GPD) that the ID is
> > incorrect and a correct one needs to be used.


--=20
With Best Regards,
Andy Shevchenko


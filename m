Return-Path: <linux-iio+bounces-15452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8DCA32BE7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE82188AB49
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F76253352;
	Wed, 12 Feb 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPqvZ4iR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D831E7C19;
	Wed, 12 Feb 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378213; cv=none; b=jTzKeCFRRjVNjngE+8bkVjQ1xG6QUWSXgvK/gAun4T5QrCt6hlkB44Dt2t/AozbrVwdnVKByyTjdptsndvP0kxTezxTBMzF0VBCeVX8JKFkSUaShZzKJzvLy23cVs6NOBZWNGKm4uLuGoF/QoQvWPGidq6doL85GZ91fjnx9n6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378213; c=relaxed/simple;
	bh=XjXapKCS9DhbpWnAR+2WMTVHpJk/hxkglVsqF28WSAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XM7fL2qWG4DHGMBMYsojoSPzdDxi/r6pZC6xkYtcWPXTjhf2GMps1NVDsm1Ou7PjUWGkX0SXZsySvAaB9BVIbZ/5YxY66gR6L+40H/EEPqgrzMHjqbDcc6bmm5wTFbUB5FX4xEjnl++uw7ui4dGpzugJqWPEXRyUrxlclZPTTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPqvZ4iR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so2984196f8f.2;
        Wed, 12 Feb 2025 08:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739378210; x=1739983010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTlFMZehIqXgecWOhPXG5xGdb+Nga31tOiqshQdfZVw=;
        b=IPqvZ4iRivsEbfYl/jYKvv51xN4710sERjvDHWJ0HBbbfGlIoqNtrxFnWYzjZ8fLzI
         jo/lzx/D+yZzzJop61G5BHGHseQayp4Cb06/e7jTU4DuTwcRi6VnrImhr7qRAEyQ4M9Q
         agbrI1+BvvZvR5mEOsdW5FC03VZDen4KrBWUTt8q8hcXo1t2RWnXJCQN0O6B+4/oLJFF
         CA+uTM+rtnY2hC7yuNPd/hR7Or26xIZCU3XB01tayVoQTITgSlqYXAqzlSsgigyDlW6T
         Iayq7w3eR8ESIdOPTX/gWgQN3XhWwSEgtwJJ1mnEaSIsVNCUTE0AEsKSpY8zhVUvTMlo
         Li0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378210; x=1739983010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTlFMZehIqXgecWOhPXG5xGdb+Nga31tOiqshQdfZVw=;
        b=knZT20gjGGwfap0VuqBqaet2d3e4SdD4R6zza9JbjBV3pYUd5QR+IeWvC/T4gY4iIP
         4FjK7fscWKpHj2SYJm1ABWFEfQ3qxPAEHzZPMTOo2/nINSV9yl54MCFvJy/3ytXpD2vR
         RrxCLBjXQXr4Pb3afnfeX9KEmZ4fIj0/l0ZnPgvmKO446Ostu0rox4tbGr3NAdsTmRKs
         v6jXHQ5xjaPVZrBnPxw7OufXL34iIqi3B38qbagnrajwh7QglkAXESjxxjXP8wA0bsf/
         Ahw18pWcqmnJCrruDu6c2d18AyDLfFsjyil7cUUDyHJxhsaGFKWyE+i/2to2/WVp9E6A
         dYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfDHYrZPY1jLvpfVIz70xYHVJVDGGf0hWWkiUM3WMxBbPPUgxrKe8u8fHiiSRPezabzSwuvIccaog9@vger.kernel.org, AJvYcCV1PQOf8suIPSNRMlmMVpGvScmhVKc72EOMwDtokcEkriTQy58fERIizYv/rr80afMQPbmVXE9D9IskMlc=@vger.kernel.org, AJvYcCV6nur+PVbC4f87ygEqUrBiBIQx3JAlBMijGO+TNZz5fMQL/Htah3D5m8Z5CWyCnXg2yYl1vrnoceQ8MekB@vger.kernel.org, AJvYcCVCH4gKZHuF7crjv7ZwTq7u8FfyhmkuCs72EPnMy0T/4q8tfyVZhqKV3Np+N+J5vgl47aHuOF99VPxZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7FyeeaUhM3OJb2vnwaoUDCmQGQHjVCvh/8XdI0FHAjpPVDCb
	1DiigfrbRJf0gOMU8h182zrJKYdhvcDfPz3x62CFBSEgZ/g+T9lYqf+9wtOnGwxeBk1edHuzzMS
	tHGSFt7CJXCsv6GvAjc+lfsepy0eMpg==
X-Gm-Gg: ASbGncuUTbdKbehEFl/SMdEuorrrWtKGPBOv2hbeJevFAZRjq2GI47dzlmG7ZNF8567
	E+l1XzlD4ophdM7YAoGgLlBDiLoXgdtnUwF0BI0idbi+scwUzxdm46bIT4Zu+C/i/+XJtDjGwTg
	==
X-Google-Smtp-Source: AGHT+IGQEufUpjj5ULRRznk/c/Wl4Rh7ecaawR42k5U/cp7XNdZFM1/A3Qh3udeid87272JmNlRqh9HTrm+ZJzgtFRA=
X-Received: by 2002:a5d:6382:0:b0:38d:d18e:8811 with SMTP id
 ffacd0b85a97d-38f244e960amr27142f8f.25.1739378209380; Wed, 12 Feb 2025
 08:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064657.5683-1-clamor95@gmail.com> <20250212064657.5683-3-clamor95@gmail.com>
 <Z6ywGgofzU1bvm0H@smile.fi.intel.com> <CAPVz0n1UuZPCb3Jdj_fK3Ut7WKBgtvj7aROqJ4YeYVMutuyv7A@mail.gmail.com>
 <Z6zIAGLot3YQLo9S@smile.fi.intel.com>
In-Reply-To: <Z6zIAGLot3YQLo9S@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Feb 2025 18:36:37 +0200
X-Gm-Features: AWEUYZnbM7zgO_XJOjqXMrt1Da05HvGz34TRc0lHrZw-1LWDZ1rEM1N2DbfBwYY
Message-ID: <CAPVz0n1Mf02GvSBd_TOuNiuCVTTOx4-228qkdf-JL_eqGCh2MA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] iio: light: Add support for AL3000a illuminance sensor
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Emil Gedenryd <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, 
	Mudit Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 18:10 Andy=
 Shevchenko
<andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 05:20:04PM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:28 =
Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Wed, Feb 12, 2025 at 08:46:56AM +0200, Svyatoslav Ryhel wrote:
>
> ...
>
> > > > +/*
> > > > + * AL3000a - Dyna Image Ambient Light Sensor
> > > > + */
> > >
> > > Can be on a single line.
> >
> > Patch checking script did not catch this as warning or style issue. If
> > such commenting is discouraged than please add this to patch checking
> > script. Comments are stripped on compilation anyway, they do not
> > affect size.
>
> First of all, it uses verb 'can' for a reason (it's not anyhow big deal).
> Second, not all stuff should be documented or scripted, we called it
> a "common sense". The common sense rule in the code is: "Do not introduce
> lines that are not needed or do not add a value". I see these 3 LoCs can
> be replaced without any downsides to 1 LoC and make it even more readable=
,
> less consumable of the resources, and more informative as opening the
> first page in the editor will give me more code than mostly unrelated
> comments.
>
> ...
>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/module.h>
> > >
> > > > +#include <linux/of.h>
> > >
> > > No of*.h in the new code, please.
> > >
> > > > +#include <linux/regulator/consumer.h>
> > >
> > > Too small headers to be included. You use much more.
> >
> > Is there a check which determines the amount of headers I must include
> > and which headers are mandatory to be included and which are forbidden
> > to inclusion. Maybe at least a list? Thanks
>
> No check, there is IWYU principle.
>
> https://include-what-you-use.org/
>
> The tool is not (yet?) suitable for the Linux kernel project and Jonathan=
,
> who is the maintainer of IIO code, had even tried it for real some time a=
go.
>

So it is not adopted by the Linux kernel. Lets return to this once it
will be adopted.

> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/iio/sysfs.h>
>
> ...
>
> > > > +static const u32 lux_table[64] =3D {
> > >
> > > I think you don't need 64 to be there, but okay, I understand the int=
ention.
> > >
> > > > +     1, 1, 1, 2, 2, 2, 3, 4, 4, 5, 6, 7, 9, 11, 13, 16,
> > >
> > > For the better readability and maintenance put pow-of-2 amount of val=
ues per
> > > line, like 8, and add the respective comment:
> > >
> > >         1, 1, 1, 2, 2, 2, 3, 4,                                 /*  0=
 -  7 */
> > >         4, 5, 6, 7, 9, 11, 13, 16,                              /*  8=
 - 15 */
> > >
> > > > +     19, 22, 27, 32, 39, 46, 56, 67, 80, 96, 116, 139,
> > > > +     167, 200, 240, 289, 347, 416, 499, 600, 720, 864,
> > > > +     1037, 1245, 1495, 1795, 2155, 2587, 3105, 3728, 4475,
> > > > +     5373, 6450, 7743, 9296, 11160, 13397, 16084, 19309,
> > > > +     23180, 27828, 33408, 40107, 48148, 57803, 69393,
> > > > +     83306, 100000
> > >
> > > Leave trailing comma, it's not a terminated list generally speaking
> > > (in the future it might grow).
> >
> > No, this list will not grow since the bit field seems to be 0x3f
> > (datasheet is not available, code is adaptation of downstream driver).
>
> You never know. Sometimes driver is getting reused to support other compa=
tible
> HW. Telling you from the experience.
>
> > > > +};
>
> ...
>
> > > > +     ret =3D i2c_smbus_write_byte_data(data->client, AL3000A_REG_S=
YSTEM, val);
> > >
> > > Why not using regmap I=E6=B6=8E APIs?
> >
> > This adaptation was written quite a long time ago, patch check did not
> > complained about using of i2c smbus. Is use of regmap mandatory now?
> > Is it somewhere specified? Thanks
>
> It adds a value to the code (in particular debugfs for free and
> many nice helper APIs). It's recommended and many maintainers would like
> to have it. It's rare that some of the generic framework or library commi=
tted
> into the kernel just left to become rotten there.
>
> > I am not a full time linux contributor and may not be familiar with
> > the recent rules.
>
> Many are not the rules so far, but recommendations and/or preferences by
> certain maintainer(s).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


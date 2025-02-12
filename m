Return-Path: <linux-iio+bounces-15454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF35A32D78
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7338D162FBE
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35252580EF;
	Wed, 12 Feb 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLAqTWMf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056972135A1;
	Wed, 12 Feb 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381296; cv=none; b=ih2arZebqZj9QCOcWxuHJJcnp/FpjGEq15IZkK4Yh7j2EYX5+iz7kHV3L13EQAbB74SDg3X299m/1T2cdQd9CDG87XhlJNoF4lSywzn+xHIUHJjTw5iaPtEkdS7ssG7WCC/sIgDviLmuhoJS7XuFhazXFwomXGLxgPAIw3KrVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381296; c=relaxed/simple;
	bh=y402Yi8SlQ7bGjb7YK7/fHgP8dhEV3YupmxX00SBe0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1YZDifdFY6yrN+5k0PJ6/OmudzmJgeFE1JJTMSuywa+Zfh+rHjBZeFcK73La6A2XLU5c21JQLjr7thy7oSRYPCtgV8+Uu8PYzWjMeUhuaappupyi2NtXbfq29Bf8Mq2ruKY72P37UNUvwTgsWRMQh+vQkLwj1jc8UzTyRN4CQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLAqTWMf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcae0d6dcso3305530f8f.1;
        Wed, 12 Feb 2025 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381293; x=1739986093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH75rro3+C3cMLVqxRXiovHK/yvOZnOVe7YXKDBOPmc=;
        b=NLAqTWMfpoAzJb+sP/p9O08mhUpdcA/fkapQMefIfG4PtKHL5jlYshVjnLbOtAKXP+
         +MSvyIp1ojs6786uuroK9w/cWO8wYPlP/ngH/PCTasZwZTJVwtxAQVTCkrfp3CsxRkOE
         w9Mck2sUB3upcZgWYF+NnU1Xiwd9x+57tpTYzalXpkiKKBMFYCv17xSnB2uv2ryxO4sg
         zV3I0IimZCNPX3EFMtkrG/g55ArocYScxv885M6IOimcQJ4ozC84HurRsadoTeumdbdr
         jIfLt3XP5zgXTMe6cQazPOilZSjmqT1pZY4KEBuj2nUQpGCO/sPp60XU/l6TSPegBqpn
         aMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381293; x=1739986093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH75rro3+C3cMLVqxRXiovHK/yvOZnOVe7YXKDBOPmc=;
        b=He8JecktzLxmqDijjOTkex/PKrTheSlxVLDOvwHkS67/ZA41fWNDPWkzVQioyFJDXz
         OioZtZ/5e76wQ3DoZVUO1GwpoJChjUTalfIc5UZjnS+LgOb2aU1UlAKDow0AKQlG9kzI
         T0sm2zaZlIqBx7hzIVp9ee4MLauDiVDmtdllVKovIoocwUv0GCrfE2FODiijuRNNyDY7
         gia+1t5qQl02WsT6R480Wq6iuVr+NPf+JS9kbCc8ZKm/XncmfsCTV5Vz/Y6NeSebOj0c
         n2s4uLYWre+7jgnRNdJAX79ElakD0E3GLm7Pxyh/e44jicNK22MGEE6tqdRo55p6gSHd
         ZNxg==
X-Forwarded-Encrypted: i=1; AJvYcCVgveNgVpiFcPBJNzVyxnl6uAiYZ+F9W0L4CnpR2PXPtKaC8+1OgEv8WPlDyz2TvJGNjmHYztRC6DVb+pA=@vger.kernel.org, AJvYcCVu3gHf/H0F8u+JVWcSOYNsUuSNDr4higjhFAXIQabGXzr+2Z3eT6+7ETRPkOfLLckbs7yTVPjdau/VQyrb@vger.kernel.org, AJvYcCWWqUZQsLqi73gmXgBBxL4xZQVHiD6Qqpq3EtZ9OoG5TeyVvX98ADmrW0wZiT5Scoz67JKoyK6SJZ5a@vger.kernel.org, AJvYcCXIqYQENwuMO5UHXhvwZ7ALgh5DkRiHCKW5+tZl9eryIYgHdC9bapNnfFnFZq7qiBbuOzGlfQkNCbJc@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4Y5/3qBUxzmwduOaoWqJAOuJx2bywwVuhXz91xz2Dql0YrqW
	jrcirOnUOTOdQjfOP9cRBcyZMAwjUyN+fCgjXLG2XzMRn8stCgnvW2FZfZSFZavurVPOsyszPFt
	jsuh1Q/6+UL6JyEs2A63A0On6ypvG4g==
X-Gm-Gg: ASbGnct4zmIPenhT2BfAfsr+NL1t27JQ0P5I0AAvyOBeKEA9R/Ewid9AmfUBmP8tIu8
	aemgmr1ENS7yKoeBB2iw5E7lEZbnGLFaRFO0YnoMEkuHYvmGmpY2oRv4GLuiBBedaSoQlSGM3Rg
	==
X-Google-Smtp-Source: AGHT+IFHGp2VcddJyJd0r3Yjkkf4R+8u+ifNxosxw3I+t06VNCVxc0BSZYOBbdWlqlQrvmWVh0BuxAawy0AYWiecw+E=
X-Received: by 2002:a5d:59ab:0:b0:38c:5d42:1516 with SMTP id
 ffacd0b85a97d-38dea2e9023mr3528978f8f.34.1739381293078; Wed, 12 Feb 2025
 09:28:13 -0800 (PST)
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
Date: Wed, 12 Feb 2025 19:28:01 +0200
X-Gm-Features: AWEUYZmbKhIPHc15NWh3JjbFH7JV2WWJgN4WfsaqJ90DpyIvebOO039oY67e30k
Message-ID: <CAPVz0n0YFXUugt1E5siZSYbCBcp6LdNv136eTWGQTbLAXE4pxQ@mail.gmail.com>
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

I will apply all your suggestions. Thank you.

Regards other patch series, may you please contain all advice inside
patch series since it is quite hard to track between them. For future
patches, I will try to avoid listed issues. Thank you.


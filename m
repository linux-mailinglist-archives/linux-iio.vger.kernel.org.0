Return-Path: <linux-iio+bounces-20984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F4AEA8E6
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 23:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45BB3BD890
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733625E839;
	Thu, 26 Jun 2025 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtWbIZdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBC25E477;
	Thu, 26 Jun 2025 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973645; cv=none; b=Mg3KQ5i4iqlmPW1sa7PTjtqnmiQw+twUqP1bPf0gFZ6hR3XajitpIlhyHiwMjLFfz3hz5x9Hv6lqI4I37nq7j6Dw1uXQv/G13TJVI6mAQQZMsWLFFcxVBInvpupBx4Dta//LoBZ7E1N0uN8cBLESobn0h69JnI+VhiflXj4vfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973645; c=relaxed/simple;
	bh=UqwVh0VzHPjDoOcfLqeUhiCeDs12oOBqFDk7yOKVZ+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBUU25AcQrCPZlgvM2B7novq9DE3gv4sdWqkcVtQXcxElFbzBYA4FVuJCpALcyxAavZ/8RMzW/RDSP9k5hM38O2nM7Gyed0oeJAm4rWVc5VgFiewl/RKAq/yqzAOFkvvNFZTyIpncDrPzfCQNtUfQFNjhPLSOdKSRwWQtgmYaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtWbIZdl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7111c6b0f1dso1968547b3.1;
        Thu, 26 Jun 2025 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973643; x=1751578443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quWoYzJCcSriVdkCnPfzLQECG4bIA9g0dURyf59YLC8=;
        b=gtWbIZdl96Ec3Lr7FlAHDSOvbUxTRCbB/Zpyz7X990Qy8J+TGWKzWnABMR3YpDV3qh
         Xvab0UUFYl3Z82tRBUEhR4HtQ1p7N6ThMYMiubZZD+wRt+P5Rtcr+4hyL/aTAYYzFyPN
         pdLSoDonuIG9Y5Z6sGG1ueGl5FqWXamnUHSEeJrYXHmWP73EiOhNh155BOSIROs0r53n
         Xa9KElFCXk0RBaXJrmJPz5wFOeMXQfLV1cfN+KUaEkCv3NIgeQ33WE/3DYmgxddgRw1J
         ed8peRh4h8MFS6cWqOyv2Keow7NDBekmjY0vibEtxWgCQ5A8DijXDoAU55Yp+w2TZnWo
         gE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973643; x=1751578443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quWoYzJCcSriVdkCnPfzLQECG4bIA9g0dURyf59YLC8=;
        b=c/hw4vve5XUrdeLzCEq8UjIWgpsz4dztLEDpg9p+6YI+huT2qJ8Cxf/EE3BAnU20Qv
         gYJYalCFQUEsPoqSiDUjRga55E0FiP949fqJ8jRVCXw6xFfyBDE5vL/OawKlthFNlrjM
         AOEcXOQzwp6sT9eegY8ICKotz0hajm2vryORi4UQ+wMyDZSZ+XBu+P1/PKCfZsdKAi7H
         rWqQlIPNBe5coJdeeX4viPtXBsopUUruS5T80vHmrEj9y7UUgRdiOypoQO3VDH+lMo8D
         RKa+WeD3SqwVV52/4dLqvoswZ7Evn8Xz1Zr8Emopd7esQr3S4mUmG6lkphJiTMggXsaV
         RGeA==
X-Forwarded-Encrypted: i=1; AJvYcCUqxtI6wMosHQ58jvxs/IMPopxaOfQ2h2Ti8u29sRhRdylDO34KvkruRZIVXmbv3sWWb3PqVwJcc3SZtzo6@vger.kernel.org, AJvYcCVAWOakg8OsdObNGzjdbR3HAYYVWugXgEzJABZzOJBUQDMnxbxUuOIuYbYHcb/QBwQfRnjA5hPr5dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYxaOwK/Ga9+pEmAARmZSf4teTIbMlxCMYQ6ndk2LB5M/8uzn
	WGZjBeh/HGzVuJOPs4p2wvES7xS2xMJ9ri/CzimDQASwnj23gMtXSH7tMWrB/CSBd2alJD7rrEU
	vS91aWkZxOCm31C6Ik1+B8GmkNXSu8nY=
X-Gm-Gg: ASbGncumXMz5MXluUIzasLz1QcxrQlRkwx8z3fJ929PjyKMZTjFsm7v308n/N3s39nH
	s9TqZmGWTJyvf5rbOMZLu5Q9pn+W1clzwrH09d0Bq7t0ZE185CVxXFG3lMgzWiWyfaVkX7jmsJN
	YLc6LgQJcPsO8pdWl5t9BSFc8r44AlDpr1anx7Fe2z4kw=
X-Google-Smtp-Source: AGHT+IFEOnHnywGMqHgq36/2c4omUJAsLuMvqZI+biAtd0YlYQ4nHxtzi0X0hTJhHdAL1m0L+TSQM99Rp3RMHXeWIpc=
X-Received: by 2002:a05:690c:5506:10b0:70f:9fcd:2eb8 with SMTP id
 00721157ae682-71517150767mr4449327b3.1.1750973643064; Thu, 26 Jun 2025
 14:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625170218.545654-1-l.rubusch@gmail.com> <20250625170218.545654-2-l.rubusch@gmail.com>
 <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com> <20250626192802.0079d579@jic23-huawei>
In-Reply-To: <20250626192802.0079d579@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 26 Jun 2025 23:33:25 +0200
X-Gm-Features: Ac12FXxUxKxWoNM9LYSC-0yDaqFLVCO8AQYpvZo-XuCNf2T_QtZ61Qn_mKaSh7E
Message-ID: <CAFXKEHZ8zDEXLT57BD5Dg1mTN-Gj0Z7uhxX5Xx=XH0wFeAhe6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for adc121s021
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sukrut Bellary <sbellary@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

I absolutely agree and won't send further versions of this.

Hi Sukrut, if you find some possibility to use it, great. If not, nevermind=
.

Thank you all, for the feedback. One small question below.

On Thu, Jun 26, 2025 at 8:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 26 Jun 2025 08:24:41 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> > Hi Lothar,
> >
> > On 25/06/2025 20:02, Lothar Rubusch wrote:
> > > Add support for the single channel variant(s) of this ADC.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> >
> > Thanks for this addition. In principle, this looks good to me but I am
> > afraid there is another colliding series being worked on:
> >
> > https://lore.kernel.org/all/20250614091504.575685-3-sbellary@baylibre.c=
om/
> >
> > Maybe you can align the effort with Sukrut?
> +CC Sukrut.
>

Hi Matti,

Perhaps just one little question here to you. You used the regulator
name "vdd" where others
before used "vref". At the end, this seems to be pretty free,
depending on how it is set in the
DT or how you name it in the DT (in my case it was "5v0", but I wanted
to keep the convention,
if so).

So, my question is, is there a naming convention what to take for a,
say, default
regulator naming or fixed 5V regulator?

Best,
L



> >
> > What I specifically like (and think is the right thing to do) in
> > Sukrut's series is replacing the 'adc122s021_channels' -array with
> > individual structures. In my opinion the array is just unnecessary
> > complexity and individual structures are simpler.
> >
> > Other than that, this looks good to me.
>
>
> Sukrut, perhaps you could add this to the end of your series, rebased
> to those changes?  Would save a synchronization step for your v5 (and
> later if needed)
>
> No problem if not, but I agree with Matti that we should take your
> series first.
>
> Jonathan
>
>
> >
> > Yours,
> >       -- Matti
> >
> >
> > > ---
> > >   drivers/iio/adc/ti-adc128s052.c | 17 ++++++++++++++++-
> > >   1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc=
128s052.c
> > > index 1b46a8155803..cf271c39e663 100644
> > > --- a/drivers/iio/adc/ti-adc128s052.c
> > > +++ b/drivers/iio/adc/ti-adc128s052.c
> > > @@ -7,6 +7,7 @@
> > >    * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> > >    * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
> > >    * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> > > + * https://www.ti.com/lit/ds/symlink/adc121s021.pdf
> > >    */
> > >
> > >   #include <linux/cleanup.h>
> > > @@ -110,6 +111,10 @@ static const struct iio_chan_spec adc128s052_cha=
nnels[] =3D {
> > >     ADC128_VOLTAGE_CHANNEL(7),
> > >   };
> > >
> > > +static const struct iio_chan_spec adc121s021_channels[] =3D {
> > > +   ADC128_VOLTAGE_CHANNEL(0),
> > > +};
> > > +
> > >   static const struct iio_chan_spec adc122s021_channels[] =3D {
> > >     ADC128_VOLTAGE_CHANNEL(0),
> > >     ADC128_VOLTAGE_CHANNEL(1),
> > > @@ -143,6 +148,10 @@ static const struct adc128_configuration adc128_=
config[] =3D {
> > >             .refname =3D "vdd",
> > >             .other_regulators =3D &bd79104_regulators,
> > >             .num_other_regulators =3D 1,
> > > +   }, {
> > > +           .channels =3D adc121s021_channels,
> > > +           .num_channels =3D ARRAY_SIZE(adc121s021_channels),
> > > +           .refname =3D "vref",
> > >     },
> > >   };
> >
> > I'd love seeing this array split to individual structs.
> >
> > >
> > > @@ -207,7 +216,10 @@ static const struct of_device_id adc128_of_match=
[] =3D {
> > >     { .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
> > >     { .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
> > >     { .compatible =3D "rohm,bd79104", .data =3D &adc128_config[3] },
> > > -   { }
> > > +   { .compatible =3D "ti,adc121s021", .data =3D &adc128_config[4] },
> > > +   { .compatible =3D "ti,adc121s051", .data =3D &adc128_config[4] },
> > > +   { .compatible =3D "ti,adc121s101", .data =3D &adc128_config[4] },
> > > +   { },
> > >   };
> > >   MODULE_DEVICE_TABLE(of, adc128_of_match);
> > >
> > > @@ -220,6 +232,9 @@ static const struct spi_device_id adc128_id[] =3D=
 {
> > >     { "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> > >     { "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> > >     { "bd79104", (kernel_ulong_t)&adc128_config[3] },
> > > +   { "adc121s021", (kernel_ulong_t)&adc128_config[4] },
> > > +   { "adc121s051", (kernel_ulong_t)&adc128_config[4] },
> > > +   { "adc121s101", (kernel_ulong_t)&adc128_config[4] },
> > >     { }
> > >   };
> > >   MODULE_DEVICE_TABLE(spi, adc128_id);
> >
>


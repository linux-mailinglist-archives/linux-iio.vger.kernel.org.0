Return-Path: <linux-iio+bounces-20749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA2ADDD18
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC64917FF69
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B572255F49;
	Tue, 17 Jun 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM3t6xvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D112EFD8B;
	Tue, 17 Jun 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191493; cv=none; b=dMbD4CR80Sdzmonu148flBnrx5D8pKnK9F9Qa4IriD0Jhn1H/RylsLpZ9VFMX7VpR2Rhru9bRmUvj6IxHSYtZWNZZnOTDKxLoQfJ7eR4k527ikdI2qZKMxOT1s9EXqiUkmnsx5c/H95RMW0j6LRY8CYogY/Z1X2u46rtz2WWf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191493; c=relaxed/simple;
	bh=RJIt7WG3ZOspYYOWIJrtVuyWqj0nYr2+lVhghRFpqv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhKzuwZsej1xyS3TB5aPUr+txxPyCsi0PgvyIAXzRpEFz2t/3MVInNMben9+Cn8OdTYaCfHqtBpnA72+hbSm2E0UYxYZcoc0z5o2993062iL850xWL9+dXoAxcIOd68fUSxe0PqC54TGoikRH3vroC/JnqSG14MqvsSDB8zovSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM3t6xvU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade326e366dso1142484866b.3;
        Tue, 17 Jun 2025 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750191490; x=1750796290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEc/jInWS+mlsww8d0uzb6CYVItqWJXY/C/BRjHunTg=;
        b=WM3t6xvUfzKAoYdpuCJcfdLMAv0p/rzDC6SQxxJwK21VJvMNN0iDtMceBfCJlFm8IT
         kIjTI9Ab1B0Tf7yHgu9PQ7KblJMHVyUCHYp5RlACgvW5FDf6io4jM65cE06Lcn7Nf2Id
         ZO3uwIuuFXCbBHdUQJXZtw1XMHQpHgfZQSZzmWLoc9Rs6lWWwgKvcSAeQ5GsbAn/IlF8
         cJFtThzJ/AWmCwXHAGZqHZLws6RN9tcQdZaRmedf279DiTSUlc2SkvpKnFDF4cx4STnr
         Hlf8NCNVVEOQgyampj+Er8hjpe6rvDgPyiRcqZR117Bh7YaETkgfE1zpmXjXq3CoL9T2
         YgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750191490; x=1750796290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEc/jInWS+mlsww8d0uzb6CYVItqWJXY/C/BRjHunTg=;
        b=wqHxqH+lPcziGTiRfcuyJENgf2VWP3mRpG+EbDwwQObY2xeP+IZvcS0zYtPS/M5rCf
         V6i51os32cCgUvINC5h+qSnoAU0PjdP4OK3vCqcQaswxCwueoBcYOxDW597H6WWML4iC
         5KaS8Zo4yxPGBj5O4S12lHzwLisXBVxrvRxN4bgXRvYIvFGNfsecp/7vc7ZHBHyFEMsd
         kg/4u1CAYFMhVY9efXbH2YlXJFSEjOqowboOsjgViscYPbaw/rY6HxPMFM0pOlx5dCu8
         mRxu1PjXWktPo0z+NoP4li9hQ91WqbWusTEdrOFFZCLlnFn9w30cDMsO6ymonxynRegn
         tBXw==
X-Forwarded-Encrypted: i=1; AJvYcCUHS7E+R7hLxkXnCB+tMEkAGQJp+t/lxAgfT84jqvoL1jNNlFal8i+cF7zowfbqIlU2gC0MSTK8p/L0@vger.kernel.org, AJvYcCUfWTN7cBPYHZh/e6A+uV2u0U8PdEHCknDS8RvI3DFuE9Zr+lnz/Ky5xmFzo+C32n/LswjJv98X6fYe7dqm@vger.kernel.org, AJvYcCUnhruW7/HiyPFw61HG53qgSn6y2m+3lrfGL23YF67JzT2yweLGjFYC2u1WbGDkzC/6iIEN92oU1/UW@vger.kernel.org, AJvYcCXiQWULmldA5DkTxdTf5NoxcMxCC1bL3Cm2zlJMNMbLw3/nrd91Kru6HqREhLDqaNd9MM+1toIIa0nuYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bEFJK4NmMamuE9NFzlrEkOH1iv88/jHPfZ3TLtlWEMAM9T5j
	Wi/Yx/XPwADEXwTd4jfHedVn3Wq6rR6qYOP/Z4Lb52c0qXlvUOsThQpqVUfOH+unryOOC0fwezq
	doBQZePju61JodWlErpbZhPS6Zg/NJn8=
X-Gm-Gg: ASbGnct1Npzg8Y2r/NaVK0Z2UY7oHzKilHuE9rqmBTeCpx3Io8F+IKRFNOCuP9u6VSL
	CPYfu2Ev+mYiHbQJR4QqOoToO10MkjLFs+3hTdGiatp5JGkAGx3ov2UW5SVyfEUFRWHRtzBUDrd
	QGvXBghrAUzR069hVeDdZqEDMPSCTUrWQnAYP4MUN5HQY=
X-Google-Smtp-Source: AGHT+IHuE9uZYXvE62BT8AzKQX2dvWzPPjvjArHXMBOp8AoBNetWawpRg+mvV3w+Xv170qTJ70H8PEeuQAdbkXf8YGE=
X-Received: by 2002:a17:906:c154:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-adfad415a59mr1502949666b.29.1750191489371; Tue, 17 Jun 2025
 13:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
 <804d66f1858014d7278aec3344d81c223661e878.1749569957.git.Jonathan.Santos@analog.com>
 <aEwd4cS7j0Vvypg8@smile.fi.intel.com> <aFGVAWi7CZAy0E8k@JSANTO12-L01.ad.analog.com>
In-Reply-To: <aFGVAWi7CZAy0E8k@JSANTO12-L01.ad.analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jun 2025 23:17:32 +0300
X-Gm-Features: AX0GCFs2EpzDynFpo556EMhMcho2_InQYRdVfK7jhsS64P9QV5UZ6zxcfifMGOU
Message-ID: <CAHp75VdbizxgF1U-LmEp-aTdWpZ5jAqvubk_7QH+RFLMrnRotQ@mail.gmail.com>
Subject: Re: [PATCH v11 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
To: aEwd4cS7j0Vvypg8@smile.fi.intel.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 7:17=E2=80=AFPM Jonathan Santos <jonath4nns@gmail.c=
om> wrote:
> On 06/13, Andy Shevchenko wrote:
> > On Wed, Jun 11, 2025 at 08:52:03AM -0300, Jonathan Santos wrote:
> > > Ad7768-1 has a different -3db frequency multiplier depending on
> > > the filter type configured. The cutoff frequency also varies accordin=
g
> > > to the current ODR.
> > >
> > > Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> > > the user which bandwidth is being allowed depending on the filter
> > > configurations.
> >
> > > +/* -3dB cutoff frequency multipliers (relative to ODR) for each filt=
er type. */
> > > +static const int ad7768_filter_3db_odr_multiplier[] =3D {
> > > +   [AD7768_FILTER_SINC5] =3D 204,            /* 0.204 */
> > > +   [AD7768_FILTER_SINC3] =3D 262,            /* 0.2617 */
> > > +   [AD7768_FILTER_SINC3_REJ60] =3D 262,      /* 0.2617 */
> > > +   [AD7768_FILTER_WIDEBAND] =3D 433,         /* 0.433 */
> >
> > Just to be sure, is it 0.433 or 0.4333(3) actually? Sometimes datasheet=
s have
> > rounding that even may lead to problems (see TSC issues for some of the=
 Intel
> > CPUs in the past). That's behind my question.
>
> Every reference I have specifies it as 0.433, so I believe that is it.

Yeah, I see now. The base is 0.10825, which is multiplied by 4 in this case=
.

> > > +};

--=20
With Best Regards,
Andy Shevchenko


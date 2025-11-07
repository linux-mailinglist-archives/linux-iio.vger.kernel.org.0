Return-Path: <linux-iio+bounces-26022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76617C40954
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07101A42A83
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5C2E975A;
	Fri,  7 Nov 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpAAEzE6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403D329C46
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529329; cv=none; b=aRTgvFUoRWEx8+JE+YVI64cjoAd0pGdhdaceMvMi+RsmhWYtc4yeMEIJIv3ZvgyzENJ8ESx34cqFx6WUf0yvn+m+fFyzvhNs5PdqQtsRrYVVcynm1lZ7XrBZtAV4K+IWhfMcE6G1dY5K7BaEBzsUPc9heMk6sV7VSdHxtH6ZWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529329; c=relaxed/simple;
	bh=on+0lfNYd2qRQ5EohElifDfUVwjZgh8Fp9lemjJw8Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvs50QOmuqPeOO9coT4nTkRbTDCEzLzHT3dUHa8QP0uoBH70RBWtuLn9yQdO0+Y0q1krkE2z8NLvruGhXB8wWGPUBjzmIGGzNnm9Z3/l1t3/d7lk6IAWB4ea5GosgOq0NaePeXWWPAzXli1sg9ttowOpppHw1henFTFvOwlFMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpAAEzE6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1145287a12.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529326; x=1763134126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om+pxjglHnG3GE2SnITLVrnlYEBEuJnFX0jyMAWe+ik=;
        b=bpAAEzE6qugsHG/BSG5H8YDNfQdbVpYCURVVZFBpr0zX+VRrgykhf4a/mNpFwXdRKO
         YJh93b4TumbET357txnsS8CfJ0JjnbG3XpAaQiJ5FDjmS8WE/Z1IcK42FX1dPtwVpw3K
         g1vQrcNgge8sXiaYzION+suRV8WKwuWpkOwiH2FJ1P3FxyQ4zC7EAeN2zKgWj9hyOj0N
         UF0IXTL6UKB/JO3nQuN91wTsXXnwnrGQ/Er5WdXCXy/C3ZBuW69xeGvJz3NVyYQ+fRQ0
         LxFDU27vEbjDGgzK8RIJX14OPWEabCSlcWXvRlRdvhhrtyJBccJZLhBG+TSeCcXWj+vR
         NtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529326; x=1763134126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=om+pxjglHnG3GE2SnITLVrnlYEBEuJnFX0jyMAWe+ik=;
        b=SXNf1tAK9dI9gkzah3Q9vYA3ILUYzFFLch71j3OUrcDUuLQCxKVYqq71Mu65DFVZSJ
         6Z5Pky3yIpSmTo03/u9QSIK2+kw4RgipgIDtD1dIfoFmxIIu5yQ0VoRJTg9SFkhOS6sJ
         L4l+9PuM0cBUIjN8c9ww/bL+JdVQadqkWPYp7HcewarrMixzvuLYYP3iCSm2ruqX+9Il
         rpFZJCz8d2nRKCAxjbs4fW/fp66QDl6SO0p0IASJEjFkt0CR6W/DJzkhD4HGwvpoxwSh
         wToK2mUi0mWozFpPJ6nWu70JXuDozLPooKZz8HehbU0EciXlGXfTPHSzQQ8oxWiLP7/f
         iAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqxs476vYwszaIcIgI8Cq/hhRfyBy3g1c7E7hLHwYglBMWqXMKWKi3IVUyA/JC7Owe+6y9ZPecdwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iE16Ym5oMyuCuwsuCgKUoRajBL/5y7LNzAMgHHLTuF3fEhLy
	mrzpdYtTr2szCYEVE8th0ai4cxkHvYYivH8WPyekq0fMyPewY8axdHPsbj8LhhyoB+bPo5CQhI0
	q3iHWcRoWkRAWK0rb4egP8Fc/hE6YZ+o=
X-Gm-Gg: ASbGnct5zUF1KLxM4ZoXv6E82Jz6rIgCu+pM62LjxYe6UMLSKn0MON9uTyilkvRIB0P
	iuYrHDMT4ZZfeP39RorcAIvNP3s8togPX5E6rHfb2KB7Pe8FOM9Fhv1wNG9yYhe0N6Kfrsz+8Wq
	Q8uTFEKqBc3N4EGWf00KQb501af93tnYV/ihlC6baQotWHp+PqkIfTTjU7nkjRw9LN8nQ9HoHcw
	OLr/Txz8NyJqRsNxJnIWj9goay8CLdSooHmVGAedTb3Dk9d/2Iz2ziNMEV5cg==
X-Google-Smtp-Source: AGHT+IHmZEpx6M0+J5OC7HbsnR5hvwcdGVfSYgbkWyKHi0+xhyzqEEx/b9s9Gbx2PtIhusPWTRG7qVzmkQemfsoLTks=
X-Received: by 2002:a17:907:7ba9:b0:b6d:a7ad:2fda with SMTP id
 a640c23a62f3a-b72c093316fmr378400366b.12.1762529326176; Fri, 07 Nov 2025
 07:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-5-fd1feae0f65a@bootlin.com> <aQzpvR-030zgA82E@smile.fi.intel.com>
 <13882660.uLZWGnKmhe@fw-rgant>
In-Reply-To: <13882660.uLZWGnKmhe@fw-rgant>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Nov 2025 17:28:10 +0200
X-Gm-Features: AWmQ_bnZqZC5EGS_uMqpAyoFV3kaYI0hktuWm533W__Dt4Ccx-T9uGAY1_3i4NQ
Message-ID: <CAHp75VcxpoYOgMLOVZ6LvPNGrvws1vnL9gDPVuK=xJjLHsGJqw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] regulator: ltm8054: Support output current limit control
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:54=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> On Thursday, 6 November 2025 19:32:29 CET Andy Shevchenko wrote:
> > On Thu, Nov 06, 2025 at 03:11:50PM +0100, Romain Gantois wrote:

...

> > > +   ctl_dac =3D devm_iio_channel_get(&pdev->dev, "ctl");
> > > +   if (IS_ERR(ctl_dac)) {
> > >
> > > +           if (PTR_ERR(ctl_dac) =3D=3D -ENODEV)
> > > +                   return ERR_PTR(-EPROBE_DEFER);
> >
> > Hmm... Are you sure about this?
>
> The only case where I want to defer is if the IO channel hasn't been crea=
ted
> yet. From what I've read in iio_channel_get(), -ENODEV is returned specif=
ically
> in this case. For example in fwnode_iio_channel_get_by_name() you have:
>
> ```
> if (!IS_ERR(chan) || PTR_ERR(chan) !=3D -ENODEV)
>                 return chan;


Yes, but my point is that -ENODEV !=3D -EPROBE_DEFER.
The latter may create an unbound driver in some cases. This needs a
very good justification explaining the metamorphoses.

--=20
With Best Regards,
Andy Shevchenko


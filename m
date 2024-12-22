Return-Path: <linux-iio+bounces-13748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AB9FA695
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15A2165A1A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB018E054;
	Sun, 22 Dec 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqCSLxXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032F18C035;
	Sun, 22 Dec 2024 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734884010; cv=none; b=J4gB44v+OsVEFVLquL0XmwDal0TDekmKr0gyhYv6rp9396hobSadQVI8+dTolgdqIq6uMM1DfB3FrgcPWRDKRThfjT3eAqdEbn2JQRG6V6Lr+8YeG4ETmcMiCXh3s8JAYGBcto3Ststji/u5LlgzkYgmEvN0tK2mwCUGMoW5a78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734884010; c=relaxed/simple;
	bh=fGNF3uvic4Sy12GBLCskR/2pxZDaCdTVX4hyM91tjfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ZCvKS5DRrOP1kBOLXdjRcw8YaGeBFgwts1HsO6tK+YjS47D6gxzIoiZvwijlQ/Jr7KNigepUkJaKgTsM1qeKuCvikG4Ntur09rHpdd18R4lMio8xpsqEKAeG48lUrUBqlmiuvGIEs4UtImSQfbjgH4sH6ToH+2Y0SaTV6mYH6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqCSLxXj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so34302765e9.1;
        Sun, 22 Dec 2024 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734884007; x=1735488807; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgYCG06gfBaaRaukkJiE2QdE6+ayEzWoyPHHU6rD6Mg=;
        b=WqCSLxXjdwW/sw6oCO1kCrBw3i+wEoghsFFZd6Hku9EzfMbS/AjM5ewIfyDgRx2qTp
         Z6CYr8pPTlSEPNJPkKBZjllHbmp0PWiMvmuK65WOWNU6dGn1V0X0pyiqmn82UgvzgeUz
         BEA44y/7leZOvIuHYsyXA5srojaYpWDEvh4BkDf6WIxCsvhIEYSofZTrXtkMxqOVl6g9
         fIBamsOFG5+ta1MqwOdjk/E5r/+1xEbEpo6GSl/y/v3fYMmvgwW7UZo16eEGi/7ySaLe
         bo9OsVV/jGgCGJ0j9N1QM6b0AXxhdIioePTjlgRDApKOE5BU1gHN10dIL2N2aqxDgdF+
         JbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734884007; x=1735488807;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgYCG06gfBaaRaukkJiE2QdE6+ayEzWoyPHHU6rD6Mg=;
        b=I0Mz6jNP1ow6Aqf4TiTq0/sBUF/rNZZbCDWQGcbilJHhSsluR6ctRp9PbltjKycBif
         HGGoOCAXXWLCVbMk0lZXmWk4qYq4WeSyL0MLtums6Lxhi1EqMOtgpxZ5Z5ghp88Q0qVk
         fCmsdyCXN+JdMR5L+jVnskK5nl/WUFpcZXKP63oCmzekxF6PNFK18Z4loAp2XSeaLkvb
         HF86BaDKgtvB8WiyIPSq2JWqPl07Fv2N9P0rGVbEW9mtUJY0z5xZnqG5xi9hEjJgc/R2
         ZU5gDF9qJ42pcOyMncRKqSLYCyZejwa4arv7ZWp7TaP76qoiF7sjtJU+BGJ1QuQZFjrb
         3jow==
X-Forwarded-Encrypted: i=1; AJvYcCVtzJjJuIfKCUWMfkSDItxMU9BJmpLbwZpZyBLLP6w+crIgGYHnT3PY+UGpZ99vfsKIHujJOP2u5rcF3kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKl5GFbd0mO3vEVfhSJa4QUuYcMuSOQynH6dqcy/Ys+/+DQqr
	GfFT5cPvAlw3A9MRVRuxS7hjSECBUCDDPQmFtay2Ei24ycdPsnQS
X-Gm-Gg: ASbGnctKX6zfLAAzQ3mkGV5AoHLCu5uD3ZgjKYmKUQzsFCIMVXiYGtpzqfxgVeI9ZNB
	/xmpkquEKIcUNuTCEM+fzDi7ud28f1IgAX/S1/Rf7QG8D3hM0jgORgX+GdNQiJ5N+37NhiS8csC
	inOKuJnos6ncaEb1vlqgh4b4jDChMoJL0HvmIBIeLUlWP9tjINkvkkqw+WUObeViIVqynHQGn73
	d+DtXZvkKSinxUKqL1n3z89VzWbePquM6qEvEh8nYlWR3sTeLs3Capm68y0ZOG+Ly/1Jq2+gMaf
	SHal7voGg50jSJmFUdwwQOV06vIcH3fd/3f+9jLEQo/nMZp8MFrr/JZdKw2Hfu0VrZgHa4TtEc4
	=
X-Google-Smtp-Source: AGHT+IFvEiJcyu0vvQGdFwDNWiQpQ2DDVaoR795ah6h5iuwm7LrkpyrEtNi9gVdnZjFqWth/J268xA==
X-Received: by 2002:a05:600c:4fd4:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-43668b48084mr73028335e9.21.1734884006580;
        Sun, 22 Dec 2024 08:13:26 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-195b-09cc-ed70-10a8.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:195b:9cc:ed70:10a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847263sm9164621f8f.50.2024.12.22.08.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 08:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Dec 2024 17:13:24 +0100
Message-Id: <D6ID1X10HYA2.IEBHNZMD9D7Z@gmail.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/2] iio: veml3235: fix scale to conform to ABI
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
X-Mailer: aerc 0.18.2
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
 <20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
 <b4b8ab5e-7b94-4919-98a4-1525be903954@gmail.com>
In-Reply-To: <b4b8ab5e-7b94-4919-98a4-1525be903954@gmail.com>

On Sun Dec 22, 2024 at 2:43 PM CET, Matti Vaittinen wrote:
> On 20/12/2024 21:28, Javier Carrasco wrote:
> > The current scale is not ABI-compliant as it is just the sensor gain
> > instead of the value that acts as a multiplier to be applied to the raw
> > value (there is no offset).
> >
> > Use the iio-gts helpers to obtain the proper scale values according to
> > the gain and integration time to match the resolution tables from the
> > datasheet.
> >
> > Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
>
> ...
>
> > +static const struct iio_itime_sel_mul veml3235_it_sel[] =3D {
> > +	GAIN_SCALE_ITIME_US(50000, 0, 1),
> > +	GAIN_SCALE_ITIME_US(100000, 1, 2),
> > +	GAIN_SCALE_ITIME_US(200000, 2, 4),
> > +	GAIN_SCALE_ITIME_US(400000, 3, 8),
> > +	GAIN_SCALE_ITIME_US(800000, 4, 16),
> >   };
> >
> > -static const int veml3235_scale_vals[] =3D { 1, 2, 4, 8 };
> > +/*
> > + * The MSB (DG) doubles the value of the rest of the field, which lead=
s to
> > + * two possible combinations to obtain gain =3D 2 and gain =3D 4. The =
gain
> > + * handlding can be simplified by restricting DG =3D 1 to the only gai=
n that
> > + * really requires it, gain =3D 8. Note that "X10" is a reserved value=
.
>
> Just a question - do you ensure there is no "invalid" register values? I
> think Jonathan has prefered doing this by writing known initialization
> values at probe.
>
> I *think* the GTS should survive cases where multiple bit patterns can
> be used to represent same gain/time - but I don't remember this for sure.
>
> I didn't have the time to do a proper thorough review - sorry. Still,
> what I browsed quickly looked good :) Thanks!
>
> Yours,
> 	-- Matti

Hi Matti,

Thanks for your feedback. The initial value of this register is indeed
set during the initialization (default is gain =3D 1). That comment is
only to explain why some combinations are missing, and why only one bit
patter per combination is required. The user does not care which one is
used, and it should be transparent to them.

I just noticed that there is a small typo in that comment (handlding
instead of handling), and I will update it for v2 after I collect more
feedback.

Best regards,
Javier Carrasco


Return-Path: <linux-iio+bounces-4149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FD789BB70
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B9282C52
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E645951;
	Mon,  8 Apr 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaUh41qg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5C45949
	for <linux-iio@vger.kernel.org>; Mon,  8 Apr 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567791; cv=none; b=YdxVbsxS9NN98QHauqsllXshkZDu6VBjtICydFlyKwqOgy/7ba4KlfuOYr9T7apBPgq5XWFvEP5d+WZTLAu4qbLE1v4TospJkH/BCPJVl3am1mQdea/N0GYOd+y9Gm5mAmaaDM2zyZ606hATiDe+edT4k7Cf/RU0YIfBBlUMxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567791; c=relaxed/simple;
	bh=NvXZ5SqMunbWeUl+IjlpSroZKYqGGqxOAFIbWgln7FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7Zp2+xKqUaqlgfZ3t4XWNww2tnD5dOk0EfoQPJ5qlWqlBUxc3CDwhf7zKHfbr+Dm4UDmDA6VcGXOH7FwHpAgP0KL/QG1Sg8PVurEjYxLnnjI9uN6Uq44WW/4Xo8mcplaGzYlZ3RSd0F7Ar3lz3PNW75dnnu/FtSO1nAlUy1gUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gaUh41qg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso4809020276.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Apr 2024 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712567789; x=1713172589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJBnw6SnXk2xm5ArBKUoafMuV9uJdGeoN7rxwhA9aqs=;
        b=gaUh41qgyiz46YvoVTZRgcaN3+vGATDs2/MZwkdUerawS2kT3QNGsjDSoUNbjD8EDi
         ct2I7l7021iVCaKqM1g8ac4bUHrz2PYap9D3wihRe6FzArO3JTSQ9Y9Cd8G/YWCzhOck
         yYrcTIGyoE2PgMdceLktEpptnmT3h3GeuLEjRlbiTvAsx3mv2sus7F4H/OX1HFyNEKVP
         Jr6M9lzqsClvpSAbp501yVUWk0eUHRAFTS2X/NRe0hOimAzbUylG0NCBC0/JG4K38s43
         bhEflQMeoSCoNVHCvPBu4IlVCk+6WxDvOZrvoyjPtlYaE7Gr1Vstc74mRJwaZSp3lA3a
         nDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567789; x=1713172589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJBnw6SnXk2xm5ArBKUoafMuV9uJdGeoN7rxwhA9aqs=;
        b=WTL58kzlsD+T5gfAEZF6Do7AR7Y9jSPYKNsUA0WnB7yRV7xFYahsIIFVguS59k8rRp
         5MxSVexFyO3TG/tMLtvvjZ2GavaCCcOqFcEi/s6zcX/qylsG6rNFAseZi4YpZSGwKDxH
         0bOdFhh/yELpmwIy+D7AgEG+MXzOrOnnicjNqWytYyPlHTc8PWfilW2y+naKtKQ5Hiqy
         izcYVH+XOpNK0lqPMm8LtmHK6UulqdBCJvTWIOC3/2aiqwBuZ5iNhR87UJOub8ESzbog
         NMTeX2t+KNI02VJr1zrmPN5vz/wwT3zEHsGTSI7JMK+uL5zEfl7Y1LTMmciNUVVbhENd
         SjeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrNVLBC5ihnYhpzc8YUYKDc5CpmMs0ppch2sdDvHyMsHUWquOku2IF1WXp5ERAyy7PgrbbZMhLXLex5/bKprlXgKWmHox46ki4
X-Gm-Message-State: AOJu0YygzqwpTHRk0oylWskM1xTnBQ6LGSq3y33faXfIt7XmkmLLWGk1
	w0HvLFlnJ8XEmuQVv76OLaNU5rDbkdL+1sQdqDmxaMjgQ9uOJQ8Q3oab/mgH8G3qo03HGh+/Qj+
	wz3IQaAXFNqxd2/tGCow7GjXA0/GPo5oNIZuQ0Q==
X-Google-Smtp-Source: AGHT+IGdL4Ux0SJS5JlVjNFzFCdnfQTU4JkwnzUiXVz8g/hyzcft1OLsybZNI/mVoUqrU4BEgXth3AfOm4dMHQbj6h8=
X-Received: by 2002:a05:6902:1003:b0:dcf:c7ef:e4e0 with SMTP id
 w3-20020a056902100300b00dcfc7efe4e0mr7257732ybt.1.1712567788736; Mon, 08 Apr
 2024 02:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330190849.1321065-1-jic23@kernel.org> <20240330190849.1321065-2-jic23@kernel.org>
 <CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
 <20240405113622.00000896@Huawei.com> <20240406112744.64f53089@jic23-huawei>
In-Reply-To: <20240406112744.64f53089@jic23-huawei>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Apr 2024 11:16:17 +0200
Message-ID: <CACRpkdbJ372YEuGOQOFNA9r_Xnbh4SdUvRiX-ExF1mxhP9tAkw@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	Marius Cristea <marius.cristea@microchip.com>, Mihail Chindris <mihail.chindris@analog.com>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, Cosmin Tanislav <demonsingur@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 12:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Fri, 5 Apr 2024 11:36:22 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Thu, 4 Apr 2024 13:36:15 +0200
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote:
> > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > The dependencies on various ab8500 components prevent this driver
> > > > being useful but they don't seem to prevent it being built.
> > > > Improve build coverage by allowing COMPILE_TEST.
> > > >
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > ...but I think AB8500_CORE is a hard requirement because
> > > <linux/mfd/abx500.h> does not provide register accessor stubs?
> > >
> > hmm. I clearly didn't test enough.  Ah well, I'll drop this one.
> > > Yours,
> > > Linus Walleij
>
> Tested again, nope, AB8500_CORE isn't needed as far as I can tell.

Oh? Weird.

> What register accessor stubs were you referring to? There are some calls =
for debug dumps
> in that header, but those aren't used by the ADC driver.

<linux/mfd/abx500.h> has for example:
(...)
int abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
        u8 *value);
(...)

and the ADC driver has:

        /* Check if ADC is not busy, lock and proceed */
        do {
                ret =3D abx500_get_register_interruptible(gpadc->dev,
                        AB8500_GPADC, AB8500_GPADC_STAT_REG, &val);


$ git grep abx500_get_register_interruptible include/linux/
include/linux/mfd/abx500.h:int
abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,

No stubs! I think there is just some other Kconfig stuff bringing the
AB8500 MFD core into
the build at any attempt.

Yours,
Linus Walleij


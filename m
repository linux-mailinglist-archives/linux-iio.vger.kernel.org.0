Return-Path: <linux-iio+bounces-1813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2E835CB5
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 09:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EF7285E4D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA0210FE;
	Mon, 22 Jan 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAZc/2/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B749210E2;
	Mon, 22 Jan 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912412; cv=none; b=oqEJZPGw8lW5q9TheWEtjGe9yL9+IDR/mmKdwmQ1xehuS46z/Vy+vGGBZUbYux1zrqh3iIYI/Oac06xvCzd23916APwdu39to0B2sfrwetI263oe51xr10mue0nHzPPVv5ED0C3yi3XWjrVW0dpwpJfvrjgzThmzHpZwUMzyvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912412; c=relaxed/simple;
	bh=5vMVsAQT3mDbv9o8sONgo7NwofOoED4ewlmXRFBnTEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5MjM4FNIXoL30gPQgtr48BczBzxZ8QUdMfxAfazen1nChUoDMyT3PwlQYhYrMuBEIbBMhbTD98SRWFHmmuPHag6Ay1ZsBAjSgX7KB5b4Iz9ljtpzoOutgCuwaNlOsolldhKsfTlWeDc3lJuMXj6H15Xfkk/dEajl4dgZyBQx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAZc/2/7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2e0be86878so716250766b.1;
        Mon, 22 Jan 2024 00:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912409; x=1706517209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RnrYLcD2G9rn1Bq7tLo7QZoFXC1V42uiu850LzhmmYw=;
        b=IAZc/2/7/6GM+lUhYnbykv51fwyY/v9zTI6MWhyExqoTfavpPvDzkzP3cU37mM/l7B
         UQ3vG49PxGEqIaX7xkMxAQI/zmBViBov7MGRtmUuJNdUl3sWLhTngywI/hpm1olDcNmM
         U220g1lVHpuG0FDawV2KlY7DKrTbK+Zv/mD+R+ztpJJ5JY8jajY4Tg9i+QkLsMKqISvg
         hehEv6IzuFyOoX3N/M3140S2f2s2lxayh58oTW/ED3llzGc4ui7H/jEfiAEsGzavi81u
         QtrsAa58eadQ4UoPi3LOE0MI+L7/ScdzJhu21VV9i/5z5tiMYYYABWyi7EYH9fkxTWJg
         qB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912409; x=1706517209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RnrYLcD2G9rn1Bq7tLo7QZoFXC1V42uiu850LzhmmYw=;
        b=PCghlDMbH8OV0dqBlJMbD48KN4Eylk9XhgBNZt7xfdbyy6sd/KqPRJVNvenu1rtl3y
         TCNr/DpkcD3LI921W7fdnL9g8L5XlvjZOMq6EOUL0F0z8rkHgMGdMZOweN74XB0s9PaJ
         RiL5EQqELkY7i+U1JokPVwVfWsxd6eXA0iGUnP0KiP/AGikTZHeMzWeVoM5fPbXNuFJE
         pEYH4fFffWVbDPdZKkiSg9KFZsDzCe/P6pQV4fRr1ewkw21OenLvE/+SasbkMwMimgut
         v4nOtGS9O76W7gFXaIT4j3pmxnFmBo6y3qYz3iJOHuS1xIBYKfBtD9IATCyX1Duwgvur
         jkQQ==
X-Gm-Message-State: AOJu0Yy+sGH2hT1sdzIIH3w5MxNlUSYS1rOghF9zahJT5g0wGWXdoNyh
	irSsdLhy63CJZLGKwfRSYXIUVP/0RfjRd6XALp6JwSfPtjErMaGL
X-Google-Smtp-Source: AGHT+IGpkIU8/P/sKBO94AsA0HLy5AkiJuiXazlekdyVsiYa5PHiKwpE0ymKoW9OY9bVx4GPTRstsQ==
X-Received: by 2002:a17:906:5645:b0:a2f:9fb:b73e with SMTP id v5-20020a170906564500b00a2f09fbb73emr4927211ejr.34.1705912408483;
        Mon, 22 Jan 2024 00:33:28 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id ti14-20020a170907c20e00b00a2cea055d92sm11712454ejc.176.2024.01.22.00.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:33:28 -0800 (PST)
Message-ID: <c184710c606ba1be33d81fe50b391709e8a48425.camel@gmail.com>
Subject: Re: [PATCH v6 7/8] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 22 Jan 2024 09:33:27 +0100
In-Reply-To: <20240121175206.598bd93a@jic23-huawei>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	 <20240119-iio-backend-v6-7-189536c35a05@analog.com>
	 <20240121175206.598bd93a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-21 at 17:52 +0000, Jonathan Cameron wrote:
> On Fri, 19 Jan 2024 17:00:53 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Convert the driver to use the new IIO backend framework. The device
> > functionality is expected to be the same (meaning no added or removed
> > features).
> >=20
> > Also note this patch effectively breaks ABI and that's needed so we can
> > properly support this device and add needed features making use of the
> > new IIO framework.
>=20
> A statement here on why we think no one will notice or that, if anyone do=
es,
> they can be helped around the incompatibility by Analog tech support etc
> would be good to have here.
>=20
> I'm happy to accept that is this the case but such a statement in this pa=
tch
> description would be good to avoid scaring people too much with the ABI b=
reakage.
>=20

Sure I can add something like that...

> One trivial comment inline.
>=20
> Jonathan
>=20
>=20
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/iio/adc/ad9467.c | 272 +++++++++++++++++++++++++++++++---=
-------------
> > =C2=A02 files changed, 181 insertions(+), 93 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 10316e15c954..ff88e5b29f33 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -324,7 +324,7 @@ config AD799X
> > =C2=A0config AD9467
> > =C2=A0	tristate "Analog Devices AD9467 High Speed ADC driver"
> > =C2=A0	depends on SPI
> > -	depends on ADI_AXI_ADC
> > +	select IIO_BACKEND
> > =C2=A0	help
> > =C2=A0	=C2=A0 Say yes here to build support for Analog Devices:
> > =C2=A0	=C2=A0 * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Conv=
erter
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 6581fce4ba95..9e448c4c6b92 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -17,13 +17,12 @@
> > =C2=A0#include <linux/of.h>
> > =C2=A0
> >=20
> > -static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, i=
nt *val2)
> > +static int ad9467_get_scale(struct ad9467_state *st, int *val, int *va=
l2)
> > =C2=A0{
> > -	const struct adi_axi_adc_chip_info *info =3D conv->chip_info;
> > -	const struct ad9467_chip_info *info1 =3D to_ad9467_chip_info(info);
> > -	struct ad9467_state *st =3D adi_axi_adc_conv_priv(conv);
> > +	const struct ad9467_chip_info *info =3D st->info;
> > =C2=A0	unsigned int i, vref_val;
> > =C2=A0	int ret;
> > =C2=A0
> > @@ -282,25 +278,24 @@ static int ad9467_get_scale(struct adi_axi_adc_co=
nv *conv,
> > int *val, int *val2)
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > =C2=A0
> > -	vref_val =3D ret & info1->vref_mask;
> > +	vref_val =3D ret & info->vref_mask;
> > =C2=A0
> > -	for (i =3D 0; i < info->num_scales; i++) {
> > +	for (i =3D 0; i < st->info->num_scales; i++) {
>=20
> Use local variable info for this as well, and the other one below.
>=20

Arghh... missed those one.

- Nuno S=C3=A1
>=20


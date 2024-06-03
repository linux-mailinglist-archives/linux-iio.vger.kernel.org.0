Return-Path: <linux-iio+bounces-5676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD18D8343
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 15:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2BD2863B7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382212D762;
	Mon,  3 Jun 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYI6bKqL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DC12D766;
	Mon,  3 Jun 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419627; cv=none; b=ic1U5ZJl2XQO6JkxIUkpJ+MK6TIe9WhSgo3WceMoneDnYeV+pOx64A/X6uJPdoaAI1Uc2ulIDQHxZ5y3+X71Y2XNvnLF/pIGmwHIEX9Tg+SNjrqhuesrBj3ztFIUMbxOxG6AgcDfpt8tCJHpFkPQpiDbDFZAslN1E7yxuqVTOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419627; c=relaxed/simple;
	bh=EFDXzbET0oDEK5hJ72ljh6kZ1Ef9iy+G5uzyhrhtjCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDNvXCws1vqOMZDyxLHoRvNuJwvD4FPnalRFXt7yyEs220IW+cIIyF0CtMB8kOkYM+qI2djPrv9e8G5kpk9xbvbv94SB6Ou2/5kiqvp2eIzURYf9SW3Iv72hY+7q1zoaoz+GQFZgJgIQE7x4SQSeQkl6mwRCgO5ZnGiocssOwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYI6bKqL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68e7538cfaso188090766b.0;
        Mon, 03 Jun 2024 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419623; x=1718024423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IIyV9sL6Yz42R1gBXDzy0b0ZnJFQDq+9KiMNnkN2uWM=;
        b=FYI6bKqLm0UW6/ooemUwVyDWttMNoKQYdMYq3SL+xXy6cURlsZF2fw2jUA1YVeEKgn
         hAnlYes2iMznRSB5d5l4JVTBeAp1f8vGtVPEUopN8oQt8I7pH3fzLZ5FX3lvXKWvYgaF
         lfhEAttEfog0dBwoclHMJ2mDNLYB1QlZTWO8rDGMbgfbfILoVFk6jHshwCRh0e2E1Cp6
         rXpnkISq5VUn/eKRQTRkSSBbeM3DDVkd2ofooX56N54JBT0eTtxeptiWRdq4SGH0tTdx
         3MdcWmj3SYyV6CPY2QiD454O1UjjUdi88kAyBE7nAvXWcuwfjKfM+WTDo1KB4BiIWFwN
         nv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419623; x=1718024423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIyV9sL6Yz42R1gBXDzy0b0ZnJFQDq+9KiMNnkN2uWM=;
        b=K299TehGzdwHjcevsIpZ/cW4lWvfC+a4NBqNahcHiC5f4oI03kSiniCU2i5Jr4ok7g
         u6t5oYmpPifnPim3otkkgJb9H9Kxqx7Qe3SMpvOSL3h0GKNJDCd6V3zKDsssDnsCOfD3
         9ph64C0/+VyaXo7/CwaoOxLCLAc20UdC7DI3ftB0NOyq48GaYjR3Hcj1PkiS+bjnOIHv
         h48DoQMAYlJU6PAtI9XySZxK7YrvSEiORuVc3xuTJe1T7VXbS/PgCyNX7sGo19oSN8OY
         HKUteVrFSDlb7sscOYOaQPTWrWFqgbayrzfSnfbTsT2/5mBvOhk76O1al1h6YAKozsAV
         nxZg==
X-Forwarded-Encrypted: i=1; AJvYcCV/veD7xx7NWT/ZSpDaTpjt3NSn3KDYWuAGhPdN1aOgBf4NFj2sRzlSfIwkylvsdUM3kzMyQ3c4e6VOhXuS9OR0l4HD1ZRYRngzFlSWFLNqBB6ojizWeskmJk6/bJ1HbLntLswZQHC/suGJ9WrN5dJdH+9+kMII3iib/PJ4804EltUwQA==
X-Gm-Message-State: AOJu0YwPBMuC4Vz2b87LohazEapPp/6fg1RUfj8Mi/f8yamiERkZ14VF
	E5PQGUYCOrTBotz5L1tL+JbSV/VL9DLQKIn/u5Ef6Opg+m3AGuovCJ+6FZMR
X-Google-Smtp-Source: AGHT+IHtTwO4VHK0/SVGfw5rnIXHFULu/ZOyEUPSIxEJGgKYp0vTo3BIfG/sBD3Ixz2pAfasVabhnw==
X-Received: by 2002:a17:906:37d2:b0:a68:c14d:2686 with SMTP id a640c23a62f3a-a68c14d26ccmr375812666b.25.1717419622938;
        Mon, 03 Jun 2024 06:00:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85e8dsm479749266b.164.2024.06.03.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:00:22 -0700 (PDT)
Message-ID: <e9ade241e57383d5342d377bc865046e612a7033.camel@gmail.com>
Subject: Re: [PATCH v4 3/6] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Dumitru Ceclan via B4 Relay
	 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Mon, 03 Jun 2024 15:00:21 +0200
In-Reply-To: <20240601194925.23123071@jic23-huawei>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	 <20240531-ad4111-v4-3-64607301c057@analog.com>
	 <20240601194925.23123071@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-01 at 19:49 +0100, Jonathan Cameron wrote:
> On Fri, 31 May 2024 22:42:29 +0300
> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org=
> wrote:
>=20
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >=20
> > Move validation of analog inputs and reference voltage selection to
> > separate functions to reduce the size of the channel config parsing
> > function and improve readability.
> > Add defines for the number of analog inputs in a channel.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/ad7173.c | 71 ++++++++++++++++++++++++++++++++++-=
-------------
> > =C2=A01 file changed, 50 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index 6e249628bc64..a20831d99aa5 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -60,6 +60,7 @@
> > =C2=A0#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> > =C2=A0#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
> > =C2=A0
> > +#define AD7173_NO_AINS_PER_CHANNEL	2
> > =C2=A0#define AD7173_CH_ADDRESS(pos, neg) \
> > =C2=A0	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
> > =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> > @@ -623,6 +624,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
> > =C2=A0static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_st=
ate *st,
> > =C2=A0						 u8 reference_select)
> > =C2=A0{
> > +	struct device *dev =3D &st->sd.spi->dev;
> > =C2=A0	int vref;
> > =C2=A0
> > =C2=A0	switch (reference_select) {
> > @@ -646,9 +648,11 @@ static unsigned int ad7173_get_ref_voltage_milli(s=
truct
> > ad7173_state *st,
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > =C2=A0
> > -	if (vref < 0)
> > +	if (vref < 0) {
> > +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
> > +			reference_select, vref);
> > =C2=A0		return vref;
> > -
> > +	}
> > =C2=A0	return vref / (MICRO / MILLI);
> > =C2=A0}
> > =C2=A0
> > @@ -905,13 +909,50 @@ static int ad7173_register_clk_provider(struct ii=
o_dev
> > *indio_dev)
> > =C2=A0					=C2=A0=C2=A0 &st->int_clk_hw);
> > =C2=A0}
> > =C2=A0
> > +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned int
> > ain[AD7173_NO_AINS_PER_CHANNEL])
> I was late to the game in replying to previous thread.
>=20
> This is neater without the loop and with 2 parameters.=C2=A0 Anyhow see r=
eply to v3.
>=20

Yeps, even more given that we're passing/copying the complete array which a=
lways
fells awkward to me :)

- Nuno S=C3=A1




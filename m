Return-Path: <linux-iio+bounces-5820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DC8FC7CA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B2F282BF3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9A18FC76;
	Wed,  5 Jun 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO2Hhg8y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9F257B;
	Wed,  5 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579814; cv=none; b=ihuAk49HSCm7RVfjpsHmVUSRDMrz2wxGOHaZadYQN2Ej3EWsnk3IWSb7Id+vslIlE5U/9eZmd0lI+/jNNOwPJRrrlTXTiUnmILgBoqghtvqTHV9cvznSbRCDhdrBoGnfmBnxg6kwAa70lUaaK6ENiqmkplUTLUPjin+yBT457XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579814; c=relaxed/simple;
	bh=ZWvr410IHWWuYNKsLYoYrO07ijJE2egibpZ67QmYtTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krs7oVkZ4Rq3yLIUDLeokZ9XMxq8P0LvcMaH+aP9nNbl2EHccbEFf9ejR4xBoZpdKUqBOTHEKmbuI29sfByyK74zRvoLLogsg1Nu2K0ExRJ35GX/8OpFPwnX8zhsh+ihDDR4xlU1oef23e+JMFn8DnKC5raqssqXujnorSAtBKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO2Hhg8y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6266ffdba8so203349166b.1;
        Wed, 05 Jun 2024 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579811; x=1718184611; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cV7zf1J5GVnNvj6COOcqVNCjZ7NVt5RFiRgF7yuHnLw=;
        b=QO2Hhg8yJyKpMsyqyKsHAsEW6nt3Fv6C7gOmfqIk9wo67V4WHdeddR1yIRxyVGymKh
         KomdKfI9AAAf88YhnL6+MZKgvI2C67ESvMuSrMp3mWmhz1AX4lYruCMZe6BO2nSM6tC4
         UntleTKxsMwAff4u4Xhc65VK6+3sDBGWEGmvMq/GbkRjaYRAU+0IBg1XcizmD3o4sugj
         jCT0Z95n0G5chVSdk/lisYe6v5prdMPYPX7oJXqoPqMC5cGHaoAVX3fT3q7k73LDznKh
         D5HtaxDhpsex2wqmgWET1brb2AU4qfr9auiMDagh8AAFDahVeWfV67Eh1LBwcuqiGvEA
         AKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579811; x=1718184611;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cV7zf1J5GVnNvj6COOcqVNCjZ7NVt5RFiRgF7yuHnLw=;
        b=mvE9kRtFNNNnq90J8Pd4+B/8Sf8ra9L8CaviG5jHiOKme0tx0NqHLj++wShSTn6KPQ
         hJ8ESF6+t5DUbQ9hU3ZY8LT8OIB93SrJxZbZMPBcp3ak1OFsunMcnyXX/cU6DD3BnNPL
         ijjPpX3xJdfyTAspoSkGawPpBmNsrMm9GKPqyhzcnAPj27UUlUrOQ2LI6+wZTcTm9t52
         LuREbiqoWFGSZJ3Z6RwnBAAqW4OeyfCNTtVnUaay9FYsaP87d4Scu+hSUgr9egYE85L/
         6I8/NMBThf/gQSZ/tWhzrelcxkR+qYj+V5CR1LRUIzufj2ndYueidYzh565RZncWVMe5
         yQiA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Z0KE7AHcF/rMnFbGKfTvXjQItrYQcSnPt2Q4QVRqkvFB/ANV5aBUmG917HRZAUNEhfCKXu+dw5gYiqOHHDBhmcpLcRONUVmKC7R4Z6Mn7DMrONva0BjlVIOhTIwr4NCGmHfQjDBW
X-Gm-Message-State: AOJu0YwnfP3XAfaaNAcS0W+0DqcRKcdcaNFkr9BWg4e+MGSgZ2JXn5jD
	8YDdwzqXq/SJdJJ72khcWCQ33R38o/NMwnTmn4nNDNMQnvbCCBoG
X-Google-Smtp-Source: AGHT+IFKIjzxbZK6itJudm8hiuq5NtiQaTOtj73xdFoRpvF9XLCXllH0gTRohuA0C8uI4HqbKUV/pw==
X-Received: by 2002:a17:906:1c11:b0:a66:e009:eb53 with SMTP id a640c23a62f3a-a699f34d9c8mr131390866b.13.1717579810959;
        Wed, 05 Jun 2024 02:30:10 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6922c59fc1sm347149766b.175.2024.06.05.02.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:30:10 -0700 (PDT)
Message-ID: <aac3acb3f02642fd9aa0ec922f7b02bb9f32435a.camel@gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: ad7266: use
 devm_regulator_get_enable_read_voltage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 11:33:57 +0200
In-Reply-To: <57a60f5c-a989-4187-ab4f-1f6a15578578@baylibre.com>
References: 
	<20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
	 <20240531-iio-adc-ref-supply-refactor-v1-2-4b313c0615ad@baylibre.com>
	 <edb66fe8c2722e600179b1f9a0d81242d84582a0.camel@gmail.com>
	 <57a60f5c-a989-4187-ab4f-1f6a15578578@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 09:10 -0500, David Lechner wrote:
> On 6/4/24 6:19 AM, Nuno S=C3=A1 wrote:
> > On Fri, 2024-05-31 at 16:19 -0500, David Lechner wrote:
> > > This makes use of the new devm_regulator_get_enable_read_voltage()
> > > function to reduce boilerplate code.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7266.c | 37 ++++++++++-----------------------=
----
> > > =C2=A01 file changed, 10 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> > > index 353a97f9c086..026db1bedc0a 100644
> > > --- a/drivers/iio/adc/ad7266.c
> > > +++ b/drivers/iio/adc/ad7266.c
> > > @@ -25,7 +25,6 @@
> > > =C2=A0
> > > =C2=A0struct ad7266_state {
> > > =C2=A0	struct spi_device	*spi;
> > > -	struct regulator	*reg;
> > > =C2=A0	unsigned long		vref_mv;
> > > =C2=A0
> > > =C2=A0	struct spi_transfer	single_xfer[3];
> > > @@ -377,11 +376,6 @@ static const char * const ad7266_gpio_labels[] =
=3D {
> > > =C2=A0	"ad0", "ad1", "ad2",
> > > =C2=A0};
> > > =C2=A0
> > > -static void ad7266_reg_disable(void *reg)
> > > -{
> > > -	regulator_disable(reg);
> > > -}
> > > -
> > > =C2=A0static int ad7266_probe(struct spi_device *spi)
> > > =C2=A0{
> > > =C2=A0	struct ad7266_platform_data *pdata =3D spi->dev.platform_data;
> > > @@ -396,28 +390,17 @@ static int ad7266_probe(struct spi_device *spi)
> > > =C2=A0
> > > =C2=A0	st =3D iio_priv(indio_dev);
> > > =C2=A0
> > > -	st->reg =3D devm_regulator_get_optional(&spi->dev, "vref");
> > > -	if (!IS_ERR(st->reg)) {
> > > -		ret =3D regulator_enable(st->reg);
> > > -		if (ret)
> > > -			return ret;
> > > -
> > > -		ret =3D devm_add_action_or_reset(&spi->dev,
> > > ad7266_reg_disable, st-
> > > > reg);
> > > -		if (ret)
> > > -			return ret;
> > > -
> > > -		ret =3D regulator_get_voltage(st->reg);
> > > -		if (ret < 0)
> > > -			return ret;
> > > -
> > > -		st->vref_mv =3D ret / 1000;
> > > -	} else {
> > > -		/* Any other error indicates that the regulator does
> > > exist */
> > > -		if (PTR_ERR(st->reg) !=3D -ENODEV)
> > > -			return PTR_ERR(st->reg);
> > > -		/* Use internal reference */
> > > +	/*
> > > +	 * Use external reference from vref if present, otherwise use
> > > 2.5V
> > > +	 * internal reference.
> > > +	 */
> >=20
> > Not sure the comment brings any added value. The code is fairly self
> > explanatory
> > IMO...
>=20
> Well, you do this every day. :-)

I guess... still not an excuse :)

>=20
> For someone who never wrote an IIO driver, it could be helpful.

Still dunno but no strong feelings anyways...

- Nuno S=C3=A1



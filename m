Return-Path: <linux-iio+bounces-5746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07F8FB0F0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0001828325C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05328145343;
	Tue,  4 Jun 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH28Si+x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4C144D37;
	Tue,  4 Jun 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499974; cv=none; b=cAMcYXWG/UkieHMDQbJ2XeIOa1wcg8i+6ooGC7O/uqDqZfFXByWOZsv5QgZlD3fcocbHZ6U6vUdzsXXI4kmZ+eIm6Yv0zsZm4z+BTUvuF425dEKSLoYqvm1xD7XpdLp1gcOfj5JPG+GRxxD1SZW3UTMVd0EJ9kLpFvCBHuX7+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499974; c=relaxed/simple;
	bh=/KTVQPgKkw5N5Iv462MWTjnxIl996lxgMwYk1UvUCgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAi1H/sgbfMEKAn/+4EJDdIRv0z/ruwQYN4LP9rPgeTjZBg0+aq7mZwJbDQeOAlkLycRY9BpXEbVQ4FBkTpjto5fSA0Mhbib81za7HbWBEMIqs4k43OV883MZj94HNBSkYUxbYvSodJin2vITwqpSHH0WmSHWkxks7DClFONbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH28Si+x; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a2f032007so5474238a12.0;
        Tue, 04 Jun 2024 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717499971; x=1718104771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GMBnX2bSlEM3fPXFPmVFP0tWhkdmltN6LnHeM92l7k0=;
        b=EH28Si+xLrhtWTRRgMsQ/UlWR/OuWPDcCnqTaDnX+tvZtLR8/WcGB8qIAUIFkaoA+f
         pEIkbK52YueNPovs5k96gbmH8kYrJ4AfUk6qEn83BfA1oW9zrpBc4tCOo4sVdR3pneLh
         Pv1IllV6AhksDGRB7WysNaiLQxIz/EGV/52J6JhNawwGTOG0ynb9hMbYA16o0jof0Q/G
         mD+cpKLmkTCmj6/c4AMerE+mL5yfFwM3aS3f5qwUS50hnECm2YBkHRAymCduHmTW92am
         MRSmLqX3ewZAC83333e6pJlDw7UUhmrxyPx8ejRMJnUDVGkYfVm08mpm3o27BHd3IStD
         DZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499971; x=1718104771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMBnX2bSlEM3fPXFPmVFP0tWhkdmltN6LnHeM92l7k0=;
        b=CAK3BQTmgx23qJJ3SD8w+50FUyCtBQmKMEt/Dsga8EN0xq8kgnLq8tZf0yyxhpABzW
         bxyxsQUN/Hu7BuNOYzfDnX2ikLRBHAwc33c6oi/u5DitsaEpesYEAB1DXa8YBVzq+zvC
         KygaPyNhuDC7LMmh2s78Jf9Ix7NaAS1fR+hCgqxEpcyB2Fw3QH/f6IC4iD0Z/vhstH6i
         LQts6VAKygAknOZfMISjQbn0P3cZSVXd8SZVgUkCX2U1mybgmkaBF7LkhRBMRbi9sf5o
         DH8QtfPFe++0mjFSzcFXjGvd70msfd2OASIkwYUnWzF0EOCfH3siCViWk7s6PS1GVvx8
         rGJg==
X-Forwarded-Encrypted: i=1; AJvYcCUYzb8rRNRlC8zK5BtMQ70+OTigii5+O2/Xqn25Ok/rkw0lpFwSM4+qOalBT2yA/DaJNskHncaeYGbT/bEj1v21Z76KvT6GfHro94KRhPVbmvahKcKxrbfuLB8JP88eISn63YwokICd
X-Gm-Message-State: AOJu0YweQXygOnRJhpoZrNKnMxauTSOGHnkfOsjtLdAk1eLkKHgVzmv/
	uRnB8m1FPn3TCBRhQ5uNt8aoZd3tlG1YnfNVCp3ssQqLjX3G0Bjb
X-Google-Smtp-Source: AGHT+IGN7N3s5/m2W/MNUly37tDVpE6w//s47AmPSal2wwJvZgWdITbWDdFPH8XvV45XGZyaphWGYw==
X-Received: by 2002:a05:6402:2313:b0:56e:743:d4d9 with SMTP id 4fb4d7f45d1cf-57a364acf15mr6032155a12.42.1717499971218;
        Tue, 04 Jun 2024 04:19:31 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb841fsm7307365a12.34.2024.06.04.04.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 04:19:31 -0700 (PDT)
Message-ID: <edb66fe8c2722e600179b1f9a0d81242d84582a0.camel@gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: ad7266: use
 devm_regulator_get_enable_read_voltage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 13:19:30 +0200
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-2-4b313c0615ad@baylibre.com>
References: 
	<20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
	 <20240531-iio-adc-ref-supply-refactor-v1-2-4b313c0615ad@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 16:19 -0500, David Lechner wrote:
> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7266.c | 37 ++++++++++---------------------------
> =C2=A01 file changed, 10 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 353a97f9c086..026db1bedc0a 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -25,7 +25,6 @@
> =C2=A0
> =C2=A0struct ad7266_state {
> =C2=A0	struct spi_device	*spi;
> -	struct regulator	*reg;
> =C2=A0	unsigned long		vref_mv;
> =C2=A0
> =C2=A0	struct spi_transfer	single_xfer[3];
> @@ -377,11 +376,6 @@ static const char * const ad7266_gpio_labels[] =3D {
> =C2=A0	"ad0", "ad1", "ad2",
> =C2=A0};
> =C2=A0
> -static void ad7266_reg_disable(void *reg)
> -{
> -	regulator_disable(reg);
> -}
> -
> =C2=A0static int ad7266_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct ad7266_platform_data *pdata =3D spi->dev.platform_data;
> @@ -396,28 +390,17 @@ static int ad7266_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	st =3D iio_priv(indio_dev);
> =C2=A0
> -	st->reg =3D devm_regulator_get_optional(&spi->dev, "vref");
> -	if (!IS_ERR(st->reg)) {
> -		ret =3D regulator_enable(st->reg);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st-
> >reg);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D regulator_get_voltage(st->reg);
> -		if (ret < 0)
> -			return ret;
> -
> -		st->vref_mv =3D ret / 1000;
> -	} else {
> -		/* Any other error indicates that the regulator does exist */
> -		if (PTR_ERR(st->reg) !=3D -ENODEV)
> -			return PTR_ERR(st->reg);
> -		/* Use internal reference */
> +	/*
> +	 * Use external reference from vref if present, otherwise use 2.5V
> +	 * internal reference.
> +	 */

Not sure the comment brings any added value. The code is fairly self explan=
atory
IMO...

> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> +	if (ret =3D=3D -ENODEV)
> =C2=A0		st->vref_mv =3D 2500;
> -	}
> +	else if (ret < 0)
> +		return ret;
> +	else

I think it would be better (as that is the typical pattern) to first check =
for
errors. Also the 'return' in the middle of the else if () is a bit weird to=
 me...
Maybe something like this?

if (ret < 0 && ret !=3D -ENODEV)
	return ret;
if (ret =3D=3D -ENODEV)
	st->vref_mv =3D 2500;
else
	st->vref_mv =3D ret / 1000;

or even replacing the if() else by
st->vref_mv =3D ret =3D=3D -ENODEV ? 2500 : ret / 1000;

- Nuno S=C3=A1



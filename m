Return-Path: <linux-iio+bounces-5442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0098D36B2
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F9D1F28639
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD23FEC;
	Wed, 29 May 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URZmtme1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DADDA6;
	Wed, 29 May 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986956; cv=none; b=V/lZ17FZcu5vlvge5RYtDdUwrIvW3hsySNriSu9aEIlvR9v+cVxKTehlyQr01HlN8SsmQ5RL3pMcA9jUq8wG4By3Vhkd5+Yzz0Ooa2xJzsZOmeAnge59hOmIP6TXHHE8KzQ0xc8H0i8kWIExypGxy+J7oOPVAZQx96DUuPJ7XoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986956; c=relaxed/simple;
	bh=DcKxVZZV+EgA4m/SNpu5gXfJDOpxyV8oN+5zhuZvvR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ua+q1OCfzmsORxAAxy3nfR3abIvBGCCVtq150gkJRMqiOVBpX01+vU9NAWzbbXBT0iF43yXzLkZd2Amy/E9+gFyk/XRgDB+3xUNT53+FFt2rmbKA5l1nFKqe6mgMdhaR+5q86UKuJk3Yc7gsEVRAcDHyHLwdeWeDxz09L/JhYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URZmtme1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6519c6ec7bso73724166b.1;
        Wed, 29 May 2024 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716986953; x=1717591753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxm5RCkT6Z8eOTgdAgsYs+Y3bbauIPRrHzupKWf9eIw=;
        b=URZmtme1Zos//ogIf7XYzHXfOjFqfAxBOeMW4kvd8txWHzuA5g1lGxKvQ6TFJYSFps
         K2IZEpqcE+CYqz5HeKKXHd1+KPO6XJKk+kRKN3eDYulaKHumxdJo/zq5HcSatRYM4FEd
         1asPYGZh+vnsVodMtOOsIwCrCZbc7E6tGj9pX4ntDJdf/bcNXjyaR6DgngTnT4/HqSLd
         F05+loohR63YRXvIcqViRAa2+Dr+pCGU8EyS+p/niSuYgGI3Pkf2PwJrjhD/B6sxB5Ls
         DA32wKF9y+jxt0DTetbnOa1lE7YhmYSQoF86tc/qvSNe32EOXE4UjVt52fEIZpCuhMgt
         SQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986953; x=1717591753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxm5RCkT6Z8eOTgdAgsYs+Y3bbauIPRrHzupKWf9eIw=;
        b=BOhmv/pIeGs+JKP4kxCqpMQaevir11fT04LTZvShC9SRdX/hy7OpYy+vRfgEf7+VHR
         OnLuN46YUKVOsn3i+0OEdDscr9JVm2Q9cJ0nygVH6/s3DecmbJrAzZMVXsHgYBvmMcao
         0fFAWgPadLgWpZ9sZQBuj+mcrKBTl/3hnAiy+fQKhcuYzSKXIPrCGA/zh7oGlicONka6
         pX5UW/rMfK8IA1W2L+h7itOVATxS3nKidFUXpKFsiI8K5NvTs5jS7JdgpBpbz2fG8cZT
         9Y/IuUrdjnmrVCzdJfcQVpa+5NGn+y9B6jSgE7tUbZwjg+VqBGUsmjo/qC4KondUUVTR
         SRWA==
X-Forwarded-Encrypted: i=1; AJvYcCUnupsFz8DBCspPkHd9ZN/ziOtgNbM3Ov1bCAGhUwaCdngZBd1sotvxhwNMTL3Tn1+oStQuvdbXAeEoJgvY/szQmEbRqXMD/jxMdDg5X6EpbphY3IYXC2XGbbwoz0EXTkn6zTakn4nnXZVxIiKGhiKjyWUsyQOl7I8i/QvAGjp/XK+mVg==
X-Gm-Message-State: AOJu0YyXxu8G4KzlyTNJpmZPKfdFsymn6dSkvX+35REtsFjr9Efy0gt+
	/D9aG6MPYfrzMq/ZHvUUgsLlle7ZgaCenht0Bvtq7xLuyi3VHhAi
X-Google-Smtp-Source: AGHT+IHFwpbqkz/8c/KOKh2nJyonvUdwIFcztAvT82b2LrqXwJx/RqdJ2bmL5xtZSfqETojujYeOyw==
X-Received: by 2002:a17:906:6a24:b0:a63:3e99:6565 with SMTP id a640c23a62f3a-a633e996aacmr661119566b.23.1716986952948;
        Wed, 29 May 2024 05:49:12 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c987cf8sm716081666b.94.2024.05.29.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:49:12 -0700 (PDT)
Message-ID: <4b704b553282c0689dfef714c49ba97a33198898.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Wed, 29 May 2024 14:49:12 +0200
In-Reply-To: <71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-3-7e9eddbbd3eb@analog.com>
	 <71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 14:27 +0200, Nuno S=C3=A1 wrote:
> On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >=20
> > Move validation of analog inputs and reference voltage selection to
> > separate functions to reduce the size of the channel config parsing
> > function and improve readability.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/ad7173.c | 62 ++++++++++++++++++++++++++++++++++-=
-------------
> > =C2=A01 file changed, 44 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index 9e507e2c66f0..8a53821c8e58 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -906,6 +906,44 @@ static int ad7173_register_clk_provider(struct iio=
_dev
> > *indio_dev)
> > =C2=A0					=C2=A0=C2=A0 &st->int_clk_hw);
> > =C2=A0}
> > =C2=A0
> > +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain[2])

Pass the pointer and size of it... Also, it should be made 'const'

> > +{
> > +	struct device *dev =3D &st->sd.spi->dev;
> > +
> > +	for (int i =3D 0; i < 2; i++) {

Use the size in here... At the very least, ARRAY_SIZE() if you keep it like=
 this.

> > +		if (ain[i] < st->info->num_inputs)
> > +			continue;
> > +
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"Input pin number out of range for pair (%d %d).\n",
> > +			ain[0], ain[1]);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad7173_validate_reference(struct ad7173_state *st, int ref_=
sel)
> > +{
> > +	struct device *dev =3D &st->sd.spi->dev;
> > +	int ret;
> > +
> > +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_INT_REF && !st->info->has_int=
_ref)
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"Internal reference is not available on current
> > model.\n");
> > +
> > +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_re=
f2)
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"External reference 2 is not available on current
> > model.\n");
> > +
> > +	ret =3D ad7173_get_ref_voltage_milli(st, ref_sel);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 ref_sel);
> > +
> > +	return 0;
>=20
> If you need a v4, I would just 'return ad7173_get_ref_voltage_milli(...)'=
. Any
> error
> log needed should be done inside ad7173_get_ref_voltage_milli(). Anyways:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20

In fact, no tag :). Just realized the above in another patch..

- Nuno S=C3=A1



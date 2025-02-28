Return-Path: <linux-iio+bounces-16190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6AA49A77
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 14:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA1E3A6F67
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD326BDA8;
	Fri, 28 Feb 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHmBQBEE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FDD1D555;
	Fri, 28 Feb 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749060; cv=none; b=IP+8vZEw5lEiHKgJN2+BHKbYvQtv7l+Y7KJFOdqIXw+Yf2+/VewZGxHu2qfTqUhzarBf24WiNVT3VZOejCu9VSM59Ue+RimNsuEZJg0/mX5hpFZPRn6T06NTsn7duIEoiEUuwrJYWnjFaLKcHBmiXS1VpRv6yvlftYZdDeOv4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749060; c=relaxed/simple;
	bh=HG9HTlvNGdnmHBqM51K38WxH2I4QiN6sibvcf6Rzxz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNbrf1BOnGYbop6VWKGhHleG0RSd30wlZ7loS40F6xrUlzRJ/vYnYFxIWgVlzqfdYdP6FCr38+qlv692Wm8XOLO2AuNKylelqlgsuFd6hjSdgXON7WPHf4suCwrRV8xvCtRlx77QxptTLu2M0Hj1/GybLY8ZiCP/fMWTBZ1DGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHmBQBEE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so13819175e9.3;
        Fri, 28 Feb 2025 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740749057; x=1741353857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rh8KIR0lZBR/NWLa9Q2ihKE6Abv28L63gVdOYLJNiB4=;
        b=RHmBQBEE21OPJuWY5Q7mZj85f/vgYnbXDF/kXfGzgPS9ksDuuAnLAVhp4nW6d7C+60
         y+UoirWY6HJHRzCOhd7KBv600/xYFw+cy7WF/Vr3TJfXO5brcTUCjzdCG/FIQU5GgYrI
         AiKsZLA2iimXOso/7QOYAuyh/qiv6p90V57GgpUSCOqEU7BCBQUTusm9ClHWJj6htEKT
         IFD31EsCH269r5WGFSigHYCUC131VbnodvcV37Cu3F5GyjeWo6GcFdcNaD1mwLfCZ/um
         5ny824hu4pjww71wsGpz2ZW9S5QobbQCIh5N9rOXIfRXsr6Vl1PYGR0ynYkpPXYDUtKn
         RSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740749057; x=1741353857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rh8KIR0lZBR/NWLa9Q2ihKE6Abv28L63gVdOYLJNiB4=;
        b=MzGkLWwA++MdMy1VwwhFhVxBTDNv68vLHxmJ1imtBBj2bNb78sJagVaKxrXWIIvUT/
         M/x+itVUF/1GQAgGuVzCV6k9js4JWKvXl8u05+TSWd2mADITfd0wIkdphoGlajF2UnNf
         /L/tXf8m/vFjAxrAS0tRtG/oWmK7vHUZhpR5kcv6VUoiH4+S8oncHUZI8ZsUksyUxpII
         eiWK05bAw/DC9XzAwsIPoEIC9RW2/yJ4J32+ewxxp5qeOJsd6whOTENHpfNwL/A3B77x
         De0BemelNWdgO9MAtJdFNITYek/TB9FZeoHQdlaJiIQCu51rOXBUtwApLsR/1hEL5SDj
         OIgA==
X-Forwarded-Encrypted: i=1; AJvYcCU9W5sdJpisc9r3GQ3BF8NBaLtzSIdcruyaKRu79krbSMxie+66HAtOHHwiNme+AIfY72R4IC/vyUTLTduTlKw=@vger.kernel.org, AJvYcCV7EWh8D7Jt+c1R3eGplEyvEuq7Db7AXBeG0JW5o4yMmm7A9r+6Z4AgiqQtoY2K8ZdoKyxGSbiZwkF7eOCS@vger.kernel.org, AJvYcCWvcLvJ1IfQO4RJu0LjJtPVtohstZLZPAq6lnvACPKXwYfmos/2GsqYE/h6tx4AAW0XAmh/Azli8BKu@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpPaefoD4+YMlRHbjshU4PIGEI5FOU96vpTdJxe4ex+eU+MFg
	kc0H0kQN+2LzU9xsopTUph5aclomf+Q+UbZK0Ozn6LTy+jtKsX9OY6YCvY0Lqdo=
X-Gm-Gg: ASbGnct+2bNL4fUCBTudXkjSyc+mGMfnBG3ZKsIfZQPYTjZKZcL9zCM+1UWdGuQ620L
	rNkkE7oOH3s+1ekUXB9FqcnZTrRl2UPJkvVdyo1rdby2ooH6KpaNLhn2FXWwwdodAUAjVdzzXLo
	JjL9EqUYpMe3BxeB+9by8fX9Na3OQ1TbOmjkAHdHKqiYxuM2TLwHvQUJKIzWjVNpxO8y4BNBu+o
	rrDGqlb0Q1nXntNHMkkDaqso1kruu5LrmXy7erf+YqEJXWG4ltTzw7HBKHPrjpJbMPCh7Z5zCl6
	xQ6ltOkAFo8RV/0yq6nSi7Bpi5t+WTfxXuSlVsyIrdfjc92uGK2Pw9MxQipe68Go/eUBNUfdXg=
	=
X-Google-Smtp-Source: AGHT+IEGfJ5sKNQtVz6Z/8Ld/0MZOUkjiLJZQs6Vz+xwpBmJkJ27m7qiHcjdTNbX4nHkCuWmUFSidQ==
X-Received: by 2002:a05:600c:35c3:b0:439:9377:fa17 with SMTP id 5b1f17b1804b1-43ba67085e7mr28001065e9.18.1740749056725;
        Fri, 28 Feb 2025 05:24:16 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711dfsm88512065e9.27.2025.02.28.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:24:16 -0800 (PST)
Message-ID: <5fa78e957fc85fa134cea5fa68b21b56c6173a44.camel@gmail.com>
Subject: Re: [PATCH next] iio: adc: ad4851: Fix signedness bug in
 ad4851_calibrate()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Fri, 28 Feb 2025 13:24:20 +0000
In-Reply-To: <f5e260e9-d7a8-4dae-b7ea-f1bbb1760e60@stanley.mountain>
References: <f5e260e9-d7a8-4dae-b7ea-f1bbb1760e60@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 12:36 +0300, Dan Carpenter wrote:
> The "c" variable is used to store error codes from ad4851_find_opt()
> so it has to be signed for the error handling to work.=C2=A0 Change it
> to type int.
>=20
> Fixes: 6250803fe2ec ("iio: adc: ad4851: add ad485x driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Btw, in ad4851_write_raw() there are some checks for negative but
> the multiplication could still wrap and turn negative so we might want to
> add an upper bounds as well:
>=20
> =C2=A0=C2=A0=C2=A0 drivers/iio/adc/ad4851.c:826 ad4851_write_raw()
> =C2=A0=C2=A0=C2=A0 warn: potential integer overflow from user 'val * st->=
osr'
>=20
> =C2=A0drivers/iio/adc/ad4851.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> index 1ad37084355e..98ebc853db79 100644
> --- a/drivers/iio/adc/ad4851.c
> +++ b/drivers/iio/adc/ad4851.c
> @@ -492,11 +492,11 @@ static int ad4851_find_opt(const unsigned long *fie=
ld,
> unsigned int start,
> =C2=A0static int ad4851_calibrate(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct ad4851_state *st =3D iio_priv(indio_dev);
> -	unsigned int opt_delay, num_lanes, delay, i, s, c;
> +	unsigned int opt_delay, num_lanes, delay, i, s;
> =C2=A0	enum iio_backend_interface_type interface_type;
> =C2=A0	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
> =C2=A0	bool status;
> -	int ret;
> +	int c, ret;
> =C2=A0
> =C2=A0	ret =3D iio_backend_interface_type_get(st->back, &interface_type);
> =C2=A0	if (ret)



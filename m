Return-Path: <linux-iio+bounces-4049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBB8983B7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2B8284A7D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2B7351C;
	Thu,  4 Apr 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm5C8dvX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD629D1C
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221663; cv=none; b=FUBC467HZe2/H6gxA0yFMqY/Np/6quB9rwbv5oEQMCWvc3v31bylnwfFfPO3LQdbIfYbfINtC9lXjEhD1ashlRpxB8qtMYjNuVItM71qNRoCVoxzHakuf9t0t7hDBdeCZT7DPVpjeotcQkHL2lh4t3sBYx08+G4wg3l+z+68gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221663; c=relaxed/simple;
	bh=eNZUwnRarv69oHjhh2BtQTApLcivIM6ywyiZKixvZi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hN2ucu5rqtr/eeFI2c3/r1pmig2rbht4zwSEDDy5lYnc/nLFuARQmWr5TSXhb7LMjtBWRQEGt+xzFeQaP8iqpOdkxG0++q0OkW51DpsNawcvMpd2wzC0szZEYfAZ1d+QbfhkVCDb0Z3407OauB6NmbkYZJ89b0Lb6D8VB8watuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm5C8dvX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so1031956a12.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221660; x=1712826460; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+ijzwHoj3pnqw/TjuUumb5b5i2cfbz0B4SgK6WCVGA=;
        b=Mm5C8dvXta+8Fwx65KcIw+N+paOV/z8VRkIWl1yX8fqIZnQkph2ARxTmy68g4A6m3p
         woqSMRMb6SbAX/T91BbDvkn+u9lGdwmgEUiXwjX0l01xsFkFC6i3q6JmMlyA+l/PUkY9
         QvnEu+kKZ1dErakJaaBw1Lg3SgUR9tnuYwc3FiQ2Ud267ZA6/JDiRlZk34cCboeOLhLu
         ZAH75Kk5T3xlEMR4WLqBOdl+1ol1FeITpyUS5XW7MYs23X2DfOWo4AF/i3Sj4XBm/nPh
         7/1LHGLeYdMfX2MnD/KqoFeSX6RktvTrgLj8bYc2hDEA7uKJIVzPBIRamQT0GzgTnpAt
         QjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221660; x=1712826460;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+ijzwHoj3pnqw/TjuUumb5b5i2cfbz0B4SgK6WCVGA=;
        b=ZBZS9zVYDIQqItAut7sskltDmfELzTYkcMcfOl4JSLmUtq/gIA1TJdkfiuiuyxCuZC
         fwvUWcr5vuf/zVNjk3U9ag3Cw0FhGvUscxAVwyCYkGf4zL4mP7/UaKol4mtKJml5EN+g
         m8ZeJu/i/DQi+PezqBcZrHcj9dmYWM/WHePtsM7xDv49xk4Ay1DIOjwUxcEern3De6Np
         BIkWVKFfV5RyA9ZzVoEgibUq8ehD5Phj/CAdkP0VjMgN9Gm9/2HqCYDNUkjq2P0f2jd5
         ZhnAEq0BjqsUqLtTA6FaEeCba0fXknsx3hu42zsVmXRxcs1OJXCjoBZ9wwzU+xUXAvR7
         M2YA==
X-Forwarded-Encrypted: i=1; AJvYcCUcKCwzIX/oNySTZouk8ZJPGj7aH6PwmO/D8FShzRfRqLZm276MaP5/rLCZXe66UcreGrWr4YN421ix8pZOvwapdl/2eYC0WCq4
X-Gm-Message-State: AOJu0Yx20Vj5Fv9tHJioSTHSaKeEo+A3bcJmDxnT+dl1yvATGUX9br2b
	UCXTXb/Crb2XzG/eh+a6X+aeM6KoRhFZTpZKbRIDmmvjlfIPFYWAs3lH9bkkp4q0mc8L
X-Google-Smtp-Source: AGHT+IHjxIWXfY23KW7j8ZYqCcCjotQDpxO3x6b1NjkldPD+j5n+RvxEYFgxtHv/bhN+D5ODCGc0ag==
X-Received: by 2002:a17:906:a402:b0:a4a:33e4:bcae with SMTP id l2-20020a170906a40200b00a4a33e4bcaemr1118243ejz.30.1712221659866;
        Thu, 04 Apr 2024 02:07:39 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906275500b00a518b14d6cesm470239ejd.172.2024.04.04.02.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:07:39 -0700 (PDT)
Message-ID: <e479cbeca4b78fb5ccf901a833ba1734735b4993.camel@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: dac: ad5770r: Use
 device_for_each_child_node_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>,  Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 04 Apr 2024 11:11:11 +0200
In-Reply-To: <20240330185305.1319844-9-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
	 <20240330185305.1319844-9-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-30 at 18:53 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
>=20
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad5770r.c | 19 ++++++-------------
> =C2=A01 file changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index f66d67402e43..c360ebf5297a 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -515,39 +515,32 @@ static int ad5770r_channel_config(struct ad5770r_st=
ate
> *st)
> =C2=A0{
> =C2=A0	int ret, tmp[2], min, max;
> =C2=A0	unsigned int num;
> -	struct fwnode_handle *child;
> =C2=A0
> =C2=A0	num =3D device_get_child_node_count(&st->spi->dev);
> =C2=A0	if (num !=3D AD5770R_MAX_CHANNELS)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	device_for_each_child_node(&st->spi->dev, child) {
> +	device_for_each_child_node_scoped(&st->spi->dev, child) {
> =C2=A0		ret =3D fwnode_property_read_u32(child, "reg", &num);
> =C2=A0		if (ret)
> -			goto err_child_out;
> -		if (num >=3D AD5770R_MAX_CHANNELS) {
> -			ret =3D -EINVAL;
> -			goto err_child_out;
> -		}
> +			return ret;
> +		if (num >=3D AD5770R_MAX_CHANNELS)
> +			return -EINVAL;
> =C2=A0
> =C2=A0		ret =3D fwnode_property_read_u32_array(child,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 "adi,range-microamp",
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 tmp, 2);
> =C2=A0		if (ret)
> -			goto err_child_out;
> +			return ret;
> =C2=A0
> =C2=A0		min =3D tmp[0] / 1000;
> =C2=A0		max =3D tmp[1] / 1000;
> =C2=A0		ret =3D ad5770r_store_output_range(st, min, max, num);
> =C2=A0		if (ret)
> -			goto err_child_out;
> +			return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> -
> -err_child_out:
> -	fwnode_handle_put(child);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad5770r_init(struct ad5770r_state *st)



Return-Path: <linux-iio+bounces-2780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A285A523
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382151F232E3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF06364CC;
	Mon, 19 Feb 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHKVTnxb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51236134;
	Mon, 19 Feb 2024 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350741; cv=none; b=WnBT/a7L+19lo1YL4iUmbx+gM7xaixeE2ARsUThrE+RIKL+f18ldxm0NbRDJheGy6s6Sj11UWEWg5TUITMcKLvEDdAW9jiL0XjAqzlzDFSMYCgY7bINPwdXYefSxFzv7rCP+VEUYfU1QG6/B5TtgOuAs/+P/bHTJY1Xr+v2c4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350741; c=relaxed/simple;
	bh=1An3SGoGnP3FTySpVaDtgNT0hlNCi0ZMAsdd6oIT2Uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tx4hhlZBsAUhpe5clVICgZ5eamo8yGXw71e7rh6i6xv04zxpav9xS5/vwsR/mCC03HhptPYeGdtJoqUVGtON+po7/JyhUlRRS7kYYs+D1Jg0MXa+IAf10pQPTqk6lBnUyDeEFtTOI61ntOSXFa6t4lfMx4VfuD683Rz8iaTpCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHKVTnxb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563e330351dso3323281a12.0;
        Mon, 19 Feb 2024 05:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708350738; x=1708955538; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYzRqxgMvXEn8rEnYytQweF2WJ0zyhNy840o0rQgmQg=;
        b=JHKVTnxbC5/cxQdJ9WDzv3+NueINsYVH/MccyMGR/U1dOx08eai565zapctEhRLy8U
         7If6081mTCGnJ2lpozi9sK/tJEoveQXcgLqyGWq4fJdbzxLrV3MqmFz/MjlGellDONjR
         hiNX2ptsBds/Ium6s5D6J6wLgAfRgDdl+OVD2GfaOodwzS7zuyvLSZZ1gmm+p9teF/bg
         QI/dhft+Bo7J08cVWUXe25OzOYLSMeFRuQpO/iFnQUbVYuKNL5Eji/bOXZqfiWC8U8CI
         U/xn2Z+NCujm4MwlmSRs21bVvJGzExcL/UfsK8sZ7/5YQ020xnnDhMhXIgbCWLo7yHBV
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350738; x=1708955538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYzRqxgMvXEn8rEnYytQweF2WJ0zyhNy840o0rQgmQg=;
        b=e6FAPXOTpNqTBxFZfV1S29g1FPbE8CPCGlr2oM84LB6wrs2u7lnqy58J7UYg+6UanM
         Y/wgTfxwAw6kKIrs5jLBG2KaZyHnZU6SD/sa+4K9tf5FyR0Spm/uimfl3LxSxS33fDSo
         cNN8TyW+rGHAkJ8a7G+Mg0GnnbNhSaCL02Irs366UuOLCLQbEzDbJVTwKz6Xpprufyg/
         KInKO1qTjI2EwT9IIahvNlytJfJxglCIDp2OrIjY2DN+ciKeuEHfShNxaeKrf7mHtg34
         1/Z3ccy2wyx7/wAyLgA9mkT6CmnfwS1KTjYeH8GzKynr2nzRshAPjSNQml4sZjiTBvZy
         1W3w==
X-Forwarded-Encrypted: i=1; AJvYcCVlOvOY5OxV9Jvd+M6duxCIpMo2Yqz6Pr+N3vWFImbV5OQRD8RrQn5IDPCcROJjtdvGKjejPGwggn4F7nbhS/4kNhJXiDbBAxpcRvWhiMuZQ3qJCFp9X5fUaXu0fw9MBDK9Sh1eIA==
X-Gm-Message-State: AOJu0YwekQpxciuUmGc3znkBohijRkea+uXe6USC1Bhv3DQ3fqdHquE3
	Dl3RztqE5rmK0dvl5ozhHJ1KiU9QjG/DwL4TNID2aArtPEw2T/1v
X-Google-Smtp-Source: AGHT+IEHVv47MCBTO3oVIqFgWdajN7wlNCl/jSds8/CGJgCQ37Kh93aRCf0Axc0OViBspeV6q/80Lg==
X-Received: by 2002:aa7:d409:0:b0:563:e961:98a9 with SMTP id z9-20020aa7d409000000b00563e96198a9mr6134964edq.13.1708350737933;
        Mon, 19 Feb 2024 05:52:17 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b005648cab22fcsm601563edt.1.2024.02.19.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:52:17 -0800 (PST)
Message-ID: <b951d63b0c53e94ae9585ced6a9965c6befcd1dc.camel@gmail.com>
Subject: Re: [PATCH v4 12/15] iio: addac: ad74413r: Use
 device_for_each_child_node_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
  Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,  Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>,  Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 14:55:38 +0100
In-Reply-To: <20240217164249.921878-13-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
	 <20240217164249.921878-13-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-17 at 16:42 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
>=20
> The use of fwnode_for_each_available_child_node() here is assumed
> to have been down to a false assumption that device_for_each_child_node()
> doesn't check avaialble - so this transition to the scoped
> device_for_each_child_node_scoped() is equivalent.
>=20
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/addac/ad74413r.c | 10 ++--------
> =C2=A01 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 7af3e4b8fe3b..cd26a16dc0ff 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1255,21 +1255,15 @@ static int ad74413r_parse_channel_config(struct
> iio_dev *indio_dev,
> =C2=A0static int ad74413r_parse_channel_configs(struct iio_dev *indio_dev=
)
> =C2=A0{
> =C2=A0	struct ad74413r_state *st =3D iio_priv(indio_dev);
> -	struct fwnode_handle *channel_node =3D NULL;
> =C2=A0	int ret;
> =C2=A0
> -	fwnode_for_each_available_child_node(dev_fwnode(st->dev),
> channel_node) {
> +	device_for_each_child_node_scoped(st->dev, channel_node) {
> =C2=A0		ret =3D ad74413r_parse_channel_config(indio_dev, channel_node);
> =C2=A0		if (ret)
> -			goto put_channel_node;
> +			return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> -
> -put_channel_node:
> -	fwnode_handle_put(channel_node);
> -
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad74413r_setup_channels(struct iio_dev *indio_dev)



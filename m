Return-Path: <linux-iio+bounces-1674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D755082D6F6
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F9E1C217BE
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F24F9C1;
	Mon, 15 Jan 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egaCaysk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C91E864;
	Mon, 15 Jan 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3368abe1093so6644233f8f.2;
        Mon, 15 Jan 2024 02:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313640; x=1705918440; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PWXR+2mvbBN228Uli6F4HdGU1aZEIn1O1c8Uhy166t8=;
        b=egaCayskyzVRGdZfZ7Cd0K5c5rg5+QDvpW7WvTrxcV5ZUT3RQMdGQxmkV625fbe6FX
         t+RrOfhmoEe2CP0PmXFCbPS1JgQSnGU668dSRXrWsS9BxApwys/YxRt1IoHXoeLtWKzA
         a3Swn2naI2Wn9TLsgNobsA8aX1GAQRZFVjqBgWnH3z7LuQmUE0+gRwt1WHQK6+X9BaTR
         sWs7QpZyfQOGnwdENv2XpucKJFVX4cD8LYxByUOFYPnMG3BU/1GaCBzz5Z6PAMokGJnC
         eL3cPl8DM9g/wetgMyDLMWsCGW7TvKqpOr52H1/yibk/qruSIHC5x6YckRR2j7DB+0/7
         OYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313640; x=1705918440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWXR+2mvbBN228Uli6F4HdGU1aZEIn1O1c8Uhy166t8=;
        b=Yd2B3hLMniM/RW0u1LDKToau0/fY9LyzKAmbnd6VuUkcfnKn+G5Wna19FNF8YhJeZR
         OofJ4rrJi44dxTYfG89ncUzNBupeZopcTjxyea1l60VlNVDx5jE2fvaOsJOynzx+Pllq
         zd2CKYyzcqUKlrRWDCKJU3Aj6JYokIvNv4xZpc+aVIWfZSDm504w497NjX7JBNx/htnD
         KNunv6uj/3834NTRhvwBV6fnciHlgOyeoYFkvLjxDyrZ8eA1RfE5FEoL1bHGKf/1xHgj
         T+RKhU77pFIYs7H50Vj9Lv7BlCxrB7jk5Uh6/WQaMcP5iQXAq0jrWcFr1R65iCTVz5aP
         7E3g==
X-Gm-Message-State: AOJu0Yw9K7SK67+jdPz2DKONiPkxuvYSj8rY1z0Xk9t8wyM5kgrcOoDI
	cRUzWPSmFEXYye/3pPvqHs8=
X-Google-Smtp-Source: AGHT+IEqHqAHs9gQtzMpaDokP3tC8lGEjxAleC/62PNHo3sw51CPuMCHSFc+B/As4caJabE+riSxsA==
X-Received: by 2002:a5d:630d:0:b0:337:6001:9ff5 with SMTP id i13-20020a5d630d000000b0033760019ff5mr2635482wru.60.1705313640419;
        Mon, 15 Jan 2024 02:14:00 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d6641000000b0033609584b9dsm11514132wrw.74.2024.01.15.02.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:14:00 -0800 (PST)
Message-ID: <137a0efdc57d7c150178d2aad35c2c51d3f82704.camel@gmail.com>
Subject: Re: [PATCH 09/13] iio: addac: ad74413r: Use __free(fwnode_handle)
 to replace fwnode_handle_put() calls
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 15 Jan 2024 11:17:12 +0100
In-Reply-To: <20240114172009.179893-10-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
	 <20240114172009.179893-10-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-14 at 17:20 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This use of the new cleanup.h scope based freeing infrastructure allows
> us to exit directly from error conditions within the
> fwnode_for_each_available_child_node(dev, child) loop. On normal exit
> from that loop no fwnode_handle reference will be held and the child
> pointer will be NULL thus making the automatically run
> fwnode_handle_put() a noop.
>=20
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/addac/ad74413r.c | 9 ++-------
> =C2=A01 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 7af3e4b8fe3b..ec9a466e118d 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1255,21 +1255,16 @@ static int ad74413r_parse_channel_config(struct
> iio_dev *indio_dev,
> =C2=A0static int ad74413r_parse_channel_configs(struct iio_dev *indio_dev=
)
> =C2=A0{
> =C2=A0	struct ad74413r_state *st =3D iio_priv(indio_dev);
> -	struct fwnode_handle *channel_node =3D NULL;
> +	struct fwnode_handle *channel_node __free(fwnode_handle) =3D NULL;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	fwnode_for_each_available_child_node(dev_fwnode(st->dev),
> channel_node) {
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



Return-Path: <linux-iio+bounces-15633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD142A380CC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F153B58A0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88544216E1B;
	Mon, 17 Feb 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkd66ySy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DC2165E2
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789614; cv=none; b=ZH84q724oqnIpIKheuHk/05osLe+SUTsHA8NqOskLMBie7l+m5om2TgzJWPbAdeCVZoxw8N8tXkrYLvGfCpXwyEDAru0ZshhSl5hbd+4UAzvInA2auHGlz1z6bPmcI4+U+ybekgASOAaPwvYcEMAgROX5eu6jVs7Y/+d8jBVvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789614; c=relaxed/simple;
	bh=hx6BdOEqPpK1NfHnwVg4U2930yrFcYMrReL1xIill/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxQlcX90dESAk8PMf+8U6INoLlttlrbl7iM/dfXyULzdG+TbgaVvZtOuctanuZCqIXxv5GUZEw0SVoOc/yUyXYtkvQD5vAtZ2JIRg5mxhYY4UFoOCiHUEImKkvjY7e8EhLBMm0GGM4M1+gWdjBK5Xxa6Sg45QUzZUUcXthSAL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkd66ySy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so8140041a12.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789610; x=1740394410; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sIXcf5wvqBI2Hn3OeOVapP5ujAVK/mI5c2uzj/bcGxM=;
        b=mkd66ySyWNQjM0fJkpkJiS02qK9G4miqCXVl/uOAk9YkWYMg6jVnRZhqZNmnp/cPVd
         KXtGEySSCVsqdJS4miWn3wcUQpnzZJx3zvF6XnlOSOZqGfSz+iJq6yTHmV8kYQ0Q+o6V
         ibYKND3apyRIAA5gw+bVKc6anhrqEwtmVrRRFSnTcDC+DOiCPzLBDsNn+88JUtYXUfnc
         aYIj+y9lygSxxDAUQjbDD2VXRiX0HK185yOyxSdpZAgyngOVbfaqJjMjOFvbmnLm220L
         bFj6oom4r+F7A4XFkieoDJBKvGFgf558oOz+G02j1Dqcqq4BZGKUBoMfTkXSZ4jcyPyr
         KpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789610; x=1740394410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIXcf5wvqBI2Hn3OeOVapP5ujAVK/mI5c2uzj/bcGxM=;
        b=SI0enMl7kVSHfUFWNhGP8DL8+X+AoTvmiQaJufhtrvLR3lDQOqSy30h212MJYeQMc6
         QpItQ9vY+CuYuYcxDqWAtgbC7BgIFcPEAoCNEfGa39Ohq58tnCARa7b9Y3OVLmrianFe
         MuPrLk9ea1vPHG+XnK6C7zazEWSsnezGmgC1b3z1n1YMBqS4+BL4W1uqY6OND6p5xvik
         Lt8k90T5qlqvRezCfQZkmUoSXnBh2ByOEWgGycVNxA7Z4778A2U2LXPDi+k614w7jZUv
         abu7WvwZQVVxehr7wKdmuXJpFbcCuGtnhJOKsk8WKt0DtqZFyXSdqLXHIpSX4a39MGfz
         UOEA==
X-Forwarded-Encrypted: i=1; AJvYcCV2X5upiT2MwsH0J4a5t43NRnLjN3cDWTdqZHH8U1LGUeg9Asm57Gpu/saG1B0e85z9OhRalFs8tsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6NruIU5EgeAJ2/JPXdTGxc5cUriwZS7IO20vUdUE6R70yys6
	p5pDrCLx5qTso2yGMwcGOE+PUQtB5dsvXKeBB+Ig05021STcLiYZ
X-Gm-Gg: ASbGnctCDtz5jk5nwL4iTleh1IpVbgtq2PCx46guOfeoKHvHy/ZHNp1Oj3dNf3MweNH
	tUUd4uKfaW614oLWzBc3WF5wTPsoMujeCFj1OXiklAT7VAzF7eoSYb8CcWoY0DgXllSNFbnGnIN
	7XvVFBr9tGc+ItIhjs8eHd2H6pXfJkC2sE/rI/ZRio6Cp1k14kpzzVfjDw+5vwRekk8oEhznQ1m
	Q6/4NGNXfOuMJhUxxQFFlPqECDlOyG18tbEaPyGjN5R40IB+5OiOVcLddDg9CzNYTdQxEVYfSU3
	tDBkMfsIBRqE/2i3xGaxbDP8n8V9yeIXoApyaV2nyfuh2hEakPBMYEPVuJiMRVY=
X-Google-Smtp-Source: AGHT+IEVSqtaUtB2yeQSmkTHDrgepAswp2QcnYEemuRArTcF2HdMUufsfNnqlioGiuQyduhCwGoUeg==
X-Received: by 2002:a05:6402:354f:b0:5dc:89e0:8eb3 with SMTP id 4fb4d7f45d1cf-5e0360b4ac4mr9114809a12.11.1739789608414;
        Mon, 17 Feb 2025 02:53:28 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28809asm7013653a12.73.2025.02.17.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:53:28 -0800 (PST)
Message-ID: <fd71c45de33a4757a426289e64bff3da46811e0e.camel@gmail.com>
Subject: Re: [PATCH v2 22/27] iio: dac: ad3552r-hs: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:53:31 +0000
In-Reply-To: <20250209180624.701140-23-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-23-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
>=20
> Cc: Angelo Dureghello <adureghello@baylibre.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.c | 15 +++++++++------
> =C2=A01 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index c1dae58c1975..cd8dabb60c55 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -129,16 +129,19 @@ static int ad3552r_hs_write_raw(struct iio_dev
> *indio_dev,
> =C2=A0				int val, int val2, long mask)
> =C2=A0{
> =C2=A0	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		/* For RAW accesses, stay always in simple-spi. */
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			return st->data->bus_reg_write(st->back,
> -				=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_CH_DAC_16B(chan-
> >channel),
> -				=C2=A0=C2=A0=C2=A0 val, 2);
> -		}
> -		unreachable();
> +		ret =3D st->data->bus_reg_write(st->back,
> +			AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> +			val, 2);
> +
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}



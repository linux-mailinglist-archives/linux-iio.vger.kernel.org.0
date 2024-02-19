Return-Path: <linux-iio+bounces-2758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E7859FA0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A821F21914
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AB22F1C;
	Mon, 19 Feb 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqsT6jgM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74562376C
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334591; cv=none; b=cCQBy4nuu+ffRVA6LXqZ8wxJSQSMojlair+3FeVV/D3dqBcNcWSixWk8l2Fa14AdiF08vqyzoM18oPl40c5J6uC/0YsysjcABptdp33Z91oxpBEe74sZCuXsY576sJoj8EYWQbyG43cSFIAu2AJ0O1HaqLJNS8/7cBwdMwAF2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334591; c=relaxed/simple;
	bh=RQEDW5uUY7a6ikKk7mnl9ObIqgD321saV95k7INseCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ExnvEyQigaYM9A/gh/McsilB/CZ1Xc5al1cDnrgiPLV7ZwbyNMVJNNkSQICGiKRD9aWxbUCYVchlYkz0AhPMOf2Mh0eKS+wSJeRiwFTzl3qLLnNpJ97i28MzJzMdNTX/hJ6Jq5xFcC6oLcPp1Jd8P7uWPoMM6OjFJgmHnxR0/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqsT6jgM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2a17f3217aso524716666b.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 01:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708334588; x=1708939388; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=thkXRFF0Bueo1E8aUKucVys/hfNElWrR7q2twXmwbjQ=;
        b=CqsT6jgMU0gCWiF7j5EGOtWDvpRhXX0QGDxoL+Soii3rcGBzgz/xglA0BHCiFuCSry
         pEJRTbGMOdHnB71gAI6Qj64Bq1f2JYBL7axPsnhMwjBrN8l3PeaTAqKH5hJ5rMgudp6E
         0qOsIuaOAM8b2SzrefZ02I1v4++reJlKLtKFUJJT9WJ2gLnl6kLatc8jMD/GFljBsDXZ
         u4+8xxIkyvsrBH+9EjVlYJF8fNL+aK6A4/7Bpg0ZR5zrkmkjcKQhxHo7cAJi4r+jf5FY
         gQmHkK39t4z6twPVy2pqi7D/HG3rYZ2jFHPGt3/HIfYq/AX2zKJHym704gA2dla7Vk54
         ECTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334588; x=1708939388;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thkXRFF0Bueo1E8aUKucVys/hfNElWrR7q2twXmwbjQ=;
        b=e1sxJgrFsVwzkgkE5//+kdSWtCDDXKV9KRwuVdPfw7nnGiy3t0Cd7IqMFnHdDya0gK
         TRz90g/k/VVklC6GdSFHgIQ6qiVYRPx1dj/OeLGStJhkfuWjfRD/LOarq3aykGfLJpUx
         +vucK1e+3u3tLI6sLCOktI0ArBG6h/taN5K6begrzB157IwcpERkdfftINVi+d4hPwwc
         obbOz3Y+UAUlwgk7EJR2GTHn4X8BUoDzq5YXQOjKl6kFns25lu8WL5ouwWxgpJew9bZT
         rXwi5SxGxbhortZVe1eWhfsldJfrOXiZoZcIIFDrlcv2b+m6VA+WCmLWiIOtz4sBhjQY
         9SIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhfxVXaGViiYGOat32B0/4/2nRkQap7IAlydmOyEtRZNE7+MbfJW4ACNmUcKpQGSuNqV/AweSUU97KTQVskRaFIYtF/t4SvyQe
X-Gm-Message-State: AOJu0YyT84H3ZeENUtAPC13msMuUlyhmJxp522vXYuJ9ohYIpVhsrK60
	rDem8aJpGRltxoic+NZfSGNGrPovFfq4TLnntYAQKa3PKHEamvIP
X-Google-Smtp-Source: AGHT+IHhOKQ+tzB4Cspshp9tuC8kgLGx+ldYn+C3KCebcFfLU81MeM0ye6GxyGTdtUTgFk3yxSB6Vw==
X-Received: by 2002:a17:906:b094:b0:a3d:1cbd:67f7 with SMTP id x20-20020a170906b09400b00a3d1cbd67f7mr7747690ejy.0.1708334587859;
        Mon, 19 Feb 2024 01:23:07 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id r8-20020a170906364800b00a3e4e7ad9dbsm1819667ejb.68.2024.02.19.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:23:07 -0800 (PST)
Message-ID: <693f716204a25da85239ba121c2802171d041989.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: ad7292: Switch from of specific to fwnode
 property handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Andy
	Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Alisa-Dariana Roman <alisa.roman@analog.com>, Haibo
 Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 10:26:29 +0100
In-Reply-To: <20240218172731.1023367-5-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
	 <20240218172731.1023367-5-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-18 at 17:27 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This reduces the wrong of device tree only IIO drivers that might
> be copied by converting over this simple case.
> Makes use of the new _scoped() handling to automatically release
> the fwnode_handle on early exit from the loop.
>=20
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7292.c | 13 ++++++-------
> =C2=A01 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index cccacec5db6d..6aadd14f459d 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -8,7 +8,8 @@
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0
> @@ -260,7 +261,6 @@ static int ad7292_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct ad7292_state *st;
> =C2=A0	struct iio_dev *indio_dev;
> -	struct device_node *child;
> =C2=A0	bool diff_channels =3D false;
> =C2=A0	int ret;
> =C2=A0
> @@ -305,12 +305,11 @@ static int ad7292_probe(struct spi_device *spi)
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->info =3D &ad7292_info;
> =C2=A0
> -	for_each_available_child_of_node(spi->dev.of_node, child) {
> -		diff_channels =3D of_property_read_bool(child, "diff-
> channels");
> -		if (diff_channels) {
> -			of_node_put(child);
> +	device_for_each_child_node_scoped(&spi->dev, child) {
> +		diff_channels =3D fwnode_property_read_bool(child,
> +							=C2=A0 "diff-channels");
> +		if (diff_channels)
> =C2=A0			break;
> -		}
> =C2=A0	}
> =C2=A0
> =C2=A0	if (diff_channels) {



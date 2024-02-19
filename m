Return-Path: <linux-iio+bounces-2779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99385A520
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 14:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E2A1F22818
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7B4364C6;
	Mon, 19 Feb 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUJOmKvE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C58364A9;
	Mon, 19 Feb 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350681; cv=none; b=Y3F8Aecir1B92ZVC9VAawbpbJyOgl6ADQPSascRrl5qtmdtyOhk9tlJB+T3tJ0j99mYMijOHei0S5r+pRKxfzQ2SsHlMWUhAINdXSYTThcrz947+vLkJKboz3uzmgIGQf6G1+b5sZ+mK/lxm2X7olaLuq9FSedGrVStc6QTJJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350681; c=relaxed/simple;
	bh=DeQ8SIdWHMzO2oYe18TAaGCWY6oYfZgZK5s/BDhca8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwdhjiWeO59K/nXAAg8GPQZ7oRWbH8c4pxn/0mMsXyCCm4Ky+MGVXnShv+4myXcpUFt1gyn1Nn8i+i2pf2K6wPbWSkkv6TK8P524yiLRSpNgKnGYxYr+0ovf8fFoC/3hiF0JTwH7qlDkMWrsx0Ie4h+6sRzoCQmAWb93c0okp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUJOmKvE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so585837a12.0;
        Mon, 19 Feb 2024 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708350678; x=1708955478; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7P8gxMu49yl5OF0t/X5MShPNpsrtS3Yx/yaIimXFrCo=;
        b=MUJOmKvEnGKwVRCOduRNW8OWf3rvLoohfyNsEbqU9RdollYTu5TGQT9G8TfmANcyr8
         rMEJyRXuxkKbUXeVoKzdYAbReKTyj2uPP96HjEC7+CjwqMMBU4DtLhPhR6N0UAU6st/N
         bzmT7tfUUNuCxmX6/l1IODsVEW2AXd5nvPr7eeidnBylqV8Uiwlig1X+87wdEnSxSQhi
         YDcjBIUIMEMTUGh32xv+8fqSl1msMvxyT5KYLmm3M8pH9TkaUJ2ctjP2ZnSB3IF24x+9
         3ig3uzJQSIOSmnxJaviIoh5EiLIfRk5BocF6tpIQD6ML845pPciU+TQ5eo3Zx/ugz4v/
         2rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350678; x=1708955478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7P8gxMu49yl5OF0t/X5MShPNpsrtS3Yx/yaIimXFrCo=;
        b=YSD9OcbntjfZab085SJM1Ivny0nByqFOQ0SmOXeb+5PLmiwlX1sidmpUMXQKGZHxyl
         MjQobY7kXY46fub+V8z3D4jstmmIVkU9xt0KNX/QmLolZq8GxtcJvx1EsAkxwxcowDeu
         FL2uIGJd104+AmTWABbO5fNCKryxqrz3r5yZp55RXNbUbEDUNgYr8npHbJtm7ldDbNOi
         79RiKFbjyWWLNgAcT24MSbU9T/o4n4ZkL1sl42DxhaK+Rax+z8AoqZXnJgxf1ztSlsW1
         Ej/AqfUeqp2yiB1o9lmcl95v+yQrxgbb682Ifl952uuF1luOJ3VY9Q2rsPBxJl/rtM5r
         8M9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUwAL/0ZTqJVzpbe12ldpjG9dfnvE0tnBzzZGrLno8H/oRyn9gOzEA4yo4lhXFEyUWpNnQJHofrdbDNPnwGyOqVK/2OD5EwEyXEHTk+ViBPIkWlC+moU6IezWmbuiCFGWQ1KFk+w==
X-Gm-Message-State: AOJu0YwOBLQ4wM01NhSh6vrXA5M5p8LmGuLKysAYzEAmRwEbb3nSJRka
	fs2ORM/pW+xCzQIxG61Zm1n7X8dMXtG3nfh0G/FJyIM0nJD7DKXToQLYPyz8wjeOAqqz
X-Google-Smtp-Source: AGHT+IEAMa/7Ubuux5PeJiwDxyuqIwHXJUYIfXKaEeI/BQJyWO6rsbTBMxmkODTjKJ8RU1K/Sq7KpA==
X-Received: by 2002:a17:906:3c0b:b0:a3e:b304:8176 with SMTP id h11-20020a1709063c0b00b00a3eb3048176mr1295905ejg.43.1708350677866;
        Mon, 19 Feb 2024 05:51:17 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id tj9-20020a170907c24900b00a3ca56e9bcfsm2976909ejc.187.2024.02.19.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:51:17 -0800 (PST)
Message-ID: <12b9675afa622d4119d8c27e9a55faf701caa7d4.camel@gmail.com>
Subject: Re: [PATCH v4 05/15] iio: adc: max11410: Use
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
Date: Mon, 19 Feb 2024 14:54:38 +0100
In-Reply-To: <20240217164249.921878-6-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
	 <20240217164249.921878-6-jic23@kernel.org>
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
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/max11410.c | 27 +++++++--------------------
> =C2=A01 file changed, 7 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index 6af829349b4e..45368850b220 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -696,7 +696,6 @@ static int max11410_parse_channels(struct max11410_st=
ate
> *st,
> =C2=A0	struct device *dev =3D &st->spi_dev->dev;
> =C2=A0	struct max11410_channel_config *cfg;
> =C2=A0	struct iio_chan_spec *channels;
> -	struct fwnode_handle *child;
> =C2=A0	u32 reference, sig_path;
> =C2=A0	const char *node_name;
> =C2=A0	u32 inputs[2], scale;
> @@ -720,7 +719,7 @@ static int max11410_parse_channels(struct max11410_st=
ate
> *st,
> =C2=A0	if (!st->channels)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	device_for_each_child_node(dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
> =C2=A0		node_name =3D fwnode_get_name(child);
> =C2=A0		if (fwnode_property_present(child, "diff-channels")) {
> =C2=A0			ret =3D fwnode_property_read_u32_array(child,
> @@ -735,47 +734,37 @@ static int max11410_parse_channels(struct max11410_=
state
> *st,
> =C2=A0			inputs[1] =3D 0;
> =C2=A0			chanspec.differential =3D 0;
> =C2=A0		}
> -		if (ret) {
> -			fwnode_handle_put(child);
> +		if (ret)
> =C2=A0			return ret;
> -		}
> =C2=A0
> =C2=A0		if (inputs[0] > MAX11410_CHANNEL_INDEX_MAX ||
> -		=C2=A0=C2=A0=C2=A0 inputs[1] > MAX11410_CHANNEL_INDEX_MAX) {
> -			fwnode_handle_put(child);
> +		=C2=A0=C2=A0=C2=A0 inputs[1] > MAX11410_CHANNEL_INDEX_MAX)
> =C2=A0			return dev_err_probe(&indio_dev->dev, -EINVAL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel index for %s,
> should be less than %d\n",
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 node_name,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 MAX11410_CHANNEL_INDEX_MAX + 1);
> -		}
> =C2=A0
> =C2=A0		cfg =3D &st->channels[chan_idx];
> =C2=A0
> =C2=A0		reference =3D MAX11410_REFSEL_AVDD_AGND;
> =C2=A0		fwnode_property_read_u32(child, "adi,reference", &reference);
> -		if (reference > MAX11410_REFSEL_MAX) {
> -			fwnode_handle_put(child);
> +		if (reference > MAX11410_REFSEL_MAX)
> =C2=A0			return dev_err_probe(&indio_dev->dev, -EINVAL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,reference value for
> %s, should be less than %d.\n",
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 node_name, MAX11410_REFSEL_MAX +
> 1);
> -		}
> =C2=A0
> =C2=A0		if (!max11410_get_vrefp(st, reference) ||
> -		=C2=A0=C2=A0=C2=A0 (!max11410_get_vrefn(st, reference) && reference <=
=3D 2)) {
> -			fwnode_handle_put(child);
> +		=C2=A0=C2=A0=C2=A0 (!max11410_get_vrefn(st, reference) && reference <=
=3D 2))
> =C2=A0			return dev_err_probe(&indio_dev->dev, -EINVAL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid VREF configuration for
> %s, either specify corresponding VREF regulators or change adi,reference
> property.\n",
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 node_name);
> -		}
> =C2=A0
> =C2=A0		sig_path =3D MAX11410_PGA_SIG_PATH_BUFFERED;
> =C2=A0		fwnode_property_read_u32(child, "adi,input-mode", &sig_path);
> -		if (sig_path > MAX11410_SIG_PATH_MAX) {
> -			fwnode_handle_put(child);
> +		if (sig_path > MAX11410_SIG_PATH_MAX)
> =C2=A0			return dev_err_probe(&indio_dev->dev, -EINVAL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,input-mode value
> for %s, should be less than %d.\n",
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 node_name, MAX11410_SIG_PATH_MAX
> + 1);
> -		}
> =C2=A0
> =C2=A0		fwnode_property_read_u32(child, "settling-time-us",
> =C2=A0					 &cfg->settling_time_us);
> @@ -793,10 +782,8 @@ static int max11410_parse_channels(struct max11410_s=
tate
> *st,
> =C2=A0			cfg->scale_avail =3D devm_kcalloc(dev,
> MAX11410_SCALE_AVAIL_SIZE * 2,
> =C2=A0							sizeof(*cfg-
> >scale_avail),
> =C2=A0							GFP_KERNEL);
> -			if (!cfg->scale_avail) {
> -				fwnode_handle_put(child);
> +			if (!cfg->scale_avail)
> =C2=A0				return -ENOMEM;
> -			}
> =C2=A0
> =C2=A0			scale =3D max11410_get_scale(st, *cfg);
> =C2=A0			for (i =3D 0; i < MAX11410_SCALE_AVAIL_SIZE; i++) {



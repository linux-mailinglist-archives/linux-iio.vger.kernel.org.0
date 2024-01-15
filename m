Return-Path: <linux-iio+bounces-1675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98982D6FC
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F2B2127F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D663F9D1;
	Mon, 15 Jan 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNmghCiW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949831426A;
	Mon, 15 Jan 2024 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e8004629bso1036115e9.2;
        Mon, 15 Jan 2024 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313760; x=1705918560; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZaw1APOcLyr18JIoL9y/e5q17nKcNRjgUr16nZsSM0=;
        b=ZNmghCiWhcmqq9/dzf91D4+gnV751zcDpqXhxB0mh0IC9ZNbL2jDKmCtZ5vShS3SaS
         zc2mL+HQ/bw3/uzR6DCv9ST/+lmTaC8SsxiOnaxbgetBDEz61cxS87QOO/wUgafG0B/o
         NVJM+3N+FOUQlw6QMJnpw933jeXjc105dMy9yhN/tRsnrl9qdn/DkbOPTyBlWRXE3WLT
         PTnhsWXVbc13F5wMlIWTORa7DJqxqgOyke9VuqGvNUeZqoxo5xED/D9dkL+fBzAZpFRI
         P231SRJ8B7BkbT+w1wrAOnskwFdsYYtIb52E/8XidxHVqvAsgnVSqtMup7Cwd929D1aP
         o7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313760; x=1705918560;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZaw1APOcLyr18JIoL9y/e5q17nKcNRjgUr16nZsSM0=;
        b=e26AkBaWm1kT8/YQIfg1uU7rFAkF9BTDXExF+5Y73VwgFpW80Cb0TCMUchJUB0r3ts
         yyZ8MOvxP4I2bMavlNW5CqBMV7RXS45w0iKH4JaTerk7wEU2281PHnb5KaHs11i2vKb/
         NIkqc3I7GUedO+SY1igtCPig11zk8p4JN3IC5vSUSkw6VWTvB0s/LxaJsa/Cl0WROWP/
         RbtC4Kx4umnSta01tgz/nhPL2Mtat7Wf2Fx8EsiGazhn+Wl4S4xcykd/YIaXitfZwwBd
         kBl8/ggzJhiULDBwfR0XP7BfafBjXELn1rWtC9+g0i7y1y3n+CVFw7aMq37eEiDg9M69
         MV5A==
X-Gm-Message-State: AOJu0YwMd0POlcT5ad20u7UV/h2yTwwRrJzdiweG7cYuPooSuV0o5xtD
	r1LjuKAvmww9e/6FKLoa6pLrAlSx2FCzlaMB8J4=
X-Google-Smtp-Source: AGHT+IGagxWaQ5aygmFSJu3YLm8VrWQ8l+hwPzYeGk4Ja+EHzZePCNtcNPuB4T02yYADCLtkO3qS4A==
X-Received: by 2002:a05:600c:68b:b0:40e:5661:870b with SMTP id a11-20020a05600c068b00b0040e5661870bmr1913464wmn.139.1705313759592;
        Mon, 15 Jan 2024 02:15:59 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c1d8200b0040e762dacfbsm4279731wms.30.2024.01.15.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:15:59 -0800 (PST)
Message-ID: <a297f0c967dbf0ce9dfe441b98ea0f8a07e25597.camel@gmail.com>
Subject: Re: [PATCH 10/13] iio: dac: ad3552: Use __free(fwnode_handle) to
 replace fwnode_handle_put() calls
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>,  Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 15 Jan 2024 11:19:11 +0100
In-Reply-To: <20240114172009.179893-11-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
	 <20240114172009.179893-11-jic23@kernel.org>
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
> device_for_each_child_node(dev, child) loop. On normal exit from that
> loop no fwnode_handle reference will be held and the child pointer
> will be NULL thus making the automatically run fwnode_handle_put() a
> noop.
>=20
> Removing the goto err; statements also allows more extensive use of
> dev_err_probe() further simplifying the code.
>=20
> Cc: Mihail Chindris <mihail.chindris@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r.c | 50 +++++++++++++++---------------------=
---
> =C2=A01 file changed, 19 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index a492e8f2fc0f..f21c88cb480a 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -880,7 +880,7 @@ static void ad3552r_reg_disable(void *reg)
> =C2=A0static int ad3552r_configure_device(struct ad3552r_desc *dac)
> =C2=A0{
> =C2=A0	struct device *dev =3D &dac->spi->dev;
> -	struct fwnode_handle *child;
> +	struct fwnode_handle *child __free(fwnode_handle) =3D NULL;
> =C2=A0	struct regulator *vref;
> =C2=A0	int err, cnt =3D 0, voltage, delta =3D 100000;
> =C2=A0	u32 vals[2], val, ch;
> @@ -951,51 +951,43 @@ static int ad3552r_configure_device(struct ad3552r_=
desc
> *dac)
> =C2=A0
> =C2=A0	device_for_each_child_node(dev, child) {
> =C2=A0		err =3D fwnode_property_read_u32(child, "reg", &ch);
> -		if (err) {
> -			dev_err(dev, "mandatory reg property missing\n");
> -			goto put_child;
> -		}
> -		if (ch >=3D AD3552R_NUM_CH) {
> -			dev_err(dev, "reg must be less than %d\n",
> -				AD3552R_NUM_CH);
> -			err =3D -EINVAL;
> -			goto put_child;
> -		}
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "mandatory reg property
> missing\n");
> +		if (ch >=3D AD3552R_NUM_CH)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "reg must be less than %d\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_NUM_CH);
> =C2=A0
> =C2=A0		if (fwnode_property_present(child, "adi,output-range-
> microvolt")) {
> =C2=A0			err =3D fwnode_property_read_u32_array(child,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 "adi,output-
> range-microvolt",
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 vals,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 2);
> -			if (err) {
> -				dev_err(dev,
> +			if (err)
> +				return dev_err_probe(dev, err,
> =C2=A0					"adi,output-range-microvolt property
> could not be parsed\n");
> -				goto put_child;
> -			}
> =C2=A0
> =C2=A0			err =3D ad3552r_find_range(dac->chip_id, vals);
> -			if (err < 0) {
> -				dev_err(dev,
> -					"Invalid adi,output-range-microvolt
> value\n");
> -				goto put_child;
> -			}
> +			if (err < 0)
> +				return dev_err_probe(dev, err,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,output-
> range-microvolt value\n");
> +
> =C2=A0			val =3D err;
> =C2=A0			err =3D ad3552r_set_ch_value(dac,
> =C2=A0						=C2=A0=C2=A0
> AD3552R_CH_OUTPUT_RANGE_SEL,
> =C2=A0						=C2=A0=C2=A0 ch, val);
> =C2=A0			if (err)
> -				goto put_child;
> +				return err;
> =C2=A0
> =C2=A0			dac->ch_data[ch].range =3D val;
> =C2=A0		} else if (dac->chip_id =3D=3D AD3542R_ID) {
> -			dev_err(dev,
> -				"adi,output-range-microvolt is required for
> ad3542r\n");
> -			err =3D -EINVAL;
> -			goto put_child;
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "adi,output-range-microvolt is
> required for ad3542r\n");
> =C2=A0		} else {
> =C2=A0			err =3D ad3552r_configure_custom_gain(dac, child, ch);
> =C2=A0			if (err)
> -				goto put_child;
> +				return err;
> =C2=A0		}
> =C2=A0
> =C2=A0		ad3552r_calc_gain_and_offset(dac, ch);
> @@ -1003,7 +995,7 @@ static int ad3552r_configure_device(struct ad3552r_d=
esc
> *dac)
> =C2=A0
> =C2=A0		err =3D ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> =C2=A0		if (err < 0)
> -			goto put_child;
> +			return err;
> =C2=A0
> =C2=A0		dac->channels[cnt] =3D AD3552R_CH_DAC(ch);
> =C2=A0		++cnt;
> @@ -1021,10 +1013,6 @@ static int ad3552r_configure_device(struct ad3552r=
_desc
> *dac)
> =C2=A0	dac->num_ch =3D cnt;
> =C2=A0
> =C2=A0	return 0;
> -put_child:
> -	fwnode_handle_put(child);
> -
> -	return err;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad3552r_init(struct ad3552r_desc *dac)



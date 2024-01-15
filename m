Return-Path: <linux-iio+bounces-1677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B505282D751
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD0B1F2219B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B51B805;
	Mon, 15 Jan 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJPK8MGp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64422BAFB;
	Mon, 15 Jan 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e416f303so31280035ad.0;
        Mon, 15 Jan 2024 02:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705314411; x=1705919211; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXIv0fOPKjRpa8NR0+rh/yu678BAVx86+SltTsqGkas=;
        b=MJPK8MGpPBIuX9bVEqCdFy0f9j40Ehmcsp+DpVBffoBiMw44rTG7KQZ2wPDobuM8yz
         dhkN9jBvQEJoDaOeiyF8WvWSDc/GwJFG2pQommZYOOfcGnwouMShCCHfCu2W18XCINzT
         Top4Za8bpKK1M4jIgktiUO5gPuZk6QQTuYA8idc9oTfxWY24QoX47lHH6JZXbrzLYSuh
         x+n8qMHXob4yRH5oGtaRRztqocasIRlPR5KBqy1TKyHuVcv768h1TDCSpT692FiY+gtP
         3E7zLipHTLSWC7aKl/lvsxsQ60m4abnNjQDFiBu9PTk2yDC+ixBRhDF4E/JBsIIJqqFE
         SFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314411; x=1705919211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXIv0fOPKjRpa8NR0+rh/yu678BAVx86+SltTsqGkas=;
        b=umncRphLzowEXEG0YlzbFgHiVs9P6NOtCre4/zFt6kcMM6gfkyl35En0q7kHz2ktnQ
         Vl3f0nJgKxABBg163dB4NjqPkk5vn+QAWnfmNmEjmLdojzc5mntyMRabNJtvcqmTrcoZ
         QtMknmNDmk8pBerhClCYhuGzIlvFVPGwiqxlC/sHvrIc0TkiOY7KoD/GQGl3gEtsV2l4
         BSV80CDCsErtq+ycgBKQQDMuxlgI5OsUtT5sPNLiHYMxDmtuGGkE1lKnSVkrPBKmBi+w
         kB9eQT2J4+dBkypaG1P5hC/co7a8I9zTIbq7Jccr6tju9ZLRh8EQYqV6UEpBTjZl2728
         QXLA==
X-Gm-Message-State: AOJu0YxiDqhEvX6ODdJ2Sf+VRZ0Ertix8y3W5Vy9YmSy2gQH/wbKFLXX
	3TlzrMv3KtKSKyUM1zxYWpo=
X-Google-Smtp-Source: AGHT+IHuhqF0aUwZLrw+QxjGgFGvpkq8X4OWWsGp63dz4iCshTAPW4IWUCF93y2mWLLi3DiLbSZF6w==
X-Received: by 2002:a17:902:654a:b0:1d5:693a:8904 with SMTP id d10-20020a170902654a00b001d5693a8904mr2421543pln.5.1705314410796;
        Mon, 15 Jan 2024 02:26:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id kt13-20020a170903088d00b001d49607f8b5sm7330839plb.34.2024.01.15.02.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:26:50 -0800 (PST)
Message-ID: <6c2715f597a7005765429196630cafb7f4279d25.camel@gmail.com>
Subject: Re: [PATCH 13/13] iio: temp: ltc2983: Use __free(fwnode_handle) to
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
Date: Mon, 15 Jan 2024 11:29:57 +0100
In-Reply-To: <20240114172009.179893-14-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
	 <20240114172009.179893-14-jic23@kernel.org>
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
> us to exit directly from error conditions and in the good path with
> the reference obtained from fwnode_find_reference() (which may be an erro=
r
> pointer) automatically released.
>=20
> Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

I guess this one could also benefit from using dev_err_probe(). Anyways:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

I might also be able to test this one...

> =C2=A0drivers/iio/temperature/ltc2983.c | 70 ++++++++++------------------=
---
> =C2=A01 file changed, 21 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/ltc2983.c
> b/drivers/iio/temperature/ltc2983.c
> index fcb96c44d954..4357364e611e 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -656,7 +656,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle
> *child, struct ltc2983_data
> =C2=A0			 const struct ltc2983_sensor *sensor)
> =C2=A0{
> =C2=A0	struct ltc2983_thermocouple *thermo;
> -	struct fwnode_handle *ref;
> +	struct fwnode_handle *ref __free(fwnode_handle) =3D NULL;
> =C2=A0	u32 oc_current;
> =C2=A0	int ret;
> =C2=A0
> @@ -714,7 +714,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle
> *child, struct ltc2983_data
> =C2=A0			 * the error right away.
> =C2=A0			 */
> =C2=A0			dev_err(&st->spi->dev, "Property reg must be
> given\n");
> -			goto fail;
> +			return ERR_PTR(ret);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -725,22 +725,15 @@ ltc2983_thermocouple_new(const struct fwnode_handle
> *child, struct ltc2983_data
> =C2=A0		thermo->custom =3D __ltc2983_custom_sensor_new(st, child,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 propname, false,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 16384, true);
> -		if (IS_ERR(thermo->custom)) {
> -			ret =3D PTR_ERR(thermo->custom);
> -			goto fail;
> -		}
> +		if (IS_ERR(thermo->custom))
> +			return ERR_CAST(thermo->custom);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* set common parameters */
> =C2=A0	thermo->sensor.fault_handler =3D ltc2983_thermocouple_fault_handle=
r;
> =C2=A0	thermo->sensor.assign_chan =3D ltc2983_thermocouple_assign_chan;
> =C2=A0
> -	fwnode_handle_put(ref);
> =C2=A0	return &thermo->sensor;
> -
> -fail:
> -	fwnode_handle_put(ref);
> -	return ERR_PTR(ret);
> =C2=A0}
> =C2=A0
> =C2=A0static struct ltc2983_sensor *
> @@ -750,7 +743,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, st=
ruct
> ltc2983_data *st,
> =C2=A0	struct ltc2983_rtd *rtd;
> =C2=A0	int ret =3D 0;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *ref;
> +	struct fwnode_handle *ref __free(fwnode_handle) =3D NULL;
> =C2=A0	u32 excitation_current =3D 0, n_wires =3D 0;
> =C2=A0
> =C2=A0	rtd =3D devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
> @@ -766,7 +759,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, st=
ruct
> ltc2983_data *st,
> =C2=A0	ret =3D fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "Property reg must be given\n");
> -		goto fail;
> +		return ERR_PTR(ret);
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D fwnode_property_read_u32(child, "adi,number-of-wires",
> &n_wires);
> @@ -787,8 +780,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, st=
ruct
> ltc2983_data *st,
> =C2=A0			break;
> =C2=A0		default:
> =C2=A0			dev_err(dev, "Invalid number of wires:%u\n",
> n_wires);
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return ERR_PTR(-EINVAL);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -798,8 +790,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, st=
ruct
> ltc2983_data *st,
> =C2=A0			if (n_wires =3D=3D 2 || n_wires =3D=3D 3) {
> =C2=A0				dev_err(dev,
> =C2=A0					"Rotation not allowed for 2/3 Wire
> RTDs");
> -				ret =3D -EINVAL;
> -				goto fail;
> +				return ERR_PTR(-EINVAL);
> =C2=A0			}
> =C2=A0			rtd->sensor_config |=3D LTC2983_RTD_C_ROTATE(1);
> =C2=A0		} else {
> @@ -829,16 +820,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child,
> struct ltc2983_data *st,
> =C2=A0				"Invalid rsense chann:%d to use in kelvin
> rsense",
> =C2=A0				rtd->r_sense_chan);
> =C2=A0
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return ERR_PTR(-EINVAL);
> =C2=A0		}
> =C2=A0
> =C2=A0		if (sensor->chan < min || sensor->chan > max) {
> =C2=A0			dev_err(dev, "Invalid chann:%d for the rtd config",
> =C2=A0				sensor->chan);
> =C2=A0
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return ERR_PTR(-EINVAL);
> =C2=A0		}
> =C2=A0	} else {
> =C2=A0		/* same as differential case */
> @@ -846,8 +835,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, st=
ruct
> ltc2983_data *st,
> =C2=A0			dev_err(&st->spi->dev,
> =C2=A0				"Invalid chann:%d for RTD", sensor->chan);
> =C2=A0
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return ERR_PTR(-EINVAL);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -856,10 +844,8 @@ ltc2983_rtd_new(const struct fwnode_handle *child, s=
truct
> ltc2983_data *st,
> =C2=A0		rtd->custom =3D __ltc2983_custom_sensor_new(st, child,
> =C2=A0							=C2=A0 "adi,custom-rtd",
> =C2=A0							=C2=A0 false, 2048,
> false);
> -		if (IS_ERR(rtd->custom)) {
> -			ret =3D PTR_ERR(rtd->custom);
> -			goto fail;
> -		}
> +		if (IS_ERR(rtd->custom))
> +			return ERR_CAST(rtd->custom);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* set common parameters */
> @@ -901,18 +887,13 @@ ltc2983_rtd_new(const struct fwnode_handle *child,
> struct ltc2983_data *st,
> =C2=A0			dev_err(&st->spi->dev,
> =C2=A0				"Invalid value for excitation current(%u)",
> =C2=A0				excitation_current);
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return ERR_PTR(-EINVAL);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> =C2=A0	fwnode_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
> =C2=A0
> -	fwnode_handle_put(ref);
> =C2=A0	return &rtd->sensor;
> -fail:
> -	fwnode_handle_put(ref);
> -	return ERR_PTR(ret);
> =C2=A0}
> =C2=A0
> =C2=A0static struct ltc2983_sensor *
> @@ -921,7 +902,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *ch=
ild,
> struct ltc2983_data *s
> =C2=A0{
> =C2=A0	struct ltc2983_thermistor *thermistor;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *ref;
> +	struct fwnode_handle *ref __free(fwnode_handle) =3D NULL;
> =C2=A0	u32 excitation_current =3D 0;
> =C2=A0	int ret =3D 0;
> =C2=A0
> @@ -938,7 +919,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *ch=
ild,
> struct ltc2983_data *s
> =C2=A0	ret =3D fwnode_property_read_u32(ref, "reg", &thermistor-
> >r_sense_chan);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "rsense channel must be configured...\n");
> -		goto fail;
> +		return ERR_PTR(ret);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (fwnode_property_read_bool(child, "adi,single-ended")) {
> @@ -958,8 +939,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *ch=
ild,
> struct ltc2983_data *s
> =C2=A0		dev_err(&st->spi->dev,
> =C2=A0			"Invalid chann:%d for differential thermistor",
> =C2=A0			sensor->chan);
> -		ret =3D -EINVAL;
> -		goto fail;
> +		return ERR_PTR(-EINVAL);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* check custom sensor */
> @@ -978,10 +958,8 @@ ltc2983_thermistor_new(const struct fwnode_handle *c=
hild,
> struct ltc2983_data *s
> =C2=A0								 propname,
> =C2=A0								 steinhart,
> =C2=A0								 64, false);
> -		if (IS_ERR(thermistor->custom)) {
> -			ret =3D PTR_ERR(thermistor->custom);
> -			goto fail;
> -		}
> +		if (IS_ERR(thermistor->custom))
> +			return ERR_CAST(thermistor->custom);
> =C2=A0	}
> =C2=A0	/* set common parameters */
> =C2=A0	thermistor->sensor.fault_handler =3D ltc2983_common_fault_handler;
> @@ -1005,8 +983,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *c=
hild,
> struct ltc2983_data *s
> =C2=A0			=C2=A0=C2=A0=C2=A0 LTC2983_SENSOR_THERMISTOR_STEINHART) {
> =C2=A0				dev_err(&st->spi->dev,
> =C2=A0					"Auto Range not allowed for custom
> sensors\n");
> -				ret =3D -EINVAL;
> -				goto fail;
> +				return ERR_PTR(-EINVAL);
> =C2=A0			}
> =C2=A0			thermistor->excitation_current =3D 0x0c;
> =C2=A0			break;
> @@ -1047,16 +1024,11 @@ ltc2983_thermistor_new(const struct fwnode_handle
> *child, struct ltc2983_data *s
> =C2=A0			dev_err(&st->spi->dev,
> =C2=A0				"Invalid value for excitation current(%u)",
> =C2=A0				excitation_current);
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return ERR_PTR(-EINVAL);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	fwnode_handle_put(ref);
> =C2=A0	return &thermistor->sensor;
> -fail:
> -	fwnode_handle_put(ref);
> -	return ERR_PTR(ret);
> =C2=A0}
> =C2=A0
> =C2=A0static struct ltc2983_sensor *



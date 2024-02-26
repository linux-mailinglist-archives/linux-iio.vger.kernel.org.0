Return-Path: <linux-iio+bounces-3075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDF866E07
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0D61F28F5F
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157D4F61D;
	Mon, 26 Feb 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq3un59W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053754EB3D
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936554; cv=none; b=f3qoOd1U1xClbgsAv3qR4pVnx93AdPhf4a4dqWkidfsp0HM3feamauFPtqdlT0KcfIOr6yoqgk3tQYcdM4GbagQLwNrMPH6oEzwP4AOAMZLGNvMbOxppMTPgLQinEr7rJe1jLQxFG4Vqp0EoNTaFLz9oE14L0UQIQfxLJG75d+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936554; c=relaxed/simple;
	bh=d3XrnrqYpuVA4jKgCBbxNW9Ao5yObxfc5SHQBOk5nVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XeHV1PKGGpiii8dHq+Gnzra00E3WVN2lQCdJvNFnzLkmYYWW6Q263GwB19e/9LIxo53FdoPQ47+FweZWdXGehdCOe1cjts0c+44W+B/KQmQ9QPSJYckmxnnwNBbi+GdyCtd8eLKJsY96+gHuLX7EXRJXrHRkxJn0jKwLY/mKP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq3un59W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so390524866b.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708936550; x=1709541350; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UZIpACATTRlSXOGanoySqi/ddwDjft17pyLNq41i1l0=;
        b=hq3un59WYT6zvsE+1ACndLOqoVKJGQSjgLTc/4I2ETKRIVRoo1bNwOCLq2YEjn4J6M
         w80VOznlAdAOAALJljZI8rkfCWRrek4O/2cekAmLLYhVghONg4h5HuJeqFm81xgNDSBt
         cxGrIcTz6QUoJrWH2HAxIwPYjnLtMtWPG/RYBZOze9ur/NFOwzopKr71n1rUr5sU4lgl
         /tcVF5dNHQm7j/uI880mTQo418YVPwAezREEqshPE24qH4WDO0yo4v9dhtnOO6GjzxA6
         oFkAPe9Z1JMbskq0kvN+0tb7UxMs6kgKgqmmJ6gNjspvF/NiLmDwxNgsJ9WxiBSVPqg2
         71pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936550; x=1709541350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZIpACATTRlSXOGanoySqi/ddwDjft17pyLNq41i1l0=;
        b=C/njx5TlNWYnt75ZvpdPcm6HPkIyzXINLySHXqYQsZ2U5mdgcUeWkhpNxOZGomfQnx
         fkfL9EIZnKc3eJv/5ipMj9ZG0ew65MMUbJkKPsWtMnIBvk96VWHCjISLcbTZL6Io8jMM
         6XsidJhiguE7McnD3oM9I6k8911iccwPHp5sTT6SZiGcaGWdgKs37t9VyH7EJaCnUt6E
         npnErX+mWHc10Xrp0hSoanFEWjuvMAtUw9r/tORrkhqkrGRHGDDAV+Vn8QbGB5b4ViWu
         KoU9Tjg2LbDBf3ZuPn8fYWI13NE1b74vxv1n0w186HQcBDB0DJoF+FmuFKn7BQPeYuRI
         99sw==
X-Forwarded-Encrypted: i=1; AJvYcCVO8XiJQ+FMS1Gm2GFp7B3kJP2T+/+vRI9lgJ/uwCv5IO9WORKMK4WdS1EMIB2JrDyVilKdTH+GxJR2ewlnQU57KK094QApJuKT
X-Gm-Message-State: AOJu0YzmISuTNgiK9U5MdKmEjqIeify82GK++D2o5shfQYrtnYsMdleX
	ILSNgsytdsHy+F8BBCFyDdUgyxTCoKnaFqixvmpstsyfS+oBDINf
X-Google-Smtp-Source: AGHT+IFXTzYAyqjorlIMCu/8ektS00K1fvvPb8TSyBwfj+8YrhqSHqOjTCRIJHP7K228FdG10l/nfA==
X-Received: by 2002:a17:907:7884:b0:a43:74fa:4efa with SMTP id ku4-20020a170907788400b00a4374fa4efamr466204ejc.55.1708936549974;
        Mon, 26 Feb 2024 00:35:49 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906b31100b00a3fbe13e2aasm2187900ejz.83.2024.02.26.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:35:49 -0800 (PST)
Message-ID: <95e48bb871d172b51786b814388d8d6e001ac76a.camel@gmail.com>
Subject: Re: [PATCH v5 1/9] iio: temp: ltc2983: Use __free(fwnode_handle)
 and device_for_each_node_scoped()
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
Date: Mon, 26 Feb 2024 09:35:49 +0100
In-Reply-To: <20240224123215.161469-2-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
	 <20240224123215.161469-2-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-24 at 12:32 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This use of the new cleanup.h scope based freeing infrastructure allows
> us to exit directly from error conditions and in the good path with
> the reference obtained from fwnode_find_reference() (which may be an erro=
r
> pointer) automatically released.
>=20
> Similarly the _scoped() version of device_for_each_child_node()
> removes the need for the manual calling of fwnode_handl_put() in
> paths where the code exits the loop early.
>=20
> Tidy up some unusual indentation in a dev_dbg() whilst here.
>=20
> Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
> v5: Add the device_for_each_child_node_scoped() change (Nuno)
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/temperature/ltc2983.c | 137 +++++++++++----------------=
---
> =C2=A01 file changed, 50 insertions(+), 87 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> index fcb96c44d954..7d5473e7b500 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -656,7 +656,6 @@ ltc2983_thermocouple_new(const struct fwnode_handle *=
child,
> struct ltc2983_data
> =C2=A0			 const struct ltc2983_sensor *sensor)
> =C2=A0{
> =C2=A0	struct ltc2983_thermocouple *thermo;
> -	struct fwnode_handle *ref;
> =C2=A0	u32 oc_current;
> =C2=A0	int ret;
> =C2=A0
> @@ -703,7 +702,8 @@ ltc2983_thermocouple_new(const struct fwnode_handle *=
child,
> struct ltc2983_data
> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0	}
> =C2=A0
> -	ref =3D fwnode_find_reference(child, "adi,cold-junction-handle", 0);
> +	struct fwnode_handle *ref __free(fwnode_handle) =3D
> +		fwnode_find_reference(child, "adi,cold-junction-handle", 0);
> =C2=A0	if (IS_ERR(ref)) {
> =C2=A0		ref =3D NULL;
> =C2=A0	} else {
> @@ -714,7 +714,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *=
child,
> struct ltc2983_data
> =C2=A0			 * the error right away.
> =C2=A0			 */
> =C2=A0			dev_err(&st->spi->dev, "Property reg must be given\n");
> -			goto fail;
> +			return ERR_PTR(ret);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -725,22 +725,15 @@ ltc2983_thermocouple_new(const struct fwnode_handle=
 *child,
> struct ltc2983_data
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
> @@ -750,14 +743,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, =
struct
> ltc2983_data *st,
> =C2=A0	struct ltc2983_rtd *rtd;
> =C2=A0	int ret =3D 0;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *ref;
> =C2=A0	u32 excitation_current =3D 0, n_wires =3D 0;
> =C2=A0
> =C2=A0	rtd =3D devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
> =C2=A0	if (!rtd)
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0
> -	ref =3D fwnode_find_reference(child, "adi,rsense-handle", 0);
> +	struct fwnode_handle *ref __free(fwnode_handle) =3D
> +		fwnode_find_reference(child, "adi,rsense-handle", 0);
> =C2=A0	if (IS_ERR(ref)) {
> =C2=A0		dev_err(dev, "Property adi,rsense-handle missing or invalid");
> =C2=A0		return ERR_CAST(ref);
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
> =C2=A0	ret =3D fwnode_property_read_u32(child, "adi,number-of-wires", &n_=
wires);
> @@ -787,8 +780,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, st=
ruct
> ltc2983_data *st,
> =C2=A0			break;
> =C2=A0		default:
> =C2=A0			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
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
> =C2=A0					"Rotation not allowed for 2/3 Wire RTDs");
> -				ret =3D -EINVAL;
> -				goto fail;
> +				return ERR_PTR(-EINVAL);
> =C2=A0			}
> =C2=A0			rtd->sensor_config |=3D LTC2983_RTD_C_ROTATE(1);
> =C2=A0		} else {
> @@ -829,16 +820,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, =
struct
> ltc2983_data *st,
> =C2=A0				"Invalid rsense chann:%d to use in kelvin rsense",
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
> =C2=A0							=C2=A0 false, 2048, false);
> -		if (IS_ERR(rtd->custom)) {
> -			ret =3D PTR_ERR(rtd->custom);
> -			goto fail;
> -		}
> +		if (IS_ERR(rtd->custom))
> +			return ERR_CAST(rtd->custom);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* set common parameters */
> @@ -901,18 +887,13 @@ ltc2983_rtd_new(const struct fwnode_handle *child, =
struct
> ltc2983_data *st,
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
> @@ -921,7 +902,6 @@ ltc2983_thermistor_new(const struct fwnode_handle *ch=
ild,
> struct ltc2983_data *s
> =C2=A0{
> =C2=A0	struct ltc2983_thermistor *thermistor;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *ref;
> =C2=A0	u32 excitation_current =3D 0;
> =C2=A0	int ret =3D 0;
> =C2=A0
> @@ -929,7 +909,8 @@ ltc2983_thermistor_new(const struct fwnode_handle *ch=
ild,
> struct ltc2983_data *s
> =C2=A0	if (!thermistor)
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0
> -	ref =3D fwnode_find_reference(child, "adi,rsense-handle", 0);
> +	struct fwnode_handle *ref __free(fwnode_handle) =3D
> +		fwnode_find_reference(child, "adi,rsense-handle", 0);
> =C2=A0	if (IS_ERR(ref)) {
> =C2=A0		dev_err(dev, "Property adi,rsense-handle missing or invalid");
> =C2=A0		return ERR_CAST(ref);
> @@ -938,7 +919,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *ch=
ild,
> struct ltc2983_data *s
> =C2=A0	ret =3D fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_=
chan);
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
> @@ -1047,16 +1024,11 @@ ltc2983_thermistor_new(const struct fwnode_handle=
 *child,
> struct ltc2983_data *s
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
> @@ -1349,8 +1321,7 @@ static irqreturn_t ltc2983_irq_handler(int irq, voi=
d *data)
> =C2=A0static int ltc2983_parse_dt(struct ltc2983_data *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *child;
> -	int ret =3D 0, chan =3D 0, channel_avail_mask =3D 0;
> +	int ret, chan =3D 0, channel_avail_mask =3D 0;
> =C2=A0
> =C2=A0	device_property_read_u32(dev, "adi,mux-delay-config-us", &st-
> >mux_delay_config);
> =C2=A0
> @@ -1368,38 +1339,35 @@ static int ltc2983_parse_dt(struct ltc2983_data *=
st)
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	st->iio_channels =3D st->num_channels;
> -	device_for_each_child_node(dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
> =C2=A0		struct ltc2983_sensor sensor;
> =C2=A0
> =C2=A0		ret =3D fwnode_property_read_u32(child, "reg", &sensor.chan);
> -		if (ret) {
> -			dev_err(dev, "reg property must given for child nodes\n");
> -			goto put_child;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"reg property must given for child nodes\n");
> =C2=A0
> =C2=A0		/* check if we have a valid channel */
> =C2=A0		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
> -		=C2=A0=C2=A0=C2=A0 sensor.chan > st->info->max_channels_nr) {
> -			ret =3D -EINVAL;
> -			dev_err(dev, "chan:%d must be from %u to %u\n",
> sensor.chan,
> -				LTC2983_MIN_CHANNELS_NR, st->info-
> >max_channels_nr);
> -			goto put_child;
> -		} else if (channel_avail_mask & BIT(sensor.chan)) {
> -			ret =3D -EINVAL;
> -			dev_err(dev, "chan:%d already in use\n", sensor.chan);
> -			goto put_child;
> -		}
> +		=C2=A0=C2=A0=C2=A0 sensor.chan > st->info->max_channels_nr)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "chan:%d must be from %u to %u\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 sensor.chan,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 LTC2983_MIN_CHANNELS_NR,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 st->info->max_channels_nr);
> +
> +		if (channel_avail_mask & BIT(sensor.chan))
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "chan:%d already in use\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 sensor.chan);
> =C2=A0
> =C2=A0		ret =3D fwnode_property_read_u32(child, "adi,sensor-type",
> &sensor.type);
> -		if (ret) {
> -			dev_err(dev,
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> =C2=A0				"adi,sensor-type property must given for child
> nodes\n");
> -			goto put_child;
> -		}
> =C2=A0
> =C2=A0		dev_dbg(dev, "Create new sensor, type %u, chann %u",
> -								sensor.type,
> -								sensor.chan);
> +			sensor.type, sensor.chan);
> =C2=A0
> =C2=A0		if (sensor.type >=3D LTC2983_SENSOR_THERMOCOUPLE &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 sensor.type <=3D LTC2983_SENSOR_THERMOCOUPLE_C=
USTOM) {
> @@ -1426,17 +1394,15 @@ static int ltc2983_parse_dt(struct ltc2983_data *=
st)
> =C2=A0			=C2=A0=C2=A0 sensor.type =3D=3D LTC2983_SENSOR_ACTIVE_TEMP) {
> =C2=A0			st->sensors[chan] =3D ltc2983_temp_new(child, st, &sensor);
> =C2=A0		} else {
> -			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
> -			ret =3D -EINVAL;
> -			goto put_child;
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Unknown sensor type %d\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 sensor.type);
> =C2=A0		}
> =C2=A0
> -		if (IS_ERR(st->sensors[chan])) {
> -			dev_err(dev, "Failed to create sensor %ld",
> -				PTR_ERR(st->sensors[chan]));
> -			ret =3D PTR_ERR(st->sensors[chan]);
> -			goto put_child;
> -		}
> +		if (IS_ERR(st->sensors[chan]))
> +			return dev_err_probe(dev, PTR_ERR(st->sensors[chan]),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to create sensor\n");
> +
> =C2=A0		/* set generic sensor parameters */
> =C2=A0		st->sensors[chan]->chan =3D sensor.chan;
> =C2=A0		st->sensors[chan]->type =3D sensor.type;
> @@ -1446,9 +1412,6 @@ static int ltc2983_parse_dt(struct ltc2983_data *st=
)
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> -put_child:
> -	fwnode_handle_put(child);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int=
 cmd,



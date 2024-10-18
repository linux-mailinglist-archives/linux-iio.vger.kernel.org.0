Return-Path: <linux-iio+bounces-10733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4E9A42D3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6361C24565
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107F1E0DF2;
	Fri, 18 Oct 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfb9K5py"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAE20264A;
	Fri, 18 Oct 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266447; cv=none; b=EEJy5v/OIFVYBZmRgmbzvKBV4aINV3l2p1483jfkZWJv1ZyEt5HtHtHitPM+XjkZVl5OcQgKz4uQEdWm6suZLlFiYRN7wJBQ5QcG0hRPjeJgP/XiVHOrQWbtA2RI/MQ0QRO2jPhMKyJFM/0bhcZTdQy/ps2Ilx+hEZ/yXulYsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266447; c=relaxed/simple;
	bh=/nQ1oYuLP22mamYw+ocZ6cHFO6dhZDg2iP/e3D1AYgc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=cxHGC1lObB3ltBOXepqIRc+hzy9K8hdiIANYjGvIlGd+1aw3hV2bwbT4O/Jn4DBIaQsYjoJy+2h0TWDkK2yNZjQw+DBqWfj4aaIRTVxO8tuxkc5MVG1pD5QgZCYei0Iq4VZIbR3DHi/7r6kSUzI3ndzUenbQ6N18ViVn9ZhkZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfb9K5py; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so22386255e9.3;
        Fri, 18 Oct 2024 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729266443; x=1729871243; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54aWpgZvp/YbuUeb3vJ0ClrRcBFyh9Gt13i4OYu3aTY=;
        b=nfb9K5pyDxWqMr8+P90R2X7MC7wqz/4vDuSShzG6liON7iqIp0JN8+fa7AXJDZFJD4
         NSguZ7Qs6vZTdoV3ex1kdoAYxy1h6MrA6pMnx5+/rkmLY1yTnNHxNBaO2sevkyw+BQcJ
         ZAlpq59k2+oK+SgYCBrF1Vq8odwTCbqna0UrmJuWqYAsnYeGWDAUHnYcDBx5ZOb/P7Qg
         hq2BdYtdkz8TN9zMd96bb4pGybQECpKhr32OZplunSDrTXhsjq0QH6ePc4wjtd+cpNwN
         wgKMCoB7Uma4F9z0YGR5vpz7FqWgdxQz2WH39a8h9I/BHmivHqTf0b5MLKIoJ1sfyHIf
         pTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266443; x=1729871243;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54aWpgZvp/YbuUeb3vJ0ClrRcBFyh9Gt13i4OYu3aTY=;
        b=rO28kIxzW0lpY1SNgCvSZ16JzcFK57h5Xg60J4fJelna23dzeEFZfzert8xvTleOCM
         b0+C4apKNXCfbvG4Rcjwy5vLQPn6q9+lgEvoMm/9EqikvFrtzU5kvbDcOYuMBGu0wrfe
         x9yaVXpCovwVJbY+enK8uTBXDJriXso8BsRZk7XaEtaI+3Sa9GpFOqbTtU3BwxlMrmGM
         ZXqjr/B40gITviNy+RRj366MhWG49fXJki/rQ6FOiqrVNbFAWDBTDKkMWOv5MpRrgT48
         cztwUkV709LUvBD2PuvXY9cEEA1IH0cUz3dZmafmJhZrCPcVFk7TmrYgZajXYLbODsaW
         05SA==
X-Forwarded-Encrypted: i=1; AJvYcCU2UtBD3NX4nAU2UmWedbAo4ZfQgQtNjapwOwYdZWO4RvVOdpmziJqZap2Nb0iZ2nghR9lznRW0NkU=@vger.kernel.org, AJvYcCXGt3G1tx3nNkNV/xnyXr2sxS7QsE2RUKCMFjp6jKlJdTcg9VtySX6m4DL6untFmkBheeUwE7ezQ9W75s5S@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcghBP6qHAyArl9R5E15M7AdD56sML8ZoK7B0ZmJy55heSUNp
	bqJW/mcXkV1Ru2eDlcgrXhbfJj72Rvhbwo0TUvaODcv6hwxniZ8e
X-Google-Smtp-Source: AGHT+IEqS86RNLBfIhGb9RB8hRxzRGWLDCD/l+f2fMff4VWujqQmCDLldw4KkcdVbWMn6PQ/h4xAIw==
X-Received: by 2002:a05:600c:1d8d:b0:431:60ac:9aef with SMTP id 5b1f17b1804b1-43161697346mr24617135e9.29.1729266441396;
        Fri, 18 Oct 2024 08:47:21 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027a50sm2229301f8f.15.2024.10.18.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:47:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241018120624.15409-1-victor.duicu@microchip.com>
References: <20241018120624.15409-1-victor.duicu@microchip.com>
Subject: Re: [PATCH v5] iio: adc: pac1921: Add ACPI support to Microchip pac1921
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: marius.cristea@microchip.com, victor.duicu@microchip.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: jic23@kernel.org, lars@metafoo.de, victor.duicu@microchip.com
Date: Fri, 18 Oct 2024 17:47:19 +0200
Message-ID: <172926643961.69047.11194012379257398256@njaxe.localdomain>
User-Agent: alot/0.11

Quoting victor.duicu@microchip.com (2024-10-18 14:06:24)
> From: Victor Duicu <victor.duicu@microchip.com>
>=20
> This driver implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.
>=20
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>=20
> The patch was tested on minnowboard and sama5.
>=20
> Differences related to previous versions:
> v5:

I think v4 was cleaner. Are the following changes necessary?

> - set maximum acceptable value of shunt resistor to 2KOHM in devicetree,
> ACPI table and user input. The chosen value is lesser than INT_MAX,
> which is about 2.1KOHM.

I would personally keep INT_MAX since the limitation is only given by the t=
ypes
used in the current conversions (see pac1921_calc_scale()) rather than bein=
g a
specific PAC1921 hardware limitation. Otherwise I would extend the comment =
on
top of those two definitions explaining why that's the maximum.

> - in pac1921_match_acpi_device and pac1921_parse_of_fw change to only
>   read 32b values for resistor shunt.
>

I think that in pac1921_match_acpi_device(), the u64 temp var was introduce=
d to
address the possible overflow coming from the u64 rez->package.elements[0].=
integer.value
and to safely perform a sanity check. I don't think we can trust blindly th=
at
the ACPI table always has a valid 32bit value in that field.

pac1921_parse_of_fw() doesn't look changed compared to v4, you already swit=
ched
back to device_property_read_u32, if it's what you are referring to.

>=20
> v4:
> - change name of pac1921_shunt_is_valid to pac1921_shunt_is_invalid.
> - fix coding style.
> - in pac1921_parse_of_fw change back to device_property_read_u32.
>=20
> v3:
> - simplify and make inline function pac1921_shunt_is_valid. Make argument=
 u64.
> - fix link to DSM documentation.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw, the shunt value is
> read as u64.
> - in pac1921_parse_of_fw remove code for reading label value from
> devicetree.
> - in pac1921_write_shunt_resistor cast the multiply result to u64 in order
> to fix overflow.
>=20
> v2:
> - remove name variable from priv. Driver reads label attribute with
> sysfs.
> - define pac1921_shunt_is_valid function.
> - move default assignments in pac1921_probe to original position.
> - roll back coding style changes.
> - add documentation for DSM(the linked document was used as reference).
> - remove acpi_match_device in pac1921_match_acpi_device.
> - remove unnecessary null assignment and comment.
> - change name of function pac1921_match_of_device to
> pac1921_parse_of_fw.
>=20
> v1:
> - initial version for review.
>=20
>  drivers/iio/adc/pac1921.c | 109 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 96 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index a96fae546bc1..9622b0da6196 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -67,6 +67,13 @@ enum pac1921_mxsl {
>  #define PAC1921_DEFAULT_DI_GAIN                0 /* 2^(value): 1x gain (=
HW default) */
>  #define PAC1921_DEFAULT_NUM_SAMPLES    0 /* 2^(value): 1 sample (HW defa=
ult) */
> =20
> +#define PAC1921_ACPI_GET_UOHMS_VALS             0
> +#define PAC1921_ACPI_GET_LABEL                 1
> +#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236=
-7a7a742e55cb"
> +/*The maximum accepted value of shunt_resistor is 2Kohms */
> +#define PAC1921_MAX_SHUNT_VALUE_OHMS           2000
> +#define PAC1921_MAX_SHUNT_VALUE_UOHMS          2000000000
> +
>  /*
>   * Pre-computed scale factors for BUS voltage
>   * format: IIO_VAL_INT_PLUS_NANO
> @@ -204,6 +211,11 @@ struct pac1921_priv {
>         } scan;
>  };
> =20
> +static inline bool pac1921_shunt_is_invalid(u32 shunt_val)
> +{
> +       return (shunt_val =3D=3D 0 || shunt_val > PAC1921_MAX_SHUNT_VALUE=
_UOHMS);
> +}
> +
>  /*
>   * Check if first integration after configuration update has completed.
>   *
> @@ -781,7 +793,7 @@ static ssize_t pac1921_write_shunt_resistor(struct ii=
o_dev *indio_dev,
>                                             const char *buf, size_t len)
>  {
>         struct pac1921_priv *priv =3D iio_priv(indio_dev);
> -       u64 rshunt_uohm;
> +       u32 rshunt_uohm;
>         int val, val_fract;
>         int ret;
> =20
> @@ -791,9 +803,13 @@ static ssize_t pac1921_write_shunt_resistor(struct i=
io_dev *indio_dev,
>         ret =3D iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
>         if (ret)
>                 return ret;
> +      =20
> +       /* This check is to ensure val*MICRO won't overflow*/
> +       if (val < 0 || val > PAC1921_MAX_SHUNT_VALUE_OHMS)
> +               return -EINVAL;
> =20
>         rshunt_uohm =3D val * MICRO + val_fract;
> -       if (rshunt_uohm =3D=3D 0 || rshunt_uohm > INT_MAX)
> +       if (pac1921_shunt_is_invalid(rshunt_uohm))
>                 return -EINVAL;
> =20

In v3 you added the (u64)val cast to solve the multiplication overflow. Was=
n't
that enough? However, if this is for better clarity I am fine with it.

>         guard(mutex)(&priv->lock);
> @@ -1150,6 +1166,71 @@ static void pac1921_regulator_disable(void *data)
>         regulator_disable(regulator);
>  }
> =20
> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Applic=
ationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows=
-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static int pac1921_match_acpi_device(struct i2c_client *client, struct p=
ac1921_priv *priv,
> +                                    struct iio_dev *indio_dev)
> +{
> +       acpi_handle handle;
> +       union acpi_object *rez;
> +       guid_t guid;
> +       char *label;
> +       u32 temp;
> +
> +       guid_parse(PAC1921_DSM_UUID, &guid);
> +       handle =3D ACPI_HANDLE(&client->dev);
> +
> +       rez =3D acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHM=
S_VALS, NULL);
> +       if (!rez)
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Could not read shunt from ACPI tabl=
e\n");
> +
> +       temp =3D rez->package.elements[0].integer.value;

I don't think we can trust rez->package.elements[0].integer.value to always=
 be
in 32bit boundaries. But if that's the case then the temp var looks unneces=
sary.

> +       ACPI_FREE(rez);
> +
> +       if (pac1921_shunt_is_invalid(temp))
> +               return dev_err_probe(&client->dev, -EINVAL, "Invalid shun=
t resistor\n");
> +
> +       priv->rshunt_uohm =3D temp;
> +       pac1921_calc_current_scales(priv);
> +
> +       rez =3D acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABE=
L, NULL);
> +       if (!rez)
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Could not read label from ACPI tabl=
e\n");
> +
> +       label =3D devm_kmemdup(&client->dev, rez->package.elements->strin=
g.pointer,
> +                            (size_t)rez->package.elements->string.length=
 + 1,
> +                            GFP_KERNEL);
> +       label[rez->package.elements->string.length] =3D '\0';
> +       indio_dev->label =3D label;
> +       ACPI_FREE(rez);
> +
> +       return 0;
> +}
> +
> +static int pac1921_parse_of_fw(struct i2c_client *client, struct pac1921=
_priv *priv)
> +{
> +       int ret;
> +       struct device *dev =3D &client->dev;
> +
> +       ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +                                      &priv->rshunt_uohm);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Cannot read shunt resistor property=
\n");
> +
> +       if (pac1921_shunt_is_invalid(priv->rshunt_uohm))
> +               return dev_err_probe(dev, -EINVAL, "Invalid shunt resisto=
r: %u\n",
> +                                    priv->rshunt_uohm);
> +
> +       pac1921_calc_current_scales(priv);
> +
> +       return 0;
> +}
> +
>  static int pac1921_probe(struct i2c_client *client)
>  {
>         struct device *dev =3D &client->dev;
> @@ -1176,17 +1257,13 @@ static int pac1921_probe(struct i2c_client *clien=
t)
>         priv->di_gain =3D PAC1921_DEFAULT_DI_GAIN;
>         priv->n_samples =3D PAC1921_DEFAULT_NUM_SAMPLES;
> =20
> -       ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> -                                      &priv->rshunt_uohm);
> -       if (ret)
> -               return dev_err_probe(dev, ret,
> -                                    "Cannot read shunt resistor property=
\n");
> -       if (priv->rshunt_uohm =3D=3D 0 || priv->rshunt_uohm > INT_MAX)
> -               return dev_err_probe(dev, -EINVAL,
> -                                    "Invalid shunt resistor: %u\n",
> -                                    priv->rshunt_uohm);
> -
> -       pac1921_calc_current_scales(priv);
> +       if (ACPI_HANDLE(&client->dev))
> +               ret =3D pac1921_match_acpi_device(client, priv, indio_dev=
);
> +       else
> +               ret =3D pac1921_parse_of_fw(client, priv);
> +       if (ret < 0)
> +               return dev_err_probe(&client->dev, ret,
> +                                    "parameter parsing error\n");
> =20
>         priv->vdd =3D devm_regulator_get(dev, "vdd");
>         if (IS_ERR(priv->vdd))
> @@ -1243,11 +1320,17 @@ static const struct of_device_id pac1921_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, pac1921_of_match);
> =20
> +static const struct acpi_device_id pac1921_acpi_match[] =3D {
> +       { "MCHP1921" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
>  static struct i2c_driver pac1921_driver =3D {
>         .driver  =3D {
>                 .name =3D "pac1921",
>                 .pm =3D pm_sleep_ptr(&pac1921_pm_ops),
>                 .of_match_table =3D pac1921_of_match,
> +               .acpi_match_table =3D pac1921_acpi_match
>         },
>         .probe =3D pac1921_probe,
>         .id_table =3D pac1921_id,
>=20
> base-commit: 57573ace0c1b142433dfe3d63ebf375269c80fc1
> --=20
> 2.43.0
>=20

Best regards,
Matteo Martelli


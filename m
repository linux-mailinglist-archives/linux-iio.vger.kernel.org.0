Return-Path: <linux-iio+bounces-9804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A56988117
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B6E286C39
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3170189502;
	Fri, 27 Sep 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPJA/X2H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C151157490;
	Fri, 27 Sep 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428083; cv=none; b=PyMlgfi0dS76LjGVdWDI7auE65cGSRwWJIhYagCC8bLWlpwNn6kyqLvnft6f6gsB6HqPwrhjc+AaJ0PiI0YuYTS/sVaCtXJXXTXjtbHv5aJpMtATGofV3tUuit7XmsYimgBHwGKxk8g/3uMArxRZtRKmb5/JKeAduGjQC3A24nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428083; c=relaxed/simple;
	bh=YdYkEg1gZBoikyiu/P8kmaozMuHwz6+kKwvKODiX2R0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=DU5RzJncHL1tbWVpGUv3YLQSDACTKQuCRyNBJN0QXCUOL/OtSIIWaZ7pt0onNCWRKwb10/U3HcMWiM1muF5xo0NOlLxNmhLbsI2tjqGqgkXxKxlAUhGApLscPMFmaDOnznzvJZu/VKLwdLE4urhm5MASBUP+JGtE9ohfcm8CWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPJA/X2H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb2191107so16005825e9.1;
        Fri, 27 Sep 2024 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727428080; x=1728032880; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ocMbJgFy/7n4DZZfEb/ZTXVgFJKrP4dxuSp3z6JKY0=;
        b=QPJA/X2H7rB1eD7a5OstrmCXbm1a/A2Ifb7+ee05CUAEwfcMuwJBMow8rtgMPS6VVG
         C9QAERU7p/ZkLCdtP8GSLLwhURnRTWY9DRmpFuR7hD7JkF1PZJ9Ll8FRNUIILxB3Nt0c
         XiFWP/3i5PUP8WxPBmXFGXWZ8cXA4WL0Ejg0UdoUrvRq55ZzTESD8fFf58tja4R7umaQ
         y0tU+9i+Y4AOPCdnQBtd7fk0U/TpRDR1OmG8e6ubYDTPMSceNyk1Zfp/sAyN2xAr2FmX
         Gurno13jjRTkJLtwcRHl1t9j26s3viN4iIo965huw7VCt1G1pI2sy8h4Iiu3gdo/qMcu
         R4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428080; x=1728032880;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ocMbJgFy/7n4DZZfEb/ZTXVgFJKrP4dxuSp3z6JKY0=;
        b=jGezAC42iY3h0gbvNwx3ye1kj2Hd1tQxkJPoC5Y90d4zUNpPNy7nkIV/Xi6s24Emd4
         79p6YvG8zcbCY0WMeay6ZjNA3A0Ae6V3UNBNJ0CLvXBaDizbGtBjuigS6NIq3loTlwCP
         YNPonDRgJSSZtQTeds1oemiPjZFltVuOj2k3uAawId6UyM1sMronBesVG5UWG22YVFOX
         di9kih9yABoSao7m92BhEWsOhmc6gg0lwjBIUPs6Mr3Rm2jP0gwSEDkdODOs2sKm0Arh
         zScO+KkbV1+FRn+e8DqUlcRO5mPw6S2LVxRde7DlIBrbHZOgJMQ7M5cXi9zjoikWAbbw
         CaMg==
X-Forwarded-Encrypted: i=1; AJvYcCVsdp2Y+oEB1rD0IEwz7a5gpPWOwUPcb59A5B9/HuLI1ociLGelvucEkKaLel2CZt8BkmViBtGfAdbyLUZC@vger.kernel.org, AJvYcCX9YgIt0p+3qGx39qn/NqyHcRLAQQ4kDLSopTFjhpk2W0X8yAubhwNX7j/wKug89twrFYdQJb3hQDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozDRTbP+DiZSZ+jXKvgVfC/nGjr+ZECwbg9dGfxi6vYfd/oSa
	ia+9JsUcOhePOGJQbQwXmTXkuBKyduF1cBWgTUQmkKHxkozB7W/f
X-Google-Smtp-Source: AGHT+IHTjpmlcQYmLgifdZ66lKq8Z7Wj79TENl1aAKrtR41P78znaY1fHEgJh4aLaZdd8xSLtMX0Xg==
X-Received: by 2002:a05:600c:4511:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42f584870f4mr18407115e9.22.1727428079561;
        Fri, 27 Sep 2024 02:07:59 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dd301dsm20262885e9.8.2024.09.27.02.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:07:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240925150856.19441-1-victor.duicu@microchip.com>
References: <20240925150856.19441-1-victor.duicu@microchip.com>
Subject: Re: [PATCH v1] iio: adc: pac1921: add ACPI support for pac1921
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: marius.cristea@microchip.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, victor.duicu@microchip.com
To: jic23@kernel.org, lars@metafoo.de, victor.duicu@microchip.com
Date: Fri, 27 Sep 2024 11:07:58 +0200
Message-ID: <172742807800.10544.2431681612964326407@njaxe.localdomain>
User-Agent: alot/0.11

Quoting victor.duicu@microchip.com (2024-09-25 17:08:56)
> From: Victor Duicu <victor.duicu@microchip.com>
>=20
> This patch implements ACPI support for pac1921.
> Driver can read shunt resistor value and device name from ACPI table.
>=20
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
>

Hello Victor, thanks for the patch.
I am not going to address the specific ACPI parsing as I don't have much
experience with it yet, but I have some other comments (see below).

> ---
>  drivers/iio/adc/pac1921.c | 116 +++++++++++++++++++++++++++++++-------
>  1 file changed, 97 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 4c2a1c07bc39..9bb61b88aaef 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -67,6 +67,10 @@ enum pac1921_mxsl {
>  #define PAC1921_DEFAULT_DI_GAIN                0 /* 2^(value): 1x gain (=
HW default) */
>  #define PAC1921_DEFAULT_NUM_SAMPLES    0 /* 2^(value): 1 sample (HW defa=
ult) */
> =20
> +#define PAC1921_ACPI_GET_UOHMS_VALS             0
> +#define PAC1921_ACPI_GET_NAME                  1
> +#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236=
-7a7a742e55cb"
> +
>  /*
>   * Pre-computed scale factors for BUS voltage
>   * format: IIO_VAL_INT_PLUS_NANO
> @@ -190,6 +194,7 @@ struct pac1921_priv {
>         u8 n_samples;
>         u8 prev_ovf_flags;
>         u8 ovf_enabled_events;
> +       char *name;

I think what you are assigning to "name" later in the patch would better
fit in a "label" sysfs attribute. iio core already checks if a "label"
DT property [1] is present and exposes it via sysfs. When not using a DT I
think you can just set the parsed name from ACPI into indio_dev->label.
Also, if you pass indio_dev to the ACPI match function you won't even
need a variable in pac1921_priv for that purpose. See for example
drivers/iio/accel/kxcjk-1013.c:kxcjk1013_match_acpi_device or
drivers/iio/accel/bmc150-accel-core.c:bmc150_apply_bosc0200_acpi_orientatio=
n.

> =20
>         bool first_integr_started;
>         bool first_integr_done;
> @@ -1151,6 +1156,79 @@ static void pac1921_regulator_disable(void *data)
>         regulator_disable(regulator);
>  }
> =20
> +static int pac1921_match_acpi_device(struct i2c_client *client, struct p=
ac1921_priv *priv)
> +{
> +       const struct acpi_device_id *device_pointer;
> +       acpi_handle handle;
> +       union acpi_object *rez;
> +       guid_t guid;
> +       struct device *dev =3D &client->dev;
> +
> +       guid_parse(PAC1921_DSM_UUID, &guid);
> +       handle =3D ACPI_HANDLE(&client->dev);
> +
> +       device_pointer =3D acpi_match_device(dev->driver->acpi_match_tabl=
e, dev);
> +       if (!device_pointer)
> +               return -EINVAL;
> +
> +       rez =3D acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHM=
S_VALS, NULL);
> +       if (!rez)
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Could not read shunt from ACPI tabl=
e\n");
> +
> +       priv->rshunt_uohm =3D rez->package.elements[0].integer.value;
> +       ACPI_FREE(rez);
> +
> +       if (priv->rshunt_uohm =3D=3D 0)
> +               return dev_err_probe(&client->dev, -EINVAL, "Shunt value =
is 0.");

Calculation of current scales assumes rshunt_uohm to be inside signed
int boundaries, so it should be checked rshunt_uohm doesn't exceed
INT_MAX. If there is any reason for the shunt resistor to be bigger than
INT_MAX (2.1KOhm) than the scales calculation must be reconsidered as
well.

Also, given that the check would be around three different points it
could also be put in an inline function or macro, something like
pac1921_shunt_is_valid(), or even into a common wrapper that validates,
set the shunt and update the current scales. But that could also be a
refactoring for a future patch.

> +
> +       pac1921_calc_current_scales(priv);
> +
> +       rez =3D acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_NAME=
, NULL);
> +       if (!rez) {
> +               priv->name =3D "";
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Could not read name from ACPI table=
\n");
> +       }
> +
> +       priv->name =3D devm_kmemdup(&client->dev, rez->package.elements->=
string.pointer,
> +                                 (size_t)rez->package.elements->string.l=
ength + 1,
> +                                 GFP_KERNEL);
> +       priv->name[rez->package.elements->string.length] =3D '\0';

As mentioned above, such name should likely be set to into indio_dev->label.

> +       ACPI_FREE(rez);
> +
> +       return 0;
> +}
> +
> +static int pac1921_match_of_device(struct i2c_client *client, struct pac=
1921_priv *priv)
> +{
> +       int ret;
> +       struct device *dev =3D &client->dev;
> +
> +       /* Read shunt resistor value */
> +       ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms"=
, &priv->rshunt_uohm);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Cannot read shunt resistor property=
\n");
> +
> +       if (priv->rshunt_uohm =3D=3D 0 || priv->rshunt_uohm > INT_MAX)
> +               return dev_err_probe(dev, -EINVAL, "Invalid shunt resisto=
r: %u\n",
> +                                    priv->rshunt_uohm);
> +
> +       pac1921_calc_current_scales(priv);
> +
> +       if (device_property_present(dev, "name")) {
> +               ret =3D device_property_read_string(dev, "name", (const c=
har **)&priv->name);
> +               if (ret)
> +                       return dev_err_probe(&client->dev, ret,
> +                                            "Invalid rail-name value\n");
> +       } else {
> +               priv->name =3D "pac1921";
> +       }
> +

Parsing of the "name" property should likely be removed, the use case
should already be covered by the DT label property [1].

> +       return 0;
> +}
> +
>  static int pac1921_probe(struct i2c_client *client)
>  {
>         struct device *dev =3D &client->dev;
> @@ -1172,22 +1250,14 @@ static int pac1921_probe(struct i2c_client *clien=
t)
>                                      "Cannot initialize register map\n");
> =20
>         devm_mutex_init(dev, &priv->lock);
> +       if (ACPI_HANDLE(&client->dev))
> +               ret =3D pac1921_match_acpi_device(client, priv);
> +       else
> +               ret =3D pac1921_match_of_device(client, priv);
> =20
> -       priv->dv_gain =3D PAC1921_DEFAULT_DV_GAIN;
> -       priv->di_gain =3D PAC1921_DEFAULT_DI_GAIN;
> -       priv->n_samples =3D PAC1921_DEFAULT_NUM_SAMPLES;

Is there any reason to move these default assignments later in the
function?

> -
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
> +       if (ret < 0)
> +               return dev_err_probe(&client->dev, ret,
> +                                    "parameter parsing error\n");
> =20
>         priv->vdd =3D devm_regulator_get(dev, "vdd");
>         if (IS_ERR(priv->vdd))
> @@ -1198,13 +1268,15 @@ static int pac1921_probe(struct i2c_client *clien=
t)
>         if (ret)
>                 return dev_err_probe(dev, ret, "Cannot enable vdd regulat=
or\n");
> =20
> -       ret =3D devm_add_action_or_reset(dev, pac1921_regulator_disable,
> -                                      priv->vdd);
> +       ret =3D devm_add_action_or_reset(dev, pac1921_regulator_disable, =
priv->vdd);

I would leave coding style changes out from this patch.

>         if (ret)
>                 return dev_err_probe(dev, ret,
> -                       "Cannot add action for vdd regulator disposal\n");
> +                                    "Cannot add action for vdd regulator=
 disposal\n");

Also here, I would leave coding style changes out from this patch.

> =20
>         msleep(PAC1921_POWERUP_TIME_MS);
> +       priv->dv_gain =3D PAC1921_DEFAULT_DV_GAIN;
> +       priv->di_gain =3D PAC1921_DEFAULT_DI_GAIN;
> +       priv->n_samples =3D PAC1921_DEFAULT_NUM_SAMPLES;

Can these be moved back at the top of the function?
> =20
>         ret =3D pac1921_init(priv);
>         if (ret)
> @@ -1212,7 +1284,7 @@ static int pac1921_probe(struct i2c_client *client)
> =20
>         priv->iio_info =3D pac1921_iio;
> =20
> -       indio_dev->name =3D "pac1921";
> +       indio_dev->name =3D priv->name;

This should likely be removed for the reasons mentioned above.

>         indio_dev->info =3D &priv->iio_info;
>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>         indio_dev->channels =3D pac1921_channels;
> @@ -1244,11 +1316,17 @@ static const struct of_device_id pac1921_of_match=
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
> base-commit: fec496684388685647652ab4213454fbabdab099
> --=20
> 2.43.0
>=20

[1]: https://github.com/devicetree-org/dt-schema/blob/c51125d571cac9596048e=
888a856d70650e400e0/dtschema/schemas/iio/iio.yaml#L39

Best regards,
Matteo Martelli


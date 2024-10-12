Return-Path: <linux-iio+bounces-10482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DA99B2CD
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DDC1F204C3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0714EC73;
	Sat, 12 Oct 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZdhDV9Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59214E2E2;
	Sat, 12 Oct 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727540; cv=none; b=mKxghytQu4RbvDISmmneNmAnpkyA1NcLtu/62HPdwYTzFI6hun3R0b6UpcYFFl7bRlUIih0lRClh/aCxYJLdsaJb1b2UZJvPoSEeE/javoSLIFfHBfejmLNHjj1kTDTDJ2wf2zwbKvzZYimfnxmgzL2isAoIsS3pjfCpNS4Yr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727540; c=relaxed/simple;
	bh=loRlVP0a1wV+4LDtA46+xUzNpDe7NqVYM/IEFzzGvlU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=NfxVyKTqGraNWQ1LXzeYwnASrgwVv4eDAEV5KaMXhJSh+gMjhh9mrhRZ1cYo9a5sa1CRtaNVxi/QFrNlhI/ywFTHVJZ9ulzCQxkPz1N0ssP2wtoHmPS7YrbgX1+wd07hsdmjgMDppk3fNFvNm/MUJqZ9Ty2S28KESoJaNQBqfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZdhDV9Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311695c6c2so20346995e9.1;
        Sat, 12 Oct 2024 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728727537; x=1729332337; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGpuFaU1nhPIGvEHXM7HdwWpvVRbU88d658wogNxKIE=;
        b=BZdhDV9QhJ+V1ouL0ZKkE3xjdG1mDSPrD9cwab1N1KtLai6BDeo5UICTzwKhPas0TR
         uwD/pGDVn8Y8W1HV4ggoqSn5yR7bkkz/qA8oflNhKNu0SS/2ck17IMgcZfdz1n2btIku
         3YffkagLRW9cWsapxD+/FRJEyp+nT7SaOyGM97lB/TW+/mvUshzTRCfVQtAgrz7Y3YDn
         mMzlpLv8IUOutvpXW3OOjYqqSE0K2Kklia4RvI9UxTCxtuUfvb+NUeNpmja6E/K40dc1
         bPhlmddDoCnKcwSvakg+nIEi8ByZOv+AbzA/zLa83vgbLlo+kzh/bYA9ypJC2pQag1eV
         km8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727537; x=1729332337;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGpuFaU1nhPIGvEHXM7HdwWpvVRbU88d658wogNxKIE=;
        b=cQDFX59qHZdsPbSeMJGhVRt+u0AGYhHbK6gUDJe/x5vzvxvWljyliY/fdWaWOr0J8k
         RON2h6pqXlqe5Q6sSNuO97Hn3ZCcW9vaywUi0aHErIupUuQzWZC9NCLeQN6yS3gs7rcx
         HlKztwL1H7EGn5mmZWrD8NRIcqXYcyIWThR4kYB3BebRaXu07VyurTAAXwJwAG7ljJes
         ZdTXXBblihk+dNOhgwPcCeZMKW9uHcvttzF8o5/vu2oZY4cftBRUxq5zMGIfF6mpD+8v
         j47A8r5wjOcZ8oN0RmMrEZvII7tf3RpygABpH/AOT3ubmpJvMTfWhLjocmiCNfGU+SOp
         m9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVc1tknTfCPg41qvGRtTcFm1JyQYaIFa1T34t+2jzbVb3gA2II7EfUJYvNRC1MT1CusZAvjuKD+PSUi+5Dz@vger.kernel.org, AJvYcCWdWNTs8wmGb5H1Gj6NdxQZHC8mgn2t32pXOkdlN1h2IavqSdHeobJIOq9gXgqG8u5YUNiSamJXYvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0FXK7U/GZf4NTMlrhBsDnnNMOl/y6AbuoKfGqCRrGxMzTwHU
	O+hQkyShSPFLSTHZYpc6T5K1Qi7I8TzNA0qfpbWaSR7KsamfXNQgwGT1WQ==
X-Google-Smtp-Source: AGHT+IEOZRzenLCmA8fxQdzAQqsgnYm3BJoGywum/Lcelq+7j+O8OVJ4UeKaoh1vd/wMDDFFRklcAA==
X-Received: by 2002:a05:600c:354e:b0:42f:8267:69e6 with SMTP id 5b1f17b1804b1-431255d4afcmr18995335e9.3.1728727536956;
        Sat, 12 Oct 2024 03:05:36 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d7487c4csm95523005e9.32.2024.10.12.03.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 03:05:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241011134454.45283-1-victor.duicu@microchip.com>
References: <20241011134454.45283-1-victor.duicu@microchip.com>
Subject: Re: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip pac1921.
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: marius.cristea@microchip.com, victor.duicu@microchip.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: jic23@kernel.org, lars@metafoo.de, victor.duicu@microchip.com
Date: Sat, 12 Oct 2024 12:05:34 +0200
Message-ID: <172872753469.9340.10387646359307852048@njaxe.localdomain>
User-Agent: alot/0.11

Quoting victor.duicu@microchip.com (2024-10-11 15:44:54)
> From: Victor Duicu <victor.duicu@microchip.com>
>=20
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.
>=20
> The patch was tested on a minnowboard(64b) and sama5(32b).
> In order to avoid overflow when reading 64b values from ACPi table or
> devicetree it is necessary:
> - the revision of .dsl file must be 2 or greater to enable 64b arithmetic.
> - the shunt resistor variable in devicetree must have the prefix "/bits/ =
64".
>=20
> Differences related to previous versions:
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
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>  drivers/iio/adc/pac1921.c | 106 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 93 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 567279664e74..01c5eceab0be 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -67,6 +67,10 @@ enum pac1921_mxsl {
>  #define PAC1921_DEFAULT_DI_GAIN                0 /* 2^(value): 1x gain (=
HW default) */
>  #define PAC1921_DEFAULT_NUM_SAMPLES    0 /* 2^(value): 1 sample (HW defa=
ult) */
> =20
> +#define PAC1921_ACPI_GET_UOHMS_VALS             0
> +#define PAC1921_ACPI_GET_LABEL                 1
> +#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236=
-7a7a742e55cb"
> +
>  /*
>   * Pre-computed scale factors for BUS voltage
>   * format: IIO_VAL_INT_PLUS_NANO
> @@ -204,6 +208,11 @@ struct pac1921_priv {
>         } scan;
>  };
> =20
> +static inline bool pac1921_shunt_is_valid(u64 shunt_val)
> +{
> +       return (shunt_val =3D=3D 0 || shunt_val > INT_MAX);
> +}
> +

It's very confusing that this returns true when the shunt is NOT valid. I w=
ould
either negate the return value or change the name.

>  /*
>   * Check if first integration after configuration update has completed.
>   *
> @@ -792,13 +801,13 @@ static ssize_t pac1921_write_shunt_resistor(struct =
iio_dev *indio_dev,
>         if (ret)
>                 return ret;
> =20
> -       rshunt_uohm =3D val * MICRO + val_fract;
> -       if (rshunt_uohm =3D=3D 0 || rshunt_uohm > INT_MAX)
> +       rshunt_uohm =3D (u64)val * MICRO + val_fract;

In commit a9bb0610b2fa ("iio: pac1921: remove unnecessary explicit casts"),
unnecessary explicit casts had been removed since it seems the preferred
approach in order to improve readability. This (u64)val cast seems unnecess=
ary
as well thus I would keep the expression without it.

> +       if (pac1921_shunt_is_valid(rshunt_uohm))
>                 return -EINVAL;

The error should be returned when the shunt is NOT valid.

> =20
>         guard(mutex)(&priv->lock);
> =20
> -       priv->rshunt_uohm =3D rshunt_uohm;
> +       priv->rshunt_uohm =3D (u32)rshunt_uohm;

I would remove the unnecessary explicit cast for the above reason.

> =20
>         pac1921_calc_current_scales(priv);
> =20
> @@ -1150,6 +1159,74 @@ static void pac1921_regulator_disable(void *data)
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
> +       u64 temp;
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
> +       ACPI_FREE(rez);
> +
> +       if (pac1921_shunt_is_valid(temp))
> +               return dev_err_probe(&client->dev, -EINVAL, "Invalid shun=
t resistor\n");

The error should be returned when the shunt is NOT valid.

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
_priv *priv,
> +                              struct iio_dev *indio_dev)
> +{
> +       int ret;
> +       struct device *dev =3D &client->dev;
> +       u64 temp;
> +
> +       ret =3D device_property_read_u64(dev, "shunt-resistor-micro-ohms"=
, &temp);

Since the driver would discard a value out of INT boundaries, I don't see t=
he
need to read a value larger than u32 that would be discarded anyway. To my
understanding, device_property_read_u32() should fail for an overflowing va=
lue
thus I would keep device_property_read_u32() here, and at that point the te=
mp
var would not be necessary as well. I think it would also help to keep the =
patch
diff confined in the ACPI extension context.

> +
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Cannot read shunt resistor property=
\n");
> +
> +       if (pac1921_shunt_is_valid(temp))
> +               return dev_err_probe(dev, -EINVAL, "Invalid shunt resisto=
r: %u\n",
> +                                    priv->rshunt_uohm);

The error should be returned when the shunt is NOT valid.

> +
> +       priv->rshunt_uohm =3D (u32)temp;

The temp var should not be necessary if switching back to device_property_r=
ead_u32(),
otherwise I would remove the unnecessary explicit cast for the above reason.

> +       pac1921_calc_current_scales(priv);
> +
> +       return 0;
> +}
> +

...

Thanks,
Matteo Martelli


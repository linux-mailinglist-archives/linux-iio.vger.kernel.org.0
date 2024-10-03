Return-Path: <linux-iio+bounces-10015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87B98EA4A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 09:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A142852B1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850284A3F;
	Thu,  3 Oct 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFeUwRAk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC52556E;
	Thu,  3 Oct 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940164; cv=none; b=ryOpckrfA7giOPxO9/v9D0npWlSLldLKfnbi3JrZq2gywXkCvQZkKKwS3wVj1i4lNRMv4hAM563adlZ4qufxhtiLVqgT+OgWRKHP16NputiwwEhKeWIjsVvUqrwlcH25oY6jp7up0r+ZwCWUWH6NZpxyxO/N4ivINmJ8RiS1AT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940164; c=relaxed/simple;
	bh=0VVSdYk70Q5GOXJ9GEpTlCddalAYUidAGBvetOYVulw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Wnj21+OLJnPQS/qrO1EZwsNOAejw1md6FCrD0chaxvy2pF1gwxwgIZA7uTe7I4fffLCwFwuF3WdXin5VOj06xdIOlya7P05RnrOCZigo2ZyEo9JBWUmI9BXzLyX68SHt9emRAfGdwG830ci6xBgAY+q6qj/77qMXAtzFUrgSYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFeUwRAk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so528099e87.1;
        Thu, 03 Oct 2024 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727940161; x=1728544961; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVUkel3Ns6UHWc92CVK1uux7XPvQZ7C+Ev01ZhpTljY=;
        b=CFeUwRAkMB7oRcWXkr+rH9fPonOBwoHLFrItpPXOMBm0wCQSps4Y2SxIGHrBbnBR1E
         Y1SOoFCuvrCeVNbwoaUaSNa3f2om6dR/O1jmGXb13UGA2d5UTcEbd2okCxZIwbVj+jUT
         45mEgHq9iZq6V9FwmTRdVP8uzDAAAaeMEET/+0+DkLHrGg8q/KKCjiWPAQlFMcfLFH7q
         ydHg6phT0x2HAQn8WlVs64s7jg4uduF8QIswvm17roFWmhC1evgc6u8xncA8ZWc642A8
         UI09nPSi5PnfjFiBhEDHsjA///VEHsikhyP0pp+2Twdn0zX4ofVzn23waTKOpHGs0PPG
         YI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940161; x=1728544961;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVUkel3Ns6UHWc92CVK1uux7XPvQZ7C+Ev01ZhpTljY=;
        b=sHZx+60ZCzW6XHHl0+X8O+OouVmgIctCTcHQeb7uA527t0bWwuAsp80IQagaAeSLJo
         AdKW49v3sRTP6/Gt3hIXdjBbKB2xuUU9ORnCkaMFilryFsJMmag6EbFWPHytO9pKIJIW
         BdTHllV3IKWrNE2L5R1LwTT2bC4xbz/NqNr2VNEvjfKFDzTvsbSZYtda8K0PWS0/mg6M
         b/rpL8NI/ausk7Fs59wBJ2CZK7zNQOXLUqj1dwL7oT2JO346TJQZyMezzq0qysVuFVXv
         RmZt/VTRXaOlPH8Y3pyPTfjF78NNhiKiiz3mCBdLVr9HNvrXyYn/zvtQuaPVEvcyY6BK
         Lhow==
X-Forwarded-Encrypted: i=1; AJvYcCUxkieQeX1ijR9cTUKY8eSVZC7VuLrdXJHayGDHo1OUrGgWlvR8qaTdCzgWGwp1hDX9ceuNP1Ylrv9NhajI@vger.kernel.org, AJvYcCW8r2eStfjWvTvEOnC3L9gl4MY/wbDHT2YV7QJ8ljEfDAG9F9fgPHQIKislgyBHk7KqN0um1IRGOyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sWUYmKOnJxEcMoHRZgcIRT3KgUTrNnzkh6Fu6nY/DNuR0MTh
	3cSip58coausTzDRStzjJUPCXoGFFlPu1Xm/CXvBc3u3W4QPaxhq
X-Google-Smtp-Source: AGHT+IEXS5rZm5UPQRRVdwtEg7pIvInVfwxz06dgrT9SUtxcIU0OVlGIvvyamnBxnlaDMTlJoDQmlw==
X-Received: by 2002:a05:6512:e9e:b0:539:955b:43d0 with SMTP id 2adb3069b0e04-539a0793c7amr3380653e87.47.1727940160187;
        Thu, 03 Oct 2024 00:22:40 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d3bcsm37346215e9.5.2024.10.03.00.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:22:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241002125445.7570-1-victor.duicu@microchip.com>
References: <20241002125445.7570-1-victor.duicu@microchip.com>
Subject: Re: [PATCH v2] iio: adc: pac1921: add ACPI support to pac1921
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: marius.cristea@microchip.com, victor.duicu@microchip.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: jic23@kernel.org, lars@metafoo.de, victor.duicu@microchip.com
Date: Thu, 03 Oct 2024 09:22:38 +0200
Message-ID: <172794015844.2520.11909797050797595912@njaxe.localdomain>
User-Agent: alot/0.11

Quoting victor.duicu@microchip.com (2024-10-02 14:54:45)
> From: Victor Duicu <victor.duicu@microchip.com>
>=20
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and device label
> from ACPI table.
>=20
> Differences related to previous versions:
> v2:
> - remove name variable from priv. Driver reads label attribute with
>   sysfs.
> - define pac1921_shunt_is_valid function.
> - move default assignments in pac1921_probe to original position.
> - roll back coding style changes.
> - add documentation for DSM(the linked document was used as reference).
> - remove acpi_match_device in pac1921_match_acpi_device.
> - remove unnecessary null assignment and comment.
> - change name of function pac1921_match_of_device to
>   pac1921_parse_of_fw.
>=20
> v1:
> - initial version for review.

Thanks Victor for having addressed our previous points. I still have a few
comments, see below.

>=20
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>  drivers/iio/adc/pac1921.c | 112 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 101 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 4c2a1c07bc39..95ade1c4d5e8 100644
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
> @@ -204,6 +208,14 @@ struct pac1921_priv {
>         } scan;
>  };
> =20
> +static bool pac1921_shunt_is_valid(u32 shunt_val)
> +{
> +       if (shunt_val =3D=3D 0 || shunt_val > INT_MAX)
> +               return false;
> +       else
> +               return true;
> +}
> +

I think this can be inline. Also, it looks a more common pattern to just re=
turn
the condition expression result.
To see some examples: grep -A 5 -R "inline .*bool .*" .

Moreover, since both the values coming from ACPI and sysfs can exceed 32-bit
boundaries, maybe it would be better to get a u64 argument here. Otherwise a
value like 5KOhm (5_000_000_000) would wrap around in the cast (~7Ohm) but =
still
considered as valid.

>  /*
>   * Check if first integration after configuration update has completed.
>   *
> @@ -794,7 +806,7 @@ static ssize_t pac1921_write_shunt_resistor(struct ii=
o_dev *indio_dev,
>                 return ret;
> =20
>         rshunt_uohm =3D (u32)val * MICRO + (u32)val_fract;
> -       if (rshunt_uohm =3D=3D 0 || rshunt_uohm > INT_MAX)
> +       if (!pac1921_shunt_is_valid((u32)rshunt_uohm))

The explicit cast is not necessary, especially if the validity function wou=
ld
take a u64 argument.

>                 return -EINVAL;
> =20
>         guard(mutex)(&priv->lock);
> @@ -1151,6 +1163,81 @@ static void pac1921_regulator_disable(void *data)
>         regulator_disable(regulator);
>  }
> =20
> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Applic=
ationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows=
-10-and-Windows-11-Driver-Support-DS00002534.pdf

It looks like the link is not working, is the following the new one (PAC193=
4 -> PAC193X) ?
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationN=
otes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-an=
d-Windows-11-Driver-Support-DS00002534.pdf

Should it be updated for the pac1934 driver as well?

> + */
> +static int pac1921_match_acpi_device(struct i2c_client *client, struct p=
ac1921_priv *priv,
> +                                    struct iio_dev *indio_dev)
> +{
> +       acpi_handle handle;
> +       union acpi_object *rez;
> +       guid_t guid;
> +       char *label;
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
> +       priv->rshunt_uohm =3D rez->package.elements[0].integer.value;

Doing this assignment before the validity check may result into accepting a
value out of the 32-bit range which would wrap around in the implicit cast =
(e.g.
5KOhm -> ~7Ohm). I think you could either move the validity check before or=
 use
a u64 temp var.

> +       ACPI_FREE(rez);
> +
> +       if (!pac1921_shunt_is_valid(priv->rshunt_uohm))
> +               return dev_err_probe(&client->dev, -EINVAL, "Invalid shun=
t resistor: %u\n",
> +                                    priv->rshunt_uohm);
> +
> +       pac1921_calc_current_scales(priv);
> +
> +       rez =3D acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_NAME=
, NULL);
> +       if (!rez)
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Could not read name from ACPI table=
\n");
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
> +
> +       ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +                                      &priv->rshunt_uohm);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Cannot read shunt resistor property=
\n");
> +
> +       if (!pac1921_shunt_is_valid(priv->rshunt_uohm))
> +               return dev_err_probe(dev, -EINVAL, "Invalid shunt resisto=
r: %u\n",
> +                                    priv->rshunt_uohm);
> +
> +       pac1921_calc_current_scales(priv);
> +
> +       if (device_property_present(dev, "label")) {
> +               ret =3D device_property_read_string(dev, "label",
> +                                                 (const char **)&indio_d=
ev->label);
> +               if (ret)
> +                       return dev_err_probe(&client->dev, ret,
> +                                            "Invalid rail-name value\n");
> +       } else {
> +               indio_dev->label =3D "pac1921";
> +       }

IIO core already checks for the label string property from DT, see
industrialio-core.c:__iio_device_register(). So I think it can be removed f=
rom
here, unless you want the driver probe to fail for an invalid label string,
which it would not happen with the IIO core handling. Also, is it necessary=
 to
have a default label? It looks meaningless to me since it would have the sa=
me
value of the name attribute.

> +
> +       return 0;
> +}
> +
>  static int pac1921_probe(struct i2c_client *client)
>  {
>         struct device *dev =3D &client->dev;
> @@ -1177,17 +1264,14 @@ static int pac1921_probe(struct i2c_client *clien=
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
> +       if (ACPI_HANDLE(&client->dev))
> +               ret =3D pac1921_match_acpi_device(client, priv, indio_dev=
);
> +       else
> +               ret =3D pac1921_parse_of_fw(client, priv,  indio_dev);
> =20
> -       pac1921_calc_current_scales(priv);
> +       if (ret < 0)
> +               return dev_err_probe(&client->dev, ret,
> +                                    "parameter parsing error\n");
> =20
>         priv->vdd =3D devm_regulator_get(dev, "vdd");
>         if (IS_ERR(priv->vdd))
> @@ -1244,11 +1328,17 @@ static const struct of_device_id pac1921_of_match=
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

Thanks,
Matteo Martelli


Return-Path: <linux-iio+bounces-23826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE18B46A57
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB95A0FA4
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDE5280A35;
	Sat,  6 Sep 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcaS3Y+f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1A2765C1;
	Sat,  6 Sep 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149684; cv=none; b=t1XqzFYE9ydwpJkCMnK6SYQx8wjSQlD0Ga9vt7qk1i0yuMgxAFkm/4MhK4UiO/Ah3+S6qCFsweeN9ASO4otlBbbReqNj8Pz2my/LXi9gdGRyprhmHITPtUlgImZVu1hzrUHkR7nfC5mNxTRNODiByHaCys21DAyVcPirK+yP1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149684; c=relaxed/simple;
	bh=/EogTmEp9ddcHlHd422rd2ELg91naaCOUhoWx/RDcOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIwYCMAc/iAehaPzMTMZm5jS2IReSxF4YB/4A9eVLRFtGvJPNTy5uK+xckyXkKoybDIPAaJkLkeFPk3ZZ25Kj5TDUkQU8AHUGNXEmRTu170H0UxuV7IyL5PSGBiWKDjGanO5FbzY6sWbjC1P2ZwcAspid0q6YnRPjYEznHvTjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcaS3Y+f; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso290335a12.3;
        Sat, 06 Sep 2025 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757149680; x=1757754480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98sjn7qESsjfOKaFuLxICTp+8fa7kfm5T8aG47i40Ck=;
        b=FcaS3Y+fYE9B6Jm51WdiJuP9tPMqO+beZBUMuhP0kWsX+1HbZllX6tm/BVxUBHBGCR
         4pLRO9Xrkk6/UQgyd8yZhgCZ87OynIgwHwHj22GylEqtFkKqG55bCbbyj8aTg4kFNQ0P
         ZRznACUGuZFdSVLS+Xhof4ZQCwc7umnLDD8qmhz5gbqlZ/e6pKlncW6sCeSWfhUItjBJ
         lBWaqNaf8tGxtiP1wZHLLvCvIEbiROEAYShh4g0vwshMRS5ia2A4E4MbCbORnM9DqhzP
         PZ97BCl7vlVd5LoCK4aJLmBsLK457sDXDOwa8RZ6LNtBSuZnaU/9jVzq+S9viyGxNg/t
         Mccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757149680; x=1757754480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98sjn7qESsjfOKaFuLxICTp+8fa7kfm5T8aG47i40Ck=;
        b=K3V6e5W4WPpTG5QhvUmquekqjeurT9mngpVYdpKsPmeF/ES/G5HFi1WeNfqhkn0Uom
         3WNuqr0x7gNt0NVNy+2WsGwOoGYWAXlad+hnyTPKb5OArqN+3Iy/jQEu/SvtFeukqyVd
         1h447EkC6PYndAJPNLcIKsWf6D1L2p9KBOIUg85B2Qe24Na4BzKylBlhr7c4wcJoRDpR
         cdaVwbhVh7uUbwc6RRP0tfDvksTzIof8Yi+S1QEcn1cQG7xwg5Qi76oZB5axVuqm/Vqq
         wpYSG1UbVCHqDQZJsKPAJMRSRB6RvRboYKLuK+y5f/pX+clHTrA6Kv8yFpvuPY9ZA5sc
         uclw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4Xji0Wp4caqc8MBZhpYflbiMJhasUpgAfu7EjOdGIizSExXNkIZp5zjtCcD63k2bS1RycrwM8hD5dOcz@vger.kernel.org, AJvYcCVD8jTnz00AsK+JckGZouukfioUv0PXeXTcp9Vx2IZZc8G4FErkv3uG/3cVml+BYehezSLxy47ID27W@vger.kernel.org, AJvYcCXMbDyaRygvMwOtGRiDbNYNTZuUqevg8v0lj2aDZg8Ez4Y+oZDdVJTTZPjD9kW+kq6lbsZiBTPqkRN2@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsaOmQOqLK5drPhdLxFFMWGxqGprYyrsL1NxZRjS8OrVoZQCd
	ANCV6r1DPQYuu4gP4svhoa+3591HFH5c0NJu1JuCIMEcLk+6WEb9oDQRfy70cFK+crY95pSx95e
	uHXqasIPuPWvQUN2nIw500cMV1Ps2tA8=
X-Gm-Gg: ASbGncvybt5XbpQZgrkCL1UFfaGNepsMN5sBZj0oWH638xAjlz/DbMO5KlJo4zlnPtO
	eZ6m/FLstR4GZjZ1g2XfRLzUBTsvov52V/HzyhTxD7utt+YzEv9XDc5/upT95vmJxiiU9fnSJAa
	4kLN6ZjePNf7yd6hPH9z+3hnpTG0aSbrYyrfjsdFNBnC0OZ+Hiv8p9sWs/o+exU/9pRfVMHLc0t
	PvL9/90eW0oh2iF2A==
X-Google-Smtp-Source: AGHT+IHEC6cqNMvUlVVHR7YYmKc5eePl4FbV9uoffdQtlLHwv+S/TriWZKfqz+qrbteibDLxRvs7Ft1QkpZBZgQgGnw=
X-Received: by 2002:a17:907:3d06:b0:b04:4786:5e02 with SMTP id
 a640c23a62f3a-b04b16dc6e4mr134938666b.45.1757149679891; Sat, 06 Sep 2025
 02:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com> <20250906-tlv493d-sensor-v6_16-rc5-v6-2-b1a62d968353@gmail.com>
In-Reply-To: <20250906-tlv493d-sensor-v6_16-rc5-v6-2-b1a62d968353@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 6 Sep 2025 12:07:23 +0300
X-Gm-Features: Ac12FXzkOILECBI6_yeKunYdSyWhZAfj3H0XbwE76b9Qf7dVlsCE2Yq6b1VJYM0
Message-ID: <CAHp75Vf0zHU3103xGeO4pt7LO7yWvd_WGssHAM87srQxHyFXvg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:38=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
>
> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
>
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
>
> The driver supports raw value read and buffered input via external trigge=
r
> to allow streaming values with the same sensing timestamp.
>
> While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> But for bus configurations interrupt(INT) is not recommended, unless timi=
ng
> constraints between I2C data transfers and interrupt pulses are monitored
> and aligned.
>
> The Sensor's I2C register map and mode information is described in produc=
t
> User Manual [1].

This version looks good enough to me.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +static int tlv493d_read_raw(struct iio_dev *indio_dev,
> +                       const struct iio_chan_spec *chan, int *val,
> +                       int *val2, long mask)
> +{
> +       struct tlv493d_data *data =3D iio_priv(indio_dev);
> +       s16 x, y, z, t;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D tlv493d_get_measurements(data, &x, &y, &z, &t);
> +               if (ret)
> +                       return ret;
> +
> +               switch (chan->address) {
> +               case TLV493D_AXIS_X:
> +                       *val =3D x;
> +                       return IIO_VAL_INT;
> +               case TLV493D_AXIS_Y:
> +                       *val =3D y;
> +                       return IIO_VAL_INT;
> +               case TLV493D_AXIS_Z:
> +                       *val =3D z;
> +                       return IIO_VAL_INT;
> +               case TLV493D_TEMPERATURE:
> +                       *val =3D t;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_MAGN:
> +                       /*
> +                        * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 =
=C2=B5T)
> +                        * Magnetic field in Gauss: mT * 10 =3D 0.098.
> +                        */
> +                       *val =3D 98;
> +                       *val2 =3D 1000;
> +                       return IIO_VAL_FRACTIONAL;
> +               case IIO_TEMP:
> +                       /*
> +                        * Temperature scale: 1.1 =C2=B0C per LSB, expres=
sed as 1100 m=C2=B0C
> +                        * Returned as integer for IIO core to apply:
> +                        * temp =3D (raw + offset) * scale
> +                        */
> +                       *val =3D 1100;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_OFFSET:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       /*
> +                        * Temperature offset includes sensor-specific ra=
w offset
> +                        * plus compensation for +25=C2=B0C bias in formu=
la.
> +                        * offset =3D -raw_offset + (25000 / 1100)
> +                        * -340 + 22.72 =3D -317.28
> +                        */
> +                       *val =3D -31728;
> +                       *val2 =3D 100;
> +                       return IIO_VAL_FRACTIONAL;
> +               default:
> +                       return -EINVAL;
> +               }

> +

Inconsistent (redundant) blank line.

> +       default:
> +               return -EINVAL;
> +       }
> +}


--=20
With Best Regards,
Andy Shevchenko


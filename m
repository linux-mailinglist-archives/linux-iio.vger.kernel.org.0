Return-Path: <linux-iio+bounces-18030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A8A86EBA
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCE37B15A7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D32080F4;
	Sat, 12 Apr 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtyJ9Xov"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B8170A23;
	Sat, 12 Apr 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482363; cv=none; b=cTPqlAkP9avxwCksrnHlsQpQr9996QNZlyPxGNk5+VzZ1pBI22XCM12Sw83g2JFGJe2gKreWKoXjLEdsDmYxOEF3QfAKdc24/HA4Ryx4/aFtriINHRdB3gZNRaTmXPZXZX8wU5lszb+mnPn2M8jOmUWctznHc4SLBisNYi2uKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482363; c=relaxed/simple;
	bh=64+M0drviQ2Lsfpaj+ZS6kkXeiGA6LezE7CpKqjDyho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeugLi0Atc8X4ZIgyDNnMvEs8iSU0T1jaI6E+AS2HYBcVfEm4EhbPBUB1Gn7lK0ozdIRVRBa7STWwM5Llj9UAAbRa59wWq8GEK0oRA8eIM2gf2T5ocDUjNsGSPNlsJi5Gg5dkpy2N94q6j7lRqHG8QT3Uuxb23xa3EIABt7jkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtyJ9Xov; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so541736266b.1;
        Sat, 12 Apr 2025 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744482359; x=1745087159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVzZCv/PVThpxrXePrstfoBW3nrq6zhwEWI/tuSD1L0=;
        b=XtyJ9XovVSzzbIOHKAsLeognM9RRkTIEIPwHg5kGbAGA4cpC6Gro2xgJ999sk1FHNk
         7x6HS5+JSOkBMcpS2kSbsrDmLQVhRxOd9XFc0MQ71GyR1SG6Qr9JsReMYV1jcspw13AI
         UyAomVZiObQrRITn6B0fbViWakIERYUe32hWH7rEtLdiRqr/IusAvL0cCGaSIGqG7X03
         Z0vnI5MWSbjp6Yln83GkQER7a9gEYdtw193llA9+tRDEtWx0s5oV3RSH9uWvRJpg1ELb
         lt3eoKBLgJzVjScz3O4A2oywQu0XNye1Uk7ElZYmnA4+xgudIcAD6S9swWSEs8fEjS78
         x7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744482359; x=1745087159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVzZCv/PVThpxrXePrstfoBW3nrq6zhwEWI/tuSD1L0=;
        b=G5tCioUZNgvDtcrz9tUpGSZAAYo7HIIQrq+r7FDsV406svzobgYy5479mG5KfBJ5JU
         Z51kWJBvFUXbu5PomREYiPd3DrWF/XOiQ17nIr19qLHmWIc1ZjEhrC0Dw2p3UlIWmvbY
         dfEzr8VfGcVLWwb8GsSzpk/gxu/DO6k3Sb3qTVScSJzP157QmN0SzJZXvCSCwUMX3Thi
         ktzboq/bnAGUA7+Z4pQxRKQhcndIM97QTW6Wcf83Otk7RdfOphMgHW7cOMYmSCbJVsTS
         gHUPjNmpQ+zXafyVbltOGJl+aHMsrQJN7ns4kacDxESrC15tJVXe7dnKX+K+CDOwUwwP
         Av0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrjrYJ+HLhYzkYpSpFY6h5dZSPKPNUzwDYW67o0yT6GaiaoKUkIBLCNIeRtUGvdD/NQ/gIkKKvPHby@vger.kernel.org, AJvYcCWOI1vRJE8Uh55xoy6daT7lOIvd1tO3KqX7R0JbbSVMGnEHetcgP+aPmXqKeGcqs5qRLNjrQvzEGtpe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxds106vXxASQi0RJfCvJGYdZx6eJS4HNBBrIARHMIoOFb9SJZo
	dPFgAy2GvktGPwpo2ODcaDby1t4Cfm4RejZVv8H4ENwsSYq+AziUnl1CyRSXL7d9JWU0TqtlxcL
	OszSQDpobvFB7aL1gbx90PFxGWvw=
X-Gm-Gg: ASbGncvx3NTLTKo2VPd8wTt4FjC1qViyQjNVc+IuiN+Cm1vrcQuGQz6Sfa6vnLCwmZ4
	H6AmpiC4mjABwgl2JXom8YvdVx04MptvDd/7tKweXdVRpC4gaZfqw2G6VBjdSGSzMLmDA3cNSIP
	pjN6z1fVAywztfyzqK+M/GWA==
X-Google-Smtp-Source: AGHT+IGk7aQeN8A/RHthEjAjbSJEUf1JEuMxAXwyjWUBeK1qXfSBXdnKKrl1cCbFTRr7mUkYG1dMtuaBRrrIDApYxSc=
X-Received: by 2002:a17:906:730a:b0:aca:cac6:3ca9 with SMTP id
 a640c23a62f3a-acad34c62eemr535014366b.27.1744482359198; Sat, 12 Apr 2025
 11:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com>
In-Reply-To: <20250409024311.19466-5-gye976@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 21:25:22 +0300
X-Gm-Features: ATxdqUFkQaa4xwXOz5fOMbuPPTy0t9E4V0bmp5KOf7Jc52Sk9YrkhbROKI7cun0
Message-ID: <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:45=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com> wro=
te:
>
> Add support for winsen MHZ19B CO2 sensor.
>
> Datasheet:
> https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver=
1_0.pdf

Make the above one line...

>

...and remove this blank line, hence this becomes a tag in the commit messa=
ge.

> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

...

> +#include <linux/kernel.h>

No usual driver has a business to include the  kernel.h. Just follow
the IWYU principle and make sure what you include is what you use
here.

...

> +struct mhz19b_state {
> +       struct serdev_device *serdev;
> +       struct regulator *vin;
> +
> +       /*
> +        * serdev receive buffer.
> +        * When data is received from the MH-Z19B,
> +        * the 'mhz19b_receive_buf' callback function is called and fills=
 this buffer.
> +        */
> +       char buf[9];

Should it be DMA-safe?

> +       int buf_idx;
> +
> +       /* must wait the 'buf' is filled with 9 bytes.*/

...wait until the...

> +       struct completion buf_ready;
> +};

Have you run `pahole` to check if this is the best layout?

...

> +/*
> + * commands have following format:

Commands

> + *
> + * +------+------+-----+------+------+------+------+------+-------+
> + * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
> + * +------+------+-----+------+------+------+------+------+-------+
> + */

...

> +static uint8_t mhz19b_get_checksum(uint8_t *packet)

What's wrong with u8 here and everywhere else?

> +{
> +       uint8_t i, checksum =3D 0;
> +
> +       for (i =3D 1; i < 8; i++)

Shouldn't you use sizeof here? It seems related to that 9 above.

> +               checksum +=3D packet[i];

> +       checksum =3D 0xff - checksum;
> +       checksum +=3D 1;
> +
> +       return checksum;

Looks to me like these lines can be simplified to

  return -checksum;

> +}

...

> +       case MHZ19B_ABC_LOGIC_CMD: {
> +               bool enable =3D *((bool *)arg);

Oh, no. The boolean type is a tricky one and here you probably break
all the possible implementation defined behaviours esp. on bigendian
systems.

> +               if (enable) {
> +                       cmd_buf[3] =3D 0xA0;
> +                       cmd_buf[8] =3D MHZ19B_ABC_LOGIC_ON_CKSUM;
> +               } else {
> +                       cmd_buf[3] =3D 0;
> +                       cmd_buf[8] =3D MHZ19B_ABC_LOGIC_OFF_CKSUM;
> +               }
> +               break;

> +       } case MHZ19B_SPAN_POINT_CMD: {

Please, split the leading } from the case (everywhere). This is an
unusual style.

> +               uint16_t ppm =3D *((uint16_t *)arg);

Do you guarantee the alignment?

> +               put_unaligned_be16(ppm, &cmd_buf[3]);
> +               cmd_buf[MHZ19B_CMD_SIZE - 1] =3D mhz19b_get_checksum(cmd_=
buf);
> +               break;
> +       } case MHZ19B_ZERO_POINT_CMD: {
> +               cmd_buf[8] =3D MHZ19B_ZERO_POINT_CKSUM;
> +               break;
> +       } default:
> +               break;
> +       }

...

> +       /* write buf to uart ctrl syncronously */

UART
synchronously

Perhaps a spellchecker to run?

> +       ret =3D serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
> +       if (ret !=3D MHZ19B_CMD_SIZE) {
> +               dev_err(dev, "write err, %d bytes written", ret);

> +               return -EINVAL;

Can ret be negative? In such a case, please propagate the actual error code=
.

> +       }

...

> +               ret =3D mhz19b_get_checksum(st->buf);

How ret is being used? And if it may hold an error code, it should be
return to the upper layers, otherwise the ret variable is a bad choice
to keep this locally.

> +               if (st->buf[MHZ19B_CMD_SIZE - 1] !=3D mhz19b_get_checksum=
(st->buf)) {
> +                       dev_err(dev, "checksum err");
> +                       return -EINVAL;
> +               }
> +
> +               ret =3D get_unaligned_be16(&st->buf[2]);
> +               return ret;

...

> +static int mhz19b_read_raw(struct iio_dev *indio_dev,
> +       struct iio_chan_spec const *chan,
> +       int *val, int *val2, long mask)
> +{
> +       int ret =3D mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, NUL=
L);
> +
> +       if (ret < 0)
> +               return ret;

It's better to use the form of

   int ret;

   ret =3D ...
   if (ret)
      ...

Also why do you have ' < 0' parts? Please, double check that you use
this form of the errorcheck if and only if the callee may return a
positive value.

> +       *val =3D ret;
> +       return IIO_VAL_INT;
> +}

...

> +/*
> + * MHZ19B only supports writing configuration values.
> + *
> + * echo 0 > calibration_auto_enable : ABC logic off
> + * echo 1 > calibration_auto_enable : ABC logic on
> + *
> + * echo 0 > calibration_forced_value : zero point calibration
> + *     (make sure the sensor had been worked under 400ppm for over 20 mi=
nutes.)

has been working / had been working ?

> + * echo [1000 1 5000] > calibration_forced_value : span point calibratio=
n
> + *     (make sure the sensor had been worked under a certain level co2 f=
or over 20 minutes.)
> + */

...

> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       bool enable;

> +       int ret =3D kstrtobool(buf, &enable);
> +
> +       if (ret)
> +               return ret;

Same comment to everywhere where you assign in the definition block
and check that in the code later on, this form is harder to maintain.

> +
> +       ret =3D mhz19b_serdev_cmd(indio_dev, MHZ19B_ABC_LOGIC_CMD, &enabl=
e);
> +       if (ret < 0)
> +               return ret;
> +
> +       return len;
> +}

...

> +       uint16_t ppm;

u16. Please, use kernel types everywhere.

...

> +       ret =3D kstrtou16(buf, 10, &ppm);

No hex?

> +       if (ret)
> +               return ret;

...

> +               if (ppm < 1000 || ppm > 5000) {

in_range()

> +                       dev_dbg(&indio_dev->dev,
> +                               "span point ppm should be 1000~5000");
> +                       return -EINVAL;
> +               }

...

> +static const struct attribute_group mhz19b_attr_group =3D {
> +       .attrs =3D mhz19b_attrs,
> +};

ATTRIBUTE_GROUP() ?

...

> +static size_t mhz19b_receive_buf(struct serdev_device *serdev,
> +       const u8 *data, size_t len)
> +{
> +       struct iio_dev *indio_dev =3D dev_get_drvdata(&serdev->dev);
> +       struct mhz19b_state *st =3D iio_priv(indio_dev);
> +
> +       for (int i =3D 0; i < len; i++)

Why signed?

> +               st->buf[st->buf_idx++] =3D data[i];
> +
> +       if (st->buf_idx =3D=3D MHZ19B_CMD_SIZE) {
> +               st->buf_idx =3D 0;
> +               complete(&st->buf_ready);
> +       }
> +
> +       return len;
> +}

...

> +       ret =3D serdev_device_set_baudrate(serdev, 9600);
> +       if (ret < 0)

Why < 0?

> +               return ret;
> +
> +       serdev_device_set_flow_control(serdev, false);
> +
> +       ret =3D serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +       if (ret < 0)

Why < 0?

> +               return ret;

--=20
With Best Regards,
Andy Shevchenko


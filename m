Return-Path: <linux-iio+bounces-6141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B1901DA2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BC71F23C9F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC547F7F7;
	Mon, 10 Jun 2024 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQcpCe0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CF76F1B;
	Mon, 10 Jun 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009930; cv=none; b=J/lgpTv8RbeOaBqyzbyCCEspMgTKFiZw/mSpNgmMbnGHLhO3rg5XUMoJuyF8ivuTELEFS+965MdacfipXu9E9bvuJK+/9kzQZwd6XXfOVllrv/2kudu4RS/adcmdJVMJ6bBpsOaoF9PPZodMKgkavHcNdy/DxavYdRb9Bcw7prs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009930; c=relaxed/simple;
	bh=zG9Nk1i9CpO30iwDpBCYAJoPe2JWUw3aG89GN5vsBvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkVWbJdYCkAHpYrNo3Sm1s45JVWm4k6h0xnPvYGRvq9nOMdun0mj9N9LvciRzj864gSclHdokkItdzDM/x9IhxSaefCAOt1FdEKcSQ5TJEuACmE3Eu4X5OSiDMw3XwE2Qj7xsiNdI7LlEEKSLwUfyLjRpZb+PbbXnMCwEehMVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQcpCe0K; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso3230888f8f.0;
        Mon, 10 Jun 2024 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718009927; x=1718614727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOAtN7oXCzbDYC+AN7vSfI2DUaJdROI9p4SpPCnLXBM=;
        b=FQcpCe0KLELg9A4nD2R3T85VjMwnJgAQSQ3tCtn7Qot177qYE/2tI0VFdr7ASlSWs0
         d8ukYNfCyS9ceR8suRg4EDprNGVzpg2sOdd3c0Wqd821+QRgmCN1/WOnMo8udoBow77X
         zw/IPIq/v+hbwKaRG0BONi7RTDa6vC+oxKrEdhq66kSQKzrvwCLwhur7eXTrr8GxEefE
         UmUTAA6VwUBUeixqZL8rxuCcVF6p1qc98Bx2KvGaAEVk7xCUrPh18PZXPDEmAIwjrXZP
         +3TKI91jS4LjcVDCxfffgeJqvSXk2ri8KdpNsnXvcDetTyT2oSu7QK3jaqG9GK7dRtb7
         itzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718009927; x=1718614727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOAtN7oXCzbDYC+AN7vSfI2DUaJdROI9p4SpPCnLXBM=;
        b=nN/yCDvzSohP5tG/4HsbmYOT4+1HBpVrIz8+EVpIjh8NP6b9YTtKk3ohxcYiBTDFj6
         bqocGC+cOf5XyBO1VBoe63ajFA4wisF9J31sdc3LufynM6AghO9JdKhh4sCFBFhT1Qv4
         Mo1w03U38slAXdrwDoU1UhAP/pIa5VdC30HQw5lXmgZqlIAAL4AF3GPTC73x+hI0BXvM
         UcUCpRKUPmg7IODovzqFk9Ys3uvNciRaRLsddUEH4yqrJru9uqRISZLQHcdspzojq89B
         mOG46sUXJRkaPUNhdyNJQ/omjJOJypdmDZpYtmrIRTFNSRnEjeRCnoOjRlvJTetPFbqa
         GbMw==
X-Forwarded-Encrypted: i=1; AJvYcCVjEaBxrcMdIuTIrfNl97VSlP3FI0InXY1nos45DIAtKHZiJofjIbqaH1eVw1umHuXVUfDWO0djOaHmzpbUeqq7CwNql8qcPrQD3u78Svfi40ZLLLyZ7wJ8Ez30MtQfq7A0Kijb/CcShA==
X-Gm-Message-State: AOJu0Yxpv0sHHoJgG6Nsm9J85+dMf7Tv+Wwvh9NnN2zVlmWNhYsJnYfi
	feUx05eavy8tXN/KvpJifNBvCjhj8Q6dZXgDCDOR+CJlSjMtCcOu97dotY1ost4HG3ZCaNyMUvX
	X84OVml6OBR7gbxPNvPMS8x7aTeU=
X-Google-Smtp-Source: AGHT+IFPU6+LOf8PgX7KOs5qPDS8vsX5Vv8RXv8XleCs5E5DIcHCc8fIioa/JjHQYg24T8SZZtlR3JvXWMYc84EnZ4U=
X-Received: by 2002:adf:b1dc:0:b0:35d:bd46:960a with SMTP id
 ffacd0b85a97d-35efed4e09emr7157345f8f.23.1718009926938; Mon, 10 Jun 2024
 01:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
 <20240505181829.49864540@jic23-huawei>
In-Reply-To: <20240505181829.49864540@jic23-huawei>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Mon, 10 Jun 2024 10:58:35 +0200
Message-ID: <CADFWO8FGqD5GyrRtvFptjMdYBhfFFwOzgZ1XnVVEPeY3E8CZPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 7:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue, 30 Apr 2024 17:27:24 +0200
> Petar Stoykov <pd.pstoykov@gmail.com> wrote:
>
> > From 6ae7537517f551540121ca6fb3b99080b7580410 Mon Sep 17 00:00:00 2001
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > Date: Mon, 15 Jan 2024 12:21:26 +0100
> > Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
> >
> > Sensirion SDP500 is a digital differential pressure sensor. The sensor =
is
> > accessed over I2C.
> >
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> Hi Petar
>
> Ignoring the patch formatting which others have already given feedback on=
,
> a few minor comments inline.
>
> Also, I'd expect some regulator handling to turn the power on.
> Obviously on your particular board there may be nothing to do but good to
> have the support in place anyway and it will be harmless if the power
> is always on.
>
> Jonathan
>
Hi Jonathan,

Thank you for looking past the formatting!

I wrongly assumed the power regulator would be handled automatically :)
I see examples of how to do it in other pressure drivers now.

> >  st_pressure-$(CONFIG_IIO_BUFFER) +=3D st_pressure_buffer.o
> > diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp50=
0.c
> > new file mode 100644
> > index 000000000000..7efcc69e829c
> > --- /dev/null
> > +++ b/drivers/iio/pressure/sdp500.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/i2c.h>
> > +#include <linux/crc8.h>
> > +#include <linux/iio/iio.h>
> > +#include <asm/unaligned.h>
> > +
> > +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized=
 to 0x31)
> > +#define SDP500_READ_SIZE        3
> > +#define SDP500_CRC8_WORD_LENGTH 2
>
> As below. I'd establish these off the data the are the lengths of by usin=
g
> a structure definition.  That will be more obvious and less fragile than
> defines hiding up here.
>
>
> > +#define SDP500_CRC8_INIT        0x00
>
> I'd just use the number inline.  Can't see what the define is adding.

I've been taught to avoid magic numbers as much as possible.
Giving it a define directly explains what the number is, even if it's used =
once.
But I'll follow the community (in this case, you) for this.

>
> > +
> > +#define SDP500_SCALE_FACTOR 60
> > +
> > +#define SDP500_I2C_START_MEAS 0xF1
> > +
> > +struct sdp500_data {
> > +    struct device *dev;
> > +};
> > +
> > +DECLARE_CRC8_TABLE(sdp500_crc8_table);
> > +
> > +static int sdp500_start_measurement(struct sdp500_data *data, const
> > struct iio_dev *indio_dev)
> > +{
> > +    struct i2c_client *client =3D to_i2c_client(data->dev);
> > +
> > +    return i2c_smbus_write_byte(client, SDP500_I2C_START_MEAS);
> Doesn't seem worth a wrapper function. I would just put this code inline.
> > +}
> > +
> > +static const struct iio_chan_spec sdp500_channels[] =3D {
> > +    {
> > +        .type =3D IIO_PRESSURE,
> > +        .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>
> As below. It's a linear scale factor, so I would prefer _RAW and _SCALE
> to let userspace deal with the maths.

I saw your other e-mail with further explanation and I begrudgingly agree.
I would much prefer if the "SDP500_SCALE_FACTOR" return code is not
accepted for the "IIO_CHAN_INFO_PROCESSED" case. And I also saw
other drivers do the same as me which gave me confidence it was the right
thing to do.
But, again, it makes sense to avoid this so I'll change it as suggested.

>
> > +    },
> > +};
> > +
> > +static int sdp500_read_raw(struct iio_dev *indio_dev,
> > +              struct iio_chan_spec const *chan,
> > +              int *val, int *val2, long mask)
> > +{
> > +    int ret;
> > +    u8 rxbuf[SDP500_READ_SIZE];
> You could define this as a struct so all the data types are obvious.
>
>         struct {
>                 __be16 data;
>                 u8 crc;
>         } __packed rxbuf;
> The  __packed let's you use sizeof(rxbuf) for the transfer size.
> Beware though as IIRC that will mean data is not necessarily aligned
> so you'll still need the unaligned accessors.
>

I know, but I prefer to receive data in simple arrays and then deal with it=
.

> > +    u8 rec_crc, calculated_crc;
> > +    s16 dec_value;
> > +    struct sdp500_data *data =3D iio_priv(indio_dev);
> > +    struct i2c_client *client =3D to_i2c_client(data->dev);
> > +
> > +    switch (mask) {
> > +    case IIO_CHAN_INFO_PROCESSED:
> > +        ret =3D i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> > +        if (ret < 0) {
> > +            dev_err(indio_dev->dev.parent, "Failed to receive data");
> > +            return ret;
> > +        }
> > +        if (ret !=3D SDP500_READ_SIZE) {
> > +            dev_err(indio_dev->dev.parent, "Data is received wrongly")=
;
>
> I'd guess indio_dev->dev.parent =3D=3D data->dev
> If so use data->dev as more compact and that's where you are getting the
> i2c_client from.
>

Makes sense.

> > +            return -EIO;
> > +        }
> > +
> > +        rec_crc =3D rxbuf[2];
> > +        calculated_crc =3D crc8(sdp500_crc8_table, rxbuf,
> > SDP500_CRC8_WORD_LENGTH,
>
> I'd use the number 2 for length directly as it's useful to know this is t=
he
> __be16 only, or sizeof(__be16)
> What is the point in rec_crc local variable?

Ok, I will use sizeof(rxbuff) - 1 instead of the define.
The rec_crc is again for readability, like the SDP500_CRC8_INIT define.
I will change it to "received_crc" which is clearer though.

>
> > +            SDP500_CRC8_INIT);
> > +        if (rec_crc !=3D calculated_crc) {
> > +            dev_err(indio_dev->dev.parent, "calculated crc =3D 0x%.2X,
> > received 0x%.2X",
> > +                calculated_crc, rec_crc);
> > +            return -EIO;
> > +        }
> > +
> > +        dec_value =3D get_unaligned_be16(rxbuf);
> > +        dev_dbg(indio_dev->dev.parent, "dec value =3D %d", dec_value);
>
> When you move to returning scale and _raw this print won't add anything s=
o
> drop it.
>
> > +
> > +        *val =3D dec_value;
> > +        *val2 =3D SDP500_SCALE_FACTOR;
> For linear transforms like this it is normally better to provide separate
> raw and scale interfaces.
>
> Then if anyone does want to add buffered support in the future that is ea=
sier
> to do as it is much more compact + userspace has floating point which is =
always
> going to be better for division than we can do in kernel.
>
> > +        return IIO_VAL_FRACTIONAL;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +}
> > +
> > +static const struct iio_info sdp500_info =3D {
> > +    .read_raw =3D &sdp500_read_raw,
> > +};
> > +
> > +static int sdp500_probe(struct i2c_client *client)
> > +{
> > +    struct iio_dev *indio_dev;
> > +    struct sdp500_data *data;
> > +    struct device *dev =3D &client->dev;
> > +    int ret;
> > +    u8 rxbuf[SDP500_READ_SIZE];
> > +
> > +    indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +    if (!indio_dev)
> > +        return -ENOMEM;
> > +
> > +    /* has to be done before the first i2c communication */
> > +    crc8_populate_msb(sdp500_crc8_table, SDP500_CRC8_POLYNOMIAL);
> > +
> > +    data =3D iio_priv(indio_dev);
> > +    data->dev =3D dev;
> > +
> > +    indio_dev->name =3D "sdp500";
> > +    indio_dev->channels =3D sdp500_channels;
> > +    indio_dev->info =3D &sdp500_info;
> > +    indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +    indio_dev->num_channels =3D ARRAY_SIZE(sdp500_channels);
> > +
> > +    ret =3D sdp500_start_measurement(data, indio_dev);
> > +    if (ret)
> > +        return dev_err_probe(dev, ret, "Failed to start measurement");
>
> Blank line here would help readability a tiny bit.
>
> > +    /* First measurement is not correct, read it out to get rid of it =
*/
> > +    i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> > +
> > +    ret =3D devm_iio_device_register(dev, indio_dev);
> > +    if (ret < 0)
> > +        return dev_err_probe(dev, ret, "Failed to register indio_dev")=
;
>
> We rarely bother with error prints on failure to register as it is unlike=
ly
> to fail because of something that happened at runtime and if it does, tha=
t
> is easy to track down.  So I'd drop this print.
> If you really want to keep it I don't mind that much.
>
> > +
> > +    return 0;
> > +}
> > +
> > +static const struct i2c_device_id sdp500_id[] =3D {
> > +    { "sdp500" },
> > +    { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> > +
> > +static const struct of_device_id sdp500_of_match[] =3D {
> > +    { .compatible =3D "sensirion,sdp500" },
> > +    { }
> > +};
> > +MODULE_DEVICE_TABLE(of, sdp500_of_match);
> > +
> > +static struct i2c_driver sdp500_driver =3D {
> > +    .driver =3D {
> > +        .name    =3D "sensirion,sdp500",
> > +        .of_match_table =3D sdp500_of_match,
> > +    },
> > +    .probe       =3D sdp500_probe,
> > +    .id_table    =3D sdp500_id,
> I'd not bother with aligning =3D signs. It just tends to create noise
> as drivers evolve and people try to keep things aligned (resulting in rea=
ligning
> everything).
>

Good point. It does also bothers me when commits are muddied by
realigning things.

> > +};
> > +module_i2c_driver(sdp500_driver);
> > +
> > +MODULE_AUTHOR("Thomas Sioutas <thomas.sioutas@prodrive-technologies.co=
m>");
> > +MODULE_DESCRIPTION("Driver for Sensirion SDP500 differential pressure =
sensor");
> > +MODULE_LICENSE("GPL");
>

I will test the driver with the suggested changes as soon as I get the
hardware again
and I will try using the b4 tool with "web submission endpoint". Thanks aga=
in!


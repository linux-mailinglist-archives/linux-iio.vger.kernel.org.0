Return-Path: <linux-iio+bounces-7293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E487927143
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47FB1F23473
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D521A3BB0;
	Thu,  4 Jul 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKPNDwBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56310A35;
	Thu,  4 Jul 2024 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080580; cv=none; b=nOrTx+SJrNi1Vi5uttGrrXdyMdk3WcqMc//GACPSpkkaeMFxV7woJGCDOfsr8Ok9igF6gBHUCtidnUQ2GCMAQ4dwElBgrpetX0FeQtmyt9WQhVNTvfueaujElKaXwYJPBhSHejEYfjMyrRXNPcsSburqXYoIS8YsZ2/Jc5iR8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080580; c=relaxed/simple;
	bh=mzREj9KU+RIGh6pjAbnDkGaXQKlTUlPduDVxLAK3XbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4Mv0SHK3cEZg5hmiJt4Qteg4uMarFOHfbWs8FS4vzvN+ziwOfMAojjjDcNAaWfhupEVgfX6XGIf5kQ1MgRrcYpKTnJrBLpkrg/9dE+USQAuZASLMSMgJ70btWDd6XuQNGHY02nWYUAbYUYkTcE81Yq1N4j9tbIYBaeywGb6i8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKPNDwBe; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-42574064b16so2265805e9.2;
        Thu, 04 Jul 2024 01:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720080577; x=1720685377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At3x/cb5L00tPzk3GxMxkPyDezWmAOT5glKpx7DWwTA=;
        b=JKPNDwBeg5Fyop5p0k473ksDDo2QOVz4KIMqB5PMGIBcZSdaUBEP3zq0kXl5xtutWw
         sRiaKFDZCjEI34nWfqomT8yytemc7mPlIDrO45c0xI9DZ0SD/5WznBGQkMxNsGJBRAaB
         URm0DmWUWJ1+F/HnD2BowkECd4VRePoeiHyiCftL3mWzdIKAkKtcjv3fe+9s/bZnkQJN
         SIC9c0Zc4eW6SV8/1QiUJ3KeMd1nM2TuH3unDGf6aTS8d12PLzuINERck0zQktTG8CTn
         KAN339qv0fyyiWvUJN0TsAL7Wf5vUAqpk6pS+/hUZxP9Xmm36VfwGaxOwLFepc5dpMDZ
         hr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080577; x=1720685377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At3x/cb5L00tPzk3GxMxkPyDezWmAOT5glKpx7DWwTA=;
        b=W39OVTQbnD0lQmwSXvSbCdcm4Dys2UYYiNhgea+uf34NmbDJkCntKN9/Bu/v6hdGfo
         wyyq7jewQC4S5A6Z5dQl1TCNXgj47kK+OFeZ1O5Nczit9IIBJSe/wzN/esbhjPiXrxja
         QOFGeMQSIJ7EzlNKO1RILTIILIAVgBavQfhUbdOFb8QaJY8XgN9ufbqz/TBK5oNz6LRy
         6ghzrfvvtYFv6cNZ02oejY08Q9gUwrcHv6Hjx+O4sIBakkvuXCezejlqM/us4xgVqEkA
         htQ/41a8BiFkFieRJASemtsQKWqiRsjwH531hU/QB3O3Cmw1KuNqJfLjuxn4SIq1ALYY
         TAfA==
X-Forwarded-Encrypted: i=1; AJvYcCVY2NRBGGDv28sNDhrwXU75hgPFL6dpXjRgoVbSItdKbvF5TZVY7NKza/mTz3Ouh1hoI/sqK2I8LE9JzLOzUNXuR4ZZnwnqfs44Gqn4EXSdLqCQadGSgL+5uVrKvwDhMJiWhAfW17K0A/PkdjM0VooXwg6cq3zCB4nBc8PSDQNZz5i2kg==
X-Gm-Message-State: AOJu0YwtLj7vyZRM/9N4+giGU2cPif1D8jOUdyA4KBWFr2AW2l5LVKRM
	t2Zc55I1W6nWu7JYwn3lzC9X7d4ugXOCDX8YSqRByPlaDzdnRF41IMpNY6qMQ2bZcU9P8lq8gH9
	Rr4utY6OwBVBEZaXMB9IB8SAissY=
X-Google-Smtp-Source: AGHT+IGlAWoGGvZHfmENCR5xELVDk3NkkWLOIAgOwRECIT6qZNihSJ9xk5VerWMGyGiYKiCCxvZK+9k3KV/57sPkZ74=
X-Received: by 2002:a05:6000:12c3:b0:367:9bc8:f3ee with SMTP id
 ffacd0b85a97d-3679dd0d302mr653365f8f.4.1720080577384; Thu, 04 Jul 2024
 01:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com> <20240702211615.0334c2e6@jic23-huawei>
In-Reply-To: <20240702211615.0334c2e6@jic23-huawei>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Thu, 4 Jul 2024 10:09:26 +0200
Message-ID: <CADFWO8E_yHdbnC7BtOXODYnKgmP9t-4sXANsveYOxw89N8V3Fw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
To: Jonathan Cameron <jic23@kernel.org>
Cc: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>, linux-iio@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 02 Jul 2024 16:59:09 +0200
> Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> wro=
te:
>
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> >
> > Sensirion SDP500 is a digital differential pressure sensor. The sensor =
is
> > accessed over I2C.
> >
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> Hi Petar
>
> Given you are going to be doing a v4, a few comments inline on things
> to tidy up in here.
>
> Note that I've already tagged what may be the last pull request from me
> for the 6.11 merge window, so this is probably 6.12 material now anyway.
> Hence plenty of time to tidy up.
>
> Jonathan
>

Hi Jonathan,
I have no rush, thank you for the explanation!

> > diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp50=
0.c
> > new file mode 100644
> > index 000000000000..661c70bc1b5b
> > --- /dev/null
> > +++ b/drivers/iio/pressure/sdp500.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for Sensirion sdp500 and sdp510 pressure sensors
> > + *
> > + * Datasheet: https://sensirion.com/resource/datasheet/sdp600
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/crc8.h>
> > +#include <linux/iio/iio.h>
>
> #include <linux/mod_devicetable.h> appropriate for the id tables.

I don't understand. Why add an extra header to a working driver?
I will add it and test the driver in the meantime.

>
> > +#include <linux/regulator/consumer.h>
> > +#include <asm/unaligned.h>
> > +
> > +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized=
 to 0x31)
>
> For IIO we tend to just use c style comments /* xxx */
> and not c++ ones.

I try to follow this rule but once in a while I slip to my old habits.
My teachers all used // for C for whatever reason. Will fix.

>
> > +#define SDP500_READ_SIZE        3
>
> > +static int sdp500_read_raw(struct iio_dev *indio_dev,
> > +                       struct iio_chan_spec const *chan,
> > +                       int *val, int *val2, long mask)
> > +{
> > +     int ret;
> > +     u8 rxbuf[SDP500_READ_SIZE];
> > +     u8 received_crc, calculated_crc;
> > +     struct sdp500_data *data =3D iio_priv(indio_dev);
> > +     struct i2c_client *client =3D to_i2c_client(data->dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> > +             if (ret < 0) {
> > +                     dev_err(data->dev, "Failed to receive data");
> > +                     return ret;
> > +             }
> > +             if (ret !=3D SDP500_READ_SIZE) {
> > +                     dev_err(data->dev, "Data is received wrongly");
> > +                     return -EIO;
> > +             }
> > +
> > +             received_crc =3D rxbuf[2];
> > +             calculated_crc =3D crc8(sdp500_crc8_table, rxbuf, sizeof(=
rxbuf) - 1, 0x00);
> A line break in here to keep it under 80 chars would be good (see below).

I find the 80 chars too constraining and also saw that the limit was update=
d
to 100 somewhere in kernel.org which made me happy. But.. you seem to
feel strongly enough about this so I'll trim lines to 80.

>
> > +             if (received_crc !=3D calculated_crc) {
> > +                     dev_err(data->dev, "calculated crc =3D 0x%.2X, re=
ceived 0x%.2X",
> > +                             calculated_crc, received_crc);
> > +                     return -EIO;
> > +             }
> > +
> > +             *val =3D get_unaligned_be16(rxbuf);
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D 1;
> > +             *val2 =3D 60;
> > +
> > +             return IIO_VAL_FRACTIONAL;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info sdp500_info =3D {
> > +     .read_raw =3D &sdp500_read_raw,
> > +};
> > +
> > +static int sdp500_probe(struct i2c_client *client)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct sdp500_data *data;
> > +     struct device *dev =3D &client->dev;
> > +     int ret;
> > +     u8 rxbuf[SDP500_READ_SIZE];
> > +
> > +     ret =3D devm_regulator_get_enable(dev, "vdd");
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to get and enable =
regulator\n");
> Given you are going around again.  Add a line break before "
> General rule is stay under 80 chars unless it hurts readability.
>
> > +


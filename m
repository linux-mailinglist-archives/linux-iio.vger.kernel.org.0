Return-Path: <linux-iio+bounces-12935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07139DFD2A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A8EB2204A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD81F9EBB;
	Mon,  2 Dec 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhNZNBGP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB63398B;
	Mon,  2 Dec 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131870; cv=none; b=iww92jJJpSu3eieJZaj7f7hxSJMr6O/mMOyfwfva+az1ndPDjNxohCmIB/ZpQr+/DnyZKzKu3n3g3aH0RHi69FzHYBbB0ClfCUiylsW0aGVA8f/vLo66kFPF9lMf5/++hBtxB410QACen+BTrK+mNq5omg066jZ3jUixBlf0jpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131870; c=relaxed/simple;
	bh=tF7gEWm2Zx5VzHOPv9iUoY44HiA9fpxBXMaVhvsyQtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWuacAWJAoqtGHtJCbF2J7Ofl6MS7SaEy57zGtEY2MNZbj+iKhZoEwr5Z0jLjkpfgapk3a6X9gxxSsHuHZqFe5dHQHFcLYn11s++N70GFa4ILp2dvBmA8MII0eDJQLr/NaYAcJbZwIgeH03AsqMT6OFVUPHcC9FZ8GQRe8nsq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhNZNBGP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef7f8acc33so9792837b3.1;
        Mon, 02 Dec 2024 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733131866; x=1733736666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Aoss/XkVgxtLxmwM1bSt0KorgawUhi01yNafo9R0a4=;
        b=AhNZNBGPdwvoFU08FbHOaMLRviH3Z5ae94Wha/YznMXxjN8RutrFcsVqhGNqtq4jYD
         xOhdmQhZlOCb4Ljt3tt7FezP2oHdzA1DWpjrePEktxqD9NGaBLefbuWB61Y8MHKRorqQ
         MSxucyOe3PMJQ0VykzNU0Cu8joNmRCvmv/tDNzNa6Qw+ZLdySjFG9R7VbQOMsqAVo2vG
         f5P/wTazIgZPUK8Df2Lu1md2meSDSxuL9fSasPW6nfeh/t+ZqXSCPKnk/5HG44LZxNPs
         HKYG1QXJICnKEuFK1RbrMWg68gqU2793boSiSFQJ5Jx4LHdgk+IH9Br6Ahi5RbElCVi9
         eLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131866; x=1733736666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Aoss/XkVgxtLxmwM1bSt0KorgawUhi01yNafo9R0a4=;
        b=ZjKidWQ0WMjWRhtWTREUC3Md92haj08ddLjjxb7/28erqUz9AeVB/WrH2rgUgGmbER
         D2gzrO9ePxl8RHXfbPsCdv9477DejoDtQFm5MFE0tlady7m2oxDsinbihRo4YDrrB0r0
         laYCJfaZBml4vpbdSp2D/hi0sI+TSArUzwk+b89t5qUv6YFUFAORBEWguuzFED8rfCf0
         kxVTUo5eHgqC8mMfG9tRv4xqvdww261UFeI0TJESX87GaXpahG04wzCYxAZeoMUBLxhT
         rQvfbESC60oAFVy50NMmJb+6RiskWgy1RKcgYl7/QlCWtaC19DZzV936EN060HUbAKkI
         shOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfA9VV/JWAoputlLLL5rDARQfPZQmObRzUkJfHNAFjAPpOskJzw5aXMkaXppw1uPrHbjt9uT0n7fnVpBoo@vger.kernel.org, AJvYcCX1cmNFlL2mu02LoRIoUouwzL4HHr6GdMsigTd4rcVNKGptG+9XifzpkFrRsWILwUq2utEiJYk5LzLL@vger.kernel.org, AJvYcCXmxATsocoj8iUjfcPc5dg37qqvwGfKhJ+3iMP8EEK51V7R7W5UptcKVf3mTpcoDBBd4E1Bn7d4rFrB@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8wkwd9bPPxpHmZcad5rO9wYeTd1vBt0RWRsW2I61awKPmszj
	wWn1qsdsILZZd/IXzEcFyXCc19edN9Zf+X3Z01+1e+BybkSeU8MI2Bhs0C7cbDrovMIGwzP5znt
	xjyQe6s3XgIrwooNmcvUCgjeWM7g=
X-Gm-Gg: ASbGncul6SzUJLqMf/ZOyv217GZe2fj/ho6Xdtt44r5NJYMxijwE6Gli5VJNlxYoXW1
	C1aNrwG9rUmsIAXDKHXn5fG9o0+wHBtnPU635d3vYlTzK3x/Be/aFyxg9K9pdBxbc
X-Google-Smtp-Source: AGHT+IEjdWzZ+SSQO7ixCc/QMQkkM2B0OurRLofzWsNFboTM/kVCFJcwpVVHxgN7WNTCiDhrzr35t06Qy+V8xjswDcU=
X-Received: by 2002:a05:6902:2784:b0:e39:96af:53b7 with SMTP id
 3f1490d57ef6-e3996af85e1mr7134013276.52.1733131866096; Mon, 02 Dec 2024
 01:31:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126074005.546447-1-tmyu0@nuvoton.com> <20241126074005.546447-3-tmyu0@nuvoton.com>
 <20241130203929.67c6c7f6@jic23-huawei>
In-Reply-To: <20241130203929.67c6c7f6@jic23-huawei>
From: Ming Yu <a0282524688@gmail.com>
Date: Mon, 2 Dec 2024 17:30:54 +0800
Message-ID: <CAOoeyxVXWAFC4ZL5Hr7H4+Vk8b86Qf2FBY0vGWa7NWPWHo6MWg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: temperature: Add Nuvoton NCT7718W support
To: Jonathan Cameron <jic23@kernel.org>
Cc: tmyu0@nuvoton.com, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, cmo@melexis.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan,

Thank you for your comments,
I will move the driver to HWMON.

Best regards,
Ming

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=881=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=884:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 26 Nov 2024 15:40:05 +0800
> Ming Yu <a0282524688@gmail.com> wrote:
>
> > This patch adds support for the Nuvoton NCT7718W temperature sensor.
> >
> Hi Ming, I'll give this a quick look only as I suspect you will end
> up moving over to hwmon.
>
> Thanks,
>
> Jonathan
>
> > Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
> ...
>
> > diff --git a/drivers/iio/temperature/nct7718.c b/drivers/iio/temperatur=
e/nct7718.c
> > new file mode 100644
> > index 000000000000..60624b3de629
> > --- /dev/null
> > +++ b/drivers/iio/temperature/nct7718.c
> > @@ -0,0 +1,505 @@
>
> > +struct nct7718_data {
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> Locks need a comment to say what data they are protecting.
>
> > +     u16 status_mask;
> > +};
>
> > +static int nct7718_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   int state)
> > +{
> > +     struct nct7718_data *data =3D iio_priv(indio_dev);
> > +     unsigned int status_mask;
> > +     int ret;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_TEMP_AMBIENT:
> > +             if (dir =3D=3D IIO_EV_DIR_RISING)
> > +                     status_mask =3D NCT7718_MSK_LTH;
> > +             break;
> > +     case IIO_MOD_TEMP_OBJECT:
> > +             if (dir =3D=3D IIO_EV_DIR_RISING)
> > +                     status_mask =3D NCT7718_MSK_RT1H;
> > +             else
> > +                     status_mask =3D NCT7718_MSK_RT1L;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     mutex_lock(&data->lock);
> > +     ret =3D i2c_smbus_read_byte_data(data->client, NCT7718_ALERTMASK_=
REG);
> > +     mutex_unlock(&data->lock);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (state)
> > +             ret &=3D ~status_mask;
> > +     else
> > +             ret |=3D  status_mask;
> I would not bother with this sort of alignment. It tends to be fragile lo=
nger
> term as code gets modified and doesn't make much difference to readablili=
ty.
>
> > +
> > +     return i2c_smbus_write_byte_data(data->client, NCT7718_ALERTMASK_=
REG,
> > +                                      data->status_mask =3D ret);
> > +}
>
> > +
> > +static int nct7718_write_thresh(struct iio_dev *indio_dev,
> > +                             const struct iio_chan_spec *chan,
> > +                             enum iio_event_type type,
> > +                             enum iio_event_direction dir,
> > +                             enum iio_event_info info,
> > +                             int val, int val2)
> > +{
> > +     struct nct7718_data *data =3D iio_priv(indio_dev);
> > +     struct i2c_client *client =3D data->client;
> > +     u8 msb_reg, lsb_reg;
> > +     s16 thresh;
> > +     int ret, s_val;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_TEMP_AMBIENT:
> > +             val =3D clamp_val(val, NCT7718_LOCAL_TEMP_MIN,
> > +                             NCT7718_LOCAL_TEMP_MAX);
> > +
> > +             if (dir =3D=3D IIO_EV_DIR_RISING) {
> > +                     return i2c_smbus_write_byte_data(client,
> > +                                                      NCT7718_LT_HALER=
T_REG,
> > +                                                      val);
> > +             }
> > +             break;
> > +     case IIO_MOD_TEMP_OBJECT:
> > +             s_val =3D (val < 0) ? ((val * 1000000) - val2) :
> > +                                 ((val * 1000000) + val2);
> > +
> > +             s_val =3D clamp_val(s_val, NCT7718_REMOTE_TEMP_MIN_MICRO,
> > +                               NCT7718_REMOTE_TEMP_MAX_MICRO);
> > +
> > +             if (dir =3D=3D IIO_EV_DIR_RISING) {
> > +                     msb_reg =3D NCT7718_RT1_HALERT_MSB_REG;
> > +                     lsb_reg =3D NCT7718_RT1_HALERT_LSB_REG;
> > +             } else {
> > +                     msb_reg =3D NCT7718_RT1_LALERT_MSB_REG;
> > +                     lsb_reg =3D NCT7718_RT1_LALERT_LSB_REG;
> > +             }
> > +
> > +             thresh =3D (s16)(s_val / (1000000 >> 3));
> > +             ret =3D i2c_smbus_write_byte_data(client,
> > +                                             msb_reg, thresh >> 3);
> > +             if (ret < 0)
> > +                     return ret;
> > +             return i2c_smbus_write_byte_data(client,
> > +                                              lsb_reg, thresh << 5);
> > +     default:
> > +             break;
> return -EINVAL; and drop return below.
>
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> >
> > +
> > +static bool nct7718_check_id(struct i2c_client *client)
> > +{
> > +     int chip_id, vendor_id, device_id;
> > +
> > +     chip_id =3D i2c_smbus_read_byte_data(client, NCT7718_VID_REG);
> > +     if (chip_id < 0)
> > +             return false;
> > +
> > +     vendor_id =3D i2c_smbus_read_byte_data(client, NCT7718_VID_REG);
> > +     if (vendor_id < 0)
> > +             return false;
> > +
> > +     device_id =3D i2c_smbus_read_byte_data(client, NCT7718_DID_REG);
> > +     if (device_id < 0)
> > +             return false;
> > +
> > +     return (chip_id =3D=3D NCT7718_CHIP_ID &&
> > +             vendor_id =3D=3D NCT7718_VENDOR_ID &&
> > +             device_id =3D=3D NCT7718_DEVICE_ID);
> As below. Don't treat this failing as an error.   It is an error if
> you can't read anything however.
>
> > +}
> > +
> > +static int nct7718_chip_config(struct nct7718_data *data)
> > +{
> > +     int ret;
> > +
> > +     /* Enable MSK_LTH, MSK_RT1H, and MSK_RT1L to monitor alarm */
> Code makes this fairly obvoius.
>
> > +     ret =3D i2c_smbus_read_byte_data(data->client,
> > +                                    NCT7718_ALERTMASK_REG);
> > +     if (ret < 0)
> > +             return ret;
> > +     data->status_mask =3D ret;
> > +     data->status_mask &=3D ~(NCT7718_MSK_LTH  |
> > +                            NCT7718_MSK_RT1H |
> > +                            NCT7718_MSK_RT1L);
> > +
> > +     ret =3D i2c_smbus_write_byte_data(data->client,
> > +                                     NCT7718_ALERTMASK_REG,
> > +                                     data->status_mask);
>
> Perhaps consider regmap for it's richer set of functionality.
>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Config ALERT Mode Setting to comparator mode */
>
> Ideally (like here) the code should be self explanatory so you don't
> need comments.  When that is the case the comment is both unnecessary
> and a source of possible future confusion if the code changes and we
> fail to keep the comment in sync.
>
> > +     return i2c_smbus_write_byte_data(data->client,
> > +                                      NCT7718_ALERTMODE_REG,
> > +                                      NCT7718_MOD_COMP);
> > +}
> > +
> > +static int nct7718_probe(struct i2c_client *client)
> > +{
> > +     struct nct7718_data *data;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     if (!nct7718_check_id(client)) {
> > +             dev_err(&client->dev, "No NCT7718 device\n");
>
> If you get an ID missmatch, it is fine to print a message, but carry on a=
nyway.
> This is necessary because DT has fallback compatibles to allow for newer =
devices
> working with older drivers.  That only works if we believe the firmware a=
nd
> ignore a mismatched ID.
>
> > +             return -ENODEV;
> > +     }
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     data->client =3D client;
> > +     mutex_init(&data->lock);
>
> For new code prefer
>         ret =3D devm_mutex_init()
>         if (ret)
>                 return ret;
>
> > +
> > +     indio_dev->name =3D client->name;
>
> client->name doesn't always end up as the part number which is what
> we need here.  Just put "nct7718" in here directly.
>
> Some drivers do this wrong and we can't fix them without breaking
> userspace, but we don't want to introduce more.
>
> > +     indio_dev->channels =3D nct7718_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(nct7718_channels);
> > +     indio_dev->info =3D &nct7718_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     ret =3D nct7718_chip_config(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (client->irq) {
> > +             ret =3D devm_request_threaded_irq(&client->dev,
> > +                                             client->irq,
> > +                                             NULL,
> > +                                             nct7718_alert_handler,
> > +                                             IRQF_TRIGGER_FALLING |
> > +                                             IRQF_ONESHOT,
> > +                                             "nct7718", indio_dev);
> > +             if (ret) {
> > +                     dev_err(&client->dev, "Failed to request irq!\n")=
;
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> > +}


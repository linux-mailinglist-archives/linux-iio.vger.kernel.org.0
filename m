Return-Path: <linux-iio+bounces-14330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC0FA0C491
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 23:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EC7188AE9F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B01F9ECE;
	Mon, 13 Jan 2025 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ9WS/Wm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99AE18FDAB;
	Mon, 13 Jan 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806770; cv=none; b=vDxrBqipOO3Mq5U6JPkSY1fk19pqZuYyRXDcnwp3NtCWTEn87Xb22mviCiF81yHJT8NoleJNa89X3799EC+cj1Upe002DosS9Qossx8vZef1DsP4MzwC2lkdtJbMNTNOg3gmu5QmpQqCqzbaNxc7TlXA8kro9EgWz+PG5p58j7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806770; c=relaxed/simple;
	bh=iqNuI7CeHp1z71N+IK+1Zokd/Dv6Jpu50q4xPdJREPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFt10S/UyiNwX5OjqYwYjBDyy5pj7YL5R1RADLJJ9dT1ECUJwpxfbIjwLD9hdZ5ogk0pLDaIYxVIG4bjTxXdOGLYvcBck9lQqaBZ1v5Xa166Wr35UZr+/By5jBoigPkDx40ax6nLh3gQ/dpVQL6mYJsMM26AKhIaL+kUZC2pY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ9WS/Wm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso6802897a12.0;
        Mon, 13 Jan 2025 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736806767; x=1737411567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gWHrGA1t8G7bq2Qx/DCwte/xjGcmknGpfAnbOJAB2I=;
        b=GZ9WS/Wmjw/XU8NO+YAhZffGgQ7HyIGxFfXhe9VMuWz6JxEI0j8k8DVVucYL5A2yHQ
         coFe0xFvaOja6LQj0V3x8xrqUsjaAIkCcUQfFz0yOKpTviOJSQoCiY0VGuEPR5XW75bS
         9jC8TIN3tQSof+zYwIkYZFubKhdbbIkocCj6ZuuQk7gj3TkI+r8ZadQDLeSL0YZfchcB
         reoZAxeIM/z9ECraoRPQoiWkPyi9gubAJl3pGWqHlqN7SSyThTuIV9E+eLPlVOZ5mDrf
         H3qIFrm6HSMuhdwMlYHvuq5bzqt6U9+/mvtFkGrymmxWjqnG5ted9yRiPn0A3gEyRANW
         crLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736806767; x=1737411567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gWHrGA1t8G7bq2Qx/DCwte/xjGcmknGpfAnbOJAB2I=;
        b=sWNM1qoCUk9c29fblK56Ut+EFtyLg5vPBqCrD5Ecr6Xt5RmfVHKNLaq/KpfcqoT7io
         hiEbbdd6/0in5LBEszDItW/jmm060EKnPNscv7UUYQeVRBqfS6QYtpOE0hLSkOUinXv8
         DnlcrG/Odq0hIULPiLNRb76LgH8Fn/vcMCR7UrKsXRt1Entw4xwpV+26VYXpyeotZerd
         TfweeN6K7ud6H56JLe2tPVFR7WKkzt8VsPtNYn2d1901Jkhf0QU/0TkMvi8OMaWj76zI
         eXqJ9sPLDQ+QBrOYKw3TqytH7NJKAI3wnO2bSyPvW+J0BnHe85bYkXZzwrdIdQQ2fVcp
         /YlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjtWj7tlusFtqoSTmjWNzCsy5EJW+eEzEodbj6nRHMQpx5q8nXu9wZL9gjQb3uokOSnKPVBUKu42d8mj5K@vger.kernel.org, AJvYcCV6ivVILtRBJwBMTIApfXtFkHZhrls3T+ZgUctOehwX2YvdoipUfaj/dV1c10hKrhPGe/HtottbTuFm@vger.kernel.org, AJvYcCVToIs7idbv/fvf/gyS12XxZ+Qx6wNeccrlTuwVFDgzrwYRRZR7QpmicGbq81hhCTjk6Zqn3ZJzRwwJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4txmFsKMoOR6FDp9gE4diphlMY8uRUPTw95NTcGfzubpkHec
	fsJpz2bFL9NrwQttLBAWmr2Y7Ea2QCBJaDm+1+NKoJeaLdR+DcC8
X-Gm-Gg: ASbGnctNa5wczviWEZ45XszxO82gpPIa5Dc9Pxu/K/vk3klV4FCkmStyMPRfonxETfz
	AMmyIhx8k+fB8yN4TZob68rvbbeHPJaO7nFSBiDJ4QuLeEIOqn8HFqLpa3/eB6kFIfHvbo77/B6
	wW3i0oxESXK2TvSuA+N7pXku0eBlJmMKxf/CvbEw0vHdm537tTRWzYWje5Ve4SIBDqsARbmgSO/
	KQAS6OYqbKTmP5iC4+iMidOh5dhgTtessn+9aeFNZQehKjKXDIBmxoLX+BJTFXSpBVMvepdKbgM
	E6NqEoFpAytAOnp2aQX5Trx4
X-Google-Smtp-Source: AGHT+IGkUsfS/DYsoVCCpxdcbGz73lkbxLfC1arPChFRsHJ1eJS9t2W7pOGfuEmejNAdiTYDgS4WuA==
X-Received: by 2002:a05:6402:35ca:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d972e0b954mr57466805a12.11.1736806766727;
        Mon, 13 Jan 2025 14:19:26 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([37.163.214.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9646be5sm557018966b.174.2025.01.13.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:19:26 -0800 (PST)
Date: Mon, 13 Jan 2025 23:19:05 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <20250113221905.ruv3w3k4w53hvf2b@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250112104453.45673-1-apokusinski01@gmail.com>
 <20250112104453.45673-3-apokusinski01@gmail.com>
 <CAHp75VedQvf2xwY3fDWX=FQaHyhaUSVJW3Y6Yt2ecpwru756vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VedQvf2xwY3fDWX=FQaHyhaUSVJW3Y6Yt2ecpwru756vw@mail.gmail.com>

Hi Andy,
Thanks for the review. I'm currently implementing some changes in the
driver according to the review, however I have some doubts regarding
removal of the `i2c_client` from `si7210_data`.

Kind regards,
Antoni

On Sun, Jan 12, 2025 at 04:18:46PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 12, 2025 at 12:45 PM Antoni Pokusinski
> <apokusinski01@gmail.com> wrote:
> >
> > Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> > temperature sensor. The driver supports the following functionalities:
> > * reading the temperature measurements
> > * reading the magnetic field measurements in a single-shot mode
> > * choosing the magnetic field measurement scale (20 or 200 mT)
> 
> ...
> 
> Many header inclusions are being missed.
> 
> + array_size.h
> 
> > +#include <linux/bitfield.h>
> 
> + bits.h (it's even mentioned in the top comment of bitfield.h)
> 
> + cleanup.h
> + err.h
> 
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/math64.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> 
> + types.h
> 
> 
> + asm/byteorder.h (or is it already available as linux/byteorder.h?),
> but it seems that what you actually wanted is linux/unaligned.h (see
> below why).
> 
> ...
> 
> > +static const unsigned int a20_otp_regs[A_REGS_COUNT] = {
> > +       SI7210_OTPREG_A0_20, SI7210_OTPREG_A1_20, SI7210_OTPREG_A2_20,
> > +       SI7210_OTPREG_A3_20, SI7210_OTPREG_A4_20, SI7210_OTPREG_A5_20
> 
> Please, leave trailing comma(s) when it's clearly not a terminator entry.
> 
> > +};
> > +
> > +static const unsigned int a200_otp_regs[A_REGS_COUNT] = {
> > +       SI7210_OTPREG_A0_200, SI7210_OTPREG_A1_200, SI7210_OTPREG_A2_200,
> > +       SI7210_OTPREG_A3_200, SI7210_OTPREG_A4_200, SI7210_OTPREG_A5_200
> 
> Ditto.
> 
> > +};
> 
> ...
> 
> > +struct si7210_data {
> > +       struct i2c_client *client;
> 
> Do we really need a room for that? Isn't it derivable from the below
> regmap? Also note the frequency of use of client vs. regmap. The
> result in the object file can be much better if regmap becomes the
> first member here. Check it (with bloat-o-meter, for example).
>

I used arm-linux-nm and the bloat-o-meter to compare the sizes and it
turned out that the version which contains the `i2c_client` has
slightly smaller size actually. Here are the results:

$ ./scripts/bloat-o-meter -p arm-linux-  ./old_si7210.ko  ./new_si7210.ko
add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
Function                                     old     new   delta
si7210_probe                                 556     560      +4
Total: Before=4021, After=4025, chg +0.10%

Here is the diff (shortened for better readability) between
the old_si7210.ko (uses `si7210_data->i2c_client`) and
new_si7210.ko (does not use `si7210_data->i2c_client`):

 struct si7210_data {
-       struct i2c_client *client;
        struct regmap *regmap;
...
 static int si7210_device_wake(struct si7210_data *data)
 {
+       struct device *dev = regmap_get_device(data->regmap);
        int ret;

-       ret = i2c_smbus_read_byte(data->client);
+       ret = i2c_smbus_read_byte(to_i2c_client(dev));
...
static int si7210_probe(struct i2c_client *client)
        data = iio_priv(indio_dev);
-       data->client = client;

Hence, I guess that it's actually better to leave the `i2c_client` as it is.

> > +       struct regmap *regmap;
> > +       struct regulator *vdd;
> > +       struct mutex fetch_lock; /* lock for a single measurement fetch */
> > +       s8 temp_offset;
> > +       s8 temp_gain;
> > +       s8 scale_20_a[A_REGS_COUNT];
> > +       s8 scale_200_a[A_REGS_COUNT];
> > +       u8 curr_scale;
> > +};
> > +
> > +static const struct iio_chan_spec si7210_channels[] = {
> > +       {
> > +               .type = IIO_MAGN,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> > +       },
> > +       {
> > +               .type = IIO_TEMP,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +       }
> 
> Leave trailing comma.
> 
> > +};
> > +
> > +static int si7210_fetch_measurement(struct si7210_data *data,
> > +                                   struct iio_chan_spec const *chan,
> > +                                   __be16 *buf)
> > +{
> > +       u8 dspsigsel = chan->type == IIO_MAGN ? 0 : 1;
> > +       int ret, result;
> 
> Why is the result signed? I believe even regmap APIs have it unsigned
> in the prototypes.
> Ah, it's even worse... See below.
> 
> > +       guard(mutex)(&data->fetch_lock);
> > +
> > +       ret = regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
> > +                                SI7210_MASK_DSPSIGSEL, dspsigsel);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
> > +                                SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
> > +                                SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /* Read the contents of the registers containing the result: DSPSIGM, DSPSIGL */
> > +       ret = regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM, &result, 2);
> 
> I stumbled over this...
> 
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *buf = cpu_to_be16(result);
> 
> ...and this piece and I think you got it wrong. What you should do is
> just supply a buf with sizeof one element.
> 
> ret = ..., buf, sizeof(buf[0]));
> 
> Otherwise this needs a very good comment explaining what the heck is done here.
> 
> > +       return 0;
> > +}
> > +
> > +static int si7210_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int *val, int *val2, long mask)
> > +{
> > +       struct si7210_data *data = iio_priv(indio_dev);
> > +       long long temp;
> > +       __be16 dspsig;
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               ret = si7210_fetch_measurement(data, chan, &dspsig);
> 
> Oh, but why...
> 
> > +               if (ret < 0)
> 
> ...then the ' < 0' part? What is the positive ret meaning?
> 
> > +                       return ret;
> > +
> > +               *val = dspsig & GENMASK(14, 0);
> > +               return IIO_VAL_INT;
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val = 0;
> > +               if (data->curr_scale == 20)
> > +                       *val2 = 1250;
> > +               else /* data->curr_scale == 200 */
> > +                       *val2 = 12500;
> > +               return IIO_VAL_INT_PLUS_MICRO;
> > +       case IIO_CHAN_INFO_OFFSET:
> > +               *val = -16384;
> > +               return IIO_VAL_INT;
> > +       case IIO_CHAN_INFO_PROCESSED:
> > +               ret = si7210_fetch_measurement(data, chan, &dspsig);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               temp = FIELD_GET(GENMASK(14, 3), dspsig);
> > +               temp = div_s64(-383 * temp * temp, 100) + 160940 * temp - 279800000;
> 
> HECTO/CENTI, but I think in this case it's not needed as it is most
> likely in alignment with the datasheet.
> 
> > +               temp = (1 + (data->temp_gain / 2048)) * temp + (1000000 / 16) * data->temp_offset;
> 
> But here MICRO? MEGA? would make sense to show the scale.
> 
> > +               ret = regulator_get_voltage(data->vdd);
> > +               if (ret < 0)
> > +                       return ret;
> 
> > +               temp -= 222 * div_s64(ret, 1000);
> 
> This is conversion from uV to mV IIUC, so replacing it with MILLI
> would make it harder to understand I suppose.
> 
> > +               *val = div_s64(temp, 1000);
> 
> MILLI?
> 
> > +               return IIO_VAL_INT;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> 
> ...
> 
> > +static int si7210_read_otpreg_val(struct si7210_data *data, unsigned int otpreg, u8 *val)
> > +{
> > +       int ret;
> > +       unsigned int otpdata;
> > +
> > +       ret = regmap_write(data->regmap, SI7210_REG_OTP_ADDR, otpreg);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = regmap_update_bits(data->regmap, SI7210_REG_OTP_CTRL,
> > +                                SI7210_MASK_OTP_READ_EN, SI7210_MASK_OTP_READ_EN);
> > +       if (ret < 0)
> > +               return ret;
> 
> > +       ret = regmap_read(data->regmap, SI7210_REG_OTP_DATA, &otpdata);
> > +       if (ret < 0)
> 
> What are those ' < 0' parts for in many  cases? Does it mean we ignore
> positive output? Why is it so?
> 
The regmap functions return value <=0 so I decided to handle errors
in the 'if (ret < 0)' way.
But in the next version I'll change that to a simpler 'if (ret)'
wherever possible
> > +               return ret;
> > +
> > +       *val = (u8)otpdata;
> 
> Why casting?
> 
> > +       return 0;
> > +}
> 
> ...
> 
> > +       /*
> > +        * According to the datasheet, the primary method to wake up a
> > +        * device is to send an empty write. However this is not feasible
> > +        * using current API so we use the other method i.e. read a single
> 
> the current
> 
> > +        * byte. The device should respond with 0xFF.
> > +        */
> 
> > +
> 
> Unneeded blank line, and TBH, the comment sounds like it should be
> rather for the entire function.
> 
> > +       int ret;
> > +
> > +       ret = i2c_smbus_read_byte(data->client);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (ret != 0xFF)
> > +               return -EIO;
> > +
> > +       return 0;
> 
> Btw, is this the only reason for having the client member in the
> private structure? If so, you can derive it from regmap.
> 
> ...
> 
> > +static int si7210_probe(struct i2c_client *client)
> > +{
> > +       struct si7210_data *data;
> > +       struct iio_dev *indio_dev;
> > +       int ret;
> > +
> > +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       data = iio_priv(indio_dev);
> 
> > +       data->client = client;
> 
> (Almost) useless?
> 
> > +       mutex_init(&data->fetch_lock);
> 
> Why not devm_mutex_init()?
> 
> > +       data->regmap = devm_regmap_init_i2c(client, &si7210_regmap_conf);
> > +       if (IS_ERR(data->regmap))
> > +               return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> > +                                    "failed to register regmap\n");
> > +
> > +       data->vdd = devm_regulator_get(&client->dev, "vdd");
> > +       if (IS_ERR(data->vdd))
> > +               return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
> > +                                    "failed to get VDD regulator\n");
> > +
> > +       ret = regulator_enable(data->vdd);
> > +       if (ret)
> > +               return ret;
> > +
> > +       indio_dev->name = dev_name(&client->dev);
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +       indio_dev->info = &si7210_info;
> > +       indio_dev->channels = si7210_channels;
> > +       indio_dev->num_channels = ARRAY_SIZE(si7210_channels);
> > +
> > +       ret = si7210_device_init(data);
> > +       if (ret)
> > +               return dev_err_probe(&client->dev, ret,
> > +                                    "device initialization failed\n");
> > +
> > +       return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> 
> ...
> 
> > +static struct i2c_driver si7210_driver = {
> > +       .driver = {
> > +               .name = "si7210",
> > +               .of_match_table = si7210_dt_ids,
> > +       },
> > +       .probe = si7210_probe,
> > +       .id_table = si7210_id,
> > +};
> 
> > +
> 
> Wrong place of this blank line...
> 
> > +module_i2c_driver(si7210_driver);
> 
> ...should be here.
> 
> > +MODULE_AUTHOR("Antoni Pokusinski <apokusinski01@gmail.com>");
> > +MODULE_DESCRIPTION("Silicon Labs Si7210 Hall Effect sensor I2C driver");
> > +MODULE_LICENSE("GPL");
> 
> -- 
> With Best Regards,
> Andy Shevchenko


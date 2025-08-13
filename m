Return-Path: <linux-iio+bounces-22680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F25B25028
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E11620607
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9792882BC;
	Wed, 13 Aug 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goKUABHz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA423B610;
	Wed, 13 Aug 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103811; cv=none; b=BBlhtE1aQhVVVtv4ohiNT5T2MRsapGI7yM2IpyXxQ9GcY20WY3GdvjsVI2OitoMoY0hgqF2hd94II+QiCNyLAGUYA1JQoHSlqzEJ170MQaBQrkMz8s45PezrEK1SHMm8lXFn1NEBVOgN8w6cSuBC7FQKD9vosoluNMxz4xaZPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103811; c=relaxed/simple;
	bh=/Cc+aLDuRJGNmCxZZCbsJBPihgq2UiCp8s34/RCVgRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr2wKeddt2O6duZNNPZr4iRv6ZxB7acaAMyA5h6Y8P5bhG0b8+A69Vk0rfqTZVx/oFaXKkVwAsDkITxWdBhE14vJzTAnvAXJCjo9CaBHPBL4g9stPUvrLFlYjLGppkn2aeWNy4YXEwn2vS+9HYvlfedqRBk1VtA3IIftoYDl0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goKUABHz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78fb04cso7668966b.1;
        Wed, 13 Aug 2025 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755103808; x=1755708608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlQnkCb781fqRYsu5x0fOQgcUDMNj97qHPbw4kB1IeI=;
        b=goKUABHzsNFtpRB6Zk/7dysaQP/fRacYEvODgUAwif14/eFbDEvVFgwcFnSxZWpNGY
         rSObjlKwM6q2rOjzqBtp2nEsTzt+gyqF7Lh4/wAZaArJaBSSozRXvRymwxhx7CmrvmXl
         HMgDf7EOsg/n9NZBD1YJ10ktUPrDTO8ht/3Wh8NU4gqc8oWDuiqlACxUpfEmpu4bDqWj
         7v4XEAEa6W5AiR9rGZRoZEE+t0iaf4NG+DOzuNNDuNQGMBLplsSbPKuJ0KKThnXBRSbS
         zDIthHsMy3fDDB2L7/QOGFniFunx3S5iqiGlba9IbTD3Rr8YWzZLk14BvusNxtAL3fIr
         K/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755103808; x=1755708608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlQnkCb781fqRYsu5x0fOQgcUDMNj97qHPbw4kB1IeI=;
        b=RxH6KKDw+6MuwjeF5ICFIrn9AZr9y4S2Y5ZPSIVjkxoQxCU6iBIVd2eVO9ldSguKlH
         6Y9BV+r57E3wFD46GZb8K52wFIwoqmGu+kBFNK1GIQj3BEhq9g2o+Z9IvTDrbhFGVoVs
         b6AchfEhyOR21T1Lb8igOdZERM3bOcRZkdop9BykVRmSrIWato2w+B0OG0i+Xh4lbZuK
         YY7djc5U+FxpJfkmAq6+7CQqyv8vKcwZEcVuWocHEKznsLe4/ogMTeKZhTHcyFDcGrMN
         VGJllpTtvVszgREfq1k3fa/ZzsQnr4F8cAcTSteeJXzFrM1Ko58u5AWCj5dGOJaym+mI
         oFEg==
X-Forwarded-Encrypted: i=1; AJvYcCWKObMzUlWDpaANQiROQaX9ZHetVG8xf/4dpLsSf093O3pbE/VrQkywdJ0CCzkLJgAILUzZrZnxzI3cU6oe@vger.kernel.org, AJvYcCXG8lXfOVCer8P+4wh7TMO4Iped7vBjooD/sZlzYtiWDQMiIp3QeauAooe0q86xit7MEDKp4nFqX7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpuRa9uViNsKhce1a8ZTPezYwmjUZAq4ukgyz2LxBG83AAnZs
	vXo0MiofbpFlH/jpqZPpI/haD8Bfzju+DHfmFYEbNpfgA8/Svbvuo58zwAJxA1fUy8n8teBFXvn
	bmsyXSj5DrrF7s4XxI8gSxLcEXrIbU20=
X-Gm-Gg: ASbGncvpC247Chi8yfzbydpc7ZjKe+alNgu7v2X++9nSddo/BXK2UgzKyK1v/VA6d3j
	uHfL2fX3MLP7m/KG03VZcGknZn9J7cX0mmGdS+GW8SnZ9yxeie14kZr8kY3BMbrygyDsYc+B9Tc
	IEtUVyhDKv+He66t4k975MDKV7Mop11ycsCyizMrJufQec6y/mUo2p5REOZ4zWYjzx5+/pUPbKj
	Ris+VdUz1a9vzUC8kzV
X-Google-Smtp-Source: AGHT+IFReqNDs8btjhDdTwaSEjek6tJU2r7jYQXgyU++kJLwPjhs/4rghJeBb59NUGtD3HdGv5PsQ/zwCAuXZ/yHMVc=
X-Received: by 2002:a17:907:97d2:b0:ae0:d1f3:f7f4 with SMTP id
 a640c23a62f3a-afca4d1a301mr367473466b.13.1755103808402; Wed, 13 Aug 2025
 09:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813151614.12098-1-bcollins@watter.com> <20250813151614.12098-5-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-5-bcollins@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 18:49:30 +0200
X-Gm-Features: Ac12FXxbiCHU96R8TwHdjzCwxZLAxc21yJTQc4tF41DUFrI0yBbyxuVtZeXSQ7Q
Message-ID: <CAHp75Vd=gNzqWLSQcyc3MjHY7TAGizQ5TPS+99UCrnKDgUPTig@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: mcp9600: Add support for dtbinding of thermocouple-type
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:17=E2=80=AFPM Ben Collins <bcollins@watter.com> w=
rote:
>
> Adds dtbinding check for thermocouple-type and sets sensor config

Adds --> Add

Btw, I do not see dtbinding check here. There is some validation code
or so. Please, make sure your commit message is close enough to what's
going on.

> to match. Add iio info attribute to show state as well.

...

> +#define MCP9600_SENSOR_CFG             0x5

0x05

> +#define MCP9600_SENSOR_TYPE_MASK       GENMASK(6, 4)

...

> +/* Map dtbinding enums to mcp9600 sensor type */

I am not sure how this comment is useful, but since it does some
magic, this magic should be explained: why do you need to map these?

> +static const unsigned int mcp9600_type_map[] =3D {
> +       [THERMOCOUPLE_TYPE_K] =3D 0,
> +       [THERMOCOUPLE_TYPE_J] =3D 1,
> +       [THERMOCOUPLE_TYPE_T] =3D 2,
> +       [THERMOCOUPLE_TYPE_N] =3D 3,
> +       [THERMOCOUPLE_TYPE_S] =3D 4,
> +       [THERMOCOUPLE_TYPE_E] =3D 5,
> +       [THERMOCOUPLE_TYPE_B] =3D 6,
> +       [THERMOCOUPLE_TYPE_R] =3D 7,
> +};

Are they not 1:1?

...

> +/* Map mcp9600 sensor type to char */
> +static const int mcp9600_tc_types[] =3D {
> +       'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'

Please, leave the trailing comma, also why is this not indexed as the above=
?

> +};

...

>                         .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | =
        \
> -                                             BIT(IIO_CHAN_INFO_SCALE),  =
      \
> +                                             BIT(IIO_CHAN_INFO_SCALE) | =
      \
> +                                             BIT(IIO_CHAN_INFO_THERMOCOU=
PLE_TYPE), \

Make it only one line +, and *not* remove one / add two.

...

>   static int mcp9600_read_raw(struct iio_dev *indio_dev,

>                 *val =3D 62;
>                 *val2 =3D 500000;
>                 return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +               *val =3D mcp9600_tc_types[data->thermocouple_type];
> +               return IIO_VAL_CHAR;

> +

Stray blank line (I don't see the above is using it) or the above is
wrong and you need one more blank line. Not enough context to me w/o
looking into the driver code.

>         default:
>                 return -EINVAL;
>         }
>  }

...

> +static int mcp9600_config(struct mcp9600_data *data)
> +{
> +       struct i2c_client *client =3D data->client;
> +       int ret, cfg;

Why is cfg signed?

> +       cfg  =3D FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
> +                         mcp9600_type_map[data->thermocouple_type]);
> +
> +       ret =3D i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg=
);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to set sensor configuration=
\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}

...

> +       /* Accept type from dt with default of Type-K. */
> +       data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
> +       ret =3D device_property_read_u32(&client->dev, "thermocouple-type=
",
> +                                      &data->thermocouple_type);
> +       if (data->thermocouple_type >=3D ARRAY_SIZE(mcp9600_type_map))
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Invalid thermocouple-type property =
%d.\n",

Please, make sure that all printf() specifiers are aligned with the
types of the respective parameters.

> +                                    data->thermocouple_type);

--=20
With Best Regards,
Andy Shevchenko


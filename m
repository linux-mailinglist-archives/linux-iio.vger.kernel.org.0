Return-Path: <linux-iio+bounces-17906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D9A84014
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FD91894A54
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122472777FF;
	Thu, 10 Apr 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM4v6RSk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4142777EA;
	Thu, 10 Apr 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279424; cv=none; b=Z4j05GiuyqyZRKRvNhVqQHRg21vGOfQRWO9zdpD1zr55nIbwMStH0ZF26aXFf/OHMlVu6tGJVvAZeV+dEp0Ii40Wd/ZGszeLnQYkxPInnyhFR5n5oGJB0B1Liu6s1cTeI2z/YLXBNkWh8WnPmZgBrg3jsjx3gHd7uRIxex7QBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279424; c=relaxed/simple;
	bh=nEEmOf7KTVXbPwq/q2k8MeCa6UO4SdmGX9WzedV9DQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgbMiv5R9Gex0Zy3c5UHXLmj0VWssgnI+ZbIgGZ2Y+Gew06Rmt6Tdzf07mhnvL48FJ4TmA6nwFixDwlrkdCt1RTrNywqDWwho4jEaJNPreAx3Y8ahLN8Jt9haMJlpzp8nr/SSCIX1YFFZh9vE5XiHJv/NRMBrT/4t5mHD7yUvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM4v6RSk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913958ebf2so505484f8f.3;
        Thu, 10 Apr 2025 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744279421; x=1744884221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=id7a/N0m6tnxDOWGLxHL/MIiS3CvgN+YjlRqlB9AidU=;
        b=nM4v6RSkWGogn/OxEwMPU+2QgJQPvG/C5fZFwiBjdH9b3pljqUzSruE/82hCc4SOx1
         8T+nIRJVilju53VUU0nMpicvvkBOOar5ejtvc+FBjzkH0UU71wXMuaAbxjxfLCIjmJZi
         LvDh1HGBW0KbsrAx5N1YB0FBjn3R97aY2RE4v25871lhQCp7TceJSc1Oh3nbmnFxd22R
         PV09etcqMKz2h3dHo7icfuY7oyHC/pWRzXSvZAuoIoT8WZ6L1d/S3Dti6SbGbKgkGfgT
         SLy7hlDT4epac9gu3lG8VBSRu38A4ZT46kKjZNkglTPRx758MHkKz27vyH5Ri1Csh5Sm
         YqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744279421; x=1744884221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id7a/N0m6tnxDOWGLxHL/MIiS3CvgN+YjlRqlB9AidU=;
        b=nkBbHdaYe9V8JAqqURHM46dRhn9ueO7cpBtJn08bqAYNstx3WT5jjItq1ZCVxV7IwM
         Sub9sgZib0TG4/+BqTp5lFyVYUr5bebpFFoogIsywkOciTErroWbE5iLHGRvTX7bcUrU
         opl/SHd0cs76UA88NGAiVkJdoB4c2yclWhTU5MOPKIXebF6h5U4EnYDBxOmGg7vaa5/s
         8F4+p5RzgQ+BpGvRS43GzSxWFlscWwV7ZhUE4PcyAyfu9TmOWZ+/yiI0s8k9pOSJ70J8
         sZTg8uekjvw/7eOGLhR58DWU1tyvAQtJvM5EzjxL3Q/Cbyjwy4bj21fu6zXAcitM2DR6
         QeEg==
X-Forwarded-Encrypted: i=1; AJvYcCU9P3VkWuChtQqmAZdX+4KwcEyO31qcEg29ElQuTmSgSmGXXj8neDs9ZEYhWiD9BTbLb0uzCjXJIwfJ@vger.kernel.org, AJvYcCWAzTA6K948qLG3BKBMKI6HMFNYeu/aRxQcSOUYUB/WEd1/B7Ji1q37HJ7BJg6x1C9xvxJhf6UsJqCjV5gf@vger.kernel.org, AJvYcCXw8q13ii2a/fkVqRJNKkBEeupFUR9f7ZJjwS1+kohd5wJidO/ZMVJ8wG4VOfiRydKoQNCp73bDRhNl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZWvvpWKGNWHFjXhfEQsiRmN9qOMLxEUPQhfxOjS8+7tXAsKh
	RGoN9M9w12Yj9JaUHNOJEWqHBWJC+VlxvcnCzUDFMalHwzEiMb1K
X-Gm-Gg: ASbGncu0wfOjZHdltVMU9ixFFv2RxJ7FwfLNbFYqVqgC54PvERsqx2dBKM0dpoEogtM
	YQwKT0bmQKtFNlC7nMXLTLk94WneWDykoVs79aPUBxL6zHEnXPvQeP7UhivYokDkkwvTu3gMru7
	uEEPKhATRvHd3vXUyzPtNShqIqZWyQd1pSTJebckA31eR10sVd4YtMvnunauJnRWTEXuHbYokur
	wZFd5PMzqx3s7Ok/yZ29pMzxPJIQDQLoZNdtxd7HPwlElXufuL3BKKmDTixZTLYHwZpYa3GfHL9
	XW4mvU82XjXoN/sOvmVA8/XdbSyZMQROR/bW4rlKZLPUeh10HMpFX/9yE5e6bsty9vE8hsc1t4N
	LnHRFNYUMf+Rv
X-Google-Smtp-Source: AGHT+IFOFvukTCJaHL2La6UQrPu/gNrspAaHMiefSsVAKCALNjEt3kPKRq1WeAlww1TpsCbLavxcGA==
X-Received: by 2002:a5d:59ad:0:b0:39c:13fa:3eb with SMTP id ffacd0b85a97d-39d8f4e43c0mr1684877f8f.39.1744279420930;
        Thu, 10 Apr 2025 03:03:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm4364505f8f.62.2025.04.10.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:03:40 -0700 (PDT)
Message-ID: <8c785dcda6d22a4a50a2d3994248c33fee69031f.camel@gmail.com>
Subject: Re: [PATCH v1 6/7] iio: adc: ad4170: Add support for internal
 temperature sensor
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
Date: Thu, 10 Apr 2025 11:03:41 +0100
In-Reply-To: <33ed56211aed85df1bcb86d5fea83991441dbec0.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	 <33ed56211aed85df1bcb86d5fea83991441dbec0.1744200264.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 09:26 -0300, Marcelo Schmitt wrote:
> The AD4170 has an internal temperature sensor that can be read using the
> ADC. Whenever possible, configure an IIO channel to provide the chip's
> temperature.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

One minor nit... Otherwise looks good:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4170.c | 72 +++++++++++++++++++++++++++++++++++++=
+--
> =C2=A01 file changed, 69 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index b382e7f3dbe0..d204f8ca840f 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -922,6 +922,27 @@ static const struct iio_chan_spec ad4170_channel_tem=
plate
> =3D {
> =C2=A0	},
> =C2=A0};
> =C2=A0
> +static const struct iio_chan_spec ad4170_temp_channel_template =3D {
> +	.type =3D IIO_TEMP,
> +	.indexed =3D 0,
> +	.channel =3D 17,
> +	.channel2 =3D 17,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type =3D {
> +		.sign =3D 's',
> +		.realbits =3D 24,
> +		.storagebits =3D 32,
> +		.shift =3D 8,
> +		.endianness =3D IIO_BE,
> +	},
> +};
> +
> =C2=A0/*
> =C2=A0 * Receives the number of a multiplexed AD4170 input (ain_n), and s=
tores the
> =C2=A0 * voltage (in =C2=B5V) of the specified input into ain_voltage. If=
 the input
> number
> @@ -1209,9 +1230,27 @@ static int ad4170_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		return ret;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> -		*val =3D chan_info->scale_tbl[pga][0];
> -		*val2 =3D chan_info->scale_tbl[pga][1];
> -		return IIO_VAL_INT_PLUS_NANO;
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val =3D chan_info->scale_tbl[pga][0];
> +			*val2 =3D chan_info->scale_tbl[pga][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +
> +		case IIO_TEMP:
> +			/*
> +			 * The scale_tbl converts output codes to mV units so
> +			 * multiply by MILLI to make the factor convert to
> =C2=B5V.
> +			 * Then, apply the temperature sensor change
> sensitivity
> +			 * of 477 =CE=BCV/K. Finally, multiply the result by MILLI
> +			 * again to comply with milli degrees Celsius IIO
> ABI.
> +			 */
> +			*val =3D 0; /* The scale integer part is always 0. */

Hmm this comment does not add much...

> +			*val2 =3D DIV_ROUND_CLOSEST(chan_info-
> >scale_tbl[pga][1] * MILLI,
> +						=C2=A0 477) * MILLI;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> =C2=A0	case IIO_CHAN_INFO_OFFSET:
> =C2=A0		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> =C2=A0		*val =3D chan_info->offset_tbl[pga];
> @@ -1855,12 +1894,39 @@ static int ad4170_parse_channels(struct iio_dev
> *indio_dev)
> =C2=A0	if (num_channels > AD4170_MAX_CHANNELS)
> =C2=A0		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
> =C2=A0
> +	/* Add one for temperature */
> +	num_channels =3D min(num_channels + 1, AD4170_MAX_CHANNELS);
> +
> =C2=A0	device_for_each_child_node_scoped(dev, child) {
> =C2=A0		ret =3D ad4170_parse_channel_node(indio_dev, child,
> chan_num++);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * Add internal temperature sensor channel if the maximum number of
> +	 * channels has not been reached.
> +	 */
> +	if (num_channels < AD4170_MAX_CHANNELS) {
> +		struct ad4170_setup *setup =3D &st->chan_infos[chan_num].setup;
> +
> +		st->chans[chan_num] =3D ad4170_temp_channel_template;
> +		st->chans[chan_num].address =3D chan_num;
> +		st->chans[chan_num].scan_index =3D chan_num;
> +
> +		st->chan_infos[chan_num].setup_num =3D AD4170_INVALID_SETUP;
> +		st->chan_infos[chan_num].initialized =3D true;
> +
> +		setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_SELECT_MSK,
> +					 AD4170_REF_AVDD);
> +
> +		ret =3D ad4170_get_input_range(st, &st->chans[chan_num],
> chan_num,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 AD4170_REF_AVDD);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Invalid input
> config\n");
> +
> +		st->chan_infos[chan_num].input_range_uv =3D ret;
> +	}
> =C2=A0	indio_dev->num_channels =3D num_channels;
> =C2=A0	indio_dev->channels =3D st->chans;
> =C2=A0	return 0;


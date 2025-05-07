Return-Path: <linux-iio+bounces-19224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C0AAD7B4
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C488A7BF9AC
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F821FF37;
	Wed,  7 May 2025 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFmyDLzJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7F21FF20;
	Wed,  7 May 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602075; cv=none; b=tQ3mfKP2KFHgrBQT58Jos9yfsLTn3O/qwl1DAIF1RDqNf3O8BwkzEatr0llRlTncPdKDDcVq6+CIl3KgV2fbnFCZXhiPU18wAL9n9pk7SWmnoMeF9fBFku94rIgJt5M83Binh4K/GEau/rFofQ3z22SvFm/a3iTQ2+4PTErQnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602075; c=relaxed/simple;
	bh=8DZu+CVrNlQyC6E7OM9zW9eqU6hui/E49M6tRuuZs38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pozm0w4/3SHCSIxBb1Sdb2wVlulkr8jk31ufyF+dr4CWelB+vWjJQvO99TGnJ7cOJrdmMjExdZryrzPml9jeDlMF8JTiebAM6xzGuKFK9OCfGt3WH6KPqUN/DrflxaR0ohsqFPsH3XsIohWh7UMrNlqz3rqf+ZGndAgjz/SP1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFmyDLzJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0782d787so41202325e9.0;
        Wed, 07 May 2025 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746602072; x=1747206872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WdzGG901viVjb88sEKqQvjvWyI+7evUPLJXxwNVitw4=;
        b=HFmyDLzJwP4/pYqqltG1mMmFijX4MlZCnOS2OcFru7ustCY7fg2Q0qXgp6sojyE8QN
         LQpRhEXIi9uaUsVRZg7P283/VVzxIIFO0fwsKNp5u6qM3wSm9x/g+XgQ2HSV3uveKH6g
         n96FeGpx/va8DHAMs2fjcqUAIxzkMCx+w2mxyXIarwd2wWZqKHyCGxLJoij0QIxIu4sM
         iqAg+FlS9WNoOFpSTSeCwTC2YWitm5z8OBuuueYW6r6FNlp/UT2CdNrV8/qxOMPmm6Tl
         JmaCRlchC0ysQ8o3iws7P53AdshDOs0vsZ1+v0OIpJE6FLHKo+a0qnVfyDdjQfR6b7Pe
         TIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602072; x=1747206872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdzGG901viVjb88sEKqQvjvWyI+7evUPLJXxwNVitw4=;
        b=XxVbqKED00vjF8KqkFfKBnFeUQJ+oFrsKXv2mL1d47GHmySWVY30NmXAjAe3pE0Jfv
         PSAyC1rmTWkcJUMnXtvLC7ONqyKQso6XgOLTBvFFdeZ5Z/0eupN5AqOujh4ujKNcrqp7
         UjsR68D6bfOTI/8Gay8kQTgab3nHuvJV1qYbQBL3ueQfKVkWQba49hvlNR8idQKEz1FE
         GWapxzuflxsMSR3ZumYKBfXxebOt2UfNQ6jPby5gJnA/oAItEUQ24X+fMYOsbA384hUM
         Bqtb51CtWOQKnL+xTCy0YG5XzQ5yU6JHbbSsT+IIwgDJNrK+l6S6N1xk848F3R0U8jL/
         qf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGV5Lsk0FyWEvd4asMI6gL92WN4Qs4i0wGkPPnsfkFT2VLIxDUzzv2RjLDOS2byK+WmAlW4z+HaKPPWBPd@vger.kernel.org, AJvYcCXqvyTKGeq9wn0hKpnPxytkqQyZie7GdX5EShTa3t2NMraiTTqA+kv2C9jgqq54AmEtdZnoQMiJep+G@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbsGPlDsGQxi6TtSxMofHET+sRZbhaWvcPhCenMsWW0E6HuVk
	WVxgZ/jc9rFygb0ZLha4+XrkQPVJQ0RyEQ7FY2bRyj+5RByIUBSaTAaOdzcvTEk=
X-Gm-Gg: ASbGncvUfKXjUyySS+KVteH7KlB8q/321TYXM7/s/3WLuE23vVpYa+djY1pkLiShqb2
	CHQRcYaBaVoGlutCFNVvcyfusi+Dr1eK1jcQUI3FzjuKsxOuh9B2jIOrNF+5Ns9Rqgg9mlBC/cf
	k8o9TXhaRZ2vuk+UN8NJAPfTH8ldkXpMAGVzRplih8xmDZRvhMLnnce98Sp0gqYUAUqg8WJfTY+
	gIxWL1WHc01j2UffPQFuL11F03bPz3PirzSWaYGmY55iiZ26nKsyCwYdVhblELQR2l+ZgziCuKw
	vJhk2ufjgCf7fmcJeQthuPQkVI/NO1dCDCgK5wz2koUnsyr6uOBuMvNFiir2xX8U9v0LwY/+BpU
	FqV++bs/Uau+pgv4=
X-Google-Smtp-Source: AGHT+IG0f21nMpug0H9uYtk3jXDdCPiWQnEsLWKOgVecub29JtWAFAClqY9cvgAxUgipGNLU0oehqA==
X-Received: by 2002:adf:ce8f:0:b0:3a0:b4ca:474 with SMTP id ffacd0b85a97d-3a0b4ca06a4mr1364319f8f.31.1746602071905;
        Wed, 07 May 2025 00:14:31 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b10083sm16087711f8f.62.2025.05.07.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:14:31 -0700 (PDT)
Message-ID: <c999800bb5f6c1f2687ff9b257079dcf719dd084.camel@gmail.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7606: add gain calibration support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 07 May 2025 07:14:56 +0100
In-Reply-To: <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
References: 
	<20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
	 <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-06 at 23:03 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
>=20
> Usage example in the fdt yaml documentation.
>=20
> Tested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7606.c | 56 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A0drivers/iio/adc/ad7606.h |=C2=A0 4 ++++
> =C2=A02 files changed, 60 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index
> a986eb1284106da4980ac36cb0b5990e4e3bd948..049fd8616769d32778aa238b348b2fb=
82fa83745
> 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -33,6 +33,10 @@
> =C2=A0
> =C2=A0#include "ad7606.h"
> =C2=A0
> +#define AD7606_CALIB_GAIN_MIN	0
> +#define AD7606_CALIB_GAIN_STEP	1024
> +#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
> +
> =C2=A0/*
> =C2=A0 * Scales are computed as 5000/32768 and 10000/32768 respectively,
> =C2=A0 * so that when applied to the raw values they provide mV values.
> @@ -125,6 +129,8 @@ static int ad7609_chan_scale_setup(struct iio_dev *in=
dio_dev,
> =C2=A0				=C2=A0=C2=A0 struct iio_chan_spec *chan);
> =C2=A0static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
> =C2=A0static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> +					struct iio_chan_spec *chan);
> =C2=A0
> =C2=A0const struct ad7606_chip_info ad7605_4_info =3D {
> =C2=A0	.max_samplerate =3D 300 * KILO,
> @@ -180,6 +186,7 @@ const struct ad7606_chip_info ad7606b_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_gain_setup_cb =3D ad7606_chan_calib_gain_setup,
> =C2=A0	.calib_offset_avail =3D ad7606_calib_offset_avail,
> =C2=A0	.calib_phase_avail =3D ad7606b_calib_phase_avail,
> =C2=A0};
> @@ -195,6 +202,7 @@ const struct ad7606_chip_info ad7606c_16_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606c_16bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_gain_setup_cb =3D ad7606_chan_calib_gain_setup,
> =C2=A0	.calib_offset_avail =3D ad7606_calib_offset_avail,
> =C2=A0	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> =C2=A0};
> @@ -246,6 +254,7 @@ const struct ad7606_chip_info ad7606c_18_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606c_18bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_gain_setup_cb =3D ad7606_chan_calib_gain_setup,
> =C2=A0	.calib_offset_avail =3D ad7606c_18bit_calib_offset_avail,
> =C2=A0	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> =C2=A0};
> @@ -357,6 +366,49 @@ static int ad7606_get_chan_config(struct iio_dev *in=
dio_dev,
> int ch,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> +					struct iio_chan_spec *chan)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned int num_channels =3D st->chip_info->num_adc_channels;
> +	struct device *dev =3D st->dev;
> +	int ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 reg, r_gain;
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return ret;
> +
> +		/* channel number (here) is from 1 to num_channels */
> +		if (reg < 1 || reg > num_channels) {
> +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> +			continue;
> +		}
> +

Sorry Angelo, just realized this now. Any reason for not treating the above=
 as a real
invalid argument? It's minor and not a big deal but odd enough...

- Nuno S=C3=A1

> +		ret =3D fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &r_gain);
> +		if (ret =3D=3D -EINVAL)
> +			/* Keep the default register value. */
> +			continue;
> +		if (ret)
> +			return ret;
> +
> +		if (r_gain > AD7606_CALIB_GAIN_MAX)
> +			return dev_err_probe(st->dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "wrong gain calibration value.");
> +
> +		/* Chan reg is 1-based index. */
> +		ret =3D st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev=
,
> =C2=A0					=C2=A0 struct iio_chan_spec *chan)
> =C2=A0{
> @@ -1410,6 +1462,10 @@ static int ad7606_probe_channels(struct iio_dev *i=
ndio_dev)
> =C2=A0				chan->info_mask_separate_available |=3D
> =C2=A0					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> =C2=A0					BIT(IIO_CHAN_INFO_CONVDELAY);
> +				ret =3D st->chip_info->calib_gain_setup_cb(
> +					indio_dev, chan);
> +				if (ret)
> +					return ret;
> =C2=A0			}
> =C2=A0
> =C2=A0			/*
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index
> f613583a7fa4095115b0b28e3f8e51cd32b93524..94165d217b69d54cbce9109b8c0f9dc=
0237cf304
> 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -50,6 +50,8 @@ struct ad7606_state;
> =C2=A0typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan=
);
> =C2=A0typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
> +typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan);
> =C2=A0
> =C2=A0/**
> =C2=A0 * struct ad7606_chip_info - chip specific information
> @@ -66,6 +68,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *ind=
io_dev);
> =C2=A0 * @init_delay_ms:	required delay in milliseconds for initializatio=
n
> =C2=A0 *			after a restart
> =C2=A0 * @offload_storagebits: storage bits used by the offload hw implem=
entation
> + * @calib_gain_setup_cb: callback to setup of gain calibration for each =
channel
> =C2=A0 * @calib_offset_avail: pointer to offset calibration range/limits =
array
> =C2=A0 * @calib_phase_avail:=C2=A0 pointer to phase calibration range/lim=
its array
> =C2=A0 */
> @@ -81,6 +84,7 @@ struct ad7606_chip_info {
> =C2=A0	bool				os_req_reset;
> =C2=A0	unsigned long			init_delay_ms;
> =C2=A0	u8				offload_storagebits;
> +	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
> =C2=A0	const int			*calib_offset_avail;
> =C2=A0	const int			(*calib_phase_avail)[2];
> =C2=A0};
>=20



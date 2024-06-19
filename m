Return-Path: <linux-iio+bounces-6548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2490E2DB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 07:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED574284FF9
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F216F30D;
	Wed, 19 Jun 2024 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMenBJlg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435661FF6;
	Wed, 19 Jun 2024 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776058; cv=none; b=lfZ3iSXpUkdmiZgS2v90utNCUFWMmXRIY+5Hc7iMsK1p8DwzJZXZSiUvQjlO4ghOlfBIuTmMNErBVWt1iucwvhr2ndjpjyoIdm8tInEj00lucwEkTll0+d2zDTRtk+kzGpxsKSZVVTgEF9yT5brCoBxS3V6vVf0bMCKpEA99sR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776058; c=relaxed/simple;
	bh=o8B7zYrVupvFv7U9g54zJDbExop09tf08epvyMrj3Qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIygCfRRkjcng4rwt1oB4/HZ/e1KoYBsDVpE70MBSYc7/Jyvkj/fuVOv6OS7XKli3GRAFRt5j1vRRGNZCO06VeX5Kh+RkEKPw16H7DF38rgmKBkmxYLkOE89ZeM9ZNEepfrGA8ZhAFnbTgt5sE2P7Ws1je+BXolYBviGls3vCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMenBJlg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so69890921fa.3;
        Tue, 18 Jun 2024 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718776054; x=1719380854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+kcrBGBf3/GydIe+LcjfY0IvCfWEER0PGXVlE1muRc=;
        b=iMenBJlgxbBbh50GxwXRWqCpQMhZo2l2Iyy2XqZ/X8O9nhSXhktKEVF5Va2TLC6Esy
         NClTZJwHjA3XUOZxqiuEIz6xtjv+1C/RkTEKY/fjnJR7m7FOWsrED2ZM9XRNJPf0eB1s
         eX94WUrGSGMASLmqYldNI8ux+pTECYtchjQROpUU362TSwjXeaJQPFK7sGyoAlbpxE/1
         ZaA+ZxJ0jPMIMy7hyBCI6pk90oruEYpwrXozAnwi8/vMNmuo/FItX4xffJVpFHFHyHJN
         fdPSy7Qr46gFJ++h2vrCPE4B72Od4LV8jrI+Rof01zptdmpD+D96sp+KTBvLPDh2OlhV
         LHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776054; x=1719380854;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+kcrBGBf3/GydIe+LcjfY0IvCfWEER0PGXVlE1muRc=;
        b=sTxauuyh4lhbtAcdK9XBUfbJUb55lyQi732geaIS5Y8HrupO5Mu/zB4Ze1Fn1Nq+3l
         Do8IkOF4VPNIRxt71bVXA6PECwZBoxKng3xDhk2ID7nti28iZFQrIIsQjo8W//3ARGZd
         20MAGawc9cioL2Qpoy0RXpZ28n5QGTR8AHBToNFmKjSzwOQK53jotMws9eNAZtc0EgXi
         qjgFtUgzhm2+fowx6mBPSh2LEYoM9WcruBvKqOfRea3CEPfv5p1VfXjsAq1lxG3w38ox
         z9HQPjcG2T/OhKa3nCGyL8rO9hmTvCPexQPNztMHOCXnS2AqVbJfGVk3YwkGmcMYCmG0
         OXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVsbDGjJmEHe33pWPaLjPvCD75SSUYd2EqBvkkaWRaEJ1bdW/NGaJVGfnRpVoesVi4c2z7CmCJqXTkMYM7iGzEpB19mr9yTkwxeR7TR
X-Gm-Message-State: AOJu0YyNHmhWVxoSC/dWCRQYiK6jbQ2HwE4EgXukwwGDRA403Fe3ORwY
	ptUWlUz77dIvGOjWDGQrqoI7ZMdCYhhfKL5ZhwYAlO87C7ig1ijr
X-Google-Smtp-Source: AGHT+IFf9QjDMZRxdXpeiL5O2FJdHK57x+se5bfjdMDBd3Pt/O+4ZdRb6IFP3txtqXmhYbvcKBOTpw==
X-Received: by 2002:a2e:2a01:0:b0:2ec:3f6c:ac37 with SMTP id 38308e7fff4ca-2ec3f6cac9cmr3948431fa.48.1718776054200;
        Tue, 18 Jun 2024 22:47:34 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm252656375e9.7.2024.06.18.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:47:33 -0700 (PDT)
Message-ID: <a0bd26a9e159e54f1b6effcdd45756ecfddf973f.camel@gmail.com>
Subject: Re: [PATCH 8/8] iio: adc: stm32-dfsdm: add scaling support to dfsdm
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 19 Jun 2024 07:47:33 +0200
In-Reply-To: <20240618160836.945242-9-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-9-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
> Add scaling support to STM32 DFSDM.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Just some general comments...=20

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/iio/adc/stm32-dfsdm-adc.c | 94 ++++++++++++++++++++++++++++=
++-
> =C2=A02 files changed, 92 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f3dfdaa80678..858ae8161fa4 100644
>=20

...

> @@ -1301,6 +1339,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *ind=
io_dev,
> =C2=A0		ret =3D stm32_dfsdm_single_conv(indio_dev, chan, val);
> =C2=A0		if (adc->hwc)
> =C2=A0			iio_hw_consumer_disable(adc->hwc);
> +		if (adc->backend[idx])
> +			iio_backend_disable(&indio_dev->dev, adc->backend[idx]);
> =C2=A0		if (ret < 0) {
> =C2=A0			dev_err(&indio_dev->dev,
> =C2=A0				"%s: Conversion failed (channel %d)\n",
> @@ -1320,6 +1360,45 @@ static int stm32_dfsdm_read_raw(struct iio_dev *in=
dio_dev,
> =C2=A0		*val =3D adc->sample_freq;
> =C2=A0
> =C2=A0		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale is expressed in mV.
> +		 * When fast mode is disabled, actual resolution may be lower
> +		 * than 2^n, where n=3Drealbits-1.
> +		 * This leads to underestimating input voltage. To
> +		 * compensate this deviation, the voltage reference can be
> +		 * corrected with a factor =3D realbits resolution / actual max
> +		 */
> +		if (adc->backend[idx]) {
> +			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
> +

This is something that I've been thinking about since the beginning of back=
ends
support. Basically having the "catch all" read_raw()/write_raw() or more de=
dicated
interfaces. For example, in your usecase I think it would make more sense t=
o have
dedicated API's like iio_backend_read_scale() and iio_backend_read_offset()=
 as you're
extending that functionality. Calling iio_backend_read_raw() seems a bit we=
ird to me.

OTOH, iio_backend_read_raw() could be useful in cases where frontends call
iio_backend_extend_chan_spec() and may get some functionality they are not =
aware of.
And so, in the default: statement this "catch all" API could be used.

Anyways, this are really minor (likely pedantic) details and you kind of ca=
me first
and made the decision for me. As I don't really have strong feelings about =
it, I'm
fine with it as-is.

> +			*val =3D div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES - 1),
> max);
> +			*val2 =3D chan->scan_type.realbits;
> +			if (chan->differential)
> +				*val *=3D 2;
> +		}
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * DFSDM output data are in the range [-2^n,2^n],
> +		 * with n=3Drealbits-1.
> +		 * - Differential modulator:
> +		 * Offset correspond to SD modulator offset.
> +		 * - Single ended modulator:
> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n, and
> Vref to 2^n.
> +		 * Add 2^n to offset. (i.e. middle of input range)
> +		 * offset =3D offset(sd) * vref / res(sd) * max / vref.
> +		 */
> +		if (adc->backend[idx]) {
> +			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
> +
> +			*val =3D div_u64((u64)max * *val, BIT(*val2 - 1));
> +			if (!chan->differential)
> +				*val +=3D max;
> +		}
> +		return IIO_VAL_INT;
> =C2=A0	}
> =C2=A0
> =C2=A0	return -EINVAL;
> @@ -1449,7 +1528,15 @@ static int stm32_dfsdm_adc_chan_init_one(struct ii=
o_dev
> *indio_dev, struct iio_c
> =C2=A0	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
> =C2=A0	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
> =C2=A0	 */
> -	ch->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
> +	if (child) {
> +		ch->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE) |
> +					BIT(IIO_CHAN_INFO_OFFSET);

Not sure if the above SCALE and OFFSET are solely properties if the backend=
. If so,
you could maybe use iio_backend_extend_chan_spec().

- Nuno S=C3=A1



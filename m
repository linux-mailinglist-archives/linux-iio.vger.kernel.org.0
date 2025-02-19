Return-Path: <linux-iio+bounces-15759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D925DA3BBD3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7CE18985A6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079241C175A;
	Wed, 19 Feb 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSNgwPqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF11AE005
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961918; cv=none; b=JSrC1eI+KnoJ4sitTj6KwsNZEF370uxwm9wyUUNVAgn/f+PPrUfhEdWkoJZS/gyGpVMRrjUSmpYR5SrSiAzWSXYEl+9TaScBHKOKyme+6Bs3kD7RTkCTy/I7RoTAldw7wSZ9juxA1bx0MV/ruGLNgBTthvWNXDFpYQUTJFgFIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961918; c=relaxed/simple;
	bh=+cm6pogby5OG2sXhf4YHUJtYQyVCs2tO4tf6exxhnFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPMLbTXgSPUHPBtqFZdh4loJKVGKrLBfRrU+cN05ONpVj/UfRUkeDP36qafP4lNteyFmaFvPzBYJjyEqbZJmpOWKkPiS057aqIFmLKrzQbBMiCWoGU5hy6XaOeLULPHd/b3gKWo8jVK/QsBn2/ocr/dvkfctzWv+Bft2//Vd8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSNgwPqF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso49303215e9.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739961914; x=1740566714; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1w4EzxIkT0umXNxNRUyrVFxJYvBO41GyYsYKvv2+PJk=;
        b=JSNgwPqFpZ4jb1JvOux7fdT3PNSl6FYmrp6ZhoZQ4/r4biAhG5lFSbgGoT3kyMu7Zk
         TGz5CsVEh/3D3UVUIgTcfUOsPHT0DHyG2TU9z4KAGGY9F4PjsGuN+oIu4WTx9vHx4ajU
         7BEfPt6dU7u7KkbgTsOkX11UH9oGg1eoNadUFh2olBRYbH1qw/8vvwQV/jqvYkBobBnh
         ktk9Y3Ghb9TwaEpTTl2EDXL9RcD/hOjbuty6qp7/4wd095v6GysLD8nJQbms/mdqj3jf
         brr1GGkhIhrcuX47fd+bXgxnGMsfz5oobj5Kda+U4VvcPwSWlff0fGxCYLKHtV0mQmuC
         +ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739961914; x=1740566714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1w4EzxIkT0umXNxNRUyrVFxJYvBO41GyYsYKvv2+PJk=;
        b=Y798ezS2tebX3MUe0g1nd+9jZ/+ygshEKi2nOw8GPi13rfzxo3cRdMrA5w1rSWtuiX
         aqtJx8BcqdULnmwFQTm5iYU9suK1YVLgunGMX7LD9VEnLHS5jXWj6Gh8HjGX9IEzI3bc
         KJC3gHeMGkBuUvNo5Kygenr5bwJi2fcGmlGQBJ0sYnKhjtILG6+Y7tjd+3CNXkZN2Dx4
         s69cJ8jYVWM2OmaBc52dJ4ferNJBDufXYSsrkI0BTZc97T1l0V5jxzWI5Xt6AY72Ooqf
         0MQ4yGty8C4z/GsY8rW92d7cILqN9xExCE2VdLnrBCbmuohKGTHHUBQWcehBXV/d9kSR
         8Kug==
X-Gm-Message-State: AOJu0YwFa4bEc4zbMtAk2ka+DUQ55mhhUuMoooIIY4dPEeRNHJ0PTCuM
	yv3MfN1tjdtumyuPo8YeEUpvvcCuGnhNZhLefALGm0XVtsGnkXgx
X-Gm-Gg: ASbGncuUFM8tmJFLW9pyKjYffzjsjTDmrvjKGNlFzGtSSBu+2wdnnHuM7fHeQ6AnA+9
	Nz8P5oriKzNaLG41w7v49w3sTcusHJzOaeg+9IeRpCfRl12U7rVrtQm5qY6xKtBce2InsV96kgf
	GY/hv3eLyZrIOjXqw2jOSzZsWIq+7Epkns5AX7WDDQbj5rOJ/wC1Y/ysbXvwoM0HL2dg0HzVmVJ
	cmtiu6Pqeo63ge+5mtqnt2QElwQ74DB1uVQP1o65O016WFVwAxsB5pttrWSBbQZun2u4i5AtIGv
	y0Vize+Bj+0bzt+/K0FZeJVfxozhHo6gXIBsKohBbL1NQyIYC9vLdowyyS+4E7k=
X-Google-Smtp-Source: AGHT+IH4kOgEEFjr2OOIsgHUmNUOjI3IPyx8R/1UgpgCxn3Eh6SYunQvaTSoQmSRqTf6zpSurGhLNw==
X-Received: by 2002:a05:600c:4f48:b0:439:8bb1:14b1 with SMTP id 5b1f17b1804b1-43999d91255mr36153995e9.11.1739961914059;
        Wed, 19 Feb 2025 02:45:14 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm54641745e9.39.2025.02.19.02.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:45:13 -0800 (PST)
Message-ID: <dcf3c98a415743b0078dfb3de8acebcdc8b2b006.camel@gmail.com>
Subject: Re: [PATCH v2 6/6] iio: adc: ad7124: Implement system calibration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Wed, 19 Feb 2025 10:45:17 +0000
In-Reply-To: <5ee955a72e6f5226233053a883e8897ae325b568.1739902968.git.u.kleine-koenig@baylibre.com>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
	 <5ee955a72e6f5226233053a883e8897ae325b568.1739902968.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 19:31 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Allow triggering both zero-scale and full-scale calibration via sysfs in
> the same way as it's done for ad7173.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7124.c | 141 ++++++++++++++++++++++++++++++++++--=
---
> =C2=A01 file changed, 124 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 5c2e5a518af3..ad14503e9797 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -4,6 +4,9 @@
> =C2=A0 *
> =C2=A0 * Copyright 2018 Analog Devices Inc.
> =C2=A0 */
> +
> +#define DEBUG

Leftover :)

- Nuno S=C3=A1

> +
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/clk.h>
> @@ -181,6 +184,7 @@ struct ad7124_channel {
> =C2=A0	struct ad7124_channel_config cfg;
> =C2=A0	unsigned int ain;
> =C2=A0	unsigned int slot;
> +	u8 syscalib_mode;
> =C2=A0};
> =C2=A0
> =C2=A0struct ad7124_state {
> @@ -202,23 +206,6 @@ struct ad7124_state {
> =C2=A0	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *,
> AD7124_MAX_CONFIGS);
> =C2=A0};
> =C2=A0
> -static const struct iio_chan_spec ad7124_channel_template =3D {
> -	.type =3D IIO_VOLTAGE,
> -	.indexed =3D 1,
> -	.differential =3D 1,
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> -	.scan_type =3D {
> -		.sign =3D 'u',
> -		.realbits =3D 24,
> -		.storagebits =3D 32,
> -		.endianness =3D IIO_BE,
> -	},
> -};
> -
> =C2=A0static struct ad7124_chip_info ad7124_chip_info_tbl[] =3D {
> =C2=A0	[ID_AD7124_4] =3D {
> =C2=A0		.name =3D "ad7124-4",
> @@ -903,6 +890,126 @@ static int ad7124_check_chip_id(struct ad7124_state=
 *st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +enum {
> +	AD7124_SYSCALIB_ZERO_SCALE,
> +	AD7124_SYSCALIB_FULL_SCALE,
> +};
> +
> +static ssize_t ad7124_write_syscalib(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> +{
> +	struct ad7124_state *st =3D iio_priv(indio_dev);
> +	struct ad7124_channel *ch =3D &st->channels[chan->channel];
> +	struct device *dev =3D &st->sd.spi->dev;
> +	bool sys_calib;
> +	int ret, mode;
> +
> +	ret =3D kstrtobool(buf, &sys_calib);
> +	if (ret)
> +		return ret;
> +
> +	mode =3D ch->syscalib_mode;
> +	if (sys_calib) {

FWIW, I agree with both David's comments. Moreover, if we do not claim the =
IIO
lock in other drivers/devices during calibration I think we should be doing
that.=20


- Nuno S=C3=A1


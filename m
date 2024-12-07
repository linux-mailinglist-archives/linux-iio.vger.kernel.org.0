Return-Path: <linux-iio+bounces-13195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D89E806D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D2018842C8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320791465AE;
	Sat,  7 Dec 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iQbGnn/x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8322745C
	for <linux-iio@vger.kernel.org>; Sat,  7 Dec 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585399; cv=none; b=pH7tkiFDYcNgLTEw3bvNf6OqVZILMA3W+TIcqycPAtJV6YA6waKdyqvm/X+ANk+f9aN9CC7lteuZf7ZXopHNnPLjov8wZORJyr6G/vQGzHa2lyoWvaisbPwuKmX+D6+p57hhFhrvtwQEIWA8vDwk4HVN8zRpnSahSAo03G3q88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585399; c=relaxed/simple;
	bh=++qwKaLQJK0eYuZPezy9s9pCAqz4NQG7EHyBEh/bhPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1z9VpbF+eNApwWZA3GDllaML3wQ/h2lvVeRWZNg2zo2NPhE7a8xql3KoFgcXS5JdRqA6SafIotYqjcS/2IDd6PQ1hLiO5DUpYmMbw2QkW79EJABst4tpZkTiEa/VFSgoaIA1KZ/0JFttd85pEQw+D1+7rnz91Qfqctt2OcbA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iQbGnn/x; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa636f6f0efso284462966b.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Dec 2024 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733585394; x=1734190194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N94u8ceJE9IihGissqr+ltow5uqSpjZz+SPLJ2SzdDc=;
        b=iQbGnn/xXpVDe2T9BJg0wVaFJ3xBRuKIfmhVzO8CvuAbIXO2rROhTWuraBGu1fB1Vc
         v4C0RAKOCMcTN7/p0Sj2ch7t/+4bjDSc2Q9udO5oHO+M5/yy/j5J1i1xJXSdlP/CZ0UW
         xnW8+p0R1eW6mHnWmmcb4+9eh5xmkF5lICDcsrcamwmyxRkFUqJPfJAw7zHR+nYHhFLb
         8C1IRY2TDqcHl6GhWUTgaIYqqFe+2Fv4FldanBcQermjFVQRGtny6gQvitIaCUsggt7O
         jCLkp2gDzLt4tJTVmoxn5GcpWiAvlGPFudjsi7edtmDB81sK9faegoXhWrmLPzKFus60
         MjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733585394; x=1734190194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N94u8ceJE9IihGissqr+ltow5uqSpjZz+SPLJ2SzdDc=;
        b=Gj15kmqzYc4uoe0CHsB/imkzM29TDaoqka6mX2vXcQYzW+LEarGGeibL4O5hEz8s5w
         wNenMV6wcOVFebdE80dnlEpBc3UyyoNeXfY8BhPc3H7mOg39os9VKD1GMXieqswnkh5s
         4G4UMX20P0SriUVoO8FMV4BK3tqtGmUG4tL8x3dbvGWruKTcFWHdE7siyKsraQD3mH+M
         ZXu7CBKQDa76KGVv0SGU54JaGU78ewAvMT3jihsH//Jm2hxASK1md9/lmxtn56+3Nois
         OLypsRaLit277x6MMavN9/UdOth6w1IT4xffNfOI3c4EaA1HkkLrmdLZ+qt9DFGW0BMP
         XNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLbRpm0LcUeTIBTzjo1TRsBpvn35afohDb62bL5+it26muLzlDftBavhfyj3lcgDBmL469SAuRXIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZlxzLU9jjJFEANylcVfegWhn86KeKupkEc6Xy171IAy2vpE6
	1Q/mrF6B4tDGjKJvwpEwDJHl+cT0dZVrRDke9V8J/b32yOEYyLzVIJcls2kIm+U=
X-Gm-Gg: ASbGnctFnpV8mLMH6ylcZy7g8CGIPlJKLShDJ37ElFjdmWxkrfhiTr2pIiuqbBxbI63
	qqFGN2C855ucbaIBF3v2NXBl3G4ISa/4vvaG+0Mf4Ah/llds3QhjL9GwFhiTqP9hLiaaPGnL2EA
	2CKsT54cVnJNKK66ta9tuL/cnA6YzP/5Lr0RpI4vRdPOlIlPOJ5T7bVB5X+W03dNvCTAaVx3waw
	ttSfy1zM4uXZ48FoP7V/GKZ5re1Wc5Mri+SqqTS572h2UJiKEev1Q==
X-Google-Smtp-Source: AGHT+IF4LY5WB0e2F6DNpEuhnVjdXbVwXG9srfjzrNNUuYa2L9aD5xp0wQlYa8StPx5b3r+PKQuxAA==
X-Received: by 2002:a17:906:2189:b0:a9a:1f8:6c9b with SMTP id a640c23a62f3a-aa63a33c764mr406864066b.37.1733585394222;
        Sat, 07 Dec 2024 07:29:54 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:a8d:e1d8:6f77:cd7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e5c660sm399012466b.19.2024.12.07.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 07:29:53 -0800 (PST)
Date: Sat, 7 Dec 2024 16:29:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <cpfpysi6zcr7n6qy642dmhsi2a4hom2p7l4rboj4jgakuzpa5p@5xaqd3oxxlrs>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-9-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ssuityvtqapol74n"
Content-Disposition: inline
In-Reply-To: <20241129153546.63584-9-antoniu.miclaus@analog.com>


--ssuityvtqapol74n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
MIME-Version: 1.0

Hello Antoniu,

On Fri, Nov 29, 2024 at 05:35:46PM +0200, Antoniu Miclaus wrote:
> +static int ad4851_set_sampling_freq(struct ad4851_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD4851_T_CNVH_NS,
> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 1, st->info->max_sample_rate_hz);
> +
> +	cnv_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +
> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;

If you want to be sure that pwm_apply_might_sleep() doesn't round down
.period (and .duty_cycle?) too much, you might consider using
pwm_round_waveform_might_sleep(). But note that this function only works
for two hwpwm drivers currently.

> +
> +	st->sampling_freq = freq;
> +
> +	return 0;
> +}
> +
> +static const int ad4851_oversampling_ratios[] = {
> +	1, 2, 4, 8, 16,	32, 64, 128,
> +	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> +	65536,
> +};
> +
> +static int ad4851_osr_to_regval(int ratio)

This function is called with an unsigned parameter only.

> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> +		if (ratio == ad4851_oversampling_ratios[i])
> +			return i - 1;

Given that ad4851_oversampling_ratios[i] == 1 << i you could simplify
that. Something like:

	if (is_power_of_2(ratio) && ratio <= 65536 && ratio > 0)
		return ilog2(ratio);

> +
> +	return -EINVAL;
> +}
> +
> +static int ad4851_set_oversampling_ratio(struct ad4851_state *st,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (osr == 1) {
> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = iio_backend_oversampling_disable(st->back);
> +		if (ret)
> +			return ret;
> +	} else {
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +				      AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_RATIO_MSK, val);

You set this register twice in a row. Can this be done in a single
register access?

> +		if (ret)
> +			return ret;

Best regards
Uwe

--ssuityvtqapol74n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdUaewACgkQj4D7WH0S
/k55Vwf/dcyzLERHADJy0eA4I3kK1jSCddOaUpX9iL4wUcXFMi2IGBfN/aJ6hVJW
RahHHZ0hx4S6Y+RMdyIb40mDgDxEOIzxihi7D+5KI6CV3cDd4oZkUkQ3rNFXQ3Gk
hOuaDEasQKueh0lbjTT5eQ4t1xzfSlNjpTrbR3t+PRtXRF1Wgkg2E+IorJ8q7duR
+tsndFiWef/2ycvM/e/RZefB9kCX+3IEiaZIzgiXIbqtZp5hcN3WQJ9iJY95s0Gq
BN7yTVmNrknMfJopgF3JhHuwtCoEfLqS6ehITy3bd1SKWL00sg2Nvnh7IBKc/04d
9M+ZIy+6be+xTyAXZi0ESyB20GywDg==
=W1c1
-----END PGP SIGNATURE-----

--ssuityvtqapol74n--


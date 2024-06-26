Return-Path: <linux-iio+bounces-6941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A904917B74
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06A3B20EF7
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73F16848F;
	Wed, 26 Jun 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPhyzL18"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02012160796;
	Wed, 26 Jun 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392117; cv=none; b=V7jUaJiIV4FMFXaBS6bD9+NtJf+7ejKItRyurFwTNWHgqC7CGSfRX7zfMglkaIBTip2HVdLfHMmWtFpTvm6DbSSAuX/gabYfBk2vCfuX9KbwFlAUEQwztn976G6vSfrnKJGVAamQ2Du3ezIK+DHKb46khqrtf1hmKbQeA02FRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392117; c=relaxed/simple;
	bh=jIFzSiVAUoXi/TMYX37soPn2mdyqaNsD1HUMPCO2mIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJJ90XSYuTqGCznzLEI+ZwcALqwrazuoopaYXiSa1yKjMfPajukZ6j2pdouO79zMJmu5jZLDCg2KTsn4fib2bs3It6kQ5HhCQlJB7eXiwJTrM+IG4wKzCaoWRP9Gk7aKgn30LUnwt84fAnKHvwfhtlPsO9pBc3TL5ptRzrGVwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPhyzL18; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso4858974e87.3;
        Wed, 26 Jun 2024 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719392114; x=1719996914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UuJKZ5dvfnd3VwIG1aD3aPBKZXM0rYW+LOmM/rqRb7g=;
        b=RPhyzL18iFaum8xnyRjflns6qAVyf55uPdOYxgTvI0pR6JGfgFlnUX6RGiImQjjftV
         E1qcFyPRufQQeCTz8usS1u1VkZ+vBne77KBPaOT9Ns45gFa7zQuMH7fAe0Th073wb0vv
         PLmm2VLdTd/RPaLJGDM8rILLmqupkcoUJt+aMuE2XrfDDXydDntYo0VLm74kBnrnxaG8
         Aw6NU/TC1erM2CcCix7jgKPW6vK5pZ/pNZ8o8jGp0XqZp31YgW5v9FR3XryFiS188CCC
         R25pe1gWwGGE7kFEhCbEynCOruznwFJ1NmkQ5LnkWg1SqwKOFk7LgH6oOkJHU2m3Uh9L
         Txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392114; x=1719996914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuJKZ5dvfnd3VwIG1aD3aPBKZXM0rYW+LOmM/rqRb7g=;
        b=aIHrrTiCH7n7+/hkXGvuVRLGzsqVX5jzLQ+/AQq80CS9lVu+9kUoU6pAyEcx4qPuHi
         TV9dTUd/7AwEsXmbbwxI5IDOJ0RYTKGYo1dr6B62Ct3YN4wM7zopM68GOwaOF2kdDOnn
         HncByHvGj4SOspwgJceKcxkK5AcuQI4KfafUYLPlmFUBrBxDnjOgIE6isE2C3ajmWkhA
         tpM0W2KCP6Gz2vSKfGXpZl2RfrPNtx8e+e05zcnfg7YzXiC6O1XpXsW8iw9reJm/EsQX
         4syJfwcQN8um/PZNY20TpnGuy3bddxWTMQGjO3/LqJCP6bqygciopyQz2QvxGNQGE4lf
         R9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW49NeBv6rNcaemteKbEM22bFLY7zkYZYBrxuGDeQRWwoVweu5arvsS5w9I1BjjtEY9Eb1jFBhq+46ep4eZ9/Z1tToaMxpkXr3wFLVWTVd7XHHX3GXXf9arWWdomRGsqP9SkSG6jWGt
X-Gm-Message-State: AOJu0Yy/uRUpZgyBEpsAkbtJBzNe0gvzz3XQA83yP0djLFcK2cT7YA+w
	KF8oW5ElCW/lsgxXq7sAOktcKX8eBeK/4jByTtgLhRq+zrOuqkWQ
X-Google-Smtp-Source: AGHT+IFuNqURBw9MrG0Gl9cJcVUawr+D9J6cKvNgIaK256nGX0K2iZmbGttOuH5LhAzrPbtCRpZWxA==
X-Received: by 2002:a05:6512:138e:b0:52c:e08c:a0dc with SMTP id 2adb3069b0e04-52ce185f753mr7582925e87.51.1719392113740;
        Wed, 26 Jun 2024 01:55:13 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8468613sm17302035e9.39.2024.06.26.01.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:55:13 -0700 (PDT)
Message-ID: <c2d746c73f7450dd10c0a0b229b3672e44fe583a.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] iio: adc: stm32-dfsdm: add scaling support to
 dfsdm
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 fabrice.gasnier@foss.st.com,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Date: Wed, 26 Jun 2024 10:59:05 +0200
In-Reply-To: <20240625150717.1038212-9-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
	 <20240625150717.1038212-9-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Olivier,

One thing that I just noticed...

On Tue, 2024-06-25 at 17:07 +0200, Olivier Moysan wrote:
> Add scaling support to STM32 DFSDM.
>=20
> When used in an analog context, a DFSDM filter typically converts the dat=
a
> from a sigma delta modulator. The IIO device associated to the DFSDM
> filter provides these data as raw data.
> The IIO device can provide scaling information (voltage and offset) to
> allow conversion of raw data into physical values.
>=20
> With the new binding based on IIO backend framework, the sigma delta
> modulators are defined as backends providing scaling information.
>=20
> The scaling is not supported with legacy binding.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> ---
>=20

...

> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale is expressed in mV.
> +		 * When fast mode is disabled, actual resolution may be lower
> +		 * than 2^n, where n =3D realbits - 1.
> +		 * This leads to underestimating the input voltage.
> +		 * To compensate this deviation, the voltage reference can be
> +		 * corrected with a factor =3D realbits resolution / actual max
> +		 */
> +		if (adc->backend[idx]) {
> +			iio_backend_read_raw(adc->backend[idx], chan, val,
> val2, mask);

Eve if it does not matter for your usecase, you should still do error handl=
ing
as iio_backend_read_raw() can return an error.

> +			*val =3D div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES -
> 1), max);
> +			*val2 =3D chan->scan_type.realbits;
> +			if (chan->differential)
> +				*val *=3D 2;
> +		}
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * DFSDM output data are in the range [-2^n, 2^n],
> +		 * with n =3D realbits - 1.
> +		 * - Differential modulator:
> +		 * Offset correspond to SD modulator offset.
> +		 * - Single ended modulator:
> +		 * Input is in [0V, Vref] range,
> +		 * where 0V corresponds to -2^n, and Vref to 2^n.
> +		 * Add 2^n to offset. (i.e. middle of input range)
> +		 * offset =3D offset(sd) * vref / res(sd) * max / vref.
> +		 */
> +		if (adc->backend[idx]) {
> +			iio_backend_read_raw(adc->backend[idx], chan, val,
> val2, mask);

Same...

- Nuno S=C3=A1


Return-Path: <linux-iio+bounces-24609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A286BAF5F9
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 09:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6B91920CEF
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E531EF36E;
	Wed,  1 Oct 2025 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sFJLSkGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DA3770B;
	Wed,  1 Oct 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303187; cv=none; b=K2FqvytSUscsJPZHVfjTnKnI3lkfR5IxgUnnshHEqlAiCvs3nFzGTcLMNbanWer8RCqBK+VWRuEeo9b3jLc7I5skfciBR/3YCgzV6BAbSO2QN5AcdmavqJ3Wyccvkeqv1odfveUiScBw563p8iYB3wRtqEBSxvcUTWiwVnYD5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303187; c=relaxed/simple;
	bh=m3GyrvFZTp0xnocM0iyhLUYbvWE/o5O0Ruc2sJ8qxg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2eoD+NVpKQ7Aq0DjPLo2eCDiJ5mLQrxM0T8M3NyElm2kIy+kBrgxPrP9g5O58nLRPdr0+SayVDWx55LKxg3sut6AagCSwZ3UNGvvt16qtp2FjlU9ySkskbw7eWZphCWL1xOL1GEKBvI+BIP6STFMjskx6u7jAXDegfvRjzmago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sFJLSkGI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 376754E40DF5;
	Wed,  1 Oct 2025 07:19:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B36E606BF;
	Wed,  1 Oct 2025 07:19:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24145102F1854;
	Wed,  1 Oct 2025 09:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759303182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bLWzwrSTti2UytVkyEvnDMwkovA44fR84c3zWkiEaN0=;
	b=sFJLSkGIuA4ckN4RYae9fVmbOjBs2QufWjdQyYpi74aKyuS2zbNoWPiXuD8E95nzBqdPFe
	UNiykmAd93lF1yoY7hBbgNootC+5RintzuENkY5Z1Lt7mlKd+qkOFsKGzqPX5TXd1foG+O
	D2y5hf4eF5uP0a4FlfVKOk5WJkDiZPo3wGda7yHocb6qmpNp1Id8yP13DQQd7sXeaIvsS3
	TumYgVYpgFLwkm3IHnuT4mTaNX1UxySY2gflLJymE0a5aKUW/AQ2M1lHreM3jnD/X6wa+Z
	X0YNNpYRU1Ag7E9Gs0gDixKzL13LhzAh55ZRTWVKsCGK/x6zHdx0DLZjLz3BOQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: add processed write API
Date: Wed, 01 Oct 2025 09:19:37 +0200
Message-ID: <5015441.GXAFRqVoOG@fw-rgant>
In-Reply-To: <2a503edb-fe9f-4d61-92c0-c1083a028e19@baylibre.com>
References:
 <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-2-bb61a401a0dc@bootlin.com>
 <2a503edb-fe9f-4d61-92c0-c1083a028e19@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1934360.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart1934360.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH v2 2/5] iio: add processed write API
Date: Wed, 01 Oct 2025 09:19:37 +0200
Message-ID: <5015441.GXAFRqVoOG@fw-rgant>
In-Reply-To: <2a503edb-fe9f-4d61-92c0-c1083a028e19@baylibre.com>
MIME-Version: 1.0

Hello David,

On Thursday, 25 September 2025 23:10:14 CEST David Lechner wrote:
> On 9/25/25 7:37 AM, Romain Gantois wrote:
> > Add a function to allow IIO consumers to write a processed value to a
...
> > +static int iio_convert_processed_to_raw_unlocked(struct iio_channel
> > *chan,
> > +						 int processed, int *raw,
> > +						 unsigned int scale)
> > +{
> > +	int scale_type, scale_val, scale_val2;
> > +	int offset_type, offset_val, offset_val2;
> > +	int ret;
> > +
> > +	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
> > +				      IIO_CHAN_INFO_SCALE);
> > +	if (scale_type >= 0) {
> > +		ret = iio_divide_by_value(raw, processed, scale_type, 
scale_val,
> > scale_val2); +		if (ret < 0)
> > +			return ret;
> > +	} else {
> > +		*raw = processed;
> > +	}
> > +
> > +	if (!scale)
> > +		return -ERANGE;
> > +
> > +	*raw = div_s64(*raw, scale);
> > +
> > +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
> > +				       IIO_CHAN_INFO_OFFSET);
> > +	if (offset_type >= 0) {
> > +		switch (offset_type) {
> > +		case IIO_VAL_INT:
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +		case IIO_VAL_INT_PLUS_NANO:
> > +			break;
> > +		case IIO_VAL_FRACTIONAL:
> > +			offset_val /= offset_val2;
> > +			break;
> > +		case IIO_VAL_FRACTIONAL_LOG2:
> > +			offset_val >>= offset_val2;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		*raw -= offset_val;
> > +	}
> 
> There are some rounding biases in this function, but I'm not sure if
> it is worth trying to make a perfectly fair function.

I'm unfamiliar with the notion of rounding bias, does it mean that nested 
calls of this function would tend to amplify rounding errors? In this case, 
would rounding to the nearest integer instead of whatever is being done by the 
integer division here be a good solution?

Maybe I'm misunderstanding what you mean, in that case please let me know.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart1934360.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjc1gkACgkQKCYAIARz
eA6MYg//Viifao41HU18GYkLlUZn/8j/K0FDeJHL+7QGILawnj1ZTgtN37o6sZIy
cKL3SHGYGaNwGuuSrP8Phl+f0d5TylhtlKk5lABeUu1pVJtQl2xVAo0NhnPmXt34
gT2r+Dx+3CCYytsF2/LlWQJZXawlgRWfXyu1RI4GZ2THCks3VZXhg14WvLVJTN97
ovCQFEgQ6DIcz9kkZvtzPtB521NZvYAeMYxgfVIFAcBcmZOX0ZLGk5JKTMpCcgwX
29ujH5CWeAlB0ivBUcBxQXk/wIjcmQwmIow9buazeKqWt0Dg4//RnMQzcXMv9mWa
H+ADj/V6mxi5jjZsMihOyeHUqqJCsMMbwpObEizOdot7eVbW/LZsa8PTJ/gcF71T
YFXmGW6/sF4eRSc6bmjLnTIfaN0h7ABZ5RrI7znAgG9oz93xy9D39nHjMgpA09p5
9dIBwMPaMngCP90VojFMeU3krzCp/1Hk82KdpvJ6gqn3Ob/47QBsDYmIjUQ6V6Sl
7grx9/zVV2uZ6lHmrNIvFRt10o90ogJ6z4FBMjz8eWMkUKNdYtxUFbTEpCcbIOhs
3nvvYBAKCF/UfRinVRs8ytHUGuk1r6pZfQ7Bd6Qtg3nBK7QA2gBKRst43ce7EiRU
rG8JRM107pBXniYRUaewQ6JW3GZfuchBmRHfC3P7r79ndCM2Lk4=
=tqTu
-----END PGP SIGNATURE-----

--nextPart1934360.tdWV9SEqCh--





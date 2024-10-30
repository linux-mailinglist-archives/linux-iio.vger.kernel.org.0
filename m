Return-Path: <linux-iio+bounces-11592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52959B5CB5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 08:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191FC1C2123B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60591D86E8;
	Wed, 30 Oct 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0NLnB58"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739D85931;
	Wed, 30 Oct 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272676; cv=none; b=WgcDcv88Ufg1uXV7CRIzxBd7BJPMTLxP6SuXiQo7exusxnkNGTp2cL5jjKbhnCKRnRi46BzmR9nNDkNJo4UQ8yZND3JLg97lFts+JOtGDR1Gu+PmUKyEcHT/yTvVF5zcUBOnwktDlogc3Ym2P8em7eHxzfdUp69Wv1hw+OfXJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272676; c=relaxed/simple;
	bh=xchgcCKaDBjNRixjrCuoZojBEBSE6n/7Fu+a2lSKmcI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTiprC4a68X7yztc/A2362dEbG1G8LHNPXbVvbTRFf9VVgiJMqkGykJ8oa/YPctwcjWEVa5AZ5RA37CO2dXrC2yY8bKL6+cj3AVEe7Ccn/wkZ8peLQ12TDFkjWUIFmm8+/coBPs3Fl3Yu/p8e+G0tQLqNwIOTJPXDPDJARugj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0NLnB58; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so63243195e9.3;
        Wed, 30 Oct 2024 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730272673; x=1730877473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1pSJnGtha0y0mr0d4hi2pIHYbxOcwXoMlSkBicYORIk=;
        b=Z0NLnB58ihhrZczSKlE2WtWvzwd8KtgUMmlKQxpfAdNiL3xrp1T7uYpMhFUok+RZtr
         pPiQScae23JTsFVVXVSer2Zy9tmsdvFY9GnkvdJmR0HUDy9JvWbtA0O2Q+bJnopgIbNt
         J25DRU+ExY7xo5fvqW55g0BZn+tCAvdoBHrwMvKoyBvkYJwDuWpScMv3WMbVrE+sdeKe
         hvcLbLZMf+prW3KEZ1yaEiy0ZWuF6z/NzR8Gb3t+1spfkSAC3W82PYfWQEwBan02BOEB
         UnhilONwl7G7LAauZ8ehO7ok3gAwqlUguM50I5PnJhX0oJrZl7vGUfzvBO4kwsKEVk9L
         DZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730272673; x=1730877473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1pSJnGtha0y0mr0d4hi2pIHYbxOcwXoMlSkBicYORIk=;
        b=ESfcf58wGBjvThBirScUlNNAzRF8vCTjadA/E1aRsebbswHw8EEMp1WakXoDSXwzrr
         iauy7pGD9+O08RADM02vm28z9PWKxNslgM5boSiq1gAbJmWvfbipXs7ZQzF8ZOYSIvTZ
         jfirqNUJFeUtOg2rKBLUvuD84nMhunwuyUzK/dorV5E6mXGqrzJdu9R4jiSw6Mn++onk
         QyfogYhXi+KPsK0nOoyE/RjzrxFA/9ig5td7CBlwWvp5rA4zV65smA1VHI1fUPIk6LBv
         mEySWnpbtgPACIq0gdxs6ab6Q90CpK6XRTi8/zqo7FxzYLOfgmSELkEES9o2IyHRc4P9
         H7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUraOO1xK/iWY7U2Ys+ml2eqA3tCmwW2K9zcVY3UI8s14ow9Pz2wU67z46yQIeIZ0XW4k5KOASg/jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAlWcUptiGi31LwNGALKgkd65Maz3c+tx1Pkxt0eHkhE9xDRw
	JARW4askvLFSTfbRmm5VfMVl4F8zgTBzuGu8bX71tw6nLqjUQsRo3gg2NnauQ9enrgwD
X-Google-Smtp-Source: AGHT+IEw/aFyjijGptjnXKmVD9U1ZnhSMgmlBWE62Z96riULqtWFkBfEqgodMeyjWnyYBqNkcw9g1Q==
X-Received: by 2002:adf:fb85:0:b0:37d:5047:76d8 with SMTP id ffacd0b85a97d-38061205e66mr9930675f8f.59.1730272672485;
        Wed, 30 Oct 2024 00:17:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bde6sm14565848f8f.40.2024.10.30.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:17:52 -0700 (PDT)
Message-ID: <95f7b9284e6d97fb991f93798758d5b5582fe0d6.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: Disable all channels at probe
 time
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Date: Wed, 30 Oct 2024 08:17:51 +0100
In-Reply-To: <20241028160748.489596-10-u.kleine-koenig@baylibre.com>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	 <20241028160748.489596-10-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-28 at 17:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> When during a measurement two channels are enabled, two measurements are
> done that are reported sequencially in the DATA register. As the code
> triggered by reading one of the sysfs properties expects that only one
> channel is enabled it only reads the first data set which might or might
> not belong to the intended channel.
>=20
> To prevent this situation disable all channels during probe. This fixes
> a problem in practise because the reset default for channel 0 is
> enabled. So all measurements before the first measurement on channel 0
> (which disables channel 0 at the end) might report wrong values.
>=20
> Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index a5d91933f505..749304d38415 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -917,6 +917,9 @@ static int ad7124_setup(struct ad7124_state *st)
> =C2=A0		 * set all channels to this default value.
> =C2=A0		 */
> =C2=A0		ad7124_set_channel_odr(st, i, 10);
> +
> +		/* Disable all channels to prevent unintended conversions. */
> +		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_co=
ntrol);



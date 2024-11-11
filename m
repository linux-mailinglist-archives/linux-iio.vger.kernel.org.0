Return-Path: <linux-iio+bounces-12116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073999C3C07
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 11:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE68E1F221FB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB32158D8B;
	Mon, 11 Nov 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAxOgm6I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16C14600D;
	Mon, 11 Nov 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321209; cv=none; b=E8ITrSIce2FKsOVQvsnsMgzLt0yZI+krDiLXS+Bn4uybYtdP0ZqUWGA2OP6WBg2zUJD/1nxR40VQ/Qqp3zTmRfUZ0fOxQCX5TLXsDtd8/NFqnrYOgKSMezFLnz1+V6UgHE9Q+aKydhvK/PUHHcwC+Fh7EonOrR6Zn5xrJvlXH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321209; c=relaxed/simple;
	bh=K32Aa/FCygnL5TajBnwQRhBUUmy/Rq9LwOa70qZz4R8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jqzDB6r6FiEg25fueV6Sw/vHk4c0FfpvHBqHy8/yzFTwkU9VoyZ50G+xBMwkqNKX5ymmUotBpJhKWJDcPalsfF99U1WzU0ldX+U/CW8o6P0TkPgCyKvnRAjw6n0aP8j/D4Q2cbtZdSl36dmfhUrBvp80aySKM/iYfDeLLm7CF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAxOgm6I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so55159165e9.2;
        Mon, 11 Nov 2024 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731321206; x=1731926006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/75HCuIvnIChwVSX8bQ0PTjz4RwEQPBR5AO+hQeL43E=;
        b=JAxOgm6Iw1PE1oMq/fD+wrKk7HOziMs+QFJ1es9Wg0uHkXbTHGb8ot8lzqDSkjbvRv
         Dx01zDlCuuwyPVqKWik67OkpCozuQEMUxqbjyQB49mmsflpY5sSVwesHShFJ8LHUZX+0
         Hw1IyF01ddLNdXHLbTWC/MTPQnw35lszj9a0UTtIq2vRfA4vOqgXwYNxz9vwNzgrvdQu
         8gdk50sHtryXHhJZwlzGZBcT5EIjfBM6LAnuc7RI8jt7GO0Qxuvk9iOSwg7Lw67P0NlN
         XZzm9zNsKfOAhn0mef/OPEcUyGySZnA6SqcyjdEEIz+UAAp82X6nU0qVvs5WLLpLi4gc
         oQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321206; x=1731926006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/75HCuIvnIChwVSX8bQ0PTjz4RwEQPBR5AO+hQeL43E=;
        b=rrKF6tZw9H7Jhf46hHRFf1Z7tLxwkEoBwr2ompqkV48RrIfHZ6w5Tmbnda44g1Bybq
         +6JiQ3F43ZxfdaiRbeYOYRsVuyYAQEhLduTrjDqPsOnN+ibA/3ZQZLT9ThwlAhhTlADp
         jkeEicju8ox93JRY+ulIvpQkbLLQ5CVq9ap0WjTpvgQe9Zzw8BCdGkdo+qPTe6vBvun2
         +g3D4XhyRNyCVPuotyqmCNZM96ykMcZ+qcaAwrNS3IIUuB6/vNhHZHoTSYCZY38x5ztr
         PXRuRDRzePhhILSFsfMrukBso9DGeg0rS2GscTZC4WxtcTi+A96ce0AoRJrKlfuY2vYo
         CA3g==
X-Forwarded-Encrypted: i=1; AJvYcCUiOLleMDRS8IsNzzYPD4+YJvAlIak58VWowwP1sylZWx/V7k9o+ERwK48kmOmQydTLkL3WrNIdaL0=@vger.kernel.org, AJvYcCWS97mYaHthhfhDcvs0pZ6M/bu+fm4PkHJeyCuBf6EeFW63mwjhjgwLrYMFp6VoCOOkTROeK+BuS0uuCvfd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+xWHXLjxgOzp0KYwwe/2nGePOV7mSRxkvJKomNsF+4Ai96zH
	vhiQKDrEj1jfDDogwoLozvwX5w793nZyRCpXDHNcDex0ErH8dLU7dxHDe+TqLtXVMLS0
X-Google-Smtp-Source: AGHT+IEkZDqDdh3QMhEX84sxbC1DLAibYOfUNoW3mxdqgHJOxsyjnCdL1DfqMfWXGfMrnpjcvN0eag==
X-Received: by 2002:a05:600c:5494:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-432bbf6ba6emr111063015e9.26.1731321204648;
        Mon, 11 Nov 2024 02:33:24 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0530694sm175469345e9.7.2024.11.11.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:33:24 -0800 (PST)
Message-ID: <b91ccaa161b962336324af31cd507fd1255e5c5c.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: Mircea Caprioru <mircea.caprioru@analog.com>, linux-iio@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 11:37:46 +0100
In-Reply-To: <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
	 <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 19:18 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The ad7124-4 and ad7124-8 both support 16 channel registers. Don't
> accept more (logical) channels from dt than that.
>=20
> Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7124.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index a5d91933f505..7473bcef7bc6 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> +#include <linux/stringify.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/adc/ad_sigma_delta.h>
> @@ -821,6 +822,11 @@ static int ad7124_parse_channel_config(struct iio_de=
v
> *indio_dev,
> =C2=A0	if (!st->num_channels)
> =C2=A0		return dev_err_probe(dev, -ENODEV, "no channel children\n");
> =C2=A0
> +	if (st->num_channels > AD7124_MAX_CHANNELS) {
> +		dev_warn(dev, "Limit number of channels to "
> __stringify(AD7124_MAX_CHANNELS) "\n");
> +		st->num_channels =3D AD7124_MAX_CHANNELS;
> +	}

Hmmm, I would treat it as an error...

- Nuno S=C3=A1



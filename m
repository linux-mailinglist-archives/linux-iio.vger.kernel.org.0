Return-Path: <linux-iio+bounces-13834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCAA9FDAD7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7141619E3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E515855C;
	Sat, 28 Dec 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt5vSrCy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EA2111;
	Sat, 28 Dec 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735394527; cv=none; b=mzFZutGBmMiOAF3IK73koLDQG1PW4LQq67CyGRPOhGg7CYUDlgamsZAOXd+b6GXlbMbYAhnnE4aUCLbr5V/wPzdhNG7tSEXox5OOCef+DOA/c5ZDozikHlV5C3ACCyCdWx1V/6pFXVVXgs0jXxqiS1lqQ4irugJag/t4ap1EjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735394527; c=relaxed/simple;
	bh=h15LbiGPG4ptqGryeqF0MqkSwDB4fZRoG3IGL3gQvs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvmLQ0L+8CEBKi/0h7kFzOleB6zHk4rBfNixyuwU5LahgwLuRxK32gRd2b2G5vQ2kE/eSsI+XCqrYXhWOJNpI3K3O6aYzUY12EBppeSyiBPEZgbAYhUVq9KvhzQ4rCLdFS/ICTV6TpFd/pM42L7nHctT/Y2S3DeY/IfkSVHJB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt5vSrCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8CDC4CECD;
	Sat, 28 Dec 2024 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735394526;
	bh=h15LbiGPG4ptqGryeqF0MqkSwDB4fZRoG3IGL3gQvs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dt5vSrCyW/ATR48JWKitWYwtUTz0hB0+zWuONDbjH1sC+c736RUUV4m+5bSVrSFsY
	 0olRFKV2WQSVEIZ26Wz2mkN9M8k6DBys2YSLq7cNSMstu0KbjFoUKIhjdvJh1yjAkg
	 nDKSePZgtH5By5dcZtSyPKXWVAd8+ka9uMhb4Hi8NBlOwnkNyCb1ZquPciyqMC9H1v
	 IbSDDlUKmtRK91sGhIPHLMXeHnPGw859AiY9nLYDaLVI5bIAUvFG26AhRxdnGpEMIk
	 Bk2AGMtA7HN/uGmgppzBnoB/TejxRdXXSljdw9mOR3w3zf6rNa60LFUZExoJxtTP5Y
	 CAyefUkktkkZQ==
Date: Sat, 28 Dec 2024 14:02:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] iio: adc: ad7380: enable regmap cache
Message-ID: <20241228140201.424936ba@jic23-huawei>
In-Reply-To: <20241224-ad7380-add-alert-support-v2-2-7c89b2bf7cb3@baylibre.com>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-2-7c89b2bf7cb3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 10:34:31 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Enable regmap cache, to avoid useless access on spi bus.
> Don't store anymore the oversampling ratio in private data structure.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

A few really minor things inline,

Jonathan

>  static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
> @@ -692,6 +709,37 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
>  	return ret;
>  }
>  
> +/**
> + * ad7380_regval_to_osr - convert OSR register value to ratio
> + * @regval: register value to check
> + *
> + * Returns: the ratio corresponding to the OSR register. If regval is not in
> + * bound, return 1 (oversampling disabled)
> + *
> + */
> +static int ad7380_regval_to_osr(int regval)

Make regval an unsigned int and yout can drop one test.
The FIELD_GET is never going to give you a signed value anyway.

> +{
> +	if (regval < 0 || regval >= ARRAY_SIZE(ad7380_oversampling_ratios))
> +		return 1;
> +
> +	return ad7380_oversampling_ratios[regval];
> +}
> +
> +static int ad7380_get_osr(struct ad7380_state *st, int *val)
> +{
> +	int tmp;
> +	int ret = 0;

No point in initializing.

> +
> +	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	*val = ad7380_regval_to_osr(FIELD_GET(AD7380_CONFIG1_OSR, tmp));
> +
> +	return 0;
> +}
> +
> +

Trivial but one blank line almost always enough!

>  /*




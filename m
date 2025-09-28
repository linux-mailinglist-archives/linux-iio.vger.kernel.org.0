Return-Path: <linux-iio+bounces-24518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C810BA6CC5
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7831895136
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB52D23B1;
	Sun, 28 Sep 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOm0KrhB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796762D239B;
	Sun, 28 Sep 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050488; cv=none; b=G3kEi76dvBox4RUCVYW6egWBojWaIpXVJO0suPwFuAn/R6oyQG69FoiYMAtVA6m3lOPVRR2+dxsZ6UmJgJ5baXpVRFtU5b/5Ami18iBxmXxhGxXBNfaNcYdJtxT5ZdwjOci0bWNfdX9By1vwCpHZ/YC9zstipYS2LO/SiSSSACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050488; c=relaxed/simple;
	bh=OmuM9T4sRr6WPDNjc7Tc1qjd4o37QkfxYkxf6IUDDOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJ4rYBsfvjgqua+TeBV5QS96MsKgsRlvAPKaUvbQQphDC22wcllBtxnLFHvkxFu/dVKq9mQvtzXSjm05F5rV8TvdYsoNNXd+eo8fbkEMRAsu9sZ4gBo3iE75vgLbS4cyFyccewAjzAm0+klNb7Nyg50uWYB9QzLtc9GSkVv8R1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOm0KrhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF63C4CEF0;
	Sun, 28 Sep 2025 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759050488;
	bh=OmuM9T4sRr6WPDNjc7Tc1qjd4o37QkfxYkxf6IUDDOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOm0KrhBpkdei5dRVg6YcqHlmeMefQHbPnMGdwavsDljIBSLYHTqNpurjnYC8R46M
	 rV5zER+Goj9IfPzxSKLt+ZM5FPhC15SJwbNOnlCsDG6jRLnJByoLxPdlFEXwoi/eUZ
	 DeZ7VAFzrYUnjsR3wcxnTf5vlp3rxPG1+XaGMTuUyopgAdDePYFUp69QUGSTPwq1iR
	 fVR9+uz5NZSUT2PiMlXQouiPoGHuc3Ti6q3pnqr2SreDulab6CHmcCqWticL3SE1g8
	 rKe2g2+q+pIaGQ0xUfWgjk1Fy2xFwevbVyymLVx4oj1oWHoT88Hl1+MyxVGKAFt4mc
	 27wNfnDpOxaVQ==
Date: Sun, 28 Sep 2025 10:07:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: add processed write API
Message-ID: <20250928100757.0fa73692@jic23-huawei>
In-Reply-To: <20250925-ltm8054-driver-v2-2-bb61a401a0dc@bootlin.com>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
	<20250925-ltm8054-driver-v2-2-bb61a401a0dc@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 14:37:34 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Add a function to allow IIO consumers to write a processed value to a
> channel.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
Just one trivial thing I noticed.
Thanks for adding the unit tests btw.  Makes me much more confident we don't have
the corner case sign errors that plagued the similar functions before unit tests and fixes
were applied.

J
> ---
>  drivers/iio/inkern.c         | 120 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h |  36 +++++++++++++
>  2 files changed, 156 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 2a1ecef2b82007f5ee8e8d0f8b35846bc4d2f94a..a6ec724b7c1fb197e6261c1162f8315deda20fd7 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -631,6 +631,57 @@ int iio_multiply_value(int *result, s64 multiplier,
>  }
>  EXPORT_SYMBOL_GPL(iio_multiply_value);
>  
> +int iio_divide_by_value(int *result, s64 numerator,
> +			unsigned int type, int val, int val2)
> +{
> +	s64 tmp_num, tmp_den;
> +
> +	switch (type) {
> +	case IIO_VAL_INT:
> +		tmp_num = numerator;
> +		tmp_den = val;
> +		break;
> +	case IIO_VAL_INT_PLUS_MICRO:
> +	case IIO_VAL_INT_PLUS_NANO:
> +		switch (type) {
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp_num = MICRO;
> +			tmp_den = MICRO;
> +			break;
> +
> +		case IIO_VAL_INT_PLUS_NANO:
> +			tmp_num = NANO;
> +			tmp_den = NANO;
> +			break;
> +		}
> +
> +		tmp_num *= (s64)numerator;

Seems to be casting an s64 to an s64.

> +		tmp_den = (s64)abs(val) * tmp_den + (s64)abs(val2);
> +
> +		if (val < 0 || val2 < 0)
> +			tmp_num *= -1;
> +
> +		break;
> +	case IIO_VAL_FRACTIONAL:
> +		tmp_num = (s64)numerator * (s64)val2;
> +		tmp_den = val;
> +		break;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp_num = (s64)numerator << val2;
> +		tmp_den = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!tmp_den)
> +		return -ERANGE;
> +
> +	*result = div64_s64(tmp_num, tmp_den);
> +
> +	return IIO_VAL_INT;
> +}



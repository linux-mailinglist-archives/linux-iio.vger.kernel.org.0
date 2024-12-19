Return-Path: <linux-iio+bounces-13643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A29F7D9D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8094E1885958
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47262582;
	Thu, 19 Dec 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsJhyAHJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D8223C49
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620794; cv=none; b=W4bMTxxBbCpR7ae2+6mwqtTwHbiZSFLywFa2rkcZ5ItfwcX4CLBIBDy7vQoMm7D5vATBug6/mUWZPlRuHfGiXTBdH9jyiub1gcrE6FKEagIDKflWfda0uLTaJ/ZxwvRlb+Yxn7P+jfTHGu3WAujPp5b8lFp3qCvmM+JoFxr4AXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620794; c=relaxed/simple;
	bh=aHCGPhGKxwQj7E/PCwMHlocrq9QzZDFktbMJ31yYeWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIBTk3Zb3wDvkWuquHogYkjwL/308EUXIJ2NQ9ZDsG4GhvWnW8pp++RJsD0ak0bVxohpdiW2a1dY9REPeeqG+YIqchLOQ2btK0orhNy9S6XoVEs+cn3lmfQ4qPDa0HdcZPR2kvi8F/q4/KsswPrYRx9CmRwIVlkIgFUZOnnYp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsJhyAHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E4BC4CED0;
	Thu, 19 Dec 2024 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734620794;
	bh=aHCGPhGKxwQj7E/PCwMHlocrq9QzZDFktbMJ31yYeWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsJhyAHJLMrVDvZTvn63rgyF1Tpux8w/ij95m27fQGq6S/fSDs7Jvoy7eU3Ya1jLi
	 e2z8F4XYUPAIvqon6YlJISKmIh7cKBJIaKiriiuEgi3kKBlWKvdoFbgIF7q0EJVaSr
	 RmMnjrWgF0bPV10pReZXplyddZrDb2v8GA2cGnbsW6zULM/MuSgoX/zWkQcCQj2lYc
	 kitTts3gIZYqnpJPjRN0hkfIEoczMV7W40ZgHn4xpEq35ZZ/Fy4Mu86CqQWxKnp7uL
	 KEgK2x5+AkOE51N51jyZ5VHcxqdXjjpXOps33VEbJ09pPimh+47QYoln6mzQoqBHOH
	 nC6BkDQVsTihw==
Date: Thu, 19 Dec 2024 15:06:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: Use `unsigned int` instead of
 plain `unsigned`
Message-ID: <20241219150626.6f6092ed@jic23-huawei>
In-Reply-To: <20241218114809.1378063-2-u.kleine-koenig@baylibre.com>
References: <20241218114809.1378063-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 12:48:09 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> This fixes a checkpatch warning:
>=20
> 	WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 	#70: FILE: drivers/iio/adc/ad_sigma_delta.c:253:
> 	+		unsigned status_reg;
>=20
> Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready =
signals")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Applied.  I dropped the fixes tag (which was useful to me to find the patch)
because it's just a warning + I don't want to mess up if I do have to rebase
for some reasons (and all the tags change!)

Thanks,

Jonathan

> ---
> Hello,
>=20
> if it's not already to late for that, feel free to squash this into the
> original commit.
>=20
> Best regards
> Uwe
>=20
>  drivers/iio/adc/ad_sigma_delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index c3c81aef34d8..7164ae255ed7 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -251,7 +251,7 @@ static int ad_sigma_delta_clear_pending_event(struct =
ad_sigma_delta *sigma_delta
>  	if (sigma_delta->rdy_gpiod) {
>  		pending_event =3D gpiod_get_value(sigma_delta->rdy_gpiod);
>  	} else {
> -		unsigned status_reg;
> +		unsigned int status_reg;
> =20
>  		ret =3D ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
>  		if (ret)
>=20
> base-commit: 132d44dc6966c1cf841ffe0f6f048165687e870b



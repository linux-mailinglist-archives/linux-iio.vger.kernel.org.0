Return-Path: <linux-iio+bounces-8216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C7946A7F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5CF1C20D5E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1B14F9F3;
	Sat,  3 Aug 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWKSfUB1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF271386D7
	for <linux-iio@vger.kernel.org>; Sat,  3 Aug 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700423; cv=none; b=KsTNgvSDoLe7bxZW2Z/NzzGJovo+H0+gq29vZ6b2qlwJe7PG86q0kmVd2nK03mzpn+JPNWsfFkrX1T4piZSZDwo4SZLW0zAbyfQDRCQQapnhH+FJ5VhW0baJjLmvVcOxw6eYWHbE0JxwN/2DtobLnNM+fbHFpFXj4tV3QOplYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700423; c=relaxed/simple;
	bh=qQSkqpxpv+RTCzhdDC1HMrY2qcn/VCuno5xrUTWtQqw=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2xxRJ3NUFJ/Kj7xravkFbSBqYcrccpmRyhqb5r8ZPQ5ZuqeF+E4MHqdW40wMKXnZ2Abbor0XIgLPU4Tbh0N7+k0fgliBCVMxu9djDd0rCb/s0worvldAb+VAMKWBw+xXUDXs4O2iuTtpYro7XVj6ncv4/2657CWHH0ZomTIRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWKSfUB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB465C116B1;
	Sat,  3 Aug 2024 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722700423;
	bh=qQSkqpxpv+RTCzhdDC1HMrY2qcn/VCuno5xrUTWtQqw=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=IWKSfUB1SFuAa2ie7mE/kaKZk4ZxeJ2lVCPRk4k3v9hr4ZcisKXSXzIQM0Zh4dSgZ
	 umbAsLvcbbzArAt8eBfm4M2BuDMMR+GSNUQhMmeRQRRfc8rUZhqUPYc3QldsQYYyDq
	 NV9YyiMvb3xHsusIqIvt7XCciLBtvxmce6oIAfOm41f+adz51mygEXShgo1AW/EvgH
	 UezbcQ4nCxJT6mN/vCILd7XYzkEssxOm9eqGR4i/dJYT1+Jn3m/D7z9kBDRMoFUU12
	 2tLivoVM0EOfM6IvRBRYMwegMY3dPJJ2U6VoAK+3eoMbQLuFhMm6DEpsmjKfJIC/2F
	 p6kl5JsS9JWYw==
Date: Sat, 3 Aug 2024 16:53:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: remove unneeded assignment in __iio_format_value
Message-ID: <20240803165337.200abd3b@jic23-huawei>
In-Reply-To: <20240730-iio-clean-fmt-value-v1-1-3e1c3deafc33@gmail.com>
References: <20240730-iio-clean-fmt-value-v1-1-3e1c3deafc33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 11:43:49 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Trivial cleanup in __iio_format_value() for the IIO_VAL_FRACTIONAL case
> where tmp1 = vals[1] assignment is unneeded and irrelevant since tmp1 is
> immediately overwritten by the subsequent div_s64_rem() call.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> Link: https://patch.msgid.link/20240730-iio-clean-fmt-value-v1-1-3e1c3deafc33@gmail.com
Applied.
> ---
>  drivers/iio/industrialio-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0f6cda7ffe45..9e364f9879ef 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -667,7 +667,6 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  					     vals[1]);
>  	case IIO_VAL_FRACTIONAL:
>  		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> -		tmp1 = vals[1];
>  		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
>  		if ((tmp2 < 0) && (tmp0 == 0))
>  			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));
> 
> ---
> base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
> change-id: 20240730-iio-clean-fmt-value-9c5a42d4fa24
> 
> Best regards,



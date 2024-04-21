Return-Path: <linux-iio+bounces-4412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D78AC051
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5181F214F4
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788041DFD1;
	Sun, 21 Apr 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX5fStdp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38792111AD
	for <linux-iio@vger.kernel.org>; Sun, 21 Apr 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721112; cv=none; b=tB351W/c+4FrcEh0iWWJaqVsv+h31K+RV7sdnmW45BQ4/F+Oznjbru5VsyGp0VSO+ByjvTGw5McS5lNmuy+pSArXsavOkl3TwERT6T0vGQUDJb5NDZ3yWjZWWUpH6lssX/Sjbra6wHMEiIEliVNYvzQ28yGTUDY2LHCBVp6hGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721112; c=relaxed/simple;
	bh=zcYk9wnT5wOvr9b6w/OnH00OfgjHlR/Ov3Yn7JlWjQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+f4/FviKePDiP55te8HT1Cxjdc921omR14TgX/VVTrH0UyioGkakTMDVzgpCL4I8Yhw4aGoJ4BCbKr+0EUAbTeXYUikWf7EaEVmLJdCy8aMcRmzSydyLQD0kWlIBsq18/ClFVLcqwhe2QIB95dxDPQKs+1QSBooiJVFCfKtS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX5fStdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFF1C113CE;
	Sun, 21 Apr 2024 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721111;
	bh=zcYk9wnT5wOvr9b6w/OnH00OfgjHlR/Ov3Yn7JlWjQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jX5fStdpMAasKkmES4wTVzn7cZ44m5a5u4t65np+FmGj3Xit82gCFg4t9A4/76nlP
	 ayFrQCpdjptBF9psvzIJ2+QQBvHRwpwA0rqcbcgtHx8ohL8J/wFeXaAunx7UaKmfEr
	 eq3zJZQLUloC4PqOZpdtWjJFmm09Nl3e4MP/vx5/vMbnlHJCGhyG+5aY+h+QLPyOaJ
	 MX8MF/2mlXhI7YG2FuquFez/W/v6SfzFW8M0s7+laij1b4hNygqxrk/FZ2PF/olRcd
	 k4haG8bpy53F1SVZW/m4I8DaCYajhSstzZEzaQ2Ez16rJpB4wAKZ8JUc5az814Mbnq
	 lFQL4W7+u3ibQ==
Date: Sun, 21 Apr 2024 18:38:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T3TDoXZpbw==?= Silva <otavio.ols@usp.br>
Cc: Thiago Duvanel <thiago.duvanel@usp.br>, Felipe =?UTF-8?B?QW7DrWJhbA==?=
 Brito <felipeanibal@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: use sign_extend32 to provide negative numbers
 conversion
Message-ID: <20240421183820.4e2c0133@jic23-huawei>
In-Reply-To: <20240420233836.24971-1-otavio.ols@usp.br>
References: <20240420233836.24971-1-otavio.ols@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Apr 2024 20:34:11 -0300
Ot=C3=A1vio Silva <otavio.ols@usp.br> wrote:

> This implements the use of the sign_extend32 function to handle the output
> of negative numbers.
>=20
> Co-developed-by: Thiago Duvanel <thiago.duvanel@usp.br>
> Signed-off-by: Thiago Duvanel <thiago.duvanel@usp.br>
> Co-developed-by: Felipe An=C3=ADbal Brito <felipeanibal@usp.br>
> Signed-off-by: Felipe An=C3=ADbal Brito <felipeanibal@usp.br>
> Signed-off-by: Ot=C3=A1vio Silva <otavio.ols@usp.br>
Hi All,

What makes you think this is signed?  It might be. If it is
you need to provide that information to justify this change.
It would also be a fix if so and need a fixes tag.

Given this device has a mixture of differential and non differential
channels, the single ended ones are very unlikely to give signed output,
the differential channels 'might' be. The datasheet does refer
to a bipolar mode with 2s complement output, so if that is in use, then the=
 results would be 2s
complement and should be sign extended.

So you need to figure out if that mode is in use or not.

Jonathan


> ---
>  drivers/iio/adc/ltc2309.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> index 8b3a89c1b..cb93dbc94 100644
> --- a/drivers/iio/adc/ltc2309.c
> +++ b/drivers/iio/adc/ltc2309.c
> @@ -124,7 +124,7 @@ static int ltc2309_read_raw_channel(struct ltc2309 *l=
tc2309,
>  		return ret;
>  	}
> =20
> -	*val =3D be16_to_cpu(buf) >> 4;
> +	*val =3D sign_extend32(be16_to_cpu(buf) >> 4, 11);
> =20
>  	return ret;
>  }



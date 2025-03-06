Return-Path: <linux-iio+bounces-16444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6173A53EEA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2CD16798B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785764D;
	Thu,  6 Mar 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix5LhPvx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE7367;
	Thu,  6 Mar 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219826; cv=none; b=TPsnBgWvnphYw3r1dCnwCsH9W5ZSBUnpoxvKq+uQSC/PchYcBvWz1YIaekKJpMDDtvnBjz1o9LpoaHhqTA5CMjvRm1iqWpxE9Frdp/xfC5Zw4868TYB/9H8DdwQouPDqlo2v0fSJjl7d8cZ+f0GvVE4Cha29H4KVyhU/Oq4T1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219826; c=relaxed/simple;
	bh=OUCGPBlwAoOwgIKTnJRCA59xZPdlnRHgy1PAw989xpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcawkwW9GTr2eEI2iOnSNns3QNZFFmBx5NIg1ySj3wSZHIKdbn50W8lqyyV/Zg3nJ/UrU+u/J2yFzSO44JE/5jBgpTMLTRXvtBcEZvErh/HHnKuMp2PP2AYNaOEnpMMdTiLzYVPA2lCjM3NAFKrYQ4P4H71lMCR5c+/PqnjbMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix5LhPvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6CCC4CED1;
	Thu,  6 Mar 2025 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219825;
	bh=OUCGPBlwAoOwgIKTnJRCA59xZPdlnRHgy1PAw989xpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ix5LhPvxvu2H7LMAi8qs9gKYt7ZK9f8Bpt8V5EZk4K0Oo19TxQYRnVtGJf8oOp2vE
	 0Ysg6v1G+fWfLqHJFSpkV729xxp5RsV8cGUKu9JdGZIIag+RvZaK+E9qTgKCMeK0uv
	 bM+6ZUzHFbX4ECMkS87/ZNNIqAxDmz9ystXZrcfOCgVLg5jLE6QEoQl+CRp8NI2m8k
	 /9j9r+HzBryTUdPGmwW61AfYVj2hudjRwt3CQNxLYzJKTpFfjhiy0FKHlwXK8CHEYV
	 1gESgCYhAmM5Xh0aXBdvL3/JXR53QmvYGM+vUUZyR9K1jN6dzriof7sr7hsYai/YSl
	 56DbbdsplIxDQ==
Date: Thu, 6 Mar 2025 00:10:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/8] iio: adc: ad7124: Benefit of dev =
 indio_dev->dev.parent in ad7124_parse_channel_config()
Message-ID: <20250306001013.7cd5d00c@jic23-huawei>
In-Reply-To: <v7l2skqj65vbku3ebjsfndfj3atl6iqpodamios2do6q6kcagf@whmuir6fwede>
References: <v7l2skqj65vbku3ebjsfndfj3atl6iqpodamios2do6q6kcagf@whmuir6fwede>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 10:41:09 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Since commit a6eaf02b8274 ("iio: adc: ad7124: Switch from of specific to
> fwnode based property handling") the function
> ad7124_parse_channel_config() has a parameter `dev` that holds
> the value `indio_dev->dev.parent`. Make use of that to shorten two code
> lines.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> this is a patch opportunity I noticed while backporting my original
> series to an older kernel to please my customer.
> I chose to sneak it into the series in the hope to not offend maintainer
> tools :-)
Leads to b4 getting rather confused, but doing the right thing in the end.

Applied.

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20
>  drivers/iio/adc/ad7124.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 5ab0d3e48c43..53b274ca42ac 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -1061,12 +1061,12 @@ static int ad7124_parse_channel_config(struct iio=
_dev *indio_dev,
>  	/* Add one for temperature */
>  	st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHANNELS);
> =20
> -	chan =3D devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> +	chan =3D devm_kcalloc(dev, st->num_channels,
>  			    sizeof(*chan), GFP_KERNEL);
>  	if (!chan)
>  		return -ENOMEM;
> =20
> -	channels =3D devm_kcalloc(indio_dev->dev.parent, st->num_channels, size=
of(*channels),
> +	channels =3D devm_kcalloc(dev, st->num_channels, sizeof(*channels),
>  				GFP_KERNEL);
>  	if (!channels)
>  		return -ENOMEM;



Return-Path: <linux-iio+bounces-14461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DBA15E0A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A2A1885837
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7380194C6A;
	Sat, 18 Jan 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdpTP4Gx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726A189BAC
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217448; cv=none; b=gsRDqiK58t+VoecC4FDv9ey3hxciZ6b/eBIY02gCEmzs/x7r/oGBhL+XByMTuKyciZhjdJa0nNEa4quShKAlnCqLRg7y1ls83Tf+Ie7zgo41WMTU2e5e2qkHef+jHNOoNBsREl11iS2DQDIMpp97mpN2Gwj/eYJ+EFf5OtoxnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217448; c=relaxed/simple;
	bh=Pl2JXYWApE+pES4GSp+xSWNFcpCmN0BVAmIzmqgJwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqZ1N+MzToet4H1NIBHirhVsk7U9eCPCo3liAsFr3XL1AB1LlRFlYqOgSWp9OlWJPIgPMEzRcGJGz7+EHbiavUGoQgVDPpBeEOTdkCszXK7tQtB99R8QG/TFZ+YQ49L8bsdz9Fn9iz7lH1dznBG8hRZVPvqrXPW5pP5nWcTcXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdpTP4Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB6DC4CED1;
	Sat, 18 Jan 2025 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737217448;
	bh=Pl2JXYWApE+pES4GSp+xSWNFcpCmN0BVAmIzmqgJwqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pdpTP4GxT3WfpUUXSTlplAi5eSy/wkbJDXmJhgbrK/LgPI0sW7ct+ev2C/7+M3L8O
	 +2je/nOiWnUBs2ibDwZh9COheAaV3DRGY2fmjKFBTpZ5gOitJAzVoWWZAwZZFy/inQ
	 +VXyId9ZXvS5ybanuncMBu5PhYRn0q88fo4CmOEX+FehUYj58tmTwdlc07JQ+SJe6T
	 V7COrPzGxVVGYIRYHNRhk8u/FyqC2fvcIioHYLwIbihF55UimRc2wDi/I6Q+x9WGiR
	 lonTWPtK5FVfBy71z+xg/VDp/UMakvuOSqj+Uzl5ozD9p4mBgw6SRkHmpeT0ZlQG+m
	 DNPdGXe09U5nw==
Date: Sat, 18 Jan 2025 16:24:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: Micro-optimize channel disabling
Message-ID: <20250118162401.72647ee0@jic23-huawei>
In-Reply-To: <20250116180342.161323-2-u.kleine-koenig@baylibre.com>
References: <20250116180342.161323-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2025 19:03:41 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> The key objective in ad7124_disable_one() is clearing the
> AD7124_CHANNEL_EN_MSK bit in the channel register. However there is no
> advantage to keep the other bits in that register because when the
> channel is used next time, all fields are rewritten anyhow. So instead
> of using ad7124_spi_write_mask() (which is a register read plus a
> register write) use a simple register write clearing the complete
> register.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Hi Uwe,

This change looks fine but why not the same in ad7124_disable_all()?

=46rom a quick look that appears to also be safe as the enable path is
the same one you are relying on for this case (I think!)

Jonathan

> ---
> Hello,
>=20
> while looking at traces I spotted this unnecessary register read. On my
> machine (de10nano) this register read takes ~23 =C2=B5s when doing
>=20
> 	cat /sys/bus/iio/devices/iio:device0/in_temp_raw
>=20
> . Compared to the time the chip needs for the actual conversion (~400
> ms) this is little gain, but still. And more relevant for me: It
> simplifies trace studies.
>=20
> To state the obvious: This is totally not urgent and merge window
> material.
>=20
> Best regards
> Uwe
>=20
>  drivers/iio/adc/ad7124.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 6ae27cdd3250..73c831626bf3 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -559,7 +559,8 @@ static int ad7124_disable_one(struct ad_sigma_delta *=
sd, unsigned int chan)
>  {
>  	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> =20
> -	return ad7124_spi_write_mask(st, AD7124_CHANNEL(chan), AD7124_CHANNEL_E=
N_MSK, 0, 2);
> +	/* The relevant thing here is that AD7124_CHANNEL_EN_MSK is cleared. */
> +	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
>  }
> =20
>  static const struct ad_sigma_delta_info ad7124_sigma_delta_info =3D {
>=20
> base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189



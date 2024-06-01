Return-Path: <linux-iio+bounces-5585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6667C8D7196
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC40B213BB
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407EB154BEE;
	Sat,  1 Jun 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5KsgmJe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0D4690;
	Sat,  1 Jun 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717267898; cv=none; b=ORp339A9VN10ciMd2mtHDlmgO257XZ2J/z3tJKQtQDPdu/gFwTn0VX9Wm5+cajZ/XuI0wviLyp0QQguqRWo2bdBaAvcU/YtVHU266XNrgaQkTZkEyDFMd+dYB6eRKtNQEq04CJuV3cLDSmnaLJNcaJN/G9aPxB/ZcQsc0ejzq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717267898; c=relaxed/simple;
	bh=kTLzy0XiVry8kuQv5OCV1tD1sJs1sBzRICilwHuwLuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVPxdcAm9D09A/e3ASosH0I5f339/ait7TcO5EUVaIuN7SUIMG6jAnz4ABdBZK8RrKUmHWjmV5wPmm7zjp2Afqc+1gGX3424iWYbF0ZmuJLRG4CHPfu0OMkuwn7oXqgxgQCtGiclhHl4Szvgu6mufl2yoqdw6DpWEIhdBGixs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5KsgmJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20136C116B1;
	Sat,  1 Jun 2024 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717267897;
	bh=kTLzy0XiVry8kuQv5OCV1tD1sJs1sBzRICilwHuwLuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J5KsgmJesgJCgXIIdKc/PnEk8dYuoyOYgOxUI6maA07A0VmgdPs6YVcwFZQvyM62+
	 jYgVUmMj0QaldLRaGn/vHUZHZRkJtoW74TuoTcGuj0W/85g2C5xEpAHgwsJ3gQqlvN
	 KjUDecuLzlpTq3rO2TewQ+SPAKK/fSlge39bzbM7yhvlfG4/88KG+RMwYGieme0bZq
	 jPzhmjCcSWwvhxB6/hs6Kn2mlRyu7U83t8kM1DjpfP1YdfeYZYE+utDlj0Cln7Q9Ex
	 s2sqJkTGOoch6E9oMWxgnGAAh/Qs4YeW4MGedh8NzzQeIDRunnoYcVoKzUIsYgqRvg
	 vu0+TT1f4K3LQ==
Date: Sat, 1 Jun 2024 19:51:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v4 4/6] iio: adc: ad7173: add support for special inputs
Message-ID: <20240601195122.5e6ffeba@jic23-huawei>
In-Reply-To: <20240531-ad4111-v4-4-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-4-64607301c057@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 May 2024 22:42:30 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> =
wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
>  Add support for selecting REF+ and REF- inputs on all models.
>  Add support for selecting ((AVDD1 =E2=88=92 AVSS)/5) inputs
>   on supported models.
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Random passing comment inline. This looks fine to me.
> ---
>  drivers/iio/adc/ad7173.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index a20831d99aa5..ebfd2d5f9632 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -66,6 +66,10 @@
>  	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>  #define AD7173_AIN_TEMP_POS	17
>  #define AD7173_AIN_TEMP_NEG	18
> +#define AD7173_AIN_COM_IN_POS	19
> +#define AD7173_AIN_COM_IN_NEG	20
> +#define AD7173_AIN_REF_POS	21
> +#define AD7173_AIN_REF_NEG	22
> =20
>  #define AD7172_2_ID			0x00d0
>  #define AD7175_ID			0x0cd0
> @@ -146,6 +150,8 @@ struct ad7173_device_info {
>  	unsigned int id;
>  	char *name;
>  	bool has_temp;
> +	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> +	bool has_common_input;
>  	bool has_input_buf;
>  	bool has_int_ref;
>  	bool has_ref2;
> @@ -216,6 +222,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>  		.has_temp =3D true,
>  		.has_input_buf =3D true,
>  		.has_int_ref =3D true,
> +		.has_common_input =3D true,

This is another good reason for breaking up this array (as suggested in v3 =
review
but perhaps a job for another patch set!)
If you break it up we can see which entry each of these actually is in the =
diff
rather than having to use line count to figure it out!

>  		.clock =3D 2 * HZ_PER_MHZ,
>  		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
>  		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -230,6 +237,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {




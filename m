Return-Path: <linux-iio+bounces-26090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E529C4422D
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E744E0416
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF82FFF82;
	Sun,  9 Nov 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMm03nIp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DB1A9FAA;
	Sun,  9 Nov 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705007; cv=none; b=kfvjzLRihLFljftsNrB810Z/5+ZJKOMztj0dIV1/2ll4h8I4Mo2eA9odtPZI4UHW+3B/QXUfgNnSmcqqAAK9qL9qxBr2bumlhPbMdgoonGXODLLGmBYD1O4ft6SMe+/nc3DCyGyzPkr5lPTXrJFCL3H4hb21/nOljEoJBCEll1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705007; c=relaxed/simple;
	bh=GkGocr5eAOyLL18g4Je+C0cYvLrAR70j/M2hE+tfMZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imw5g3JXQRv+R7yLwXVfj9ZlpJWxajFlnhnPJpF0ApqvQ0aFwaBa/YPShpB5ztYBzaGyGmbytjz77eVnkLAOLi7xVpcCmHTpQcaL/Yufv6IupJzQzJT7ukiOxH11KmVrkNESoASaP8Sp4cYuEvJ/mAH9BtyUFz7cXlwmG8A3H/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMm03nIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86558C19421;
	Sun,  9 Nov 2025 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762705007;
	bh=GkGocr5eAOyLL18g4Je+C0cYvLrAR70j/M2hE+tfMZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DMm03nIpA95NzNQD9/HkzXNajmu3Hvtoya7qbUWA0azwE7d04uQHwYflsN7SEI/zr
	 +vZFLRtP/TaQFZTwMP2YJ9K5B1P2HgMS3Ehy9cQ8I5FwjvthQ9WEF1/CIq6xEhremS
	 HlS9wiNXhs7stG+2Nd+a4Ls4kHY9X36rp4+dPDL1FpydLWnCjiwZoIF7AH74Aaz6rJ
	 4eMVzkDuPgOkaG07/1y1+USQWmHRzViOkwsNVvWfDlcOByyjccVxWriBITd+vWLY+R
	 vyNTbpJv0zyOflJFcctOAlgZLCPSGiveRY/ChoP5Tyv39o/VEhQkOWWYad+CWNXq7L
	 ArGBWQ3U6klug==
Date: Sun, 9 Nov 2025 16:16:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 08/12] iio: dac: ad5446: Make use of
 devm_mutex_init()
Message-ID: <20251109161640.6b63600d@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-8-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-8-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:13 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

> ---
>  drivers/iio/dac/ad5446.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index c7876217c7ec..59e1f67ef334 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -184,7 +184,9 @@ int ad5446_probe(struct device *dev, const char *name,
>  	indio_dev->channels =3D &st->chip_info->channel;
>  	indio_dev->num_channels =3D 1;
> =20
> -	mutex_init(&st->lock);
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> =20
>  	st->pwr_down_mode =3D MODE_PWRDWN_1k;
> =20
>=20



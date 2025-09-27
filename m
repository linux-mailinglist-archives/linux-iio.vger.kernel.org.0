Return-Path: <linux-iio+bounces-24505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D64BA6236
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B97B21E8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13D22A7E4;
	Sat, 27 Sep 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY/unRBR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23B46B5
	for <linux-iio@vger.kernel.org>; Sat, 27 Sep 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758995862; cv=none; b=sPljPIqrkUUWqHJHcVzA+GtPogd3bghkbBuiTk0V4dyYEb/0tep+rAWWE36RRmoZD68b5ibWJUa5ru2V89yNlyYe5bGh95YVq1/8Ut+S8pm9n24P4/20V8pn8G137eFicBDLlBFfxqa2I4F2rNsQmd5+w6TRP/YTk2lEm3AHElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758995862; c=relaxed/simple;
	bh=KLA9lZKaa09fjNpGx4/0JD/0YtWBlqN5pJOVnWJBa+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/e1+W8kR9M6G5/VGz7Su16mJ56K9h0xC+7uqnjzGe2cOXs0uIg5UEByHkOXzo/9NQc/vP6XzUQyocnaL7Nh29VUHCQlgxTb/KOnizoKmt0RcO3YkbI0UdRupffUYrBRGtLT/rmBWNl5yCPPjqNos0X0N3jGorGKkzfGCm1Od+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY/unRBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46FCC4CEE7;
	Sat, 27 Sep 2025 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758995862;
	bh=KLA9lZKaa09fjNpGx4/0JD/0YtWBlqN5pJOVnWJBa+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GY/unRBREPiu0e4eVJ71h96sL6qCqIJShLPhbd3/3h+tYiyXJ3YFYRlFBCMzp8reV
	 +02SJo5GurIy6OTqytW678nEvWuDDKaDpDQAIqSRmCk56vukE5vFHylS3oeBE02kBV
	 V54MtOmnCoOz7zKuRlwZ2vaMs3O0Jg1agefBLyQMck5ZSsgIXVXJNoSKqabPQsP8Wi
	 IL4edcWIk+4vIYGSZAgZVbtQHcaZIEbtaKWNUHYfYYimPn/M0lmVdxKBCI3hQA8WZ2
	 X2c2/TGSeCr5OtyTrlYElAUkUchAVCJ0UPk40faahEpgXrUaWjtQ/OlKTcSZbGVuqV
	 7TgucRRW5Lwgw==
Date: Sat, 27 Sep 2025 18:57:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/2] iio: dac: ltc2688: make use of devm_mutex_init()
Message-ID: <20250927185734.76f8bf72@jic23-huawei>
In-Reply-To: <20250923-dev-ltc2688-minor-v1-1-ef92c441dc42@analog.com>
References: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
	<20250923-dev-ltc2688-minor-v1-1-ef92c441dc42@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Sep 2025 09:41:47 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Use devm_mutex_init() since it brings some benefits when
> CONFIG_DEBUG_MUTEXES is enabled.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
> ---
>  drivers/iio/dac/ltc2688.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index 7a2ee26a7d68730fe90d9cc91ea764f05eb61791..57028d422868ec48e6900ef1c=
c4be6dee9cd4547 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -953,7 +953,9 @@ static int ltc2688_probe(struct spi_device *spi)
> =20
>  	/* Just write this once. No need to do it in every regmap read. */
>  	st->tx_data[3] =3D LTC2688_CMD_NOOP;
> -	mutex_init(&st->lock);
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> =20
>  	st->regmap =3D devm_regmap_init(dev, &ltc2688_regmap_bus, st,
>  				      &ltc2688_regmap_config);
>=20



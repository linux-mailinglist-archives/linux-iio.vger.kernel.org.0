Return-Path: <linux-iio+bounces-8728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0671D95D552
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FB81C2115B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F218E02E;
	Fri, 23 Aug 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYi4OFM2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60C5695;
	Fri, 23 Aug 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437933; cv=none; b=JrdOV3tHSdj5UHYShLWS2wtEVJOEQz3z0+uh+bX5vQEmOrr1NbAzzQ7Nz+ANzN4HBlrc+SSkR7Nc1OYKl39sen1CTClS6UkS2cj0Xre0aMfXyaK8GlZOs4fwqAoLvhZ4aQ8PD1EZlOP9VGS1zOQZgbpCMSwHqwUQrlAOTnlXquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437933; c=relaxed/simple;
	bh=FkpFzI5HjK99v6rTah/K9d9aG4JksPJ77VuB76o8Y1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIrrdI/lQHKpAwcC08OUeiqUgh8ZLt88RkP97/vkrHQ8KfhXb46afL6WW2WGLS+LXoI5y0wD4MzVLv2wP/aiGbY9yV209+Bcc3WIwX4MagWWutm2gc7QYr/FaWYgD05oMpJJYqbUQG6kBLTNVjLY2r/GkWLwSrPucu9+7S2GEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYi4OFM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC33C32786;
	Fri, 23 Aug 2024 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724437932;
	bh=FkpFzI5HjK99v6rTah/K9d9aG4JksPJ77VuB76o8Y1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYi4OFM2D2So7+hNRkL6y0izV7jqVuJvUiH67XBU4fjxjJ7ydLCSrpjQpZYEs7Rgf
	 pLogNT5gNzJ/673yjo54LZjsMmKhBxC26Ie8KiIQV1O4PJM91vgDgY95T/wmcQpgC2
	 85Yf2QNtRbusaeaccxnr2DbELbXFZUbuKkU6bFxwZOCURMTmQ0FR421EuMacX6f3wQ
	 spwOMdw1gP3DNghxOBoHS+YhOAX5fJUThcbdhqBhy69GUaSJfC25EY+dUztCugsJfJ
	 ZNsotYqA+lgj4ikBMqYFnHBrwuVzxJVQmzniP/kgF2tsIMbJVRui8yAyS2+QxoyFe7
	 k1m9uq07wIHTg==
Date: Fri, 23 Aug 2024 19:32:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@mainlining.org
Subject: Re: [PATCH v4 1/4] iio: magnetometer: ak8975: Relax failure on
 unknown id
Message-ID: <20240823193203.7772a6b0@jic23-huawei>
In-Reply-To: <20240819-ak09918-v4-1-f0734d14cfb9@mainlining.org>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
	<20240819-ak09918-v4-1-f0734d14cfb9@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 00:29:39 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

> Relax failure when driver gets an unknown device id for
> allow probe for register compatible devices.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
> ---
>  drivers/iio/magnetometer/ak8975.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index ccbebe5b66cd..8eef4d5dd9e2 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -484,10 +484,13 @@ static int ak8975_who_i_am(struct i2c_client *clien=
t,
>  		if (wia_val[1] =3D=3D AK09916_DEVICE_ID)
>  			return 0;
>  		break;
> -	default:
> -		dev_err(&client->dev, "Type %d unknown\n", type);
>  	}
> -	return -ENODEV;
> +
> +	dev_info(&client->dev, "Device ID %x is unknown.\n", wia_val[1]);
> +	/* Let driver to probe on unknown id for support more register
Comment style wrong, I'll fix it up.

With that tweak applied to the togreg branch of iio.git

Thanks,

Jonathan


> +	 * compatible variants.
> +	 */
> +	return 0;
>  }
> =20
>  /*
>=20



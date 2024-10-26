Return-Path: <linux-iio+bounces-11315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95799B174B
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4811F224E6
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E01D2F66;
	Sat, 26 Oct 2024 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdmi7C6F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7D217F22;
	Sat, 26 Oct 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941118; cv=none; b=eMj7USe+29xYDNOE/YXCOw7b3+UeKXOzHxhNDuTDnqmK5pg31DaxnAqotqokCg5uqKU85IXGHReAhZNKQa4sjnRCQcVfNPfSLIrKISnCZyiBxbeIuNYiQoRx9rpWwGpFZzublEBwrql7Fmb7FYaPdzmrMM1xQh/qxP889fanBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941118; c=relaxed/simple;
	bh=2ebx8JE3cOZ78rahI/iG/3gioK1zWds4HeoYY99Iopk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K633KvcgI+ei7lZj5783NymG8P6V22vViK4AGiQHDAwlzuRU6hiSYBUqvdk3VqjF2VQDgUJw63sYlpUoTwEpVoA+Kiv7iSNnSLDfeAAY7KS3AMifQZ2HbBQr1tHY4Hg3EpA1IurDH7KsfTrPQ9MJolZE2H/sdsUxBob1YoZmvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdmi7C6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07416C4CEC6;
	Sat, 26 Oct 2024 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729941117;
	bh=2ebx8JE3cOZ78rahI/iG/3gioK1zWds4HeoYY99Iopk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fdmi7C6FTgRJ+UkByuQ1pdRqLeo0X3VFGI0sto5sW+PODlMgV58UE9KQ5V/3ZKM2H
	 ugmIBw7nsxTusE/KQAaS7Mbw/Chjkev6JGEhHOwSkLa8Z/krRb/jm1vwk0xgicjqhI
	 EUDRO/4zf1cW/loQvUkmxQ9+goWzxDtP4yDGJwWmyIqbiDiLiQx/dnvw56MWzl3AQX
	 76p3QjvNmUJRuROd9WySSbhjBDyRmg6jyOm2DnxuJ+Gdhe5FOtAE3QssOw3kiN+Kqw
	 UXqDYHL0H8JaJ+Jjs5uXf9ivL5Y2FeYgLr1RaXslwy7jwey/V9Jjv9DlZY9dBUECxK
	 uXmanW53b1xnA==
Date: Sat, 26 Oct 2024 12:11:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 06/24] iio: accel: kxcjk-1013: Remove redundant
 =?UTF-8?B?ScKyQw==?= ID
Message-ID: <20241026121123.5463f021@jic23-huawei>
In-Reply-To: <20241024191200.229894-7-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-7-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 22:04:55 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The ACPI IDs are defined in the respective ID tables. Puting them
> to the I=C2=B2C ID legacy table has no meaning. Remove that ID.
>=20
> Fixes: 3bfa74f86006 ("iio:kxcjk-1013: Add support for SMO8500 device")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index bbf65fc97b08..2eec95d8defb 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1717,7 +1717,6 @@ static const struct i2c_device_id kxcjk1013_id[] =
=3D {
>  	{"kxtf9",     KXTF9},
>  	{"kx022-1020", KX0221020},
>  	{"kx023-1025", KX0231025},
> -	{"SMO8500",   KXCJ91008},
>  	{}
>  };
> =20



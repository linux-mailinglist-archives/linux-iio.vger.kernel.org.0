Return-Path: <linux-iio+bounces-22495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A4B1F5B9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DE43B4BBB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEFF278E42;
	Sat,  9 Aug 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm3dn7io"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F61D618C
	for <linux-iio@vger.kernel.org>; Sat,  9 Aug 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761761; cv=none; b=V7CIe/xE6k/CvSo/igpk7n2kzQW4+6BxEuByk5Xt372rHqzrPTqcfhULqcZD4+DcD0bye0BoNrPfjtDSgUFny7f8A9f4YD8jqpKE+irQ7GdM9+zNIjWT8tJMtLogv3Lb9UmSJl7iSNnhSCujWGTvTAPsZShuoFxK/UJ8cSBTekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761761; c=relaxed/simple;
	bh=+0eolhrmsOIvUOqM5tMnuLAVtEbaj4oYs0xtLVOHqR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzH3WCGCvrU3nsCHw6XImDITFta2XHn3HEWQHmAk0Y3iBvdweL8wFh9andkYlQC/7G+aabrduW4VfGQx8vjpdSW+3BX+86HHRUrHh43i4LIWpS1FccYBVte8QW+XvjM5zpPK+11jPaICTVSWRFHoGP4zQlxUtWnolX45rawoJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm3dn7io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCDDC4CEE7;
	Sat,  9 Aug 2025 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754761760;
	bh=+0eolhrmsOIvUOqM5tMnuLAVtEbaj4oYs0xtLVOHqR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pm3dn7ioHEQhHYWZ0FTp+XmAXRn+mIu2DuMIDcTYUDSxqSyaOfdvofW2KSAqrjD6X
	 +cMuxzVhCdbMs4I3kxODwQKxja5bEN6aE6f3npVO4NldR6wcngc6y+p/m2Ht08a6iW
	 1vz5HY7t3y/SfdIJaXJowHPUQDIb56SCKo6hjvmLCwSnwKyvU8aJpzUG8AKK8vJrqa
	 5CEyoGGMqEBkKgIzIYGTyFPAM3KXzwAvbsT/oAVHUVNjrNeB7Jtso5So66YzyKxdLX
	 OhqVqenfWwe4Wo14BMfT7sxkvkvr6VvJAq1d3pwMRJO0SfL+TifZ+KKQqTNSVPS2gd
	 p08YMOX0JFwqg==
Date: Sat, 9 Aug 2025 18:49:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: imu: adis16475: remove extra line
Message-ID: <20250809184913.4a1ec14d@jic23-huawei>
In-Reply-To: <20250808-adis15475-extraline-v1-1-e3259a466e95@analog.com>
References: <20250808-adis15475-extraline-v1-1-e3259a466e95@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Aug 2025 17:12:33 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Remove extra line before adis16475_probe().
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Normally we'd not bother with this sort of thing unless otherwise working
on the driver, but given it's you and you are very active in general, appli=
ed.

> ---
>  drivers/iio/imu/adis16475.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 924395b7e3b45dd3a6459d6eb788fa2ec86c4a29..ab39bea1e729ea8abb56dbbca=
3d5305dc1973083 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1930,7 +1930,6 @@ static int adis16475_config_irq_pin(struct adis1647=
5 *st)
>  	return 0;
>  }
> =20
> -
>  static int adis16475_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>=20
> ---
> base-commit: 6408dba154079656d069a6a25fb3a8954959474c
> change-id: 20250808-adis15475-extraline-534e5698f3a7
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20



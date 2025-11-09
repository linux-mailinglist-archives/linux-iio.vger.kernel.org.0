Return-Path: <linux-iio+bounces-26094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75DC44267
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E433AD0B6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C7303A38;
	Sun,  9 Nov 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI/hDStn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20192FFF94;
	Sun,  9 Nov 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705969; cv=none; b=qVXgXPfGupDqwmtg9lX3ttiNb32sfhkXB6gkCRFtrYXkT65Iw5c1bzUMr57oX6PQnFdYXyvkDgcOG1CAyizyJqRFvMIitykGMow1U4eE9bSS1+m4Tml4XNoV5V/meQ8Udl4Fe2OzYNfPOkM79aHy1lSJfFIibmFVqXEMp6z9Yc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705969; c=relaxed/simple;
	bh=IHSkKfxDXOEzAiJ4OsaBd2WyTY7cy0e4Eh42LB5ZmoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWlqL/z0OXF+P23uir6oL0PI38hKop8oTGEQk7Lrk3y3eTpyYw+2k0nNXPUwz9pUwL368SChOCt6bE9XQ2R8ngWBvV//DquCELLP/p4cVbPHlsVzOq5H7seghlPGbqopS8ZJ+1PLFqCGzG0Q8kB+Db8YHI2hNO/P2hM79WrLIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI/hDStn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE46C19421;
	Sun,  9 Nov 2025 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762705966;
	bh=IHSkKfxDXOEzAiJ4OsaBd2WyTY7cy0e4Eh42LB5ZmoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uI/hDStnZcwnLzT1SNes/yvlEkXW/iFFASTfmxxQaFDmRNmgtxMJJxFX1Ak479d8W
	 E8HgBfx9YeWP7iCyrET1GCrPMGCwzZUuRPLA8kmuFy04hVy2l39fcry8sLfJXb5NQD
	 VJVJgJPg9YpdUVV3HtYJzXqspjuxVOJNVfyq2rjY5TGhKo55+5i3tgemD3TmQwORIu
	 e0pVlOv3nxFEuZO/EZ/4nyXdkdTszV+NFYzorHeap45niJ6vqoEq74q981GoVbeHtf
	 UiZls4Zc9qWcMlR08hFpYyKpyw3lbViAsJsBaBJp4xNoJcMBxfMhGIhccb2wzV1hXX
	 F3hUNyNWcUB6w==
Date: Sun, 9 Nov 2025 16:32:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 12/12] iio: dac: ad5446: Add AD5542 to the spi id
 table
Message-ID: <20251109163239.5319293e@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-12-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-12-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:17 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> This adds support for the AD5542 single channel Current Source and
> Voltage Output DACs.
>=20
> It is similar to the AD5542A model so just use the same id.
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/ad5446-spi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad5446-spi.c b/drivers/iio/dac/ad5446-spi.c
> index 1a52f6014fad..487268d52ce2 100644
> --- a/drivers/iio/dac/ad5446-spi.c
> +++ b/drivers/iio/dac/ad5446-spi.c
> @@ -175,6 +175,7 @@ static const struct spi_device_id ad5446_spi_ids[] =
=3D {
>  	{"ad5453", (kernel_ulong_t)&ad5446_chip_info}, /* ad5453 is compatible =
to the ad5446 */
>  	{"ad5512a", (kernel_ulong_t)&ad5512a_chip_info},
>  	{"ad5541a", (kernel_ulong_t)&ad5541a_chip_info},
> +	{"ad5542", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542 a=
re compatible */
>  	{"ad5542a", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542a=
 are compatible */
>  	{"ad5543", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5543 a=
re compatible */
>  	{"ad5553", (kernel_ulong_t)&ad5553_chip_info},
> @@ -211,6 +212,7 @@ static const struct of_device_id ad5446_of_ids[] =3D {
>  	{ .compatible =3D "adi,ad5453", .data =3D &ad5446_chip_info },
>  	{ .compatible =3D "adi,ad5512a", .data =3D &ad5512a_chip_info },
>  	{ .compatible =3D "adi,ad5541a", .data =3D &ad5541a_chip_info },
> +	{ .compatible =3D "adi,ad5542", .data =3D &ad5541a_chip_info },
>  	{ .compatible =3D "adi,ad5542a", .data =3D &ad5541a_chip_info },
>  	{ .compatible =3D "adi,ad5543", .data =3D &ad5541a_chip_info },
>  	{ .compatible =3D "adi,ad5553", .data =3D &ad5553_chip_info },
>=20

Applied.


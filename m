Return-Path: <linux-iio+bounces-25009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE6DBD0A48
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE3C3BB7C6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295022ECD2E;
	Sun, 12 Oct 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDPpBt+b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A41A275;
	Sun, 12 Oct 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760295740; cv=none; b=PAJqARc87u8iPltMM0PShGtxL51wnvzQuTWgTJfJIZ2xL1tiQ2GZE2qo9z+ASDJxIvIwjADTDnViylU6uvuKfk+7W7TwgOZKWRDgjf+noSPEJnf/UGeToSA9wUBc2gyIZO94VOoV+Xqrl5YGWbHpW4R4cU1J4n7HezEpZwNOrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760295740; c=relaxed/simple;
	bh=T2d7uJPk5zDWBAlwmh0QUxrkKWoRtML4gbEucNeFsIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP6TgHkiJKMfeZDORHRsT2ob55gbfuaz+Ielb79E/CL/GUHH0IoGd+Oev0bWac6+NeURdAO2e/oVs6KI2aR7edt65PxbSgaRuefGNMjfA9PXunMmRFWalkaqr8ieZ+3Q7/SAxLgk9tFPdojUeHw9MxT+9P8Vi5Cz7n4tDVanZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDPpBt+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA45C4CEE7;
	Sun, 12 Oct 2025 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760295740;
	bh=T2d7uJPk5zDWBAlwmh0QUxrkKWoRtML4gbEucNeFsIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cDPpBt+bCtMeJ4arqW/DvhpHGMZb6nFtLSToteoLUjbniz/GOrIOj62plxvXFW2RJ
	 s3t23i6Z0iI75B3f5UrYMOnLfjB0kbq6RldcuvcLJaAN32mve6JEV1FCP6xmw+w4mu
	 gcUoOtjks5pQc6+yG/0zt2vWSR6gP2EgqLJypjnOTBKr0T7YwTu8qnLU9ifV8NWn3U
	 Hwgsm5cn9W8ZDNokPKLbQklbA5CSLAlYU+gvH3m69xdWUtPOrGefYG+aIp81NYsx9F
	 ssi36Uz/cdl3PolexNSVA3syEHRQPeSTMqat8jj+fUTPUF6SDrzYR77YLJooh+tpYC
	 HS99D73qfHC/g==
Date: Sun, 12 Oct 2025 20:02:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Kyungmin Park  <kyungmin.park@samsung.com>,
 Karol Wrona <k.wrona@samsung.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:common:ssp_sensors: Fix an error handling path
 ssp_probe()
Message-ID: <20251012200211.19170a6f@jic23-huawei>
In-Reply-To: <3e91c2a282499f862ed7d27842d5bc2ee461ebf8.camel@gmail.com>
References: <6fdd39e3763a6e0e700982ac6ed63a5748a4ce67.1760122717.git.christophe.jaillet@wanadoo.fr>
	<3e91c2a282499f862ed7d27842d5bc2ee461ebf8.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 19:56:41 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-10-10 at 20:58 +0200, Christophe JAILLET wrote:
> > If an error occurs after a successful mfd_add_devices() call, it should=
 be
> > undone by a corresponding mfd_remove_devices() call, as already done in=
 the
> > remove function.
> >=20
> > Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to my temporary fixes branch (I'll rebase on rc1) and marked
for stable.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/common/ssp_sensors/ssp_dev.c | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c
> > b/drivers/iio/common/ssp_sensors/ssp_dev.c
> > index 1e167dc673ca..da09c9f3ceb6 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> > @@ -503,7 +503,7 @@ static int ssp_probe(struct spi_device *spi)
> > =C2=A0	ret =3D spi_setup(spi);
> > =C2=A0	if (ret < 0) {
> > =C2=A0		dev_err(&spi->dev, "Failed to setup spi\n");
> > -		return ret;
> > +		goto err_setup_spi;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	data->fw_dl_state =3D SSP_FW_DL_STATE_NONE;
> > @@ -568,6 +568,8 @@ static int ssp_probe(struct spi_device *spi)
> > =C2=A0err_setup_irq:
> > =C2=A0	mutex_destroy(&data->pending_lock);
> > =C2=A0	mutex_destroy(&data->comm_lock);
> > +err_setup_spi:
> > +	mfd_remove_devices(&spi->dev);
> > =C2=A0
> > =C2=A0	dev_err(&spi->dev, "Probe failed!\n");
> > =C2=A0 =20



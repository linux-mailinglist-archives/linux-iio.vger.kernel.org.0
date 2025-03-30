Return-Path: <linux-iio+bounces-17378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372CEA75B93
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932333A4BAF
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB31D7998;
	Sun, 30 Mar 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzD1Q+yF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212A3EA83;
	Sun, 30 Mar 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743357377; cv=none; b=Kh5lTq42zP7rcA+yavhDXXnJFuFquB77M04eHOLwJdWuTw2I5ki+AehVLMeUD/EHNrrEFXX644hcRfRsfKDMZO0azHDNhZ8pJmbRZF3XG7kSP3/BFXGmD3/Xktm5U6aViXIJLKiW+K/XHIUGQjCqaoJ1j4m8Q7WJ6+iz08y8f1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743357377; c=relaxed/simple;
	bh=z2UZratQ5PAPn87t0I365fTNgSBXoVi6zUXa/d9LnJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEyTeTrd+me1K5D5YFjQ/bd36/gQj5ybZ+LFCf6QLjuFUkDOv603xNn74xinb01bLwozr26OhaCrn1XC3EnHhVhaia69uXmeGBh6FovO1kcg65imT0HUQFiohHZhWoGxDBOSGnTMJOmY2uXAljawR0VPyvRTM9vJNTbxQ5wslZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzD1Q+yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A0C4CEDD;
	Sun, 30 Mar 2025 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743357376;
	bh=z2UZratQ5PAPn87t0I365fTNgSBXoVi6zUXa/d9LnJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzD1Q+yFMvI9ioTvba7VuX2HKa45xdeGCRc2WfClUmm/tU6B6p8ZQPei3biXlIckX
	 qK3rFHrQSnjobiPSp45+efXrTjUNtvXwp4wz+vd+NN/KJzon3wkOv+mp4sJXUl1kOD
	 ehQCPV8XDkyu+N+K/q3EgClRwl2vyN2N5xmsB5BRk7MqMbSrg2fyga5UDmqB8bigmn
	 xczGJF1lpM+Pnj+fGRV+3iH8E7mCFLBglxUEmNDwRgltxvCBElupLxrPZov7uUcn4o
	 ixgQRBi4DIAO1D295GmDaiJfKTKBDBcJCnLVXMPyyFTMgk292S+kTe6LUZDIVNNkgZ
	 JRDnyxXpUX9xQ==
Date: Sun, 30 Mar 2025 18:56:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 01/10] iio: adc: ad7606: check for NULL before
 calling sw_mode_config()
Message-ID: <20250330185608.20a4899a@jic23-huawei>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-1-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
	<20250318-iio-adc-ad7606-improvements-v2-1-4b605427774c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 17:52:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Check that the sw_mode_config function pointer is not NULL before
> calling it. Not all buses define this callback, which resulted in a NULL
> pointer dereference.
>=20
> Fixes: e571c1902116 ("iio: adc: ad7606: move scale_setup as function poin=
ter on chip-info")
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to my temporary fixes-togreg-testing branch. I'll rebase that once
Greg's pull request has been taken by Linus.

> ---
>  drivers/iio/adc/ad7606.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 1a314fddd7eb987b52016ce7242b446677f66427..703556eb7257ea0647135c4b2=
68a8ead93115c6f 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1236,9 +1236,11 @@ static int ad7616_sw_mode_setup(struct iio_dev *in=
dio_dev)
>  	st->write_scale =3D ad7616_write_scale_sw;
>  	st->write_os =3D &ad7616_write_os_sw;
> =20
> -	ret =3D st->bops->sw_mode_config(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (st->bops->sw_mode_config) {
> +		ret =3D st->bops->sw_mode_config(indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	/* Activate Burst mode and SEQEN MODE */
>  	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
> @@ -1268,6 +1270,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *in=
dio_dev)
>  	st->write_scale =3D ad7606_write_scale_sw;
>  	st->write_os =3D &ad7606_write_os_sw;
> =20
> +	if (!st->bops->sw_mode_config)
> +		return 0;
> +
>  	return st->bops->sw_mode_config(indio_dev);
>  }
> =20
>=20



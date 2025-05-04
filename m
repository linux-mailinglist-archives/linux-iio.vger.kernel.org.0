Return-Path: <linux-iio+bounces-19064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC63AA88BC
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2BD3AF40C
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045E7221545;
	Sun,  4 May 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noZbrPfh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEE1DC9AF;
	Sun,  4 May 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380699; cv=none; b=GmKcSBe8ZZCNS5AK6XZAxMPEkbQB27KRM1xyfLq21eJPWSiYyRahRLZ1g6zJecq//QjO++C7gXU2IcLwxoaQy9FtssC/wcygvDFwCWFnNT2FwcLsk30LhTQmHK0wsL/NgYFN4FvnOUrWRop4Kgrf7GttTHUBMPSwrDErjMPQVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380699; c=relaxed/simple;
	bh=nZfJYEjCOqtdSARcr3q0IVB+SSd9cNY36FDKHmmgmAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJCRBQe83IQSpQO9Qa7lZ3II98nEIx4REEyjwX54HfKlf/Z8rIsV/baVaOjRTDvgbEJpVALwcmzkT5WyVjo93Lwozxcf7M0Q2jdR3yTfyqMK6HrsROWHK5RXhc2RuV77GhNDBd/JbGc+wV7z6gUJVvuXiSEIwO5dfDWF5lLw0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noZbrPfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A05C4CEE7;
	Sun,  4 May 2025 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746380699;
	bh=nZfJYEjCOqtdSARcr3q0IVB+SSd9cNY36FDKHmmgmAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=noZbrPfhJgr7J9NO5kQmLnfIldUfedkzM8CbHLr4VQARNDPg3vr9ecpYWI4JJoiSX
	 PcoyCYpXIc3sp+MTKyA74tNlfmSM5MueBXMvNWvGJ9/hGaFbTrjELTQeJQ/LcQxFU/
	 aHuPdaOCTG3g4nEZtVPkmPcJiQeoePJT2FDCY21sMlSbKEbF4Xp7MgPKMxeRxEkqdo
	 zrjFOUtCHW7QGuDsZb0a0m5jg3cWu22w2c/Odu6j5h95/V3fIKG+lyYTyk/KdTAzQR
	 NJV8f7/Tv9agITHFgcvTYSSQVyfsuePZSfWoug7vFhLSLSeEfjfYhn/2hrY7m1BOJ7
	 vVLdevB1ewenQ==
Date: Sun, 4 May 2025 18:44:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 6/7] iio: adc: ad4170: Add support for internal
 temperature sensor
Message-ID: <20250504184448.43b8045e@jic23-huawei>
In-Reply-To: <c249f5c7ee07583b65cd40b0fc6f1faa79c3bfe9.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
	<c249f5c7ee07583b65cd40b0fc6f1faa79c3bfe9.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 09:29:12 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The AD4170 has an internal temperature sensor that can be read using the
> ADC. Whenever possible, configure an IIO channel to provide the chip's
> temperature.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

One trivial comment below.
I don't mind that much given you already did it this way though.

>  /*
>   * Receives the number of a multiplexed AD4170 input (ain_n), and stores=
 the
>   * voltage (in =C2=B5V) of the specified input into ain_voltage. If the =
input number
> @@ -1189,9 +1210,27 @@ static int ad4170_read_raw(struct iio_dev *indio_d=
ev,
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> -		*val =3D chan_info->scale_tbl[pga][0];
> -		*val2 =3D chan_info->scale_tbl[pga][1];
> -		return IIO_VAL_INT_PLUS_NANO;
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:

When you know you are going to have changes like this in later patches
in the same posted series it is fine to make the diff smaller by
using a switch from the start.

Occasionally you'll get a comment from someone like me who can't
hold the whole set in my head and misses that is what is going on.
Just reply to say it was diff minimization and likely no one will ever
mind!

> +			*val =3D chan_info->scale_tbl[pga][0];
> +			*val2 =3D chan_info->scale_tbl[pga][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +
> +		case IIO_TEMP:
> +			/*
> +			 * The scale_tbl converts output codes to mV units so
> +			 * multiply by MILLI to make the factor convert to =C2=B5V.
> +			 * Then, apply the temperature sensor change sensitivity
> +			 * of 477 =CE=BCV/K. Finally, multiply the result by MILLI
> +			 * again to comply with milli degrees Celsius IIO ABI.
> +			 */
> +			*val =3D 0;
> +			*val2 =3D DIV_ROUND_CLOSEST(chan_info->scale_tbl[pga][1] * MILLI,
> +						  477) * MILLI;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}



Return-Path: <linux-iio+bounces-18863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D0AA169F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CB117480D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F52528FC;
	Tue, 29 Apr 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrJznZZb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163351C6B4;
	Tue, 29 Apr 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948160; cv=none; b=QA/NoDzSTcM87ORXUqAcPiHrBga2sbdWfmplM7WqmYKe/4xswSiTedRZLWU0nYVaj2LJwqszNicMd1GJYJje8DcCclVCCTILMYtwFC5xb0Yn9CTkZRtZJrLMyy2oO1u0/pjniRw09BmyzwX9NjfETFlzbKfRT6VP0pd9y2eH44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948160; c=relaxed/simple;
	bh=EuiTY7wVzUPlxKWHnvDSpAAOtakCrEzIVRnNO3fVHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/hfxr5pHC02oI/cMNTs00tu4CMcoLfaArGT0OnmhLyllyF5mRK+wzcgQNWFLcmrtPHoSSmDh/prOaHIfcXTzwpEhuE2u/B/PmRhvtYoD0ZV7o/aj2smJV3v8oAlzNRH7L8zaIcOWwvxXFlsjX5qyj5yuZo7W1HB7jQwfF0ZHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrJznZZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71892C4CEEE;
	Tue, 29 Apr 2025 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745948159;
	bh=EuiTY7wVzUPlxKWHnvDSpAAOtakCrEzIVRnNO3fVHLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrJznZZbFIABkFjxemjdAK499Saz+ZH1WNC/vqvomSD9v1/pFX8fu3Sc7+BxG2leq
	 lHqAMUwbKLtPbhCMvpyAVa3CL1nIrnhCdUuSDvd2h8eyTy0d09E6cECM9a2cFRBuNC
	 /y4It7pqho4gspsaoityyYTaogDDkGNc3gGcqzgnOokO2poBWl/wHz+Rd9C1tC6czl
	 vt1V0MnijZoh20PybxilY/AhrKS9+vDE3BVp5iqv6/rTXAqhDZgMnajAGF1KjA0rIX
	 7QuljdUdvFZ7Fz/D35wRSIkEAiBck/w7kmInRAnAIBNGpVTJAObhf6cgrz/ZnAgmmk
	 Co7PdLszzW1pA==
Date: Tue, 29 Apr 2025 18:35:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: max1363: Reorder max11607_mode_list[]
Message-ID: <20250429183552.6a87e4cb@jic23-huawei>
In-Reply-To: <20250429150213.2953747-2-festevam@gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429150213.2953747-2-festevam@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Apr 2025 12:02:13 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> The IIO core emits warnings when a scan mask is a subset of a previous one
> in the available_scan_masks array.=20
>=20
> In the current max11607_mode_list[], the s0to3 mode (channels 0=E2=80=933,
> mask 0xF) precedes the s2to3 mode (channels 2=E2=80=933, mask 0xC). Since=
 0xC is a
> subset of 0xF, the following warning is triggered:
>=20
> max1363 1-0064: Mask 7 (0xc) is a subset of mask 6 (0xf) and will be igno=
red
>=20
> Reordering the max11607_mode_list[] to place s0to3 after s2to3 ensures th=
at
> more specific scan modes are listed before broader ones, preventing such
> warnings.=E2=80=8B
>=20
> This change improves clarity and avoids unnecessary warnings during device
> initialization.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

There are others in there that are out of order...
max1238_mode_list[] for example looks to be as s6to7 should be before s0to7
(there are more issues with that one).

Would you mind taking a quick look at all those others as I'd like
one fix for all of them if possible?

Thanks,

Jonathan



> ---
>  drivers/iio/adc/max1363.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index d0c6e94f7204..e8eeb00bef7b 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -577,8 +577,8 @@ static const struct iio_chan_spec max1238_channels[] =
=3D MAX1363_12X_CHANS(12);
> =20
>  static const enum max1363_modes max11607_mode_list[] =3D {
>  	_s0, _s1, _s2, _s3,
> -	s0to1, s0to2, s0to3,
> -	s2to3,
> +	s0to1, s0to2, s2to3,
> +	s0to3,
>  	d0m1, d2m3, d1m0, d3m2,
>  	d0m1to2m3, d1m0to3m2,
>  };



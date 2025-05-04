Return-Path: <linux-iio+bounces-19041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6FAA873E
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A87A8AB9
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE91D5166;
	Sun,  4 May 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8xOtQT+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E17DA73;
	Sun,  4 May 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746372128; cv=none; b=cVvI8rPt6OuD9YjGDCxmzER3QpM7Ha8x9RsBRHGCVD+KoPP++MeYgGFIq+qx6pVwZV60/LpSMv8oiv9m2vf2AyAkmsT+fHFsSgzqhANWy7ZqiS7KF0hhq+b9U1EIWjD3FtZ5kuf4McOuUtBEYYteY8y5qWdkBrwWM0Gx5iB2HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746372128; c=relaxed/simple;
	bh=AEkzEBU3143KxzQbR7rAGVWLfe3ey5sdykehyg1ERvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oD9ud6hoXY1p774kl61vx4r4Azoa8b7Z+QCUFBBcWcIcnh4NWpEAu+T0Tfhd/ubPRO0w+Os/8Q2Kpuxj28xoT1G6lH3b87G4T4p9kEVElMmxyp9BaxLrGsbq5pZv3mwbGYMUWsLNZjedWIu1BvViG/JCUhTu70GvSZCcwBBe6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8xOtQT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6255CC4CEE7;
	Sun,  4 May 2025 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746372128;
	bh=AEkzEBU3143KxzQbR7rAGVWLfe3ey5sdykehyg1ERvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8xOtQT+fGEkXaLF+zlgPeq9Otnh2cqJqICP2RVuVxfcXg95ddn6hQ/10K24/GTV9
	 54f97J7rPdzT8YZLP5c8z3YTWf0n4UuMK27zn85nnfwdAtmNDy+e2oH2TLDdDgYZ5X
	 FnfvUdqCq+7xEzhQr2TpKav11z1TxpAU2wlr0Q5a4CutSHFGumfWTkd4RQKHJp2tO3
	 jc+NqhV9WADyBtcZPuNvbdxF26ruoF9aRtp3pWox7lm/RCp/5iCfHaZunb+b7SZnBm
	 BBdjNl6Iiq6RK4AyV+JIVvSE7Hp5TNO9T/jKNhLl58tSWljmteHE2OvNBG9GRVuuNz
	 qGF0H5NVmBfPQ==
Date: Sun, 4 May 2025 16:21:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <20250504162158.7f89d76f@jic23-huawei>
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
	<20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 May 2025 15:27:00 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add support for offset and phase calibration, only for
> devices that support software mode, that are:
>=20
> ad7606b
> ad7606c-16
> ad7606c-18
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

One trivial typo.

> +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int v=
al,
> +				  int val2)
> +{
> +	int wreg, start_ns, step_ns, stop_ns;
> +
> +	if (val !=3D 0)
> +		return -EINVAL;
> +
> +	start_ns =3D st->chip_info->calib_phase_avail[0][1];
> +	step_ns =3D st->chip_info->calib_phase_avail[1][1];
> +	stop_ns =3D st->chip_info->calib_phase_avail[2][1];
> +
> +	/*
> +	 * ad7606b: phase dielay from 0 to 318.75 =CE=BCs in steps of 1.25 =CE=
=BCs.

Spell check. delay



> +	 * ad7606c-16/18: phase delay from 0 =C2=B5s to 255 =C2=B5s in steps of=
 1 =C2=B5s.
> +	 */


Return-Path: <linux-iio+bounces-20074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF74AC9BA4
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A601659B7
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69115B115;
	Sat, 31 May 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prg4Dp2v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0279A17E0;
	Sat, 31 May 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707766; cv=none; b=lzyFGqRsXEoGMDxV1KGT6mq4DKUjPzBfpIai8YutmdH6aHHVymv3h+Q8F12JH/QhAfXEag9JVRxRRyaLiVMi4yAVXejK3H75up1Ddae+s3D4jCLYmHJrbwywV7/QAdiPw34CC6AIVLDkHiVB9Wfazt0BL587GaFZBxodAMmEYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707766; c=relaxed/simple;
	bh=65lTG7OakIavgaG/FQQzB/iJVoTPCcemuDT8rAnL5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/UG0l91ZUkzyfBeR3Gabscv0LsbSIpc4hn8FCHFa0QRlVj/lhyeys1X9znXY1tvggBdC1yl2n465cj6gkjIJ5LSMLd8TYZ/Dbe5Ko9ABpRbCglfY+GwdbJfaz5HlCJSQ8f8lPdgWxzrfOgjnuBEStq/NUxzYlgmcXlAgoniMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prg4Dp2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37027C4CEE3;
	Sat, 31 May 2025 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748707765;
	bh=65lTG7OakIavgaG/FQQzB/iJVoTPCcemuDT8rAnL5KI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Prg4Dp2vuL6U3ibgpHcWV5PSEYg/8SgVec1MsB6MMQ+h1fjDqjt66SyedBZ+LK+A6
	 1EjgVH5gQsZ61qkYv8xN/+fyMY65Q7nHnWypJRA0BzQz4cmVpPU7yYxTrjt/sSKT1j
	 0H3z00II3RSw/wlJpVL1loKaiBZ3feHkyb0JuKrBHaSru7zpOlD3rapWimtxA1yfbE
	 xPms1W3ztvNYRyJLeZua9YWf6aeJGhdDcMN3OEJrQKwSKCg/TIx8YLPPjaRQxpyEq9
	 S9hDl/Hh75g5hCR72TcyD18Ius9OL1ke16c/JfeBPNPSJM/hZj5JvN1kaddMk39NMs
	 MKy6hpLiAK1aQ==
Date: Sat, 31 May 2025 17:09:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <20250531170917.56210a5c@jic23-huawei>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-3-b487022ce199@baylibre.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
	<20250526-wip-bl-ad7606-calibration-v7-3-b487022ce199@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 12:03:18 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add support for offset and phase calibration, only for
> devices that support software mode, that are:

Really trivial but wrap nearer 75 chars.

>=20
> ad7606b
> ad7606c-16
> ad7606c-18
>=20
> Tested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>




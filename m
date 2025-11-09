Return-Path: <linux-iio+bounces-26085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F73C441E3
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A96D3AA968
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383F32FFF9A;
	Sun,  9 Nov 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOfqN4pD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D02FB097;
	Sun,  9 Nov 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704364; cv=none; b=TOTEm4SuLvWQcmIp+rYSWJECDJmstz+ibIc7bOBs4Ie5PUTw32/2+at+8TiUFUct2+96kATWC85vugzIoQIeCMJI9mA2XzDusgyW7pp1EiRTYycgxt8XWG9Or2aK0uQ+3o3vcvmWH/+lBev6aVqCG85N154yQrnkV/iaNFHCJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704364; c=relaxed/simple;
	bh=2/PBE+Jvd0Ocvid7j1XEbUJpOlkPnx/8SyKpguoyaI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPPtPGnCBWNGRVzmQJcQ44/hCy0a/2Nvi6k+jVNmyXrphstOz5ttBuAhDIfsE8TbLWYaiXtXDWm0htnlwVjNjDj2EHXFi/mRfeYpNcIbXWAMSIgIgnjI2yE6jARtosYbhjK6QkdfBb3q/6M73T0STcxlUMOXmlkzlSkfI7544Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOfqN4pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8E5C19422;
	Sun,  9 Nov 2025 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704363;
	bh=2/PBE+Jvd0Ocvid7j1XEbUJpOlkPnx/8SyKpguoyaI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AOfqN4pDcEDwTSpL2LHtEd/XuBRRGXUgjNpGWSKsTq/HCsMVVaQ7bVQELv93psPix
	 jZdrCTXZzs9a76M08kk+Kvmhzz8h+ViWBPKjsZ1vWz0oT51cMcehT8/2V5roAhOCrU
	 LIE1ASYMYOiBUsOZvngsrZ/jpCCGwAcADommkqXbNIivf+e2iYR+2KezH2TE6piDvC
	 osB3jCkLJOdnLi2mAr6BpcCuIIIHO9LRRmtGyZ3eSNzvPl/JRa099QJhp6ffOgrnXM
	 RrFe73vVCHm4oAIDvQiYDFI8qbhDx8RaDtSPStLVgZPWLZs6xRDmdmBqgmWcX/DQsb
	 p2rFDaKU84NMw==
Date: Sun, 9 Nov 2025 16:05:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 04/12] iio: dac: ad5446: Don't ignore missing
 regulator
Message-ID: <20251109160556.2e2e9bbc@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-4-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-4-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:09 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> If the chip does not have an internal reference, do not ignore a missing
> regulator as we won't be able to actually provide a proper scale for the
> DAC. Since it's now seen as an error, flip the if() logic so errors are
> treated first (which is the typical pattern).
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
> ---
>  drivers/iio/dac/ad5446.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index c0a38f642451..cbe2a6862f10 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -253,10 +253,11 @@ static int ad5446_probe(struct device *dev, const c=
har *name,
>  	if (ret < 0 && ret !=3D -ENODEV)
>  		return ret;
>  	if (ret =3D=3D -ENODEV) {
> -		if (chip_info->int_vref_mv)
> -			st->vref_mv =3D chip_info->int_vref_mv;
> -		else
> -			dev_warn(dev, "reference voltage unspecified\n");
> +		if (!chip_info->int_vref_mv)
> +			return dev_err_probe(dev, ret,
> +					     "reference voltage unspecified\n");
> +
> +		st->vref_mv =3D chip_info->int_vref_mv;
>  	} else {
>  		st->vref_mv =3D ret / 1000;
>  	}
>=20



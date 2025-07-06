Return-Path: <linux-iio+bounces-21392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71434AFA489
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998E67A6810
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438A202963;
	Sun,  6 Jul 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD6sbyev"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3620299E;
	Sun,  6 Jul 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751798704; cv=none; b=MXFHeUQbUd9zLHVc6GPLT7kt4/d8PuSmH6U0P82E6VqcKVRLKBcJEXeDfluJaFf6TKxBUuFO+wNjfwjzxf8wIoV3nd13ZZkXxWmHraDbVwRSBwTmVxAzb9ESC5DoWzTJN9CSyuGjlr654AK7T3pcaCT6WGhGtxroNjosV2t39X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751798704; c=relaxed/simple;
	bh=relSNinZmZOhsw3SUrIKIcecYWDMki2gp5tmi3W3ukw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHYVVp02OZTL9XmNp8xepDXgKHn89ETjoug5H/nWTW7c8dOddR+iSYYlCgvR0rOeU3PXa9oweJKFNQzP/JOFUcB0GKUld5iQQfKj4rvANmqbwCKxarXIqFVSQKYHtO4Ijvh9r6gE2mFXVhK0lWTlFu8RJvvhSqn6h1tlAYNrDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD6sbyev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1983CC4CEED;
	Sun,  6 Jul 2025 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751798703;
	bh=relSNinZmZOhsw3SUrIKIcecYWDMki2gp5tmi3W3ukw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZD6sbyevNQWtttBPqjhEmI+oJWV/FQ7TsYfcJppRl85pe0PAb7wpjQkzoBBol/Zvl
	 3msv5fbaGw+TraDwcmPtAhuDsv/lL++0tL2w8laWmOwCYQHAxm9RQ1QEqK581SECz7
	 Vh+1rGdqqbtO/f/WPMc7vfZHzXjVeEXP1JACBt7HGNrxQJow15n/63pj9w4QbxPkyI
	 Np06V1hjKl7MPqukKPMIczLAv5NcCu8ZCUHt/1ChaEGo/fQN008wV5tJsz807jaeQG
	 xN46KtMLN0WBFd70DLbE72QW0bYk/uuOArm6U7LzrDrbOagPT37HemtrIrUKiv5VL+
	 3V1G5ZnZT4gRQ==
Date: Sun, 6 Jul 2025 11:44:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 0/6] iio: Add support for MT6363/6373 Auxiliary ADC
Message-ID: <20250706114455.26748e20@jic23-huawei>
In-Reply-To: <ab0a407412c705e409d9d26591543713a092c13f.camel@gmail.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
	<ab0a407412c705e409d9d26591543713a092c13f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Jul 2025 13:39:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-07-03 at 16:11 +0200, AngeloGioacchino Del Regno wrote:
> > Changes in v2:
> > =C2=A0- Added error checks to all regmap r/w operations
> > =C2=A0- Moved adc_vref addition to different commit
> > =C2=A0- Various other fixes
> >=20
> > This series adds support for the Auxiliary ADC IP found on the new
> > MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
> > the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone SoC.
> >=20
> > AngeloGioacchino Del Regno (6):
> > =C2=A0 dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
> > =C2=A0 dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
> > =C2=A0 iio: adc: mt6359: Add ready register index and mask to channel d=
ata
> > =C2=A0 iio: adc: mt6359: Move reference voltage to platform data
> > =C2=A0 iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
> > =C2=A0 iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC
> >=20
> > =C2=A0.../iio/adc/mediatek,mt6359-auxadc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0drivers/iio/adc/mt6359-auxadc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 440 +++++++++++++++---
> > =C2=A0.../iio/adc/mediatek,mt6363-auxadc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 +
> > =C2=A0.../iio/adc/mediatek,mt6373-auxadc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
> > =C2=A04 files changed, 416 insertions(+), 69 deletions(-)
> > =C2=A0create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-au=
xadc.h
> > =C2=A0create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-au=
xadc.h =20
>=20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied to the togreg branch of iio.git.  Initially pushed out as testing
for 0-day to take a first look and see if we missed anything.
Jonathan



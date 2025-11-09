Return-Path: <linux-iio+bounces-26083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E3C441D7
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8E4A4E59D7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530012FFDC2;
	Sun,  9 Nov 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdUmbDKK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CD2FB097;
	Sun,  9 Nov 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704324; cv=none; b=EufFj4rJ5Qaxp2cczX+d5KrOx2Dq06Eb2369lTGU3Vy+CvF7gopziylS2nLc4WdmljdxlscAHcm8a9chKbmHcffrEs+QO8ylYGTKc/loCZH7ZLxwEOf1c+dQzQs7hMGrXyxsEZOg9rLoFC/5M4DPFbXsHTaLRBhdXwlwCUeAlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704324; c=relaxed/simple;
	bh=TCn9WsWWIpQqxBZ3ubi3zq50LUv1NLetYm3Tss9DFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjZQCEfhZNaHhMlqJSJjd2M8alV0t3JH5Q1QXptPHX6QF8LCBLndaqHPBuQzQ5zMn2mAPS9qv/DcMwzOarKAsmORAYOu0DBCUT3AArGuJfGIg3sHG+35MmRWpwAUyzJX1Uro9OxxNJ7Pux2Q8/fvOpeY9Xn7Ua81VwKK76Ule+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdUmbDKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB65BC19421;
	Sun,  9 Nov 2025 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704322;
	bh=TCn9WsWWIpQqxBZ3ubi3zq50LUv1NLetYm3Tss9DFAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdUmbDKKFHqIdcrWpg+f4f7chz7ODnTfSFGJaRIPE9y268QPL6/g8JRm+Sw2CdR3w
	 HLunNKUpsD4oalrYTEBcEiW3AOcloUpkW0FHfC8h4VNq8ASUly1z7vrpQvHswsDz7h
	 dkrAeFV6kyaooEfWAu8NoWU9ZFgVr8JZnT83WUQogku5IZkr3wYGjURUFtExA6iyRK
	 n/D6PAhiSw5e0Sewje9aBNr8geNnBpASULzJhMI9XDDOz9I1tjDzeUIfYFjuIjgDu8
	 NHw6jBYtglJBHChcvREb31wZ5+/rFNCeiW+08gzAdsXMnAkYAU5RMc+b79NIygeSjQ
	 WG/2z/NLAUG5A==
Date: Sun, 9 Nov 2025 16:05:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 01/12] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251109160514.2e21c687@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:06 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Add device tree binding documentation for the Analog Devices AD5446
> family of Digital-to-Analog Converters and derivative devices from
> Texas Instruments. There's both SPI and I2C interfaces and feature
> resolutions ranging from 8-bit to 16-bit.
>=20
> The binding covers 29 derivatives devices including the AD5446 series,
> AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
> and TI DAC081s101/DAC101s101/DAC121s101 devices.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
Applied.


Return-Path: <linux-iio+bounces-14814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B76A2494B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F0818871D0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D751ADC8B;
	Sat,  1 Feb 2025 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX0I9L1j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8552C9A;
	Sat,  1 Feb 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738415274; cv=none; b=Nm4KQTyB6Mimx4Vas6A8GfymYdj3Nbmghg23wAG2pGUCSS9uyBURV3lCRxXa5CLnlY66Z51NL/ZXls+DTKtrCRvcktN6ew6Pv0ymdQ5aTzDMyBBvY2zMEPH36aAewgkz1rTi2FlYZnlVJqD4RWKmG6swqFxAjC4E2gz3WQ2QJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738415274; c=relaxed/simple;
	bh=3c7EcwI17Vg+HCQNijPdYh0mZTvVumFobex0FajJWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1ZTVtq6m36j13i9CvVVED0tdAIBePnXluvFeDEVP+thMz2yL38wxL3INEFqoIOjbLSvwuwssI1qIBNfhZudtAoSOnoqFgdXZUHlgPYEuostacwQHFESytL9lUgnfPOBLhvk9nPzYULexoAVISA+4yFYl5wYG10fuEWJSyFRuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX0I9L1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0C9C4CED3;
	Sat,  1 Feb 2025 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738415273;
	bh=3c7EcwI17Vg+HCQNijPdYh0mZTvVumFobex0FajJWqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VX0I9L1jxycCbH8JMonWKlTJfoTJ7saOW9Lr528nxgWl35aTa0dQA82BLOW3r5dRq
	 OwrEFGtYXD7x9BbUulwre7SqX2mUdqkSIT4Se3QbxMm1+vgXrAGcnfl0Srw+sTeScl
	 o565Z0dxpbDo+7cHso8ugvRhb6mInn3+P8HuUe4pHQ4UE+K2N4ozr6qKSWtuEhKj67
	 xgiDtmUBefxUW//Jy/wVV4T5Uy7y2QVPJwTrpLhCljfmoCDvfwgRMAfpBwLdhW+JnY
	 a9nPtcuautxLf01WOa3rM0LYWxc46hvS4VPOklEG0c+dERwuE8CJtVaX1Zngnl8C65
	 /qepJEiUHBggA==
Date: Sat, 1 Feb 2025 13:07:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandru
 Ardelean <aardelean@baylibre.com>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guillaume Stols
 <gstols@baylibre.com>
Subject: Re: [PATCH v3 07/10] iio: adc: adi-axi-adc: add support for AD7606
 register writing
Message-ID: <20250201130743.5ac0b86d@jic23-huawei>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-7-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
	<20250129-wip-bl-ad7606_add_backend_sw_mode-v3-7-c3aec77c0ab7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> +static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 buf;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/*
> +	 * The address is written on the highest weight byte, and the MSB set
> +	 * at 1 indicates a read operation.
> +	 */
> +	buf = FIELD_PREP(ADI_AXI_REG_ADDRESS_MASK, reg) | ADI_AXI_REG_READ_BIT;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +	axi_adc_raw_read(back, val, 4);

sizeof(*val)

> +
> +	/* Write 0x0 on the bus to get back to ADC mode */
> +	buf = 0;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +	return 0;
> +}




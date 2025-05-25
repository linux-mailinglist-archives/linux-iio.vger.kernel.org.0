Return-Path: <linux-iio+bounces-19895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67495AC350C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AAB188D073
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C711F461A;
	Sun, 25 May 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciOSXdcN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B91F1932;
	Sun, 25 May 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748181901; cv=none; b=SlaQxdlpH+LlPsGTxvLEhsZJJCEhKhhL7SFexQf593FOSpuAcwiJP2cexUH+j1R1SPdSBxlHD3hQOJgcWuGjBP1KkLZi9rS5ayOXNk8al9dfZI1e8mdX6D+3By/kCykWmH/pOM7UkBfmMpZ0M9CAqkO3OStgLVtt2RXYNYQzgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748181901; c=relaxed/simple;
	bh=xMa5PC1je1qkO3Hj32MvdEpsG9wNtaG0UU8XyLz1EUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlMPCmkUnHdXCsQyn4u5sYU8uNKccIGg/AmUeE0vUa8twQREsv+gmF/z5U+2fqD4Mu5/9r0M6OrEeGXwUCS27AUYxC1fADTteQcgTBUI5xHxNHKpeN45wbjwV6k19AjkS52k1ssRYFSk1paxSkbG6QAAadfxkl90POp4NzN2K4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciOSXdcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4909C4CEEA;
	Sun, 25 May 2025 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748181900;
	bh=xMa5PC1je1qkO3Hj32MvdEpsG9wNtaG0UU8XyLz1EUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ciOSXdcN9N1O51EqxJ3Wzj4qSCjvwmNk4VFz97c0wE7EOnRU3row6gb4f/jJV9Wuj
	 mkk3PYKCNtvAjXNgPkjdNZB9ImEkt1BPYyInmw2tXAUjRUapjtvm7V2Ob1t97Cd7OS
	 Lwb1hsOPkNeGYFhv2cgbD5NYFmFQPXbmT29GpDNG5BdHSMuxERiO0l6JZjfJDZwoTM
	 ZWApZOA2xN0PAwJJ886UM7I3lOZ+0HnrrrogaNI0K8jgprjYxBd0Epr19s2704yq61
	 PJVftZsXW0/Q75lEVADjc+KsL6lGkM2hpx0/kkIcgPBzqxE+6p+mVysqK8Ud2wRGlt
	 9AJqudYVwMOww==
Date: Sun, 25 May 2025 15:04:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 6/6] iio: adc: ad7606: add gain calibration support
Message-ID: <20250525150452.6638a917@jic23-huawei>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-6-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
	<20250522-wip-bl-ad7606-calibration-v6-6-487b90433da0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 May 2025 15:27:07 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
>=20
> Usage example in the fdt yaml documentation.
>=20
> Tested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

A few minor things inline.

> @@ -355,6 +363,46 @@ static int ad7606_get_chan_config(struct iio_dev *in=
dio_dev, int ch,
>  	return 0;
>  }
> =20
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned int num_channels =3D st->chip_info->num_adc_channels;
> +	struct device *dev =3D st->dev;
> +	int ret;
> +
> +	/*
> +	 * This function is called once, and parses all the channel nodes,
> +	 * so continuing on next channel node on errors, informing of them.

This doesn't seem correct any more as we don't continue on error with excep=
tion
of ones around the optional rfilter-ohms value.

> +	 */
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 reg, r_gain;
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return ret;
> +
> +		/* Chan reg is a 1-based index. */
> +		if (reg < 1 || reg > num_channels)
> +			return ret;
> +
> +		ret =3D fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					       &r_gain);
> +		if (ret)
> +			/* Keep the default register value. */
> +			continue;

Might be simpler to just write the default?

		r_gain =3D /*WHATEVER DEFAULT IS */
		fwnode_property_read_u32(child, "adi,rfilter-ohms", &r_gain);
		if (r_gain > A7606...


> +
> +		if (r_gain > AD7606_CALIB_GAIN_MAX)
> +			return -EINVAL;
> +
> +		ret =3D st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}




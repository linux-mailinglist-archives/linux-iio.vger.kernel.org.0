Return-Path: <linux-iio+bounces-11377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25B9B1CC5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E461B1C20ADF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95804126C0F;
	Sun, 27 Oct 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAfrpv+T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E856742;
	Sun, 27 Oct 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730021408; cv=none; b=mShN7kDDxZbBuaTcqFRqBZ0tr11T2eHgQOSo+Fqa5jpgpTt6sZdlTrqf1iDSE+ORfuSTB3TH4LWE9dOjOJN3yHqZV1fQKx30NlyZ97S909ez2qThACFBBOX/pdH0dxfwiUAvXTGCv3sIcxrOzaBiQ/cR9QxEL3wLTS0CH2HgRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730021408; c=relaxed/simple;
	bh=n7eptGpGloWD/Z2gcMyX/TTRsQdRlLncjHeagEvFTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0vRTIAl6xmzJq8jy3e+5dMqqHjiWC1cciGwvN8aMeTN6NNb+BP0gdMYh/ZV0KhZX3IQ8QLhumpQgTA4vC2SvpDmEIfSYJCvMkznDy7Ga3HMCmdrRj4HT/iN9Ggx7ACJFx2xdX2F75NlqxVXYGDfsjd7XQwjBl2PF/+HYRLFoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAfrpv+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CB3C4CEC3;
	Sun, 27 Oct 2024 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730021407;
	bh=n7eptGpGloWD/Z2gcMyX/TTRsQdRlLncjHeagEvFTl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAfrpv+TKc2QE4WQy9z3yx5GtX9nOKi71/5g1mVl2nET9UYN9Qq+mvHHBtx3PXdhZ
	 tJZ4Iu3rvxAnbRR8jysjqZp2BwVwwzmF51Zm1DziharphqA0Up8gQt12sV1+bDZBUN
	 tPhhCaPz48j5cissGowKneW2B/KFGQ+nnI8Jy4qHMuF606E71X1PrEu+KGt+5eJzx2
	 grmDY20GDl+maoHANGmmsg90hlFs10H2xTFOXX43Q5P+o32Js2hDnOushtUhk5gs3G
	 c0nfr8EGlTz4iKithDagaRfwEwBQSIX3KV1TSyDh6mB3NfyFD5TzB/x6xiOrERIpJ+
	 lr/2xmvPu7dtQ==
Date: Sun, 27 Oct 2024 09:29:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: ad7380: add support for adaq4370-4 and
 adaq4380-4
Message-ID: <20241027092958.79e9f945@jic23-huawei>
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-3-6a29bd0f79da@baylibre.com>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
	<20241024-ad7380-add-adaq4380-4-support-v3-3-6a29bd0f79da@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 10:16:58 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
> acquisition signal chain =CE=BCModule solutions compatible with the ad738x
> family, with the following differences:
>=20
> - pin selectable gain in front of each 4 adc
> - internal reference is 3V derived from refin-supply (5V)
> - additional supplies
>=20
> This implies that IIO_CHAN_INFO_SCALE can not be shared by type.
If respinning for other reasons, maybe=20
"by type for these new devices." or I can tweak whilst applying.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Looks good to me. Only comment is a 'maybe' for pulling out a local
dev variable to shave a few characters off some long lines.
May not be worth the effort.

> @@ -1104,6 +1186,42 @@ static int ad7380_probe(struct spi_device *spi)
>  		st->vcm_mv[i] =3D ret / 1000;
>  	}
> =20
> +	for (i =3D 0; i < MAX_NUM_CHANNELS; i++)
> +		st->gain_milli[i] =3D AD7380_DEFAULT_GAIN_MILLI;
> +
> +	if (st->chip_info->has_hardware_gain) {
> +		device_for_each_child_node_scoped(&spi->dev, node) {
> +			unsigned int channel, gain;
> +			int gain_idx;
> +
> +			ret =3D fwnode_property_read_u32(node, "reg", &channel);
> +			if (ret)
> +				return dev_err_probe(&spi->dev, ret,
Hmm. It might be worth a precursor patch to add
struct device *dev =3D &spi->dev; for probe to shorten all these a little
(+ a bunch of existing cases)

Up to you though.

> +						     "Failed to read reg property\n");
> +
> +			if (channel >=3D st->chip_info->num_channels - 1)
> +				return dev_err_probe(&spi->dev, -EINVAL,
> +						     "Invalid channel number %i\n",
> +						     channel);
> +
> +			ret =3D fwnode_property_read_u32(node, "adi,gain-milli",
> +						       &gain);
> +			if (ret && ret !=3D -EINVAL)
> +				return dev_err_probe(&spi->dev, ret,
> +						     "Failed to read gain for channel %i\n",
> +						     channel);
> +			if (ret !=3D -EINVAL) {
> +				/*
> +				 * Match gain value from dt to one of supported
> +				 * gains
> +				 */
> +				gain_idx =3D find_closest(gain, ad7380_gains,
> +							ARRAY_SIZE(ad7380_gains));
> +				st->gain_milli[channel] =3D ad7380_gains[gain_idx];
> +			}
> +		}
> +	}
> +

